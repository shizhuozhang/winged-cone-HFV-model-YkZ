%%绘制部分气动系数的曲线
MaS = 5:0.5:15; % MaS-4
% ALPHAS = -5:0.5:10; %ALPHAS+6
ALPHAS = -2:0.5:10; %ALPHAS+6
m = length(MaS);
n = length(ALPHAS);
RUD = 10;
RE = 10;
LE = 10;
% CLa = zeros(21,31);
% Cma = zeros(21,31);
% Cm_De = zeros(21,31);
% Cm_Dr = zeros(21,31);
% CDa = zeros(21,31);
% CYb = zeros(21,31);
% Cn_De = zeros(21,31);
% Cn_Dr = zeros(21,31);
% Cl_De = zeros(21,31);
% Cl_Dr = zeros(21,31);
% LDrt = zeros(21,31);
CLa = zeros(m,n);
Cma = zeros(m,n);
Cm_Da = zeros(m,n);
Cm_Dr = zeros(m,n);
CDa = zeros(m,n);
CYb = zeros(m,n);
Cn_Da = zeros(m,n);
Cn_Dr = zeros(m,n);
Cl_Da = zeros(m,n);
Cl_Dr = zeros(m,n);
LDrt = zeros(m,n);
for i=1:1:m
    Ma = MaS(i);
    for j=1:1:n
        ALPHA = ALPHAS(j);
        %% 纵向运动
        %攻角引起的升力系数
        CLa(i,j) = - 8.19E-02 + 4.7E-02*Ma + 1.86E-02*ALPHA - 4.73E-04*ALPHA*Ma - 9.19E-03*(Ma^2) - 1.52E-04*(ALPHA^2) + 5.99E-07*((ALPHA*Ma)^2) ...
              + 7.74E-04*(Ma^3) + 4.08E-06*(ALPHA^3) - 2.93E-05*(Ma^4) - 3.91E-07*(ALPHA^4) + 4.12E-07*(Ma^5) + 1.3E-08*(ALPHA^5);
        %攻角引起的俯仰力矩系数
        Cma(i,j) = - 2.192E-02 + 7.739E-03*Ma - 2.260E-03*ALPHA + 1.808E-04*(ALPHA*Ma) - 8.849E-04*(Ma^2) + 2.616E-04*(ALPHA^2) ...
              - 2.880E-07*((ALPHA*Ma)^2) + 4.617E-05*(Ma^3) -7.887E-05*(ALPHA^3) - 1.143E-06*(Ma^4) ...
              + 8.288E-06*(ALPHA^4) + 1.082E-08*(Ma^5) - 2.789E-07*(ALPHA^5);
        %右舵引起的俯仰力矩系数
        Cm_Da(i,j) = - 5.67E-05 - 6.59E-05*ALPHA - 1.51E-06*Ma - 4.46E-06*ALPHA*Ma ...
                    + 2.89E-04*RE + 4.48E-06*ALPHA*RE - 5.87E-06*Ma*RE + 9.72E-08*ALPHA*Ma*RE;
        %方向舵引起的俯仰力矩系数
        Cm_Dr(i,j) = - 2.79E-05*ALPHA - 5.89E-08*(ALPHA^2) + 1.58E-03*(Ma^2) + 6.42E-08*(ALPHA^3) - 6.69E-04*(Ma^3) ...
                 - 2.1E-08*(ALPHA^4) + 1.05E-04*(Ma^4) + 3.14E-09*(ALPHA^5) - 7.74E-06*(Ma^5) ...
                 - 2.18E-10*(ALPHA^6) + 2.7E-07*(Ma^6) + 5.74E-12*(ALPHA^7) - 3.58E-09*(Ma^7) ...
                 + 1.43E-07*(RUD^4) - 4.77E-22*(RUD^5) - 3.38E-10*(RUD^6) + 2.63E-24*(RUD^7);
        %% 侧向运动
         %攻角引起的阻力系数
        CDa(i,j) =   + 8.717E-02 - 3.307E-02*Ma + 3.179E-03*ALPHA - 1.25E-04*ALPHA*Ma + 5.036E-03*(Ma^2) - 1.1E-03*(ALPHA^2) ...
                + 1.405E-07*((ALPHA*Ma)^2) - 3.658E-04*(Ma^3) + 3.175E-04*(ALPHA^3) + 1.274E-05*(Ma^4) - 2.985E-05*(ALPHA^4) ...
                - 1.705E-07*(Ma^5) + 9.766E-07*(ALPHA^5);
        %侧滑角引起的侧向力系数
        CYb(i,j) =  -2.9253E-01*Ma + 2.8803E-03*ALPHA - 2.8943E-04*(ALPHA*Ma)+ 5.4822E-02*(Ma^2) + 7.3535E-04*(ALPHA^2) ...
              - 4.6490E-09*((ALPHA*(Ma^2))^2) - 2.0675E-08*(((ALPHA^2)*Ma)^2) + 4.6205E-06*((ALPHA*Ma)^2) + 2.6144E-11*(((ALPHA^2)* (Ma^2))^2) ...
              - 4.3203E-03*(Ma^3) - 3.7405E-04*(ALPHA^3) + 1.5495E-04*(Ma^4) + 2.8183E-05*(ALPHA^4) ...
              - 2.0829E-06*(Ma^5) -5.2083E-07*(ALPHA^5);   
  
        %右舵引起的偏航力矩系数
        Cn_Da(i,j) = + 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
                - 1.30E-05*RE - 8.93E-08*(ALPHA*Ma)*RE + 1.97E-06*(RE^2) + 1.41E-11*((ALPHA*Ma*RE)^2) ; 
        %方向舵引起的偏航力矩系数
        Cn_Dr(i,j) = + 2.85E-18 - 3.59E-19 *ALPHA -1.26E-19*Ma + 1.57E-20*(ALPHA*Ma) ...
                 - 5.28E-04*RUD + 1.39E-05*(ALPHA*RUD) + 1.65E-05*(Ma*RUD) - 3.13E-07*(ALPHA*Ma)*RUD ;        
       % 右舵引起的滚转力矩系数
        Cl_Da(i,j) = + 3.570E-04 - 9.569E-05*ALPHA - 3.598E-05*Ma + 4.950E-06*(ALPHA^2) + 1.411E-06*(Ma^2) ...
                + 1.170E-04*RE + 2.794E-08*ALPHA*Ma*RE - 1.160E-06*(RE^2) - 4.641E-11*((ALPHA*Ma*RE)^2);       
        % 方向舵引起的滚转力矩系数
        Cl_Dr(i,j) = - 5.0103E-19 + 6.2723E-20*ALPHA + 2.3418E-20*Ma - 3.4201E-21*(ALPHA*Ma) ... 
                 + 1.1441E-04*RUD - 2.6824E-06*(ALPHA*RUD) - 3.5496E-06*(Ma*RUD) + 5.5547E-08*(ALPHA*Ma)*RUD ;   
             
        LDrt(i,j) = CLa(i,j)/CDa(i,j);  %%升阻比
    end
