%% 计算
% 输入参数：
% 输出参数：

function TrimDelta = calTrimDelta(Com_angle,FltSdt_S)

global Xcg;  %%质心到参考力矩中心距离
global b;    %%翼展
global c;    %%平均气动弦长
global Coef_aero;  %%气动模型计算的转换系数 %本应该用弧度到度的转换系数，但由于有问题，暂时用这个调试

ALPHA = Coef_aero * Com_angle(1);  %%由于气动数据拟合的问题，这里本应该将弧度转化为度，但是有未知的复杂问题,这里用系数5简单代替
% beta = Com_angle(2);  %beta=0;
RUD = 0;

Height = FltSdt_S(3); Veloc = FltSdt_S(4); 
Env_para = calEnv_para(Height,Veloc);%计算当前的大气环境参数
Ma = Env_para(3); 

syms RE LE 

CDa =   + 8.717E-02 - 3.307E-02*Ma + 3.179E-03*ALPHA - 1.25E-04*ALPHA*Ma + 5.036E-03*(Ma^2) - 1.1E-03*(ALPHA^2) ...
        + 1.405E-07*((ALPHA*Ma)^2) - 3.658E-04*(Ma^3) + 3.175E-04*(ALPHA^3) + 1.274E-05*(Ma^4) - 2.985E-05*(ALPHA^4) ...
        - 1.705E-07*(Ma^5) + 9.766E-07*(ALPHA^5);
% CD_RE = + 4.5548E-04 + 2.5411E-05*ALPHA -1.1436E-04*Ma + 3.2187E-06*(ALPHA^2) + 3.0140E-06*(Ma^2) ...
%         - 3.6417E-05*RE - 5.3015E-07*ALPHA*Ma*RE + 6.9629E-06*(RE^2) + 2.1026E-12*(((ALPHA*Ma)*RE)^2);    
% CD_LE = + 4.5548E-04 + 2.5411E-05*ALPHA -1.1436E-04*Ma + 3.2187E-06*(ALPHA^2) + 3.0140E-06*(Ma^2) ...
%         - 3.6417E-05*LE - 5.3015E-07*ALPHA*Ma*LE + 6.9629E-06*(LE^2) + 2.1026E-12*(((ALPHA*Ma)*LE)^2);   
% CD_RUD = + 7.5E-04 - 2.29E-05*ALPHA - 9.69E-05*Ma + 8.76E-07*(ALPHA^2) + 2.7E-06*(Ma^2) ...
%          - 1.83E-06*RUD + 9.13E-09*ALPHA*Ma*RUD + 1.97E-06*(RUD^2) - 1.77E-11*((ALPHA*Ma*RUD)^2);    
C_D = CDa ; %+ CD_RE + CD_LE + CD_RUD

% CY_RE = -1.02E-06 - 1.12E-07*ALPHA + 4.48E-07*Ma + 2.82E-09*(ALPHA^2) - 2.36E-08*(Ma^2) ...
%         + 2.27E-07*RE + 4.11E-09*ALPHA*Ma*RE - 5.04E-08*(RE^2) + 4.5E-14*((ALPHA*Ma*RE)^2);
% CY_LE = -(-1.02E-06 - 1.12E-07*ALPHA + 4.48E-07*Ma + 2.82E-09*(ALPHA^2) - 2.36E-08*(Ma^2) ...
%         + 2.27E-07*LE + 4.11E-09*ALPHA*Ma*LE - 5.04E-08*(LE^2) + 4.5E-14*(ALPHA*Ma*LE)^2);
% CY_RUD = -1.43E-18 + 4.86E-20*ALPHA + 1.86E-19*Ma + 3.84E-04*RUD - 1.17E-05*ALPHA*RUD - 1.07E-05*Ma*RUD + 2.6E-07*ALPHA*Ma*RUD;
% C_Y = CY_RUD + CY_RE + CY_LE;% 

CLa = - 8.19E-02 + 4.7E-02*Ma + 1.86E-02*ALPHA - 4.73E-04*ALPHA*Ma - 9.19E-03*(Ma^2) - 1.52E-04*(ALPHA^2) + 5.99E-07*((ALPHA*Ma)^2) ...
      + 7.74E-04*(Ma^3) + 4.08E-06*(ALPHA^3) - 2.93E-05*(Ma^4) - 3.91E-07*(ALPHA^4) + 4.12E-07*(Ma^5) + 1.3E-08*(ALPHA^5);
CL_RE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
        - 4.14E-04*RE - 3.51E-06*ALPHA*RE + 8.72E-06*Ma*RE - 1.7E-07*ALPHA*Ma*RE;
