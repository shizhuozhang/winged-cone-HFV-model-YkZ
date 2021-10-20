%% 计算
% 输入参数：
% 输出参数：

function TrimDelta = calTrimDelta(Com_angle,FltSdt_S)

global Xcg;  %%质心到参考力矩中心距离
global S;    %%翼展参考面积
global b;    %%翼展
global c;    %%平均气动弦长

alpha = Com_angle(1);   beta = Com_angle(2);    mu = Com_angle(3);

%飞行状态参数
%X_loc = Flight_State_s(1);   Y_loc = Flight_State_s(2) ;   Height = Flight_State_s(3);
Veloc = FltSdt_S(4);   gamma = FltSdt_S(5);   chi = FltSdt_S(6);

Env_para = calEnv_para(Height,Veloc);%计算当前的大气环境参数
g = Env_para(1);  Rho = Env_para(2);  Ma = Env_para(3); 

q_bar = Veloc^2*Rho/2; %%动压的计算

%% 计算气动力
C_D = funC_D(Ma,alpha,delta_e,delta_a,delta_r);  %% X轴向阻力系数
C_Y = funC_Y(Ma,alpha,beta,delta_e,delta_a,delta_r);%% Y轴向侧向力系数
C_L = funC_L(Ma,alpha,delta_e,delta_a);%% Z轴向升力系数


%% 计算气动力矩
%滚转通道
Clb = funClb(Ma,alpha);
Cl_delta_a = funCl_delta_a(Ma,alpha,delta_a);
Cl_delta_e = funCl_delta_e(Ma,alpha,delta_e);
Cl_delta_r = funCl_delta_r(Ma,alpha,delta_r);
% Clw = Clb*beta + Cl_delta_a + Cl_delta_e + Cl_delta_r;%该式里的角度是弧度值
M_l_b = Clb*beta*b*q_bar*S;
M_l_d = (Cl_delta_a + Cl_delta_e + Cl_delta_r)*b*q_bar*S;

%俯仰通道
Cma = funCma(Ma,alpha); %仅用马赫数和攻角拟合
Cm_delta_a = funCm_delta_a(Ma,alpha,delta_a);
Cm_delta_e = funCm_delta_e(Ma,alpha,delta_e);
Cm_delta_r = funCm_delta_r(Ma,alpha,delta_r);
% Cmw = Cma + Cm_delta_a + Cm_delta_e + Cm_delta_r;
M_m_a = Cma*c*q_bar*S;
M_m_d = (Cm_delta_a + Cm_delta_e + Cm_delta_r)*c*q_bar*S;

%偏航通道
Cnb = funCnb(Ma,alpha);
Cn_delta_a = funCn_delta_a(Ma,alpha,delta_a);
Cn_delta_e = funCn_delta_e(Ma,alpha,delta_e);
Cn_delta_r = funCn_delta_r(Ma,alpha,delta_r);
%Cnw = Cnb*beta + Cn_delta_a + Cn_delta_e + Cn_delta_r;%该式里的角度是弧度值
M_n_b = Cnb*beta*b*q_bar*S;
M_n_d = (Cn_delta_a + Cn_delta_e + Cn_delta_r)*b*q_bar*S;

%第1个方程
Xcsa = Xcg*sin(alpha);
Xcca = Xcg*cos(alpha);
AM = ALPHA*Ma;
AMt = (ALPHA*Ma)^2;
(Cm_delta_a + Cm_delta_e + Cm_delta_r)*c + C_D*Xcsa + C_L*Xcca + Cma *c =0;

