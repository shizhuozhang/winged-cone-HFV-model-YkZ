%% 龙格库塔积分求解位置参数
%输入：
%输出：角速度矢量 Omega = [q ,r, p];
function Omega_1 = RK_Omega(Omega, Moment, h)

K1 = Equ_right_Omega( Omega, Moment );
K2 = Equ_right_Omega( Omega + (h/2)*K1, Moment );
K3 = Equ_right_Omega( Omega + (h/2)*K2, Moment );
K4 = Equ_right_Omega( Omega + h*K3, Moment );

Omega_1 = Omega +( K1 + 2*K2 + 2*K3 + K4)*h/6;
end
%%   方程右边项
function dOmega = Equ_right_Omega(Omega, Moment)

global Jx;   %%绕X轴转动惯量 
global Jy;   %%绕y轴转动惯量 
global Jz;   %%绕z轴转动惯量 

q = Omega(1); r = Omega(2); p = Omega(3); 
Mr_x = Moment(1);  Mr_y = Moment(2);  Mr_z = Moment(3); %%各轴的合力

dq = (Jz - Jx)*p*r/Jy + Mr_y/Jy; % 俯仰角速度 
dr = (Jx - Jy)*p*q/Jz + Mr_z/Jz; % 偏航加速度
dp = (Jy - Jz)*q*r/Jx + Mr_x/Jx; % 滚转加速度

dOmega(1) = dq;  dOmega(2) = dr;  dOmega(3) = dp;  
end
