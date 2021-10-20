%% 气动阻力系数CD的计算
%输入参数：马赫，攻角，三个舵偏角
%输出参数：阻力系数C_D

Ma =15;
RE = 10;
LE = 10;
RUD = 10;
ALPHAc = -2:0.5:12; %deg
%  ALPHAc = ALPHAc/57.3; %rad
n = length(ALPHAc);
CDa = zeros(1,n);
CD_RE = zeros(1,n);
CD_LE = zeros(1,n);
CD_RUD = zeros(1,n);
C_D = zeros(1,n);
for i=1:1:n
    ALPHA = ALPHAc(i);
%% 攻角引起的阻力系数
CDa(i) =   + 8.717E-02 - 3.307E-02*Ma + 3.179E-03*ALPHA - 1.25E-04*ALPHA*Ma + 5.036E-03*(Ma^2) - 1.1E-03*(ALPHA^2) ...
        + 1.405E-07*((ALPHA*Ma)^2) - 3.658E-04*(Ma^3) + 3.175E-04*(ALPHA^3) + 1.274E-05*(Ma^4) - 2.985E-05*(ALPHA^4) ...
        - 1.705E-07*(Ma^5) + 9.766E-07*(ALPHA^5);

%% 右舵引起的阻力系数
% CD_RE = + 4.02E-04 + 2.34E-05*ALPHA - 1.02E-04*Ma + 3.08E-06*(ALPHA^2) + 2.61E-06*(Ma^2) ...
%         - 3.46E-05*RE - 5.38E-07*ALPHA*Ma*RE + 6.84E-06*(RE^2) + 5.28E-12*((ALPHA*Ma*RE)^2);  % 原数据，似乎不对
CD_RE(i) = + 4.5548E-04 + 2.5411E-05*ALPHA -1.1436E-04*Ma + 3.2187E-06*(ALPHA^2) + 3.0140E-06*(Ma^2) ...
        - 3.6417E-05*RE - 5.3015E-07*ALPHA*Ma*RE + 6.9629E-06*(RE^2) + 2.1026E-12*(((ALPHA*Ma)*RE)^2);    

%% 左舵引起的阻力系数
% CD_RE = + 4.02E-04 + 2.34E-05*ALPHA - 1.02E-04*Ma + 3.08E-06*(ALPHA^2) + 2.61E-06*(Ma^2) ...
%         - 3.46E-05*RE - 5.38E-07*ALPHA*Ma*RE + 6.84E-06*(RE^2) + 5.28E-12*((ALPHA*Ma*RE)^2);  % 原数据，似乎不对
CD_LE(i) = + 4.5548E-04 + 2.5411E-05*ALPHA -1.1436E-04*Ma + 3.2187E-06*(ALPHA^2) + 3.0140E-06*(Ma^2) ...
        - 3.6417E-05*LE - 5.3015E-07*ALPHA*Ma*LE + 6.9629E-06*(LE^2) + 2.1026E-12*(((ALPHA*Ma)*LE)^2);   

%% 方向舵引起的阻力系数
CD_RUD(i) = + 7.5E-04 - 2.29E-05*ALPHA - 9.69E-05*Ma + 8.76E-07*(ALPHA^2) + 2.7E-06*(Ma^2) ...
         - 1.83E-06*RUD + 9.13E-09*ALPHA*Ma*RUD + 1.97E-06*(RUD^2) - 1.77E-11*((ALPHA*Ma*RUD)^2);

 %% 总的阻力系数    
C_D(i) = CDa(i) + CD_RE(i) + CD_LE(i) + CD_RUD(i);
end

figure(1);
plot(ALPHAc,C_D,'-k','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,CDa,'-r','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('C_D','FontSize',12);
saveas(gcf,'CDa CurVes.fig');

figure(2);
plot(ALPHAc,CD_RE,'-.g','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,CD_LE,'-.m','LineWidth',2);
plot(ALPHAc,CD_RUD,'-.b','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('C_D d','FontSize',12);
saveas(gcf,'CDd CurVes.fig');
%通过曲线可知，阻力系数主要是攻角引起的阻力（5*E-3-40*E-3量级）
%舵偏引起的阻力系数可以忽略（5*E-4）