- 1.134E-04*c - 1.597E-04*ALPHA*c - 3.02E-06*Ma*c  - 8.92E-06*AM*c - 5.89E-08*c*ALPHA^2 + 1.58E-03*c*Ma^2 + 6.42E-08*c*ALPHA^3 - 6.69E-04*c*Ma^3 
- 2.1E-08*c*ALPHA^4 + 1.05E-04*c*Ma^4  + 3.14E-09*c*ALPHA^5 - 7.74E-06*c*Ma^5 - 2.18E-10*c*ALPHA^6 + 2.7E-07*c*Ma^6 + 5.74E-12*c*ALPHA^7 - 3.58E-09*c*Ma^7
+ 2.89E-04*c*RE + 4.48E-06*c*ALPHA*RE - 5.87E-06*c*Ma*RE + 9.72E-08*c*AM*RE
+ 2.89E-04*c*LE + 4.48E-06*c*ALPHA*LE - 5.87E-06*c*Ma*LE + 9.72E-08*c*AM*LE; %忽略了高阶的方向舵项
%% 阻力系数
+ 8.872E-02*Xcsa + 3.203E-03*ALPHA*Xcsa - 3.31E-02*Xcsa*Ma - 1.07E-04*Xcsa*ALPHA^2 + 5.043E-03*Xcsa*Ma^2 - 1.25E-04*Xcsa*AM + 1.405E-07*Xcsa*AMt
- 3.658E-04*Xcsa*Ma^3 + 3.175E-04*Xcsa*ALPHA^3 + 1.274E-05*Xcsa*Ma^4 - 2.985E-05*Xcsa*ALPHA^4 - 1.705E-07*Xcsa*Ma^5 + 9.766E-07*Xcsa*ALPHA^5;
-3.46E-05*Xcsa*RE - 5.38E-07*Xcsa*AM*RE + 6.84E-06*Xcsa*RE^2 + 5.28E-12*Xcsa*AMt*RE^2
-3.46E-05*Xcsa*LE - 5.38E-07*Xcsa*AM*LE + 6.84E-06*Xcsa*LE^2 + 5.28E-12*Xcsa*AMt*LE^2
- 1.83E-06*Xcsa*RUD + 9.13E-09*Xcsa*AM*RUD + 1.97E-06*Xcsa*RUD^2 - 1.77E-11*Xcsa*AMt*RUD^2

%% 升力系数
- 8.193E-02*Xcca + 4.701E-02*Xcca*Ma + 1.88E-02*Xcca*ALPHA - 4.636E-04*Xcca*AM - 9.19E-03*Xcca*Ma^2 - 1.52E-04*Xcca*ALPHA^2 + 5.99E-07*Xcca*AMt 
+ 7.74E-04*Xcca*Ma^3 + 4.08E-06*Xcca*ALPHA^3 - 2.93E-05*Xcca*Ma^4 - 3.91E-07*Xcca*ALPHA^4 + 4.12E-07*Xcca*Ma^5 + 1.3E-08*Xcca*ALPHA^5;         
- 4.14E-04*Xcca*RE - 3.51E-06*Xcca*ALPHA*RE + 8.72E-06*Xcca*Ma*RE - 1.7E-07*Xcca*AM*RE;
- 4.14E-04*Xcca*LE - 3.51E-06*Xcca*ALPHA*LE + 8.72E-06*Xcca*Ma*LE - 1.7E-07*Xcca*AM*LE;  

- 2.192E-02*c + 7.739E-03*Ma*c - 2.260E-03*ALPHA*c + 1.808E-04*(ALPHA*Ma)*c - 8.849E-04*c*Ma^2 + 2.616E-04*c*ALPHA^2 - 2.880E-07*c*(ALPHA*Ma)^2 
+ 4.617E-05*c*Ma^3 - 7.887E-05*c*ALPHA^3 - 1.143E-06*c*Ma^4 + 8.288E-06*c*ALPHA^4 + 1.082E-08*c*Ma^5 - 2.789E-07*c*ALPHA^5 ;    

OnR = + 2.89E-04*c + 4.48E-06*c*ALPHA - 5.87E-06*c*Ma + 9.72E-08*c*AM -3.46E-05*Xcsa - 5.38E-07*Xcsa*AM - 4.14E-04*Xcca - 3.51E-06*Xcca*ALPHA + 8.72E-06*Xcca*Ma - 1.7E-07*Xcca*AM;
On2R = + 6.84E-06*Xcsa + 5.28E-12*Xcsa*AMt;
OnL = + 2.89E-04*c + 4.48E-06*c*ALPHA - 5.87E-06*c*Ma + 9.72E-08*c*AM -3.46E-05*Xcsa - 5.38E-07*Xcsa*AM - 4.14E-04*Xcca - 3.51E-06*Xcca*ALPHA + 8.72E-06*Xcca*Ma - 1.7E-07*Xcca*AM;
On2L = + 6.84E-06*Xcsa + 5.28E-12*Xcsa*AMt;
OnU = - 1.83E-06*Xcsa + 9.13E-09*Xcsa*AM;
On2U = + 1.97E-06*Xcsa - 1.77E-11*Xcsa*AMt;

