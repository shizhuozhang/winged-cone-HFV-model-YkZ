%% ��������ϵ��CD�ļ���
%�����������գ����ǣ�������ƫ��
%�������������ϵ��C_D
function C_D = funC_D(Ma,ALPHA,RE,LE,RUD) %ע��1����д��alpha ��λ�Ƕȣ�2����ƫ˳���ǣ��ҡ��󡢷���

CDa = funCDa(Ma,ALPHA);
CD_RE = funCD_LE(Ma,ALPHA,RE);
CD_LE = funCD_RE(Ma,ALPHA,LE);
CD_RUD = funCD_RUD(Ma,ALPHA,RUD);

C_D = CDa + CD_RE + CD_LE + CD_RUD;
end

%% �������������ϵ��
function CDa = funCDa(Ma,ALPHA)
CDa =   + 8.717E-02 - 3.307E-02*Ma + 3.179E-03*ALPHA - 1.25E-04*ALPHA*Ma + 5.036E-03*(Ma^2) - 1.1E-03*(ALPHA^2) ...
        + 1.405E-07*((ALPHA*Ma)^2) - 3.658E-04*(Ma^3) + 3.175E-04*(ALPHA^3) + 1.274E-05*(Ma^4) - 2.985E-05*(ALPHA^4) ...
        - 1.705E-07*(Ma^5) + 9.766E-07*(ALPHA^5);
end

%% �Ҷ����������ϵ��
function CD_RE = funCD_RE(Ma,ALPHA,RE)
% CD_RE = + 4.02E-04 + 2.34E-05*ALPHA - 1.02E-04*Ma + 3.08E-06*(ALPHA^2) + 2.61E-06*(Ma^2) ...
%         - 3.46E-05*RE - 5.38E-07*ALPHA*Ma*RE + 6.84E-06*(RE^2) + 5.28E-12*((ALPHA*Ma*RE)^2);  % ԭ���ݣ��ƺ�����
CD_RE = + 4.5548E-04 + 2.5411E-05*ALPHA -1.1436E-04*Ma + 3.2187E-06*(ALPHA^2) + 3.0140E-06*(Ma^2) ...
        - 3.6417E-05*RE - 5.3015E-07*ALPHA*Ma*RE + 6.9629E-06*(RE^2) + 2.1026E-12*(((ALPHA*Ma)*RE)^2);    
end

%% ������������ϵ��
function CD_LE = funCD_LE(Ma,ALPHA,LE)
% CD_RE = + 4.02E-04 + 2.34E-05*ALPHA - 1.02E-04*Ma + 3.08E-06*(ALPHA^2) + 2.61E-06*(Ma^2) ...
%         - 3.46E-05*RE - 5.38E-07*ALPHA*Ma*RE + 6.84E-06*(RE^2) + 5.28E-12*((ALPHA*Ma*RE)^2);  % ԭ���ݣ��ƺ�����
CD_LE = + 4.5548E-04 + 2.5411E-05*ALPHA -1.1436E-04*Ma + 3.2187E-06*(ALPHA^2) + 3.0140E-06*(Ma^2) ...
        - 3.6417E-05*LE - 5.3015E-07*ALPHA*Ma*LE + 6.9629E-06*(LE^2) + 2.1026E-12*(((ALPHA*Ma)*LE)^2);   
end

%% ��������������ϵ��
function CD_RUD = funCD_RUD(Ma,ALPHA,RUD)
CD_RUD = + 7.5E-04 - 2.29E-05*ALPHA - 9.69E-05*Ma + 8.76E-07*(ALPHA^2) + 2.7E-06*(Ma^2) ...
         - 1.83E-06*RUD + 9.13E-09*ALPHA*Ma*RUD + 1.97E-06*(RUD^2) - 1.77E-11*((ALPHA*Ma*RUD)^2);
end

%ͨ�����߿�֪������ϵ����Ҫ�ǹ��������������5*E-3-4*E-2������
%��ƫ���������ϵ�����Ժ��ԣ�5*E-4��