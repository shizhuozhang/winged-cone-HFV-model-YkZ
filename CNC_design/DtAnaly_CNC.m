clear all;
close all;
load FltData_k3_bias0.mat;

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

Ero_alp = FltData2(:,24);   Ero_bta = FltData2(:,25);  Ero_mu = FltData2(:,26);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
Ero_qw = FltData2(:,27);   Ero_rw = FltData2(:,28);  Ero_pw = FltData2(:,29);  %构成角速度控制误差矢量 Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
Acc_pit = FltData2(:,30);  Acc_yaw = FltData2(:,31);  Acc_rol = FltData2(:,32);  %构成角加速度矢量 Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
Dlt_alp = FltData2(:,33);  Dlt_bet = FltData2(:,34);  Dlt_mu = FltData2(:,35);  %构成等效舵偏矢量 DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];

%% 分析
figure(4);
plot3(X_loc/1000,Y_loc/1000,Height/1000,'-k','LineWidth',2);
xlabel('X (km)','FontSize',12);
ylabel('Y (km)','FontSize',12);
zlabel('H (km)','FontSize',12);
grid on;

% figure(1);
% plot(T,alpha*Rad2Deg,'-r','LineWidth',2);        
% hold on
% plot(T,beta*Rad2Deg,'--g','LineWidth',2);
% plot(T,mu*Rad2Deg,'-.b','LineWidth',2); 
% grid on
% xlabel('Time (s)','FontSize',13);
% ylabel('Angles (deg)','FontSize',13);
% % axis([0 12 -60 160])
% set(gca,'FontSize',13);
% h1=legend('\alpha','\beta','\mu','Location','SouthWest');
% set(h1,'box','off');
% 
% figure(2);
% plot(T,Ero_alp*Rad2Deg,'-r','LineWidth',2);        
% hold on
% plot(T,Ero_bta*Rad2Deg,'--g','LineWidth',2);
% plot(T,Ero_mu*Rad2Deg,'-.b','LineWidth',2); 
% grid on
% xlabel('Time (s)','FontSize',13);
% ylabel('e-Angle (deg)','FontSize',13);
% axis([0 100 -0.5 1])
% set(gca,'FontSize',13);
% h1=legend('e_{\alpha}','e_{\beta}','e_{\mu}','Location','SouthEast');
% set(h1,'box','off');
% 
% figure(3);
% plot(T,q*Rad2Deg,'-r','LineWidth',2);  
% hold on;
% plot(T,r*Rad2Deg,'-.g','LineWidth',2);  
% plot(T,p*Rad2Deg,'--b','LineWidth',2);  
% grid on;
% xlabel('Time (s)','FontSize',13);
% ylabel('Omega (deg/s)','FontSize',13);
% axis([0 100 -2 4])
% set(gca,'FontSize',13);
% h1=legend('q','r','p','Location','NorthEast');
% set(h1,'box','off');
% 
% figure(4);
% plot(T,Ero_qw*Rad2Deg,'-r','LineWidth',2);  
% hold on;
% plot(T,Ero_rw*Rad2Deg,'-.g','LineWidth',2);  
% plot(T,Ero_pw*Rad2Deg,'--b','LineWidth',2);  
% grid on;
% xlabel('Time (s)','FontSize',13);
% ylabel('e-Omega (deg/s)','FontSize',13);
% axis([0 100 -2 2])
% set(gca,'FontSize',13);
% h1=legend('e_q','e_r','e_p','Location','NorthEast');
% set(h1,'box','off');
% 
% figure(5);
% plot(T,Acc_pit*Rad2Deg,'-r','LineWidth',2);  
% hold on;
% plot(T,Acc_yaw*Rad2Deg,'-.g','LineWidth',2);  
% plot(T,Acc_rol*Rad2Deg,'--b','LineWidth',2);  
% grid on;
% xlabel('Time (s)','FontSize',13);
% ylabel('Acc (deg/s/s)','FontSize',13);
% axis([0 100 -20 20])
% set(gca,'FontSize',13);
% h1=legend('Acc_pit','Acc_yaw','Acc_rol','Location','NorthEast');
% set(h1,'box','off');
% 
% % figure(6);
% % plot(T,Dlt_bet,'-.k','LineWidth',2);  
% % grid on;
% % xlabel('Time (s)','FontSize',13);
% % ylabel('Dt-bta (deg)','FontSize',13);
% % axis([0 100 -0.8 0.8])
% % set(gca,'FontSize',13);
% % 
% % figure(7);
% % plot(T,Dlt_mu,'--b','LineWidth',2);  
% % grid on;
% % xlabel('Time (s)','FontSize',13);
% % ylabel('Dt-mu (deg)','FontSize',13);
% % axis([0 100 -1 1])
% % set(gca,'FontSize',13);
% 
% figure(8);
% plot(T,Dlt_e,'-r','LineWidth',2);  
% hold on;
% plot(T,Dlt_a,'-.g','LineWidth',2);  
% plot(T,Dlt_r,'--b','LineWidth',2);  
% grid on;
% xlabel('Time (s)','FontSize',13);
% ylabel('DeltaA (deg)','FontSize',13);
% axis([0 100 -20 5])
% set(gca,'FontSize',13);
% h1=legend('Dt-e','Dt-a','Dt-r','Location','SouthEast');
% set(h1,'box','off');