On1 = + 2.181E-02*c - 7.736E-03*Ma*c + 2.1E-03*c*ALPHA - 1.897E-04*c*AM + 8.849E-04*c*Ma^2 - 2.617E-04*c*ALPHA^2 + 2.880E-07*c*AMt + 1.58E-03*c*Ma^2 - 7.152E-04*c*Ma^3 + 7.893E-05*c*ALPHA^3; 
On2 = + 1.06E-04*c*Ma^4 - 8.29E-06*c*ALPHA^4 - 7.75E-06*c*Ma^5 + 2.82E-07*c*ALPHA^5 - 2.18E-10*c*ALPHA^6 + 2.7E-07*c*Ma^6 + 5.74E-12*c*ALPHA^7 - 3.58E-09*c*Ma^7;

On1 = - 2.203E-02*c - 2.42E-03*ALPHA*c + 7.736E-03*Ma*c + 1.719E-04*AM*c + 6.951E-04*c*Ma^2 + 2.615E-04*c*ALPHA^2 - 2.880E-07*c*(ALPHA*Ma)^2 - 7.881E-05*c*ALPHA^3 - 6.228E-04*c*Ma^3;
On2 = + 8.267E-06*c*ALPHA^4 + 1.039E-04*c*Ma^4 - 2.758E-07*c*ALPHA^5 - 7.73E-06*c*Ma^5 - 2.18E-10*c*ALPHA^6 + 2.7E-07*c*Ma^6 + 5.74E-12*c*ALPHA^7 - 3.58E-09*c*Ma^7;
On3 = - 8.193E-02*Xcca + 4.701E-02*Xcca*Ma + 1.88E-02*Xcca*ALPHA - 4.636E-04*Xcca*AM - 9.19E-03*Xcca*Ma^2 - 1.52E-04*Xcca*ALPHA^2 + 5.99E-07*Xcca*AMt; 
On4 = + 7.74E-04*Xcca*Ma^3 + 4.08E-06*Xcca*ALPHA^3 - 2.93E-05*Xcca*Ma^4 - 3.91E-07*Xcca*ALPHA^4 + 4.12E-07*Xcca*Ma^5 + 1.3E-08*Xcca*ALPHA^5;   
On5 = + 8.872E-02*Xcsa + 3.203E-03*ALPHA*Xcsa - 3.31E-02*Xcsa*Ma - 1.07E-04*Xcsa*ALPHA^2 + 5.043E-03*Xcsa*Ma^2 - 1.25E-04*Xcsa*AM + 1.405E-07*Xcsa*AMt;
On6 = - 3.658E-04*Xcsa*Ma^3 + 3.175E-04*Xcsa*ALPHA^3 + 1.274E-05*Xcsa*Ma^4 - 2.985E-05*Xcsa*ALPHA^4 - 1.705E-07*Xcsa*Ma^5 + 9.766E-07*Xcsa*ALPHA^5;
On = On1 + On2 + On3 + On4 + On5 + On6; 

