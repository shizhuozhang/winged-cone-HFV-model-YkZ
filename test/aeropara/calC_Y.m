%% 气动侧向力系数CY的计算
%输入参数：马赫，攻角，侧滑角，三个舵偏角
%输出参数：侧向力系数C_Y
Ma =15;
RE = 10;
LE = 10;
RUD = 0;
beta = 0;
ALPHAc = -2:0.5:12; %deg
% ALPHA = ALPHA/57.3; %rad
n = length(ALPHAc);
CYb = zeros(1,n);
CY_RE = zeros(1,n);
CY_LE = zeros(1,n);
CY_RUD = zeros(1,n);
C_Y = zeros(1,n);
for i=1:1:n
        ALPHA = ALPHAc(i);
%% 攻角引起的侧向力系数
CYb(i) =  -2.9253E-01*Ma + 2.8803E-03*ALPHA - 2.8943E-04*(ALPHA*Ma)+ 5.4822E-02*(Ma^2) + 7.3535E-04*(ALPHA^2) ...
      - 4.6490E-09*((ALPHA*(Ma^2))^2) - 2.0675E-08*(((ALPHA^2)*Ma)^2) + 4.6205E-06*((ALPHA*Ma)^2) + 2.6144E-11*(((ALPHA^2)* (Ma^2))^2) ...
      - 4.3203E-03*(Ma^3) - 3.7405E-04*(ALPHA^3) + 1.5495E-04*(Ma^4) + 2.8183E-05*(ALPHA^4) ...
      - 2.0829E-06*(Ma^5) -5.2083E-07*(ALPHA^5);      
%% 右舵引起的侧向力系数
CY_RE(i) = -1.02E-06 - 1.12E-07*ALPHA + 4.48E-07*Ma + 2.82E-09*(ALPHA^2) - 2.36E-08*(Ma^2) ...
        + 2.27E-07*RE + 4.11E-09*ALPHA*Ma*RE - 5.04E-08*(RE^2) + 4.5E-14*((ALPHA*Ma*RE)^2);

%% 左舵引起的侧向力系数
CY_LE(i) = -(-1.02E-06 - 1.12E-07*ALPHA + 4.48E-07*Ma + 2.82E-09*(ALPHA^2) - 2.36E-08*(Ma^2) ...
        + 2.27E-07*LE + 4.11E-09*ALPHA*Ma*LE - 5.04E-08*(LE^2) + 4.5E-14*(ALPHA*Ma*LE)^2);

%% 方向舵引起的侧向力系数?
CY_RUD(i) = -1.43E-18 + 4.86E-20*ALPHA + 1.86E-19*Ma + 3.84E-04*RUD - 1.17E-05*ALPHA*RUD - 1.07E-05*Ma*RUD + 2.6E-07*ALPHA*Ma*RUD;
%% 总的
C_Y(i) = CYb(i)*beta + CY_RE(i) + CY_LE(i) + CY_RUD(i); 
end

figure(1);
plot(ALPHAc,C_Y,'-k','LineWidth',2);
grid on;
xlabel('alpha /deg','FontSize',12);
ylabel('C_Y','FontSize',12);
saveas(gcf,'CY CurVe.fig');

figure(2);
plot(ALPHAc,CYb,'-r','LineWidth',2);
grid on;
xlabel('alpha /deg','FontSize',12);
ylabel('CYb','FontSize',12);
saveas(gcf,'CYb CurVe.fig');

figure(3);
plot(ALPHAc,CY_RE,'-.g','LineWidth',2);
hold on;
grid on;
plot(ALPHAc,CY_LE,'-.m','LineWidth',2);
plot(ALPHAc,CY_RUD,'-.b','LineWidth',2);
xlabel('alpha /deg','FontSize',12);
ylabel('C_Y d','FontSize',12);
saveas(gcf,'CYd CurVes.fig');
%通过曲线可知，侧向力系数主要是侧滑角引起的侧向力（E-1量级）
%俯仰舵舵偏引起的侧向力系数可以忽略（E-6量级）
%方向舵 不为0时，引起一定的侧向力（E-3量级）
%因此，当侧滑角为0，，侧向力可忽略（方向舵偏为0时，E-18量级；方向舵偏为10时，E-3量级）