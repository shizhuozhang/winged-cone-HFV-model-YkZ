%% 气动升力系数CL的计算
%输入参数：马赫，攻角，三个舵偏角
%输出参数：升力系数C_L
function C_L=funC_L(Ma,ALPHA,RE,LE) %注意1）大写的alpha 单位是度，2）舵偏顺序是，右、左、方向

CLa = funCLa(Ma,ALPHA);
CL_RE = funCL_RE(Ma,ALPHA,RE);
CL_LE = funCL_LE(Ma,ALPHA,LE);
C_L = CLa + CL_RE + CL_LE;
end

%% 攻角引起的升力系数
function CLa = funCLa(Ma,ALPHA)
CLa = - 8.19E-02 + 4.7E-02*Ma + 1.86E-02*ALPHA - 4.73E-04*ALPHA*Ma - 9.19E-03*(Ma^2) - 1.52E-04*(ALPHA^2) + 5.99E-07*((ALPHA*Ma)^2) ...
      + 7.74E-04*(Ma^3) + 4.08E-06*(ALPHA^3) - 2.93E-05*(Ma^4) - 3.91E-07*(ALPHA^4) + 4.12E-07*(Ma^5) + 1.3E-08*(ALPHA^5);
end

%% 右舵引起的升力系数
function CL_RE = funCL_RE(Ma,ALPHA,RE)
% CL_RE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
%         - 4.14E-04*RE - 3.51E-06*ALPHA*RE + 8.72E-06*Ma*RE - 1.7E-07*ALPHA*Ma*RE;
CL_RE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
        + 2*(- 4.14E-04*RE - 3.51E-06*ALPHA*RE + 8.72E-06*Ma*RE - 1.7E-07*ALPHA*Ma*RE);%%% 修改后的拟合公式，将舵偏的系数乘以了2
end

%% 左舵引起的升力系数
function CL_LE = funCL_LE(Ma,ALPHA,LE)
% CL_LE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
%         - 4.14E-04*LE - 3.51E-06*ALPHA*LE + 8.72E-06*Ma*LE - 1.7E-07*ALPHA*Ma*LE;
CL_LE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
        + 2*(- 4.14E-04*LE - 3.51E-06*ALPHA*LE + 8.72E-06*Ma*LE - 1.7E-07*ALPHA*Ma*LE);%%% 修改后的拟合公式，将舵偏的系数乘以了2
end
%通过曲线可知，升力系数主要是攻角引起的升力（E-2量级）
%舵偏引起的升力系数可以忽略（E-3）