OnR*RE + On2R*RE^2 +OnL*LE + On2L*LE^2 + OnU*RUD + On2U*RUD^2 + On = 0
%第2个方程
(Cn_delta_a + Cn_delta_e + Cn_delta_r)*b - Xcg*C_Y = 0; 
- 1.30E-05*b*RE - 8.93E-08*b*AM*RE + 1.97E-06*b*RE^2 + 1.41E-11*b*AMt*RE^2 
+ 1.30E-05*b*LE + 8.93E-08*b*AM*LE - 1.97E-06*b*LE^2 - 1.41E-11*b*AMt*LE^2
- 5.28E-04*b*RUD + 1.39E-05*b*ALPHA*RUD + 1.65E-05*b*Ma*RUD - 3.13E-07*b*AM*RUD
+ 2.85E-18*b - 3.59E-19*b *ALPHA -1.26E-19*b*Ma  + 1.57E-20*b*AM
+
- 2.27E-07*Xcg*RE - 4.11E-09*Xcg*AM*RE + 5.04E-08*Xcg*RE^2 - 4.5E-14*Xcg*AMt*RE^2
+ 2.27E-07*Xcg*LE + 4.11E-09*Xcg*AM*LE - 5.04E-08*Xcg*LE^2 + 4.5E-14*Xcg*AMt*LE^2
- 3.84E-04*Xcg*RUD + 1.17E-05*Xcg*ALPHA*RUD + 1.07E-05*Xcg*Ma*RUD - 2.6E-07*Xcg*AM*RUD
+ 1.43E-18*Xcg - 4.86E-20*ALPHA*Xcg - 1.86E-19*Ma*Xcg 

TwR*RE + Tw2R*RE^2 +TwL*LE + Tw2L*LE^2 + TwU*RUD + Tw = 0
TwR = - 1.30E-05*b - 8.93E-08*b*AM - 2.27E-07*Xcg - 4.11E-09*Xcg*AM
Tw2R = + 1.97E-06*b + 1.41E-11*b*AMt + 5.04E-08*Xcg - 4.5E-14*Xcg*AMt
TwL = + 1.30E-05*b + 8.93E-08*b*AM + 2.27E-07*Xcg + 4.11E-09*Xcg*AM
Tw2L = - 1.97E-06*b - 1.41E-11*b*AMt - 5.04E-08*Xcg + 4.5E-14*Xcg*AMt
TwU = - 5.28E-04*b + 1.39E-05*b*ALPHA + 1.65E-05*b*Ma - 3.13E-07*b*AM - 3.84E-04*Xcg + 1.17E-05*Xcg*ALPHA + 1.07E-05*Xcg*Ma - 2.6E-07*Xcg*AM
Tw = + 2.85E-18*b - 3.59E-19*b *ALPHA -1.26E-19*b*Ma  + 1.57E-20*b*AM + 1.43E-18*Xcg - 4.86E-20*ALPHA*Xcg - 1.86E-19*Ma*Xcg 
%第3个方程
Cl_delta_a + Cl_delta_e + Cl_delta_r =0; 

1.170E-04*RE + 2.794E-08*AM*RE - 1.160E-06*RE^2 - 4.641E-11*AMt*RE^2 
-1.170E-04*LE - 2.794E-08*AM*LE + 1.160E-06*LE^2 + 4.641E-11*AMt*LE^2 
+ 0.00011441*RUD - 2.6824E-06*ALPHA*RUD - 3.5496E-06*Ma*RUD + 5.5547E-08*AM*RUD
- 5.0103E-19 + 6.2723E-20*ALPHA + 2.3418E-20*Ma  - 3.4201E-21*AM = 0;

ThR*RE + Th2R*RE^2 +ThL*LE + Th2L*LE^2 + ThU*RUD + Th = 0
ThR = 1.170E-04 + 2.794E-08*AM
Th2R = - 1.160E-06 - 4.641E-11*AMt
ThL = -1.170E-04 - 2.794E-08*AM
Th2L = + 1.160E-06 + 4.641E-11*AMt
ThU = + 0.00011441 - 2.6824E-06*ALPHA - 3.5496E-06*Ma + 5.5547E-08*AM
Th = - 5.0103E-19 + 6.2723E-20*ALPHA + 2.3418E-20*Ma  - 3.4201E-21*AM 

%先用等效舵偏进行合成，再用分配矩阵求实际舵偏
TrimDelta(1) = delta_e;  TrimDelta(2) = delta_a; TrimDelta(3) = delta_r;

end


%要注意！！！气动系数计算公式中的 攻角和舵偏的单位是deg，侧滑角和角速率的单位是rad(/s)

