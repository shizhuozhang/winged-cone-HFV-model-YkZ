%% �ƻ���Y�����������ϵ��Cm�ļ��㣬�ı丩�����ٶ�q
%�����������գ��ٶȣ����ǣ��໬�ǣ�������ƫ�ǣ��������ٶ�q
%����������ܵĸ�������ϵ��C_m
function Cmw = funC_mw(Ma,ALPHA,RE,LE,RUD,q,V) %ע��1����д��alpha ��λ�Ƕȣ�2����ƫ˳���ǣ��ҡ��󡢷���

global c;  %ȫ�ֺ�ֵ������ƽ�������ҳ�,��λm

%Cma = funCma(Ma,alpha,delta_a);
Cma = funCma(Ma,ALPHA);%����������͹������
Cm_RE = funCm_RE(Ma,ALPHA,RE);
Cm_LE = funCm_LE(Ma,ALPHA,LE);
Cm_RUD = funCm_RUD(Ma,ALPHA,RUD);
Cmq = funCmq(Ma,ALPHA);

Cmw = Cma + Cm_RE + Cm_LE + Cm_RUD + Cmq*(q*c/V/2);
end

%% ��������ĸ�������ϵ��
function Cma = funCma(Ma,ALPHA)
Cma = - 2.192E-02 + 7.739E-03*Ma - 2.260E-03*ALPHA + 1.808E-04*(ALPHA*Ma) - 8.849E-04*(Ma^2) + 2.616E-04*(ALPHA^2) ...
      - 2.880E-07*((ALPHA*Ma)^2) + 4.617E-05*(Ma^3) -7.887E-05*(ALPHA^3) - 1.143E-06*(Ma^4) ...
      + 8.288E-06*(ALPHA^4) + 1.082E-08*(Ma^5) - 2.789E-07*(ALPHA^5);
end
%% �Ҷ�����ĸ�������ϵ��
function Cm_RE = funCm_RE(Ma,ALPHA,RE)
% Cm_RE = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma - 4.46E-06*ALPHA*Ma ...
%         + 2.89E-04*RE + 4.48E-06*ALPHA*RE - 5.87E-06*Ma*RE + 9.72E-08*ALPHA*Ma*RE;
Cm_RE = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma - 4.46E-06*ALPHA*Ma ...
        +2*(2.89E-04*RE + 4.48E-06*ALPHA*RE - 5.87E-06*Ma*RE + 9.72E-08*ALPHA*Ma*RE);%%�޸ĺ����Ϲ�ʽ������ƫ��ϵ��������2
end

%% �������ĸ�������ϵ��
function Cm_LE = funCm_LE(Ma,ALPHA,LE)
% Cm_LE = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma - 4.46E-06*ALPHA*Ma ...
%         + 2.89E-04*LE + 4.48E-06*ALPHA*LE - 5.87E-06*Ma*LE + 9.72E-08*ALPHA*Ma*LE;
Cm_LE = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma - 4.46E-06*ALPHA*Ma ...
        +2*(2.89E-04*LE + 4.48E-06*ALPHA*LE - 5.87E-06*Ma*LE + 9.72E-08*ALPHA*Ma*LE);  %%�޸ĺ����Ϲ�ʽ������ƫ��ϵ��������2
end

%% ���������ĸ�������ϵ��
function Cm_RUD = funCm_RUD(Ma,ALPHA,RUD)
Cm_RUD = - 2.79E-05*ALPHA - 5.89E-08*(ALPHA^2) + 1.58E-03*(Ma^2) + 6.42E-08*(ALPHA^3) - 6.69E-04*(Ma^3) ...
         - 2.1E-08*(ALPHA^4) + 1.05E-04*(Ma^4) + 3.14E-09*(ALPHA^5) - 7.74E-06*(Ma^5) ...
         - 2.18E-10*(ALPHA^6) + 2.7E-07*(Ma^6) + 5.74E-12*(ALPHA^7) - 3.58E-09*(Ma^7) ...
         + 1.43E-07*(RUD^4) - 4.77E-22*(RUD^5) - 3.38E-10*(RUD^6) + 2.63E-24*(RUD^7);
end

%% �������ٶ�����ĸ�������ϵ��
function Cmq = funCmq(Ma,ALPHA)
Cmq = - 1.36 + 3.86E-01*Ma + 7.85E-04*ALPHA + 1.4E-04*ALPHA*Ma - 5.42E-02*(Ma^2) + 2.36E-03*(ALPHA^2) - 1.95E-06*((ALPHA*Ma)^2) ...
      + 3.8E-03*(Ma^3) - 1.48E-03*(ALPHA^3) - 1.3E-04*(Ma^4) + 1.69E-04*(ALPHA^4) + 1.71E-06*(Ma^5) - 5.93E-06*(ALPHA^5);
end

%ͨ�����߿�֪����������ϵ����Ҫ�Ǹ�����͹�������ģ����ߴ�С�൱����E-3������
%�������ƫ����ĸ�������ϵ����E-3������
%���������ĸ������ؿɺ��ԣ�E-4������
% ����������ĸ�������ϵ����E-1�������������ڳ����ٶȣ��ܵ�Ӱ���С
%�ܵĸ�������ϵ�����нϴ�ķ�����