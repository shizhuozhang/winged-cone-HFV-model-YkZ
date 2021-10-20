%% ����
% ���������
% ���������
function [Force_t, Force_a, Moment] = cal_F_M(Delta_aer, FltSdt_S, FltSdt_F)

%% ������ֵ
global Time;   %%ʵ�ʷ���ʱ��
global m0;   %%�����������
global Jx;   %%��X��ת������ 
global Jy;   %%��X��ת������ 
global Jz;   %%��X��ת������ 
global Xcg;  %%���ĵ��ο��������ľ���
global S;    %%��չ�ο����
global b;    %%��չ
global c;    %%ƽ�������ҳ�
global Rad2Deg;  %%����ת��Ϊ��
global Distb_flag; %�Ƿ������ⲿ����ţ�������ţ�
global Distb_para;
global Uncertn_flag; %�Ƿ������ⲿ����ţ�������ţ�
global Uncertn_para;
% m0 = 63500;    %%��λ kg 
% Jx = 637234;  %%��λ kg*m2  
% Jy = 6101181; %%��λ kg*m2 
% Jz = 6101181; %%��λ kg*m2 
% Xcg = 4.4668; %%��λ m
% S = 334.73;   %%��λ m2
% b = 18.288;   %%��λ m
% c = 24.384;   %%��λ m
% Rad2Deg = 180 / 3.141592; 
% disturb_flag=0;
% Uncertn =zeros(1,11);
% Delta_ear =[-5, -5, 0];
% FltSdt_S =[0,0,30000,4590,0,0];
% FltSdt_F =[0,0,0, 10/Rad2Deg, 0, 0,0,0,0];


%��ƫ����
RE = Delta_aer(1); LE = Delta_aer(2); RUD = Delta_aer(3);

%����״̬����
%X_loc = Flight_State_s(1);   Y_loc = Flight_State_s(2) ; 
Height = FltSdt_S(3);
Veloc = FltSdt_S(4);   gamma = FltSdt_S(5);   chi = FltSdt_S(6);

%theta = Flight_State_f(1);   psi = Flight_State_f(2);   phi = Flight_State_f(3);  

ALPHA = FltSdt_F(4); 
%  ALPHA = 5 * Com_angle(1); 
beta = FltSdt_F(5);   mu = FltSdt_F(6);
q = FltSdt_F(7);   r = FltSdt_F(8);   p = FltSdt_F(9);

%% ���������������
Env_para = calEnv_para(Height,Veloc);%���㵱ǰ�Ĵ�����������
g = Env_para(1);  Rho = Env_para(2);  Ma = Env_para(3);   
%Tmprt = Env_para(4); Vs = Env_para(5);

%% ��������������������
C_D = funC_D(Ma,ALPHA,RE,LE,RUD);  %% X��������ϵ��
C_Y = funC_Y(Ma,ALPHA,beta,RE,LE,RUD);%% Y���������ϵ��
C_L = funC_L(Ma,ALPHA,RE,LE);%% Z��������ϵ��
C_lw = funC_lw(Ma,ALPHA,beta,RE,LE,RUD,p,r,Veloc);  %% ��X����������ϵ��
C_mw = funC_mw(Ma,ALPHA,RE,LE,RUD,q,Veloc);  %% ��Y����������ϵ��
C_nw = funC_nw(Ma,ALPHA,beta,RE,LE,RUD,p,r,Veloc);  %% ��Z����������ϵ��

%�������޲�ȷ����
if Uncertn_flag == 1
    %��ȷ������
    xm  = Uncertn_para(1); xJx = Uncertn_para(2);  xJy = Uncertn_para(3); xJz = Uncertn_para(4);
    xRho = Uncertn_para(5); 
    xCD = Uncertn_para(6);  xCY = Uncertn_para(7);  xCL = Uncertn_para(8);  
    xCl = Uncertn_para(9);  xCm = Uncertn_para(10); xCn = Uncertn_para(11);
    
    m0 = m0*(1 + xm); %������ȷ����
    Jx = Jx*(1 + xJx); Jy = Jy*(1 + xJy); Jz = Jz*(1 + xJz);%ת��������ȷ���ԣ�
    Rho = Rho*(1 + xRho);%�����ܶȲ�ȷ����
    C_D = C_D*(1 + xCD); C_Y = C_Y*(1 + xCY); C_L = C_L*(1 + xCL);%����������ȷ����
    C_lw = C_lw*(1 + xCl); C_mw = C_mw*(1 + xCm); C_nw = C_nw*(1 + xCn);
end
%������Ų�ȷ����
if Distb_flag == 1
    d1 = 0.2*sin(Time + PI/3);
    d2 = 0.2*sin(Time + 2*PI/3);  
    d3 = 0.2*sin(Time + PI/3);
    d4 = 0.2*sin(Time + 4*PI/3);
    d5 = 0.2*sin(Time + 5*PI/3);
    d6 = 0.2*sin(Time + 2*PI);
    d7 = normrnd(0,0.2);
    Dstrb = [d1, d2, d3, d4, d5, d6]; %���Ǻ�������
%    Dstrb = [d7, d7, d7, d7, d7, d7]; %�������
%��������˳��; dCD; dCY; dCL; dCl;  dCm; dCn 
    Distb_para = Dstrb;
else
    Distb_para = zeros(1,11); %��ʼֵ����Ϊ0
end
    
    
q_bar = Veloc^2*Rho/2; %%��ѹ�ļ���

F_Da = C_D*q_bar*S; %% �ٶ�ϵ�µ�X��������
F_Ya = C_Y*q_bar*S; %% �ٶ�ϵ�µ�Y���������
F_La = C_L*q_bar*S; %% �ٶ�ϵ�µ�Z��������
M_la = C_lw*b*q_bar*S; %% �ٶ�ϵ�µ���X����������
M_ma = C_mw*c*q_bar*S;%% �ٶ�ϵ�µ���Y����������
M_na = C_nw*b*q_bar*S;%% �ٶ�ϵ�µ���Z����������

%�������ں���ϵ�µ��������
F_xt = -F_Da;
F_yt = F_Ya*cos(mu) + F_La*sin(mu);
F_zt = F_Ya*sin(mu) - F_La*cos(mu);
%���������ٶ�ϵ�µ��������
F_xa = -F_Da;   F_ya = F_Ya;    F_za = -F_La;
%���������ڻ���ϵ�µ��������
M_xb =  M_la;     %% ����ϵ�µ���X����������
M_yb =  M_ma + Xcg*(F_Da*sin(ALPHA) + F_La*cos(ALPHA));  %% ����ϵ�µ���Y����������
M_zb =  M_na - Xcg*F_Ya;  %% ����ϵ�µ���Z����������

%% ��������
G = m0*g; %����ϵ�µ�����
%�����ں���ϵ�µ��������
G_xt = - G*sin(gamma);
G_yt = 0;
G_zt = G*cos(gamma);
%�������ٶ�ϵ�µ��������
G_xa = G*cos(gamma)*cos(mu);
G_ya = G*cos(gamma)*sin(mu);
G_za = - G*cos(gamma)*tan(beta)*cos(mu);

%% �������
%��������ϵ�µĺ���
Force_t(1) = F_xt + G_xt;   Force_t(2) = F_yt + G_yt;   Force_t(3) = F_zt + G_zt;
%�ٶ�����ϵ�µĺ���
Force_a(1) = F_xa + G_xa;  Force_a(2) = F_ya + G_ya;  Force_a(3) = F_za + G_za;
%��������ϵ�µĺ�����
Moment(1) = M_xb;   Moment(2) = M_yb;  Moment(3) = M_zb;

 end






