%% 俯仰力矩系数
%攻角引起的俯仰力矩系数
Cma = - 2.192E-02 + 7.739E-03*Ma - 2.260E-03*ALPHA + 1.808E-04*(ALPHA*Ma) - 8.849E-04*Ma^2 + 2.616E-04*ALPHA^2 -2.880E-07*(ALPHA*Ma)^2 + 4.617E-05*Ma^3 -7.887E-05*ALPHA^3 -1.143E-06*Ma^4 + 8.288E-06*ALPHA^4 + 1.082E-08*Ma^5 - 2.789E-07*ALPHA^5 ;
%右舵引起的俯仰力矩系数
Cm_delta_a = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma + 2.89E-04*RE + 4.48E-06*ALPHA*RE - 4.46E-06*ALPHA*Ma - 5.87E-06*Ma*RE + 9.72E-08*ALPHA*Ma*RE;
%左舵引起的俯仰力矩系数
Cm_delta_e = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma + 2.89E-04*LE + 4.48E-06*ALPHA*LE - 4.46E-06*ALPHA*Ma - 5.87E-06*Ma*LE + 9.72E-08*ALPHA*Ma*LE;
%方向舵引起的俯仰力矩系数
Cm_delta_r = - 2.79E-05*ALPHA - 5.89E-08*ALPHA^2 + 1.58E-03*Ma^2 + 6.42E-08*ALPHA^3 - 6.69E-04*Ma^3 - 2.1E-08*ALPHA^4 + 1.05E-04*Ma^4 + 1.43E-07*RUD^4 + 3.14E-09*ALPHA^5 - 7.74E-06*Ma^5 - 4.77E-22*RUD^5 - 2.18E-10*ALPHA^6 + 2.7E-07*Ma^6 - 3.38E-10*RUD^6 + 5.74E-12*ALPHA^7 - 3.58E-09*Ma^7 + 2.63E-24*RUD^7;

Cm_delta = - 1.134E-04 - 1.597E-04*ALPHA - 3.02E-06*Ma  - 8.92E-06*ALPHA*Ma - 5.89E-08*ALPHA^2 + 1.58E-03*Ma^2 + 6.42E-08*ALPHA^3 - 6.69E-04*Ma^3 
           - 2.1E-08*ALPHA^4 + 1.05E-04*Ma^4  + 3.14E-09*ALPHA^5 - 7.74E-06*Ma^5 - 2.18E-10*ALPHA^6 + 2.7E-07*Ma^6 + 5.74E-12*ALPHA^7 - 3.58E-09*Ma^7
           + 2.89E-04*RE + 4.48E-06*ALPHA*RE - 5.87E-06*Ma*RE + 9.72E-08*ALPHA*Ma*RE
           + 2.89E-04*LE + 4.48E-06*ALPHA*LE - 5.87E-06*Ma*LE + 9.72E-08*ALPHA*Ma*LE; %忽略了高阶的方向舵项
           
Cma = - 2.192E-02 + 7.739E-03*Ma - 2.260E-03*ALPHA + 1.808E-04*(ALPHA*Ma) - 
      8.849E-04*Ma^2 + 2.616E-04*ALPHA^2 -2.880E-07*(ALPHA*Ma)^2 
      + 4.617E-05*Ma^3 -7.887E-05*ALPHA^3 
      -1.143E-06*Ma^4 + 8.288E-06*ALPHA^4 
      + 1.082E-08*Ma^5 - 2.789E-07*ALPHA^5 ;
