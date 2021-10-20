%% 龙格库塔积分求解位置参数
%输入：
%输出：航迹矢量Trajct = [Veloc, gamma, chi];

function Trajct_1 = RK_Trajct(Trajct,Force_t,h)

K1 = Equ_right_Trajct(Trajct, Force_t);
K2 = Equ_right_Trajct(Trajct + (h/2)*K1, Force_t);
K3 = Equ_right_Trajct(Trajct + (h/2)*K2, Force_t);
K4 = Equ_right_Trajct(Trajct + h*K3, Force_t);

Trajct_1 = Trajct +(K1 + 2*K2 + 2*K3 + K4)*h/6;
end
%%   方程右边项
function dTrajct = Equ_right_Trajct(Trajct, Force_t)

global m0;   %%再入飞行质量

Veloc = Trajct(1);   gamma = Trajct(2);  % chi = Trajct(3);
Fr_x = Force_t(1);  Fr_y = Force_t(2);  Fr_z = Force_t(3);

dVeloc = Fr_x/m0;  %第一个微分方程 速度
dgamma = - Fr_z/m0/Veloc;  %第二个微分方程 航迹倾角
dchi = Fr_y/m0/Veloc/(cos(gamma));    %第三个微分方程 航迹偏角

dTrajct(1) = dVeloc;  dTrajct(2) = dgamma;  dTrajct(3) = dchi;  
end