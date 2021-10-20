%%计算飞行高度处的大气环境参数
% 输入参数：飞行高度和飞行速度
% 输出参数：环境参数数组，具体定义如下：
%重力加速度g，空气密度Rho，马赫数Ma，温度Tmprt，声速Vs
% g = Env_para(1);  Rho = Env_para(2);  Ma = Env_para(3);   Tmprt = Env_para(4); Vs = Env_para(5);
function Env_para = calEnv_para(Height,Veloc)

Re = 6371393;  %%地球半径，单位m
g0 = 9.8; %%地球表面的重力加速度
T0 = 288.15; %%地球表面的温度
Rho0 = 1.225; %%地球表面的大气密度
h0 = 7315.2; %%计算所需的系数
%% 计算20-30KM的下的温度
% Tmprt = 196.65 + Height/(1+Height/Re)/1000; %自己推得温度的经验公式，可能不准，影响不大，也可以用下面的
%% 计算温度和空气密度
if Height <= 11000
    Tmprt = T0 - 0.0065*Height;
    Rho = Rho0*(Tmprt/T0)^4.25588;
elseif (Height>11000)&&(Height<=20000)
    Tmprt=216.65;
    Rho = 0.36392*exp((-Height+11000)/6341.62);
else
    Tmprt = 216.65+0.001*(Height-20000);
    Rho= Rho0*exp(-Height/h0);
%    Rho=0.088035*(1+(0.001*Height-20)/216.55)^(-35.1632);%%另一种计算方式
end

%% 计算声速和马赫数?
Vs = 20.0468*sqrt(Tmprt); %%声速
Ma = Veloc/Vs;  %%马赫数

%% 计算重力加速度?
g = g0*(Re/(Re+Height))^2;   

Env_para(1) = g;    
Env_para(2) = Rho;
Env_para(3) = Ma;
Env_para(4) = Tmprt;
Env_para(5) = Vs;
end