%% 滚转力矩系数
%侧滑引起的滚转力矩系数
Clb = - 1.402E-01 + 3.326E-02*Ma - 7.590E-04*ALPHA + 8.596E-06*(ALPHA*Ma) - 3.794E-03*Ma^2 + 2.354E-06*ALPHA^2 -1.044E-08*(ALPHA*Ma)^2 + 2.219E-04*Ma^3 - 8.964E-18*ALPHA^3 - 6.462E-06*Ma^4 + 3.803E-19*ALPHA^4 + 7.419E-08*Ma^5 -3.353E-21*ALPHA^5 ;
% 右舵引起的滚转力矩系数
Cl_delta_a = + 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 1.170E-04*RE + 2.794E-08*(ALPHA*Ma)*RE + 4.950E-06*ALPHA^2 + 1.411E-06*Ma^2 - 1.160E-06*RE^2 - 4.641E-11*((ALPHA*Ma)*RE)^2;
% 左舵引起的滚转力矩系数
Cl_delta_e = -(3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 1.170E-04*LE + 2.794E-08*(ALPHA*Ma)*LE + 4.950E-06*ALPHA^2 + 1.411E-06*Ma^2 - 1.160E-06*LE^2 - 4.641E-11*((ALPHA*Ma)*LE)^2) ;
% 方向舵引起的滚转力矩系数
Cl_delta_r = - 5.0103E-19 + 6.2723E-20*ALPHA + 2.3418E-20*Ma + 0.00011441*RUD - 2.6824E-06*(ALPHA*RUD) - 3.4201E-21*(ALPHA*Ma) - 3.5496E-06*(Ma*RUD) + 5.5547E-08*(ALPHA*Ma)*RUD ;

Cl_delta = 1.170E-04*RE + 2.794E-08*(ALPHA*Ma)*RE - 1.160E-06*RE^2 - 4.641E-11*((ALPHA*Ma)*RE)^2 
          -1.170E-04*LE - 2.794E-08*(ALPHA*Ma)*LE + 1.160E-06*LE^2 + 4.641E-11*((ALPHA*Ma)*LE)^2 
          + 0.00011441*RUD - 2.6824E-06*(ALPHA*RUD)- 3.5496E-06*(Ma*RUD) + 5.5547E-08*(ALPHA*Ma)*RUD
          - 5.0103E-19 + 6.2723E-20*ALPHA + 2.3418E-20*Ma  - 3.4201E-21*(ALPHA*Ma);
 Clb*beta = 0;        
          


%% 偏航力矩系数
%侧滑引起的偏航力矩系数
Cnb = + 3.68E-01 + 6.03E-16*ALPHA + 9.79E-02*Ma - 3.84E-16*ALPHA^2 + 1.24E-02*Ma^2 + 8.58E-17*ALPHA^3 - 8.05E-04*Ma^3 - 7.75E-18*ALPHA^4 + 2.57E-05*Ma^4 + 2.42E-19*ALPHA^5 - 3.20E-07*Ma^5;
%右舵引起的偏航力矩系数
Cn_delta_a = + 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma - 1.30E-05*RE - 8.93E-08*(ALPHA*Ma)*RE -6.39E-07*ALPHA^2 + 8.16E-07*Ma^2 + 1.97E-06*RE^2 + 1.41E-11*((ALPHA*Ma)*RE)^2 ;
%左舵引起的偏航力矩系数
Cn_delta_e = -(2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma - 1.30E-05*LE - 8.93E-08*(ALPHA*Ma)*LE -6.39E-07*ALPHA^2 + 8.16E-07*Ma^2 + 1.97E-06*LE^2 + 1.41E-11*((ALPHA*Ma)*LE)^2);
%方向舵引起的偏航力矩系数
Cn_delta_r = + 2.85E-18 - 3.59E-19 *ALPHA -1.26E-19*Ma -5.28E-04*RUD + 1.39E-05*(ALPHA*RUD) + 1.57E-20*(ALPHA*Ma) + 1.65E-05*(Ma*RUD) - 3.13E-07*(ALPHA*Ma)*RUD ;

Cn_delta = - 1.30E-05*RE - 8.93E-08*(ALPHA*Ma)*RE + 1.97E-06*RE^2 + 1.41E-11*((ALPHA*Ma)*RE)^2 
           + 1.30E-05*LE + 8.93E-08*(ALPHA*Ma)*LE - 1.97E-06*LE^2 - 1.41E-11*((ALPHA*Ma)*LE)^2
           - 5.28E-04*RUD + 1.39E-05*(ALPHA*RUD) + 1.65E-05*Ma*RUD - 3.13E-07*(ALPHA*Ma)*RUD
           + 2.85E-18 - 3.59E-19 *ALPHA -1.26E-19*Ma  + 1.57E-20*(ALPHA*Ma);
Cnb*beta=0

