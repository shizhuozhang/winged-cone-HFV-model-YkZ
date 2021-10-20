%% 绕机体X轴的气动力矩系数Cl的计算，改变滚转角速度p
%输入参数：马赫，速度，攻角，侧滑角，三个舵偏角，滚转角速度p和偏航角速度r
%输出参数：总的滚转力矩系数C_l
Ma =15;
RE = 10;
LE = -10;
RUD = 0;
beta = 0;
ALPHAc = -2:0.5:12; %deg
b = 18.288;%%翼展 m
p = 0;
r = 0;
% ALPHA = ALPHA/57.3; %rad
n = length(ALPHAc);
Clb = zeros(1,n);
Cl_RE = zeros(1,n);
Cl_LE = zeros(1,n);
Cl_RUD = zeros(1,n);
Clp = zeros(1,n);
Clr = zeros(1,n);
Clw = zeros(1,n);
for i=1:1:n
        ALPHA = ALPHAc(i);
%% 侧滑引起的滚转力矩系数
Clb(i) = - 1.402E-01 + 3.326E-02*Ma - 7.590E-04*ALPHA + 8.596E-06*(ALPHA*Ma) ...
      - 3.794E-03*(Ma^2) + 2.354E-06*(ALPHA^2) -1.044E-08*((ALPHA*Ma)^2) + 2.219E-04*(Ma^3) - 8.964E-18*(ALPHA^3) ...
      - 6.462E-06*(Ma^4) + 3.803E-19*(ALPHA^4) + 7.419E-08*(Ma^5) -3.353E-21*(ALPHA^5);

%% 右舵引起的滚转力矩系数
Cl_RE(i) = + 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
        +2*(1.170E-04*RE + 2.794E-08*ALPHA*Ma*RE) + 4*(-1.160E-06*(RE^2) - 4.641E-11*((ALPHA*Ma*RE)^2)) ;

%% 左舵引起的滚转力矩系数
Cl_LE(i) = -( 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
        +2*(1.170E-04*LE + 2.794E-08*ALPHA*Ma*LE) + 4*(-1.160E-06*(LE^2) - 4.641E-11*((ALPHA*Ma*LE)^2)));

%% 方向舵引起的滚转力矩系数
Cl_RUD(i) = - 5.0103E-19 + 6.2723E-20*ALPHA + 2.3418E-20*Ma - 3.4201E-21*(ALPHA*Ma) ... 
         + 1.1441E-04*RUD - 2.6824E-06*(ALPHA*RUD) - 3.5496E-06*(Ma*RUD) + 5.5547E-08*(ALPHA*Ma)*RUD ;

%% 滚转角速度引起的滚转力矩系数
Clp(i) = - 2.99E-01 + 7.47E-02*Ma + 1.38E-03*ALPHA - 8.78E-05*(ALPHA*Ma) - 9.13E-03*(Ma^2) - 2.04E-04*(ALPHA^2) - 1.52E-07*((ALPHA*Ma)^2) ...
      + 5.73E-04*(Ma^3) - 3.86E-05*(ALPHA^3) - 1.79E-05*(Ma^4) + 4.21E-06*(ALPHA^4) + 2.20E-07*(Ma^5) - 1.15E-07*(ALPHA^5);

%% 偏航角速度引起的滚转力矩系数

Clr(i) = + 3.82E-01 - 1.06E-01*Ma + 1.94E-03* ALPHA - 8.15E-05*(ALPHA*Ma) + 1.45E-02*(Ma^2) - 9.76E-06*(ALPHA^2) + 4.49E-08*((ALPHA*Ma)^2) ...
      - 1.02E-03*(Ma^3) - 2.70E-07*(ALPHA^3) + 3.56E-05*(Ma^4) + 3.19E-08*(ALPHA^4) - 4.81E-07*(Ma^5) -1.06E-09*(ALPHA^5);

Clw(i) = Clb(i)*beta + Cl_RE(i) + Cl_LE(i) + Cl_RUD(i) + Clp(i)*(p*b/V/2) + Clr(i)*(r*b/V/2);%该式里的角度是弧度值
end

figure(1);
plot(ALPHAc,Clw,'-k','LineWidth',2);
grid on;
xlabel('alpha /deg','FontSize',12);
ylabel('Clw','FontSize',12);
%saveas(gcf,'Clw CurVe.fig');

figure(2);
plot(ALPHAc,Clb,'-r','LineWidth',2);
grid on;
xlabel('alpha /deg','FontSize',12);
ylabel('Clb','FontSize',12);
%saveas(gcf,'Clb CurVe.fig');

figure(3);
plot(ALPHAc,Cl_RE,'-.g','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,Cl_LE,'-.m','LineWidth',2);
plot(ALPHAc,Cl_RUD,'-.b','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('C_Y d','FontSize',12);
%saveas(gcf,'CYd CurVes.fig');

figure(4);
plot(ALPHAc,Clp,'-.g','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,Clr,'-.m','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('Cp Cr','FontSize',12);
%saveas(gcf,'CpCr CurVes.fig');
%通过曲线可知，滚转力矩系数主要是侧滑角引起的侧向力（E-2量级）
%俯仰舵舵偏引起的滚转力矩系数（E-3量级）
%方向舵引起的滚转力矩系数（E-3量级），但影响小于俯仰舵偏
% 角速率引起的滚转力矩系数（E-2量级），但由于除以速度，总的影响较小
%因此，当侧滑角为0，滚转力矩系数主要受俯仰舵影响，方向舵也会造成一定的干扰（（E-3量级））

