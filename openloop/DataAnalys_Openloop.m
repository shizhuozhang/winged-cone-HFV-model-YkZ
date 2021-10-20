%参数对应关系如下：
% xm  =Uncertn(1); xJx =Uncertn(2); xJy =Uncertn(3); xJz =Uncertn(4); xRho = Uncertn(5); 
% xCD = Uncertn(6);  xCY = Uncertn(7);  xCL = Uncertn(8); xCl = Uncertn(9);  xCm = Uncertn(10); xCn = Uncertn(11); 

% X_loc = FltSdt_S(1);   Y_loc = FltSdt_S(2) ;   Height = FltSdt_S(3); %构成位置矢量 Locat = [X_loc, Y_loc, Height];
% Veloc = FltSdt_S(4);   gamma = FltSdt_S(5);   chi = FltSdt_S(6); %构成航迹矢量 Trajct = [Veloc, gamma, chi];

% theta = FltSdt_F(1);   psi = FltSdt_F(2);   phi = FltSdt_F(3); %构成欧拉角矢量 EulerAng = [theta ,psi, phi];
% alpha = FltSdt_F(4);   beta = FltSdt_F(5);   mu = FltSdt_F(6); %构成气动角矢量 AeroAng = [alpha, beta, mu];
% q = FltSdt_F(7);   r = FltSdt_F(8);   p = FltSdt_F(9); %构成角速率矢量 Omega = [q ,r, p];

%Cmd_alp = CtrlSdt_B(1);  Cmd_bet = CtrlSdt_B(2);    Cmd_mu = CtrlSdt_B(3); %构成指令矢量 CmdAng = [Cmd_alp ,Cmd_bet, Cmd_mu];
%Dlt_a = CtrlSdt_B(4);  Dlt_e = CtrlSdt_B(5);    Dlt_r = CtrlSdt_B(6); %构成实际舵偏矢量 DeltaA = [Dlt_a ,Dlt_e, Dlt_r];
  
%Ero_pit = CtrlSdt_P(1);  Ero_yaw = CtrlSdt_P(2);    Ero_rol = CtrlSdt_P(3); %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
%Ero_qw = CtrlSdt_P(4);  Ero_rw = CtrlSdt_P(5);    Ero_pw = CtrlSdt_P(6); %构成角速度控制误差矢量 Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
%Acc_pit = CtrlSdt_P(7);  Acc_yaw = CtrlSdt_P(8);    Acc_rol = CtrlSdt_P(9); %构成角加速度矢量 Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
%Dlt_alp = CtrlSdt_P(10);  Dlt_bet = CtrlSdt_P(11);    Dlt_mu = CtrlSdt_P(12); %构成等效舵偏矢量 DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];



clear all;
close all;
load AllSimuData.mat;

My_PI = 3.14159;
Rad2Deg = 180 / My_PI; 

T = FltData2(:,1);  Ma= FltData2(:,2);  
X_loc = FltData2(:,3);   Y_loc = FltData2(:,4) ;   Height = FltData2(:,5); %构成位置矢量 Locat = [X_loc, Y_loc, Height];
Veloc = FltData2(:,6);   gamma = FltData2(:,7);   chi = FltData2(:,8); %构成航迹矢量 Trajct = [Veloc, gamma, chi];

theta = FltData2(:,9);   psi = FltData2(:,10);   phi = FltData2(:,11); %构成欧拉角矢量 EulerAng = [theta ,psi, phi];
alpha = FltData2(:,12);   beta = FltData2(:,13);   mu = FltData2(:,14); %构成气动角矢量 AeroAng = [alpha, beta, mu];
q = FltData2(:,15);   r = FltData2(:,16);   p = FltData2(:,17); %构成角速率矢量 Omega = [q ,r, p];

Cmd_alp = FltData2(:,18);  Cmd_bet = FltData2(:,19);    Cmd_mu = FltData2(:,20); %构成指令矢量 CmdAng = [Cmd_alp ,Cmd_bet, Cmd_mu];
Dlt_e = FltData2(:,21);  Dlt_a = FltData2(:,22);    Dlt_r = FltData2(:,23); %构成实际舵偏矢量 DeltaA = [Dlt_a ,Dlt_e, Dlt_r];

Ero_pit = FltData2(:,24);   Ero_yaw = FltData2(:,25);  Ero_rol = FltData2(:,26);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
Ero_qw = FltData2(:,27);   Ero_rw = FltData2(:,28);  Ero_pw = FltData2(:,29);  %构成角速度控制误差矢量 Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
Acc_pit = FltData2(:,30);  Acc_yaw = FltData2(:,31);  Acc_rol = FltData2(:,32);  %构成角加速度矢量 Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
Dlt_alp = FltData2(:,33);  Dlt_bet = FltData2(:,34);  Dlt_mu = FltData2(:,35);  %构成等效舵偏矢量 DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];

%% 开环特性分析
figure(1);
plot(T,alpha*Rad2Deg,'-r','LineWidth',2);        
grid on;
xlabel('Time (s)','FontSize',12);
ylabel('Alpha (deg)','FontSize',12);

figure(2);
plot(T,beta*Rad2Deg,'--g','LineWidth',2);
hold on;
plot(T,mu*Rad2Deg,'-.b','LineWidth',2); 
grid on;
xlabel('Time (s)','FontSize',12);
ylabel('Angles (deg)','FontSize',12);
h1=legend('\beta','\mu','Location','SouthEast');
set(h1,'box','off');

figure(3);
plot(T,q*Rad2Deg,'-r','LineWidth',2);  
hold on;
plot(T,r*Rad2Deg,'-.g','LineWidth',2);  
plot(T,p*Rad2Deg,'--b','LineWidth',2);  
grid on;
xlabel('Time (s)','FontSize',12);
ylabel('Omega (deg/s)','FontSize',12);
h1=legend('q','r','p','Location','SouthEast');
set(h1,'box','off');

figure(4);
plot3(X_loc/1000,Y_loc/1000,Height/1000,'-k','LineWidth',2);
xlabel('X (km)','FontSize',12);
ylabel('Y (km)','FontSize',12);
zlabel('H (km)','FontSize',12);
grid on;

figure(5);
plot(T,Veloc,'-.r','LineWidth',2); 
grid on;
xlabel('Time (s)','FontSize',12);
ylabel('V (m/s)','FontSize',12);

figure(6);
plot(T,gamma*Rad2Deg,'-r','LineWidth',2); 
hold on;
plot(T,chi*Rad2Deg,'--b','LineWidth',2);
grid on;
xlabel('Time (s)','FontSize',12);
ylabel('Angle (deg)','FontSize',12);
h1=legend('\gamma','\chi','Location','SouthWest');
set(h1,'box','off');

figure(7);
plot(T,theta*Rad2Deg,'-r','LineWidth',2);
hold on;
plot(T,psi*Rad2Deg,'-.g','LineWidth',2);
plot(T,phi*Rad2Deg,'--b','LineWidth',2);
grid on;
xlabel('Time (s)','FontSize',12);
ylabel('Angle (deg)','FontSize',12);
h1=legend('\theta','\psi','\phi','Location','SouthEast');
set(h1,'box','off');
% 
% figure(11);
% plot(T,Dlt_a,'-.r','LineWidth',2); 
% hold on;
% plot(T,Dlt_e,'-.b','LineWidth',2); 
% plot(T,Dlt_r,'-.g','LineWidth',2); 


% end