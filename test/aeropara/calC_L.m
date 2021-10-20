%% 气动升力系数CL的计算
%输入参数：马赫，攻角，三个舵偏角
%输出参数：升力系数C_L
Ma =15;
RE = 10;
LE = 10;
RUD = 10;
ALPHAc = -2:0.5:12; %deg
% ALPHA = ALPHA/57.3; %rad
n = length(ALPHAc);
CLa = zeros(1,n);
CL_RE = zeros(1,n);
CL_LE = zeros(1,n);
CL_RUD = zeros(1,n);
C_L = zeros(1,n);
for i=1:1:n
        ALPHA = ALPHAc(i);
%% 攻角引起的升力系数
CLa(i) = - 8.19E-02 + 4.7E-02*Ma + 1.86E-02*ALPHA - 4.73E-04*ALPHA*Ma - 9.19E-03*(Ma^2) - 1.52E-04*(ALPHA^2) + 5.99E-07*((ALPHA*Ma)^2) ...
      + 7.74E-04*(Ma^3) + 4.08E-06*(ALPHA^3) - 2.93E-05*(Ma^4) - 3.91E-07*(ALPHA^4) + 4.12E-07*(Ma^5) + 1.3E-08*(ALPHA^5);


%% 右舵引起的升力系数
CL_RE(i) = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
       + 2*(- 4.14E-04*RE - 3.51E-06*ALPHA*RE + 8.72E-06*Ma*RE - 1.7E-07*ALPHA*Ma*RE);

% CL_RE(i) = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
%         - 8.28E-04*RE - 7.02E-06*ALPHA*RE + 1.744E-05*Ma*RE - 3.4E-07*ALPHA*Ma*RE;

%% 左舵引起的升力系数
CL_LE(i) = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
        + 2*(- 4.14E-04*LE - 3.51E-06*ALPHA*LE + 8.72E-06*Ma*LE - 1.7E-07*ALPHA*Ma*LE);
% CL_LE(i) = - 1.45E-05 + 1.01E-04*ALPHA + 7.1E-06*Ma + 4.7E-06*ALPHA*Ma ...
%         - 8.28E-04*LE - 7.02E-06*ALPHA*LE + 1.744E-05*Ma*LE - 3.4E-07*ALPHA*Ma*LE;
%% 总的升力系数
C_L(i) = CLa(i) + CL_RE(i) + CL_LE(i);
end

figure(1);
plot(ALPHAc,C_L,'-k','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,CLa,'-r','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('C_L','FontSize',12);
% saveas(gcf,'CLa CurVes.fig');

figure(2);
plot(ALPHAc,CL_RE,'-.g','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,CL_LE,'-.m','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('C_L d','FontSize',12);
% saveas(gcf,'CLd CurVes.fig');
%通过曲线可知，升力系数主要是攻角引起的阻力（E-2量级）
%舵偏引起的升力系数可以忽略（E-3）