CL_LE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
        - 4.14E-04*LE - 3.51E-06*ALPHA*LE + 8.72E-06*Ma*LE - 1.7E-07*ALPHA*Ma*LE;
C_L = CLa + CL_RE + CL_LE;

Cl_RE = + 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
        + 1.170E-04*RE + 2.794E-08*ALPHA*Ma*RE - 1.160E-06*(RE^2) - 4.641E-11*((ALPHA*Ma*RE)^2);
Cl_LE = -( 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
        + 1.170E-04*LE + 2.794E-08*ALPHA*Ma*LE - 1.160E-06*(LE^2) - 4.641E-11*((ALPHA*Ma*LE)^2));
Cl_RUD = - 5.0103E-19 + 6.2723E-20*ALPHA + 2.3418E-20*Ma - 3.4201E-21*(ALPHA*Ma) ... 
         + 1.1441E-04*RUD - 2.6824E-06*(ALPHA*RUD) - 3.5496E-06*(Ma*RUD) + 5.5547E-08*(ALPHA*Ma)*RUD ;
C_lw =  Cl_RE + Cl_LE + Cl_RUD;

Cma = - 2.192E-02 + 7.739E-03*Ma - 2.260E-03*ALPHA + 1.808E-04*(ALPHA*Ma) - 8.849E-04*(Ma^2) + 2.616E-04*(ALPHA^2) ...
      - 2.880E-07*((ALPHA*Ma)^2) + 4.617E-05*(Ma^3) -7.887E-05*(ALPHA^3) - 1.143E-06*(Ma^4) ...
      + 8.288E-06*(ALPHA^4) + 1.082E-08*(Ma^5) - 2.789E-07*(ALPHA^5);
Cm_RE = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma - 4.46E-06*ALPHA*Ma ...
        + 2.89E-04*RE + 4.48E-06*ALPHA*RE - 5.87E-06*Ma*RE + 9.72E-08*ALPHA*Ma*RE;
Cm_LE = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma - 4.46E-06*ALPHA*Ma ...
        + 2.89E-04*LE + 4.48E-06*ALPHA*LE - 5.87E-06*Ma*LE + 9.72E-08*ALPHA*Ma*LE;
Cm_RUD = - 2.79E-05*ALPHA - 5.89E-08*(ALPHA^2) + 1.58E-03*(Ma^2) + 6.42E-08*(ALPHA^3) - 6.69E-04*(Ma^3) ...
         - 2.1E-08*(ALPHA^4) + 1.05E-04*(Ma^4) + 3.14E-09*(ALPHA^5) - 7.74E-06*(Ma^5) ...
         - 2.18E-10*(ALPHA^6) + 2.7E-07*(Ma^6) + 5.74E-12*(ALPHA^7) - 3.58E-09*(Ma^7) ...
         + 1.43E-07*(RUD^4) - 4.77E-22*(RUD^5) - 3.38E-10*(RUD^6) + 2.63E-24*(RUD^7);
C_mw = Cma + Cm_RE + Cm_LE + Cm_RUD; 

% Cn_RE = + 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
%         - 1.30E-05*RE - 8.93E-08*(ALPHA*Ma)*RE + 1.97E-06*(RE^2) + 1.41E-11*((ALPHA*Ma*RE)^2) ;
% Cn_LE = -( 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
%         - 1.30E-05*LE - 8.93E-08*(ALPHA*Ma)*LE + 1.97E-06*(LE^2) + 1.41E-11*((ALPHA*Ma*LE)^2)) ;
% Cn_RUD = + 2.85E-18 - 3.59E-19 *ALPHA -1.26E-19*Ma + 1.57E-20*(ALPHA*Ma) ...
%          - 5.28E-04*RUD + 1.39E-05*(ALPHA*RUD) + 1.65E-05*(Ma*RUD) - 3.13E-07*(ALPHA*Ma)*RUD ;
% C_nw =  Cn_RE + Cn_LE + Cn_RUD ;%该式里的角度是弧度值  

%气动力矩在机体系下的坐标分量
eq1 =  C_lw*b;     %% 机体系下的绕X轴气动力矩
eq2 =  C_mw*c + Xcg*(C_D*sind(ALPHA) + C_L*cosd(ALPHA));  %% 机体系下的绕Y轴气动力矩
% eq3 =  C_nw*b - Xcg*C_Y;  %% 机体系下的绕Z轴气动力矩 不关注偏航

[REs, LEs] = solve(eq1, eq2,'RE','LE');
Da = double(REs); De = double(LEs); %%类型转化为double

TrimDelta(1) =  De; TrimDelta(2) =  Da; TrimDelta(3) =  RUD; %%舵偏顺序 e,a,r
end