%% 阻力系数
CDa = + 8.717E-02 - 3.307E-02*Ma + 3.179E-03*ALPHA - 1.25E-04*ALPHA*Ma + 5.036E-03*Ma^2 - 0.1E-03*ALPHA^2 + 1.405E-07*(ALPHA*Ma)^2 - 3.658E-04*Ma^3 + 3.175E-04*ALPHA^3 + 1.274E-05*Ma^4 - 2.985E-05*ALPHA^4 - 1.705E-07*Ma^5 + 9.766E-07*ALPHA^5;
CD_delta_a = +4.02E-04 + 2.34E-05*ALPHA - 1.02E-04*Ma -3.46E-05*RE - 5.38E-07*ALPHA*Ma*RE + 3.08E-06*ALPHA^2 + 2.61E-06*Ma^2 + 6.84E-06*RE^2 + 5.28E-12*(ALPHA*Ma*RE)^2;
CD_delta_e = +4.02E-04 + 2.34E-05*ALPHA - 1.02E-04*Ma -3.46E-05*LE - 5.38E-07*ALPHA*Ma*LE + 3.08E-06*ALPHA^2 + 2.61E-06*Ma^2 + 6.84E-06*LE^2 + 5.28E-12*(ALPHA*Ma*LE)^2;
CD_delta_r = +7.5E-04 - 2.29E-05*ALPHA - 9.69E-05*Ma - 1.83E-06*RUD + 9.13E-09*ALPHA*Ma*RUD + 8.76E-07*ALPHA^2 + 2.7E-06*Ma^2 + 1.97E-06*RUD^2 - 1.77E-11*(ALPHA*Ma*RUD)^2;

%% 升力系数
CLa = - 8.19E-02 + 4.7E-02*Ma + 1.86E-02*ALPHA - 4.73E-04*ALPHA*Ma - 9.19E-03*Ma^2 - 1.52E-04*ALPHA^2 + 5.99E-07*(ALPHA*Ma)^2 + 7.74E-04*Ma^3 + 4.08E-06*ALPHA^3 - 2.93E-05*Ma^4 - 3.91E-07*ALPHA^4 + 4.12E-07*Ma^5 + 1.3E-08*ALPHA^5;
CL_delta_a = -1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma - 4.14E-04*RE - 3.51E-06*ALPHA*RE + 4.7E-06*ALPHA*Ma + 8.72E-06*Ma*RE - 1.7E-07*ALPHA*Ma*RE;
CL_delta_e = -1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma - 4.14E-04*LE - 3.51E-06*ALPHA*LE + 4.7E-06*ALPHA*Ma + 8.72E-06*Ma*LE - 1.7E-07*ALPHA*Ma*LE;

%% 侧向力系数
CYb = 1.76 + 4.58E-01*Ma - 3.26E-03*ALPHA + 3.8E-05*ALPHA*Ma - 6.36E-02*Ma^2 + 2.36E-03*ALPHA^2 + 3.45E-07*(ALPHA*Ma)^2 + 4.44E-03*Ma^3 - 6.03E-04*ALPHA^3 - 1.51E-04*Ma^4 + 4.52E-05*ALPHA^4 + 1.98E-06*Ma^5 - 1.09E-06*ALPHA^5;
CY_delta_a = -1.02E-06 - 1.12E-07*ALPHA + 4.48E-07*Ma + 2.27E-07*RE +4.11E-09*ALPHA*Ma*RE + 2.82E-09*ALPHA^2 - 2.36E-08*Ma^2 - 5.04E-08*RE^2 + 4.5E-14*(ALPHA*Ma*RE)^2;
CY_delta_e = -(-1.02E-06 - 1.12E-07*ALPHA + 4.48E-07*Ma + 2.27E-07*LE +4.11E-09*ALPHA*Ma*LE + 2.82E-09*ALPHA^2 - 2.36E-08*Ma^2 - 5.04E-08*LE^2 + 4.5E-14*(ALPHA*Ma*LE)^2);
CY_delta_r = -1.43E-18 + 4.86E-20*ALPHA + 1.86E-19*Ma + 3.84E-04*RUD - 1.17E-05*ALPHA*RUD - 1.07E-05*Ma*RUD + 2.6E-07*ALPHA*Ma*RUD;

