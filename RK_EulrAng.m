%% 龙格库塔积分求解位置参数
%输入：
%输出： 欧拉角矢量 EulerAng = [theta ,psi, phi];
function EulerAng_1 = RK_EulrAng(EulerAng, Omega, h)

K1 = Equ_right_EulrAng( EulerAng, Omega );
K2 = Equ_right_EulrAng( EulerAng + (h/2)*K1, Omega );
K3 = Equ_right_EulrAng( EulerAng + (h/2)*K2, Omega );
K4 = Equ_right_EulrAng( EulerAng + h*K3, Omega );

EulerAng_1 = EulerAng +( K1 + 2*K2 + 2*K3 + K4)*h/6;
end
%%   方程右边项
function dEulrAng = Equ_right_EulrAng( EulerAng, Omega )

theta = EulerAng(1); phi = EulerAng(3); %psi = EulerAng(2); 
q = Omega(1); r = Omega(2); p = Omega(3); 

dtheta = q*cos(phi) - r*sin(phi); %第一个微分方程 俯仰角
dpsi = (q*sin(phi) + r*cos(phi))/cos(theta); %第二个微分方程 偏航角
dphi = p + (q*sin(phi) + r*cos(phi))*tan(theta); %第三个微分方程 滚转角

dEulrAng(1) = dtheta;  dEulrAng(2) = dpsi;  dEulrAng(3) = dphi;  
end
