%% 计算
% 输入参数：
% 输出参数：
function [Force_t, Force_a, Moment] = cal_F_M(Delta_aer, FltSdt_S, FltSdt_F)

%% 参量赋值
global Time;   %%实际仿真时间
global m0;   %%再入飞行质量
global Jx;   %%绕X轴转动惯量 
global Jy;   %%绕X轴转动惯量 
global Jz;   %%绕X轴转动惯量 
global Xcg;  %%质心到参考力矩中心距离
global S;    %%翼展参考面积
global b;    %%翼展
global c;    %%平均气动弦长
global Rad2Deg;  %%弧度转换为度
global Distb_flag; %是否引入外部风干扰（随机干扰）
global Distb_para;
global Uncertn_flag; %是否引入外部风干扰（随机干扰）
global Uncertn_para;
% m0 = 63500;    %%单位 kg 
% Jx = 637234;  %%单位 kg*m2  
% Jy = 6101181; %%单位 kg*m2 
% Jz = 6101181; %%单位 kg*m2 
% Xcg = 4.4668; %%单位 m
% S = 334.73;   %%单位 m2
% b = 18.288;   %%单位 m
% c = 24.384;   %%单位 m
% Rad2Deg = 180 / 3.141592; 
% disturb_flag=0;
% Uncertn =zeros(1,11);
% Delta_ear =[-5, -5, 0];
% FltSdt_S =[0,0,30000,4590,0,0];
% FltSdt_F =[0,0,0, 10/Rad2Deg, 0, 0,0,0,0];


%舵偏参数
RE = Delta_aer(1); LE = Delta_aer(2); RUD = Delta_aer(3);

%飞行状态参数
%X_loc = Flight_State_s(1);   Y_loc = Flight_State_s(2) ; 
Height = FltSdt_S(3);
Veloc = FltSdt_S(4);   gamma = FltSdt_S(5);   chi = FltSdt_S(6);

%theta = Flight_State_f(1);   psi = Flight_State_f(2);   phi = Flight_State_f(3);  

ALPHA = FltSdt_F(4); 
%  ALPHA = 5 * Com_angle(1); 
beta = FltSdt_F(5);   mu = FltSdt_F(6);
q = FltSdt_F(7);   r = FltSdt_F(8);   p = FltSdt_F(9);

%% 计算大气环境参数
Env_para = calEnv_para(Height,Veloc);%计算当前的大气环境参数
g = Env_para(1);  Rho = Env_para(2);  Ma = Env_para(3);   
%Tmprt = Env_para(4); Vs = Env_para(5);

%% 计算气动力和气动力矩
C_D = funC_D(Ma,ALPHA,RE,LE,RUD);  %% X轴向阻力系数
C_Y = funC_Y(Ma,ALPHA,beta,RE,LE,RUD);%% Y轴向侧向力系数
C_L = funC_L(Ma,ALPHA,RE,LE);%% Z轴向升力系数
C_lw = funC_lw(Ma,ALPHA,beta,RE,LE,RUD,p,r,Veloc);  %% 绕X轴气动力矩系数
C_mw = funC_mw(Ma,ALPHA,RE,LE,RUD,q,Veloc);  %% 绕Y轴气动力矩系数
C_nw = funC_nw(Ma,ALPHA,beta,RE,LE,RUD,p,r,Veloc);  %% 绕Z轴气动力矩系数

%气动极限不确定性
if Uncertn_flag == 1
    %不确定参数
    xm  = Uncertn_para(1); xJx = Uncertn_para(2);  xJy = Uncertn_para(3); xJz = Uncertn_para(4);
    xRho = Uncertn_para(5); 
    xCD = Uncertn_para(6);  xCY = Uncertn_para(7);  xCL = Uncertn_para(8);  
    xCl = Uncertn_para(9);  xCm = Uncertn_para(10); xCn = Uncertn_para(11);
    
    m0 = m0*(1 + xm); %质量不确定性
    Jx = Jx*(1 + xJx); Jy = Jy*(1 + xJy); Jz = Jz*(1 + xJz);%转动惯量不确定性，
    Rho = Rho*(1 + xRho);%空气密度不确定性
    C_D = C_D*(1 + xCD); C_Y = C_Y*(1 + xCY); C_L = C_L*(1 + xCL);%气动参数不确定性
    C_lw = C_lw*(1 + xCl); C_mw = C_mw*(1 + xCm); C_nw = C_nw*(1 + xCn);
end
%随机干扰不确定性
if Distb_flag == 1
    d1 = 0.2*sin(Time + PI/3);
    d2 = 0.2*sin(Time + 2*PI/3);  
    d3 = 0.2*sin(Time + PI/3);
    d4 = 0.2*sin(Time + 4*PI/3);
    d5 = 0.2*sin(Time + 5*PI/3);
    d6 = 0.2*sin(Time + 2*PI);
    d7 = normrnd(0,0.2);
    Dstrb = [d1, d2, d3, d4, d5, d6]; %三角函数干扰
%    Dstrb = [d7, d7, d7, d7, d7, d7]; %随机干扰
%干扰向量顺序; dCD; dCY; dCL; dCl;  dCm; dCn 
    Distb_para = Dstrb;
else
    Distb_para = zeros(1,11); %初始值均设为0
end
    
    
q_bar = Veloc^2*Rho/2; %%动压的计算

F_Da = C_D*q_bar*S; %% 速度系下的X轴向阻力
F_Ya = C_Y*q_bar*S; %% 速度系下的Y轴向侧向力
F_La = C_L*q_bar*S; %% 速度系下的Z轴向升力
M_la = C_lw*b*q_bar*S; %% 速度系下的绕X轴气动力矩
M_ma = C_mw*c*q_bar*S;%% 速度系下的绕Y轴气动力矩
M_na = C_nw*b*q_bar*S;%% 速度系下的绕Z轴气动力矩

%气动力在航迹系下的坐标分量
F_xt = -F_Da;
F_yt = F_Ya*cos(mu) + F_La*sin(mu);
F_zt = F_Ya*sin(mu) - F_La*cos(mu);
%气动力在速度系下的坐标分量
F_xa = -F_Da;   F_ya = F_Ya;    F_za = -F_La;
%气动力矩在机体系下的坐标分量
M_xb =  M_la;     %% 机体系下的绕X轴气动力矩
M_yb =  M_ma + Xcg*(F_Da*sin(ALPHA) + F_La*cos(ALPHA));  %% 机体系下的绕Y轴气动力矩
M_zb =  M_na - Xcg*F_Ya;  %% 机体系下的绕Z轴气动力矩

%% 计算重力
G = m0*g; %惯性系下的重力
%重力在航迹系下的坐标分量
G_xt = - G*sin(gamma);
G_yt = 0;
G_zt = G*cos(gamma);
%重力在速度系下的坐标分量
G_xa = G*cos(gamma)*cos(mu);
G_ya = G*cos(gamma)*sin(mu);
G_za = - G*cos(gamma)*tan(beta)*cos(mu);

%% 计算合力
%航迹坐标系下的合力
Force_t(1) = F_xt + G_xt;   Force_t(2) = F_yt + G_yt;   Force_t(3) = F_zt + G_zt;
%速度坐标系下的合力
Force_a(1) = F_xa + G_xa;  Force_a(2) = F_ya + G_ya;  Force_a(3) = F_za + G_za;
%机体坐标系下的合力矩
Moment(1) = M_xb;   Moment(2) = M_yb;  Moment(3) = M_zb;

 end






















