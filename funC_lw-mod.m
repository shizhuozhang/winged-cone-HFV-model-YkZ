%% 绕机体X轴的气动力矩系数Cl的计算，改变滚转角速度p
%输入参数：马赫，速度，攻角，侧滑角，三个舵偏角，滚转角速度p和偏航角速度r
%输出参数：总的滚转力矩系数C_l
function Clw = funC_lw(Ma,ALPHA,beta,RE,LE,RUD,p,r,V)  %注意1）大写的alpha 单位是度，2）舵偏顺序是，右、左、方向

global b;  %全局恒值变量，翼展，单位m

Clb = funClb(Ma,ALPHA);
Cl_RE = funCl_RE(Ma,ALPHA,RE);
Cl_LE = funCl_LE(Ma,ALPHA,LE);
Cl_RUD = funCl_RUD(Ma,ALPHA,RUD);
Clp = funClp(Ma,ALPHA);
Clr = funClr(Ma,ALPHA);

Clw = Clb*beta + Cl_RE + Cl_LE + Cl_RUD + Clp*(p*b/V/2) + Clr*(r*b/V/2);%该式里的角度是弧度值
end

%% 侧滑引起的滚转力矩系数
function Clb = funClb(Ma,ALPHA)
Clb = - 1.402E-01 + 3.326E-02*Ma - 7.590E-04*ALPHA + 8.596E-06*(ALPHA*Ma) ...
      - 3.794E-03*(Ma^2) + 2.354E-06*(ALPHA^2) -1.044E-08*((ALPHA*Ma)^2) + 2.219E-04*(Ma^3) - 8.964E-18*(ALPHA^3) ...
      - 6.462E-06*(Ma^4) + 3.803E-19*(ALPHA^4) + 7.419E-08*(Ma^5) -3.353E-21*(ALPHA^5);
end

%% 右舵引起的滚转力矩系数
function Cl_RE = funCl_RE(Ma,ALPHA,RE)
% Cl_RE = + 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
%         + 1.170E-04*RE + 2.794E-08*ALPHA*Ma*RE - 1.160E-06*(RE^2) - 4.641E-11*((ALPHA*Ma*RE)^2);
Cl_RE = + 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
        +2*(1.170E-04*RE + 2.794E-08*ALPHA*Ma*RE) + 4*(-1.160E-06*(RE^2) - 4.641E-11*((ALPHA*Ma*RE)^2));%%修改后的拟合公式，将舵偏的系数乘以了2
end

%% 左舵引起的滚转力矩系数
function Cl_LE = funCl_LE(Ma,ALPHA,LE)
% Cl_LE = -( 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
%         + 1.170E-04*LE + 2.794E-08*ALPHA*Ma*LE - 1.160E-06*(LE^2) - 4.641E-11*((ALPHA*Ma*LE)^2));
Cl_LE = -( 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
        +2*(1.170E-04*LE + 2.794E-08*ALPHA*Ma*LE) + 4*(-1.160E-06*(LE^2) - 4.641E-11*((ALPHA*Ma*LE)^2)));%%修改后的拟合公式，将舵偏的系数乘以了2
end

%% 方向舵引起的滚转力矩系数
function Cl_RUD = funCl_RUD(Ma,ALPHA,RUD)
Cl_RUD = - 5.0103E-19 + 6.2723E-20*ALPHA + 2.3418E-20*Ma - 3.4201E-21*(ALPHA*Ma) ... 
         + 1.1441E-04*RUD - 2.6824E-06*(ALPHA*RUD) - 3.5496E-06*(Ma*RUD) + 5.5547E-08*(ALPHA*Ma)*RUD ;
end

%% 滚转角速度引起的滚转力矩系数
function Clp = funClp(Ma,ALPHA)
Clp = - 2.99E-01 + 7.47E-02*Ma + 1.38E-03*ALPHA - 8.78E-05*(ALPHA*Ma) - 9.13E-03*(Ma^2) - 2.04E-04*(ALPHA^2) - 1.52E-07*((ALPHA*Ma)^2) ...
      + 5.73E-04*(Ma^3) - 3.86E-05*(ALPHA^3) - 1.79E-05*(Ma^4) + 4.21E-06*(ALPHA^4) + 2.20E-07*(Ma^5) - 1.15E-07*(ALPHA^5);
end

%% 偏航角速度引起的滚转力矩系数
function Clr = funClr(Ma,ALPHA)
Clr = + 3.82E-01 - 1.06E-01*Ma + 1.94E-03* ALPHA - 8.15E-05*(ALPHA*Ma) + 1.45E-02*(Ma^2) - 9.76E-06*(ALPHA^2) + 4.49E-08*((ALPHA*Ma)^2) ...
      - 1.02E-03*(Ma^3) - 2.70E-07*(ALPHA^3) + 3.56E-05*(Ma^4) + 3.19E-08*(ALPHA^4) - 4.81E-07*(Ma^5) -1.06E-09*(ALPHA^5);
end

%通过曲线可知，滚转力矩系数主要是侧滑角引起的侧向力（E-2量级）
%俯仰舵舵偏引起的滚转力矩系数（E-3量级）
%方向舵引起的滚转力矩系数（E-3量级），但影响小于俯仰舵偏
% 角速率引起的滚转力矩系数（E-2量级），但由于除以速度，总的影响较小
%因此，当侧滑角为0，滚转力矩系数主要受俯仰舵影响，方向舵也会造成一定的干扰（（E-3量级））