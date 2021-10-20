%% 绕机体Z轴的气动力矩系数Cn的计算，改变偏航角速度r
%输入参数：马赫，速度，攻角，侧滑角，三个舵偏角，滚转角速度p和偏航角速度r
%输出参数：总的偏航力矩系数C_n
Ma =15;
RE = 10;
LE = 10;
RUD = 10;
beta = 0;
ALPHAc = -2:0.5:12; %deg
b = 18.288;%%翼展 m
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
%% 侧滑引起的偏航力矩系数
Cnb(i) = + 6.998E-04*ALPHA + 5.9115E-02*Ma -7.525E-05*(ALPHA*Ma) + 2.516E-04*((ALPHA).^2) -1.4824E-02*(Ma^2) - 2.1924E-07*((ALPHA*Ma)^2) ...
      - 1.0777E-04*(ALPHA^3) + 1.2692E-03*(Ma^3) + 1.0707E-08 *((ALPHA*Ma)^3) ...
      + 9.4989E-06*(ALPHA^4) - 4.7098E-05*(Ma^4) - 5.5472E-11*((ALPHA*Ma)^4) ...
      - 2.5953E-07*(ALPHA^5) + 6.4284E-07*(Ma^5) + 8.5863E-14*((ALPHA*Ma)^5);        

%% 右舵引起的偏航力矩系数
Cn_RE(i) = + 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
        - 1.30E-05*RE - 8.93E-08*(ALPHA*Ma)*RE + 1.97E-06*(RE^2) + 1.41E-11*((ALPHA*Ma*RE)^2) ;

%% 左舵引起的偏航力矩系数
Cn_LE(i) = -( 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
        - 1.30E-05*LE - 8.93E-08*(ALPHA*Ma)*LE + 1.97E-06*(LE^2) + 1.41E-11*((ALPHA*Ma*LE)^2)) ;

%% 方向舵引起的偏航力矩系数
Cn_RUD(i) = + 2.85E-18 - 3.59E-19 *ALPHA -1.26E-19*Ma + 1.57E-20*(ALPHA*Ma) ...
         - 5.28E-04*RUD + 1.39E-05*(ALPHA*RUD) + 1.65E-05*(Ma*RUD) - 3.13E-07*(ALPHA*Ma)*RUD ;

%% 滚转角速度引起的偏航力矩系数
Cnp(i) = + 3.68E-01 - 9.79E-02*Ma + 7.61E-16*ALPHA + 1.24E-02*(Ma^2) - 4.64E-16*(ALPHA^2) - 8.05E-04*(Ma^3) + 1.01E-16*(ALPHA^3) ...
      + 2.57E-05*(Ma^4) - 9.18E-18*(ALPHA^4) - 3.20E-07*(Ma^5) + 2.96E-19*(ALPHA^5);

%% 偏航角速度引起的偏航力矩系数
Cnr(i) = - 2.41 + 5.96E-01*Ma - 2.74E-03*ALPHA + 2.09E-04*(ALPHA*Ma) - 7.57E-02*(Ma^2) + 1.15E-03*(ALPHA^2) - 6.53E-08*((ALPHA*Ma)^2) ...
      + 4.90E-03*(Ma^3) - 3.87E-04*(ALPHA^3) - 1.57E-04*(Ma^4) + 3.60E-05*(ALPHA^4) + 1.96E-06*(Ma^5) - 1.18E-06*(ALPHA^5);

Cnw(i) = Cnb(i)*beta + Cn_RE(i) + Cn_LE(i) + Cn_RUD(i) + Cnp(i)*(p*b/V/2) + Cnr(i)*(r*b/V/2);%该式里的角度是弧度值

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
%通过曲线可知，偏航力矩系数系数主要是侧滑角（E-2量级）和方向舵（E-3量级）引起
%俯仰舵舵偏引起的偏航力矩系数较小（E-4量级）
%方向舵引起的偏航力矩系数（E-3量级）较大
% 角速率引起的偏航力矩系数（E-1量级），但由于除以速度，总的影响较小
%因此，当侧滑角为0，偏航力矩主要受方向舵影响（E-3量级）
