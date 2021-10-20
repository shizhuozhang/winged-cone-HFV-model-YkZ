%% ��������������λ�ò���
%���룺
%�����������ʸ�� AeroAng = [alpha, beta, mu];
function AeroAng_1 = RK_AeroAng( AeroAng, Omega, Force_a, V, h)

K1 = Equ_right_AeroAng( AeroAng, Omega, Force_a, V);
K2 = Equ_right_AeroAng( AeroAng + (h/2)*K1, Omega, Force_a, V );
K3 = Equ_right_AeroAng( AeroAng + (h/2)*K2, Omega, Force_a, V );
K4 = Equ_right_AeroAng( AeroAng + h*K3, Omega, Force_a, V );

AeroAng_1 = AeroAng +( K1 + 2*K2 + 2*K3 + K4)*h/6;
end

%%   �����ұ���
function dAeroAng = Equ_right_AeroAng( AeroAng, Omega, Force_a, V )

global m0;   %%�����������

alpha = AeroAng(1); beta = AeroAng(2); %mu = AeroAng(3); 
q = Omega(1); r = Omega(2); p = Omega(3); 
Fr_ap = Force_a(1);  Fr_bt = Force_a(2);  Fr_mu = Force_a(3); %%����ĺ���

dalpha = q - tan(beta)*(p*cos(alpha) + r*sin(alpha)) + Fr_ap/m0/V/cos(beta); %��һ��΢�ַ��� ����
dbeta = p*sin(alpha) - r*cos(alpha) + Fr_bt/m0/V; %�ڶ���΢�ַ��� �໬��
dmu = (p*cos(alpha) + r*sin(alpha))/cos(beta) + Fr_mu/m0/V; %������΢�ַ��� ����

dAeroAng(1) = dalpha;  dAeroAng(2) = dbeta;  dAeroAng(3) = dmu;  

end
