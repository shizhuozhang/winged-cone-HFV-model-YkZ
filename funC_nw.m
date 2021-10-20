%% �ƻ���Z�����������ϵ��Cn�ļ��㣬�ı�ƫ�����ٶ�r
%�����������գ��ٶȣ����ǣ��໬�ǣ�������ƫ�ǣ���ת���ٶ�p��ƫ�����ٶ�r
%����������ܵ�ƫ������ϵ��C_n
function Cnw = funC_nw(Ma,ALPHA,beta,RE,LE,RUD,p,r,V) %ע��1����д��alpha ��λ�Ƕȣ�2����ƫ˳���ǣ��ҡ��󡢷���

global b;  %ȫ�ֺ�ֵ��������չ����λm

Cnb = funCnb(Ma,ALPHA);
Cn_RE = funCn_RE(Ma,ALPHA,RE);
Cn_LE = funCn_LE(Ma,ALPHA,LE);
Cn_RUD = funCn_RUD(Ma,ALPHA,RUD);
Cnp = funCnp(Ma,ALPHA);
Cnr = funCnr(Ma,ALPHA);

Cnw = Cnb*beta + Cn_RE + Cn_LE + Cn_RUD + Cnp*(p*b/V/2) + Cnr*(r*b/V/2);%��ʽ��ĽǶ��ǻ���ֵ
end

%% �໬�����ƫ������ϵ��
function Cnb = funCnb(Ma,ALPHA)
% Cnb = + 3.68E-01 + 6.03E-16*ALPHA + 9.79E-02*Ma - 3.84E-16*(ALPHA^2) + 1.24E-02*(Ma^2) + 8.58E-17*(ALPHA^3) - 8.05E-04*(Ma^3) ...
%       - 7.75E-18*(ALPHA^4) + 2.57E-05*(Ma^4) + 2.42E-19*(ALPHA^5) - 3.20E-07*(Ma^5); %ԭ���ݣ�ò�Ʋ���
Cnb = + 6.998E-04*ALPHA + 5.9115E-02*Ma -7.525E-05*(ALPHA*Ma) + 2.516E-04*((ALPHA).^2) -1.4824E-02*(Ma^2) - 2.1924E-07*((ALPHA*Ma)^2) ...
      - 1.0777E-04*(ALPHA^3) + 1.2692E-03*(Ma^3) + 1.0707E-08 *((ALPHA*Ma)^3) ...
      + 9.4989E-06*(ALPHA^4) - 4.7098E-05*(Ma^4) - 5.5472E-11*((ALPHA*Ma)^4) ...
      - 2.5953E-07*(ALPHA^5) + 6.4284E-07*(Ma^5) + 8.5863E-14*((ALPHA*Ma)^5);        
end

%% �Ҷ������ƫ������ϵ��
function Cn_RE = funCn_RE(Ma,ALPHA,RE)
Cn_RE = + 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
        - 1.30E-05*RE - 8.93E-08*(ALPHA*Ma)*RE + 1.97E-06*(RE^2) + 1.41E-11*((ALPHA*Ma*RE)^2) ;
end

%% ��������ƫ������ϵ��
function Cn_LE = funCn_LE(Ma,ALPHA,LE)
Cn_LE = -( 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
        - 1.30E-05*LE - 8.93E-08*(ALPHA*Ma)*LE + 1.97E-06*(LE^2) + 1.41E-11*((ALPHA*Ma*LE)^2)) ;
end

%% ����������ƫ������ϵ��
function Cn_RUD = funCn_RUD(Ma,ALPHA,RUD)
Cn_RUD = + 2.85E-18 - 3.59E-19 *ALPHA -1.26E-19*Ma + 1.57E-20*(ALPHA*Ma) ...
         - 5.28E-04*RUD + 1.39E-05*(ALPHA*RUD) + 1.65E-05*(Ma*RUD) - 3.13E-07*(ALPHA*Ma)*RUD ;
end

%% ��ת���ٶ������ƫ������ϵ��
function Cnp = funCnp(Ma,ALPHA)
%Cnp = + 3.68E-01 - 9.79E-02*Ma + 9.55E-16*ALPHA - 2.79E-17*(ALPHA*Ma)+ 1.24E-02*Ma^2 - 4.26E-16*ALPHA^2 + 7E-20*(ALPHA*Ma)^2 ...
%        - 8.05E-04*Ma^3 + 9.4E-17*ALPHA^3 + 2.57E-05*Ma^4 - 8.9E-18*ALPHA^4 -3.20E-07* Ma^5 + 2.99E-19*ALPHA^5 ;
Cnp = + 3.68E-01 - 9.79E-02*Ma + 7.61E-16*ALPHA + 1.24E-02*(Ma^2) - 4.64E-16*(ALPHA^2) - 8.05E-04*(Ma^3) + 1.01E-16*(ALPHA^3) ...
      + 2.57E-05*(Ma^4) - 9.18E-18*(ALPHA^4) - 3.20E-07*(Ma^5) + 2.96E-19*(ALPHA^5);
end

%% ƫ�����ٶ������ƫ������ϵ��
function Cnr = funCnr(Ma,ALPHA)
Cnr = - 2.41 + 5.96E-01*Ma - 2.74E-03*ALPHA + 2.09E-04*(ALPHA*Ma) - 7.57E-02*(Ma^2) + 1.15E-03*(ALPHA^2) - 6.53E-08*((ALPHA*Ma)^2) ...
      + 4.90E-03*(Ma^3) - 3.87E-04*(ALPHA^3) - 1.57E-04*(Ma^4) + 3.60E-05*(ALPHA^4) + 1.96E-06*(Ma^5) - 1.18E-06*(ALPHA^5);
end

%ͨ�����߿�֪��ƫ������ϵ��ϵ����Ҫ�ǲ໬�ǣ�E-2�������ͷ���棨E-3����������
%�������ƫ�����ƫ������ϵ����С��E-4������
%����������ƫ������ϵ����E-3�������ϴ�
% �����������ƫ������ϵ����E-1�������������ڳ����ٶȣ��ܵ�Ӱ���С
%��ˣ����໬��Ϊ0��ƫ��������Ҫ�ܷ����Ӱ�죨E-3������