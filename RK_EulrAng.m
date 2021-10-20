%% ��������������λ�ò���
%���룺
%����� ŷ����ʸ�� EulerAng = [theta ,psi, phi];
function EulerAng_1 = RK_EulrAng(EulerAng, Omega, h)

K1 = Equ_right_EulrAng( EulerAng, Omega );
K2 = Equ_right_EulrAng( EulerAng + (h/2)*K1, Omega );
K3 = Equ_right_EulrAng( EulerAng + (h/2)*K2, Omega );
K4 = Equ_right_EulrAng( EulerAng + h*K3, Omega );

EulerAng_1 = EulerAng +( K1 + 2*K2 + 2*K3 + K4)*h/6;
end
%%   �����ұ���
function dEulrAng = Equ_right_EulrAng( EulerAng, Omega )

theta = EulerAng(1); phi = EulerAng(3); %psi = EulerAng(2); 
q = Omega(1); r = Omega(2); p = Omega(3); 

dtheta = q*cos(phi) - r*sin(phi); %��һ��΢�ַ��� ������
dpsi = (q*sin(phi) + r*cos(phi))/cos(theta); %�ڶ���΢�ַ��� ƫ����
dphi = p + (q*sin(phi) + r*cos(phi))*tan(theta); %������΢�ַ��� ��ת��

dEulrAng(1) = dtheta;  dEulrAng(2) = dpsi;  dEulrAng(3) = dphi;  
end
