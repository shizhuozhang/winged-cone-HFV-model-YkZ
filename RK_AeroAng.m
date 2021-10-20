%% 龙格库塔积分求解位置参数
%输入：
%输出：气动角矢量 AeroAng = [alpha, beta, mu];
function AeroAng_1 = RK_AeroAng( AeroAng, Omega, Force_a, V, h)

K1 = Equ_right_AeroAng( AeroAng, Omega, Force_a, V);
K2 = Equ_right_AeroAng( AeroAng + (h/2)*K1, Omega, Force_a, V );
K3 = Equ_right_AeroAng( AeroAng + (h/2)*K2, Omega, Force_a, V );
K4 = Equ_right_AeroAng( AeroAng + h*K3, Omega, Force_a, V );

AeroAng_1 = AeroAng +( K1 + 2*K2 + 2*K3 + K4)*h/6;
end

%%   方程右边项
function dAeroAng = Equ_right_AeroAng( AeroAng, Omega, Force_a, V )

global m0;   %%再入飞行质量

alpha = AeroAng(1); beta = AeroAng(2); %mu = AeroAng(3); 
q = Omega(1); r = Omega(2); p = Omega(3); 
Fr_ap = Force_a(1);  Fr_bt = Force_a(2);  Fr_mu = Force_a(3); %%各轴的合力

dalpha = q - tan(beta)*(p*cos(alpha) + r*sin(alpha)) + Fr_ap/m0/V/cos(beta); %第一个微分方程 攻角
dbeta = p*sin(alpha) - r*cos(alpha) + Fr_bt/m0/V; %第二个微分方程 侧滑角
dmu = (p*cos(alpha) + r*sin(alpha))/cos(beta) + Fr_mu/m0/V; %第三个微分方程 倾侧角

dAeroAng(1) = dalpha;  dAeroAng(2) = dbeta;  dAeroAng(3) = dmu;  

end
