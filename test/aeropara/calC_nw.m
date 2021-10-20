%% �ƻ���Z�����������ϵ��Cn�ļ��㣬�ı�ƫ�����ٶ�r
%�����������գ��ٶȣ����ǣ��໬�ǣ�������ƫ�ǣ���ת���ٶ�p��ƫ�����ٶ�r
%����������ܵ�ƫ������ϵ��C_n
Ma =15;
RE = 10;
LE = 10;
RUD = 10;
beta = 0;
ALPHAc = -2:0.5:12; %deg
b = 18.288;%%��չ m
p = 0;
r = 0;
% ALPHA = ALPHA/57.3; %rad
n = length(ALPHAc);
Cnb = zeros(1,n);
Cn_RE = zeros(1,n);
Cn_LE = zeros(1,n);
Cn_RUD = zeros(1,n);
Cnp = zeros(1,n);
Cnr  = zeros(1,n);
Cnw = zeros(1,n);
for i=1:1:n
        ALPHA = ALPHAc(i);
%% �໬�����ƫ������ϵ��
Cnb(i) = + 6.998E-04*ALPHA + 5.9115E-02*Ma -7.525E-05*(ALPHA*Ma) + 2.516E-04*((ALPHA).^2) -1.4824E-02*(Ma^2) - 2.1924E-07*((ALPHA*Ma)^2) ...
      - 1.0777E-04*(ALPHA^3) + 1.2692E-03*(Ma^3) + 1.0707E-08 *((ALPHA*Ma)^3) ...
      + 9.4989E-06*(ALPHA^4) - 4.7098E-05*(Ma^4) - 5.5472E-11*((ALPHA*Ma)^4) ...
      - 2.5953E-07*(ALPHA^5) + 6.4284E-07*(Ma^5) + 8.5863E-14*((ALPHA*Ma)^5);        

%% �Ҷ������ƫ������ϵ��
Cn_RE(i) = + 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
        - 1.30E-05*RE - 8.93E-08*(ALPHA*Ma)*RE + 1.97E-06*(RE^2) + 1.41E-11*((ALPHA*Ma*RE)^2) ;

%% ��������ƫ������ϵ��
Cn_LE(i) = -( 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
        - 1.30E-05*LE - 8.93E-08*(ALPHA*Ma)*LE + 1.97E-06*(LE^2) + 1.41E-11*((ALPHA*Ma*LE)^2)) ;

%% ����������ƫ������ϵ��
Cn_RUD(i) = + 2.85E-18 - 3.59E-19 *ALPHA -1.26E-19*Ma + 1.57E-20*(ALPHA*Ma) ...
         - 5.28E-04*RUD + 1.39E-05*(ALPHA*RUD) + 1.65E-05*(Ma*RUD) - 3.13E-07*(ALPHA*Ma)*RUD ;

%% ��ת���ٶ������ƫ������ϵ��
Cnp(i) = + 3.68E-01 - 9.79E-02*Ma + 7.61E-16*ALPHA + 1.24E-02*(Ma^2) - 4.64E-16*(ALPHA^2) - 8.05E-04*(Ma^3) + 1.01E-16*(ALPHA^3) ...
      + 2.57E-05*(Ma^4) - 9.18E-18*(ALPHA^4) - 3.20E-07*(Ma^5) + 2.96E-19*(ALPHA^5);

%% ƫ�����ٶ������ƫ������ϵ��
Cnr(i) = - 2.41 + 5.96E-01*Ma - 2.74E-03*ALPHA + 2.09E-04*(ALPHA*Ma) - 7.57E-02*(Ma^2) + 1.15E-03*(ALPHA^2) - 6.53E-08*((ALPHA*Ma)^2) ...
      + 4.90E-03*(Ma^3) - 3.87E-04*(ALPHA^3) - 1.57E-04*(Ma^4) + 3.60E-05*(ALPHA^4) + 1.96E-06*(Ma^5) - 1.18E-06*(ALPHA^5);

Cnw(i) = Cnb(i)*beta + Cn_RE(i) + Cn_LE(i) + Cn_RUD(i) + Cnp(i)*(p*b/V/2) + Cnr(i)*(r*b/V/2);%��ʽ��ĽǶ��ǻ���ֵ

end

figure(1);
plot(ALPHAc,Cnw,'-k','LineWidth',2);
grid on;
xlabel('alpha /deg','FontSize',12);
ylabel('C_n','FontSize',12);
saveas(gcf,'Cn CurVe.fig');

figure(2);
plot(ALPHAc,Cnb,'-r','LineWidth',2);
grid on;
xlabel('alpha /deg','FontSize',12);
ylabel('Cnb','FontSize',12);
saveas(gcf,'Cnb CurVe.fig');

figure(3);
plot(ALPHAc,Cn_RE,'-.g','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,Cn_LE,'-.m','LineWidth',2);
plot(ALPHAc,Cn_RUD,'-.b','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('C_n d','FontSize',12);
saveas(gcf,'Cnd CurVes.fig');

figure(4);
plot(ALPHAc,Cnp,'-.g','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,Cnr,'-.m','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('Cp Cr','FontSize',12);
saveas(gcf,'CpCr CurVes.fig');
%ͨ�����߿�֪��ƫ������ϵ��ϵ����Ҫ�ǲ໬�ǣ�E-2�������ͷ���棨E-3����������
%�������ƫ�����ƫ������ϵ����С��E-4������
%����������ƫ������ϵ����E-3�������ϴ�
% �����������ƫ������ϵ����E-1�������������ڳ����ٶȣ��ܵ�Ӱ���С
%��ˣ����໬��Ϊ0��ƫ��������Ҫ�ܷ����Ӱ�죨E-3������
