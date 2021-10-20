%% ��������ϵ��CL�ļ���
%�����������գ����ǣ�������ƫ��
%�������������ϵ��C_L
function C_L=funC_L(Ma,ALPHA,RE,LE) %ע��1����д��alpha ��λ�Ƕȣ�2����ƫ˳���ǣ��ҡ��󡢷���

CLa = funCLa(Ma,ALPHA);
CL_RE = funCL_RE(Ma,ALPHA,RE);
CL_LE = funCL_LE(Ma,ALPHA,LE);
C_L = CLa + CL_RE + CL_LE;
end

%% �������������ϵ��
function CLa = funCLa(Ma,ALPHA)
CLa = - 8.19E-02 + 4.7E-02*Ma + 1.86E-02*ALPHA - 4.73E-04*ALPHA*Ma - 9.19E-03*(Ma^2) - 1.52E-04*(ALPHA^2) + 5.99E-07*((ALPHA*Ma)^2) ...
      + 7.74E-04*(Ma^3) + 4.08E-06*(ALPHA^3) - 2.93E-05*(Ma^4) - 3.91E-07*(ALPHA^4) + 4.12E-07*(Ma^5) + 1.3E-08*(ALPHA^5);
end

%% �Ҷ����������ϵ��
function CL_RE = funCL_RE(Ma,ALPHA,RE)
% CL_RE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
%         - 4.14E-04*RE - 3.51E-06*ALPHA*RE + 8.72E-06*Ma*RE - 1.7E-07*ALPHA*Ma*RE;
CL_RE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
        + 2*(- 4.14E-04*RE - 3.51E-06*ALPHA*RE + 8.72E-06*Ma*RE - 1.7E-07*ALPHA*Ma*RE);%%% �޸ĺ����Ϲ�ʽ������ƫ��ϵ��������2
end

%% ������������ϵ��
function CL_LE = funCL_LE(Ma,ALPHA,LE)
% CL_LE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
%         - 4.14E-04*LE - 3.51E-06*ALPHA*LE + 8.72E-06*Ma*LE - 1.7E-07*ALPHA*Ma*LE;
CL_LE = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
        + 2*(- 4.14E-04*LE - 3.51E-06*ALPHA*LE + 8.72E-06*Ma*LE - 1.7E-07*ALPHA*Ma*LE);%%% �޸ĺ����Ϲ�ʽ������ƫ��ϵ��������2
end
%ͨ�����߿�֪������ϵ����Ҫ�ǹ��������������E-2������
%��ƫ���������ϵ�����Ժ��ԣ�E-3��