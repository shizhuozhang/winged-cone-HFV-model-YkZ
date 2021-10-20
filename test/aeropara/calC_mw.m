%% �ƻ���Y�����������ϵ��Cm�ļ��㣬�ı丩�����ٶ�q
%�����������գ��ٶȣ����ǣ��໬�ǣ�������ƫ�ǣ��������ٶ�q
%����������ܵĸ�������ϵ��C_m
Ma =15;
RE = 10;
LE = 10;
RUD = 10;
beta = 0;
ALPHAc = -2:0.5:12; %deg
c = 24.384;%%ƽ�������ҳ� m
q =0;
V = 4500;
% ALPHAc = ALPHAc/57.3; %rad
n = length(ALPHAc);
Cma = zeros(1,n);
Cm_RE = zeros(1,n);
Cm_LE = zeros(1,n);
Cm_RUD = zeros(1,n);
Cmq = zeros(1,n);
Cmw = zeros(1,n);
for i=1:1:n
        ALPHA = ALPHAc(i);

%% ��������ĸ�������ϵ��
Cma(i) = - 2.192E-02 + 7.739E-03*Ma - 2.260E-03*ALPHA + 1.808E-04*(ALPHA*Ma) - 8.849E-04*(Ma^2) + 2.616E-04*(ALPHA^2) ...
      - 2.880E-07*((ALPHA*Ma)^2) + 4.617E-05*(Ma^3) -7.887E-05*(ALPHA^3) - 1.143E-06*(Ma^4) ...
      + 8.288E-06*(ALPHA^4) + 1.082E-08*(Ma^5) - 2.789E-07*(ALPHA^5);
  
%% �Ҷ�����ĸ�������ϵ��
Cm_RE(i) = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma - 4.46E-06*ALPHA*Ma ...
        +2*(2.89E-04*RE + 4.48E-06*ALPHA*RE - 5.87E-06*Ma*RE + 9.72E-08*ALPHA*Ma*RE) ;
    
%% �������ĸ�������ϵ��
Cm_LE(i) = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma - 4.46E-06*ALPHA*Ma ...
        +2*(2.89E-04*LE + 4.48E-06*ALPHA*LE - 5.87E-06*Ma*LE + 9.72E-08*ALPHA*Ma*LE) ;

%% ���������ĸ�������ϵ��
Cm_RUD(i) = - 2.79E-05*ALPHA - 5.89E-08*(ALPHA^2) + 1.58E-03*(Ma^2) + 6.42E-08*(ALPHA^3) - 6.69E-04*(Ma^3) ...
         - 2.1E-08*(ALPHA^4) + 1.05E-04*(Ma^4) + 3.14E-09*(ALPHA^5) - 7.74E-06*(Ma^5) ...
         - 2.18E-10*(ALPHA^6) + 2.7E-07*(Ma^6) + 5.74E-12*(ALPHA^7) - 3.58E-09*(Ma^7) ...
         + 1.43E-07*(RUD^4) - 4.77E-22*(RUD^5) - 3.38E-10*(RUD^6) + 2.63E-24*(RUD^7);

%% �������ٶ�����ĸ�������ϵ��
Cmq(i) = - 1.36 + 3.86E-01*Ma + 7.85E-04*ALPHA + 1.4E-04*ALPHA*Ma - 5.42E-02*(Ma^2) + 2.36E-03*(ALPHA^2) - 1.95E-06*((ALPHA*Ma)^2) ...
      + 3.8E-03*(Ma^3) - 1.48E-03*(ALPHA^3) - 1.3E-04*(Ma^4) + 1.69E-04*(ALPHA^4) + 1.71E-06*(Ma^5) - 5.93E-06*(ALPHA^5);

Cmw(i) = Cma(i) + Cm_RE(i) + Cm_LE(i) + Cm_RUD(i) + Cmq(i)*(q*c/V/2);
end

figure(1);
plot(ALPHAc,Cmw,'-k','LineWidth',2);
grid on;
xlabel('alpha /deg','FontSize',12);
ylabel('C_m','FontSize',12);
%saveas(gcf,'Cm CurVe.fig');

figure(2);
plot(ALPHAc,Cma,'-r','LineWidth',2);
grid on;
xlabel('alpha /deg','FontSize',12);
ylabel('Cma','FontSize',12);
%saveas(gcf,'Cma CurVe.fig');

figure(3);
plot(ALPHAc,Cm_RE,'-.g','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,Cm_LE,'-.m','LineWidth',2);
plot(ALPHAc,Cm_RUD,'-.b','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('C_m d','FontSize',12);
%saveas(gcf,'Cmd CurVes.fig');

figure(4);
plot(ALPHAc,Cmq,'-.g','LineWidth',2);
grid on;
xlabel('alpha /deg','FontSize',12);
ylabel('Cq','FontSize',12);
%saveas(gcf,'Cq CurVes.fig');
%ͨ�����߿�֪����������ϵ����Ҫ�Ǹ�����͹�������ģ����ߴ�С�൱����E-3������
%�������ƫ����ĸ�������ϵ����E-3������
%���������ĸ������ؿɺ��ԣ�E-4������
% ����������ĸ�������ϵ����E-1�������������ڳ����ٶȣ��ܵ�Ӱ���С
%�ܵĸ�������ϵ�����нϴ�ķ�����