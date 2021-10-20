%% ��������������λ�ò���
%���룺
%��������ٶ�ʸ�� Omega = [q ,r, p];
function Omega_1 = RK_Omega(Omega, Moment, h)

K1 = Equ_right_Omega( Omega, Moment );
K2 = Equ_right_Omega( Omega + (h/2)*K1, Moment );
K3 = Equ_right_Omega( Omega + (h/2)*K2, Moment );
K4 = Equ_right_Omega( Omega + h*K3, Moment );

Omega_1 = Omega +( K1 + 2*K2 + 2*K3 + K4)*h/6;
end
%%   �����ұ���
function dOmega = Equ_right_Omega(Omega, Moment)

global Jx;   %%��X��ת������ 
global Jy;   %%��y��ת������ 
global Jz;   %%��z��ת������ 

q = Omega(1); r = Omega(2); p = Omega(3); 
Mr_x = Moment(1);  Mr_y = Moment(2);  Mr_z = Moment(3); %%����ĺ���

dq = (Jz - Jx)*p*r/Jy + Mr_y/Jy; % �������ٶ� 
dr = (Jx - Jy)*p*q/Jz + Mr_z/Jz; % ƫ�����ٶ�
dp = (Jy - Jz)*q*r/Jx + Mr_x/Jx; % ��ת���ٶ�

dOmega(1) = dq;  dOmega(2) = dr;  dOmega(3) = dp;  
end