end
ALPHAx = ALPHAS(5:n);
LDrtx = LDrt(:,5:n);
figure(11)
mesh(ALPHAx,MaS,LDrtx);
grid on;
xlabel('alpha','FontSize',12);
ylabel('Ma','FontSize',12);
zlabel('L-D ratio','FontSize',12);
saveas(gcf,'LDratio.png');
saveas(gcf,'LDratio.fig');

% figure(1)
% mesh(ALPHAS,MaS,CLa);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('CLa','FontSize',12);
% saveas(gcf,'CLa.png');
% saveas(gcf,'CLa.fig');
% 
% figure(2)
% mesh(ALPHAS,MaS,Cma);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('Cma','FontSize',12);
% saveas(gcf,'Cma.png');
% saveas(gcf,'Cma.fig');
% 
% figure(3)
% mesh(ALPHAS,MaS,Cm_Da);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('Cm-Da','FontSize',12);
% saveas(gcf,'Cm_Da.png');
% saveas(gcf,'Cm_Da.fig');
% 
% figure(4)
% mesh(ALPHAS,MaS,Cm_Dr);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('Cm-Dr','FontSize',12);
% saveas(gcf,'Cm_Dr.png');
% saveas(gcf,'Cm_Dr.fig');
% 
% figure(5)
% mesh(ALPHAS,MaS,CDa);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('CDa','FontSize',12);
% saveas(gcf,'CDa.png');
% saveas(gcf,'CDa.fig');
% 
% figure(6)
% mesh(ALPHAS,MaS,CYb);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('CYb','FontSize',12);
% saveas(gcf,'CYb.png');
% saveas(gcf,'CYb.fig');

% figure(7)
% mesh(ALPHAS,MaS,Cn_Da);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('Cn-Da','FontSize',12);
% saveas(gcf,'Cn_Da.png');
% saveas(gcf,'Cn_Da.fig');
% 
% figure(8)
% mesh(ALPHAS,MaS,Cn_Dr);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('Cn-Dr','FontSize',12);
% saveas(gcf,'Cn_Dr.png');
% saveas(gcf,'Cn_Dr.fig');
% 
% figure(9)
% mesh(ALPHAS,MaS,Cl_Da);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('Cl-Da','FontSize',12);
% saveas(gcf,'Cl_Da.png');
% saveas(gcf,'Cl_Da.fig');
% 
% figure(10)
% mesh(ALPHAS,MaS,Cl_Dr);
% grid on;
% xlabel('alpha','FontSize',12);
% ylabel('Ma','FontSize',12);
% zlabel('Cl-Dr','FontSize',12);
% saveas(gcf,'Cl_Dr.png');
% saveas(gcf,'Cl_Dr.fig');
