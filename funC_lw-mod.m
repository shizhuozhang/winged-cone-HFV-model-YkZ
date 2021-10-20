%% �ƻ���X�����������ϵ��Cl�ļ��㣬�ı��ת���ٶ�p
%�����������գ��ٶȣ����ǣ��໬�ǣ�������ƫ�ǣ���ת���ٶ�p��ƫ�����ٶ�r
%����������ܵĹ�ת����ϵ��C_l
function Clw = funC_lw(Ma,ALPHA,beta,RE,LE,RUD,p,r,V)  %ע��1����д��alpha ��λ�Ƕȣ�2����ƫ˳���ǣ��ҡ��󡢷���

global b;  %ȫ�ֺ�ֵ��������չ����λm

Clb = funClb(Ma,ALPHA);
Cl_RE = funCl_RE(Ma,ALPHA,RE);
Cl_LE = funCl_LE(Ma,ALPHA,LE);
Cl_RUD = funCl_RUD(Ma,ALPHA,RUD);
Clp = funClp(Ma,ALPHA);
Clr = funClr(Ma,ALPHA);

Clw = Clb*beta + Cl_RE + Cl_LE + Cl_RUD + Clp*(p*b/V/2) + Clr*(r*b/V/2);%��ʽ��ĽǶ��ǻ���ֵ
end

%% �໬����Ĺ�ת����ϵ��
function Clb = funClb(Ma,ALPHA)
Clb = - 1.402E-01 + 3.326E-02*Ma - 7.590E-04*ALPHA + 8.596E-06*(ALPHA*Ma) ...
      - 3.794E-03*(Ma^2) + 2.354E-06*(ALPHA^2) -1.044E-08*((ALPHA*Ma)^2) + 2.219E-04*(Ma^3) - 8.964E-18*(ALPHA^3) ...
      - 6.462E-06*(Ma^4) + 3.803E-19*(ALPHA^4) + 7.419E-08*(Ma^5) -3.353E-21*(ALPHA^5);
end

%% �Ҷ�����Ĺ�ת����ϵ��
function Cl_RE = funCl_RE(Ma,ALPHA,RE)
% Cl_RE = + 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
%         + 1.170E-04*RE + 2.794E-08*ALPHA*Ma*RE - 1.160E-06*(RE^2) - 4.641E-11*((ALPHA*Ma*RE)^2);
Cl_RE = + 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
        +2*(1.170E-04*RE + 2.794E-08*ALPHA*Ma*RE) + 4*(-1.160E-06*(RE^2) - 4.641E-11*((ALPHA*Ma*RE)^2));%%�޸ĺ����Ϲ�ʽ������ƫ��ϵ��������2
end

%% �������Ĺ�ת����ϵ��
function Cl_LE = funCl_LE(Ma,ALPHA,LE)
% Cl_LE = -( 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
%         + 1.170E-04*LE + 2.794E-08*ALPHA*Ma*LE - 1.160E-06*(LE^2) - 4.641E-11*((ALPHA*Ma*LE)^2));
Cl_LE = -( 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
        +2*(1.170E-04*LE + 2.794E-08*ALPHA*Ma*LE) + 4*(-1.160E-06*(LE^2) - 4.641E-11*((ALPHA*Ma*LE)^2)));%%�޸ĺ����Ϲ�ʽ������ƫ��ϵ��������2
end

%% ���������Ĺ�ת����ϵ��
function Cl_RUD = funCl_RUD(Ma,ALPHA,RUD)
Cl_RUD = - 5.0103E-19 + 6.2723E-20*ALPHA + 2.3418E-20*Ma - 3.4201E-21*(ALPHA*Ma) ... 
         + 1.1441E-04*RUD - 2.6824E-06*(ALPHA*RUD) - 3.5496E-06*(Ma*RUD) + 5.5547E-08*(ALPHA*Ma)*RUD ;
end

%% ��ת���ٶ�����Ĺ�ת����ϵ��
function Clp = funClp(Ma,ALPHA)
Clp = - 2.99E-01 + 7.47E-02*Ma + 1.38E-03*ALPHA - 8.78E-05*(ALPHA*Ma) - 9.13E-03*(Ma^2) - 2.04E-04*(ALPHA^2) - 1.52E-07*((ALPHA*Ma)^2) ...
      + 5.73E-04*(Ma^3) - 3.86E-05*(ALPHA^3) - 1.79E-05*(Ma^4) + 4.21E-06*(ALPHA^4) + 2.20E-07*(Ma^5) - 1.15E-07*(ALPHA^5);
end

%% ƫ�����ٶ�����Ĺ�ת����ϵ��
function Clr = funClr(Ma,ALPHA)
Clr = + 3.82E-01 - 1.06E-01*Ma + 1.94E-03* ALPHA - 8.15E-05*(ALPHA*Ma) + 1.45E-02*(Ma^2) - 9.76E-06*(ALPHA^2) + 4.49E-08*((ALPHA*Ma)^2) ...
      - 1.02E-03*(Ma^3) - 2.70E-07*(ALPHA^3) + 3.56E-05*(Ma^4) + 3.19E-08*(ALPHA^4) - 4.81E-07*(Ma^5) -1.06E-09*(ALPHA^5);
end

%ͨ�����߿�֪����ת����ϵ����Ҫ�ǲ໬������Ĳ�������E-2������
%�������ƫ����Ĺ�ת����ϵ����E-3������
%���������Ĺ�ת����ϵ����E-3����������Ӱ��С�ڸ�����ƫ
% ����������Ĺ�ת����ϵ����E-2�������������ڳ����ٶȣ��ܵ�Ӱ���С
%��ˣ����໬��Ϊ0����ת����ϵ����Ҫ�ܸ�����Ӱ�죬�����Ҳ�����һ���ĸ��ţ���E-3��������