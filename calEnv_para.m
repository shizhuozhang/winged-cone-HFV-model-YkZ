%%������и߶ȴ��Ĵ�����������
% ������������и߶Ⱥͷ����ٶ�
% ��������������������飬���嶨�����£�
%�������ٶ�g�������ܶ�Rho�������Ma���¶�Tmprt������Vs
% g = Env_para(1);  Rho = Env_para(2);  Ma = Env_para(3);   Tmprt = Env_para(4); Vs = Env_para(5);
function Env_para = calEnv_para(Height,Veloc)

Re = 6371393;  %%����뾶����λm
g0 = 9.8; %%���������������ٶ�
T0 = 288.15; %%���������¶�
Rho0 = 1.225; %%�������Ĵ����ܶ�
h0 = 7315.2; %%���������ϵ��
%% ����20-30KM���µ��¶�
% Tmprt = 196.65 + Height/(1+Height/Re)/1000; %�Լ��Ƶ��¶ȵľ��鹫ʽ�����ܲ�׼��Ӱ�첻��Ҳ�����������
%% �����¶ȺͿ����ܶ�
if Height <= 11000
    Tmprt = T0 - 0.0065*Height;
    Rho = Rho0*(Tmprt/T0)^4.25588;
elseif (Height>11000)&&(Height<=20000)
    Tmprt=216.65;
    Rho = 0.36392*exp((-Height+11000)/6341.62);
else
    Tmprt = 216.65+0.001*(Height-20000);
    Rho= Rho0*exp(-Height/h0);
%    Rho=0.088035*(1+(0.001*Height-20)/216.55)^(-35.1632);%%��һ�ּ��㷽ʽ
end

%% �������ٺ������?
Vs = 20.0468*sqrt(Tmprt); %%����
Ma = Veloc/Vs;  %%�����

%% �����������ٶ�?
g = g0*(Re/(Re+Height))^2;   

Env_para(1) = g;    
Env_para(2) = Rho;
Env_para(3) = Ma;
Env_para(4) = Tmprt;
Env_para(5) = Vs;
end