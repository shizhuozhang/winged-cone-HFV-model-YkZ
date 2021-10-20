%  clear all;
% close all;
%load FltData_k3_bias0.mat;
%  load FltData_k3_bias1-1-30.mat;
%   load FltData_k3_bias1-16-30.mat;
%  load FltData_k3_bias2-1-30.mat;
%  load FltData_k3_bias2-16-30.mat;

% My_PI = 3.14159;
% Rad2Deg = 180 / My_PI; 
% 
% T = FltData2(:,1);  
% Ero_alp = FltData2(:,24);   Ero_bta = FltData2(:,25);  Ero_mu = FltData2(:,26);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];

% T1 = FltData2(:,1);  
% Ero_alp1 = FltData2(:,24);   Ero_bta1 = FltData2(:,25);  Ero_mu1 = FltData2(:,26);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];

% T2 = FltData2(:,1);  
% Ero_alp2 = FltData2(:,24);   Ero_bta2 = FltData2(:,25);  Ero_mu2 = FltData2(:,26);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];

% T3 = FltData2(:,1);  
% Ero_alp3 = FltData2(:,24);   Ero_bta3 = FltData2(:,25);  Ero_mu3 = FltData2(:,26);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];

% T4 = FltData2(:,1);  
% Ero_alp4 = FltData2(:,24);   Ero_bta4 = FltData2(:,25);  Ero_mu4 = FltData2(:,26);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
% % 
%% 分析

figure(1);
plot(T,Ero_alp*Rad2Deg,'-b','LineWidth',2); 
hold on; 
plot(T1,Ero_alp1*Rad2Deg,'-.g','LineWidth',2); 
plot(T2,Ero_alp2*Rad2Deg,'--r','LineWidth',2); 
grid on;
xlabel('Time (s)','FontSize',13);
ylabel('e-alpha (deg)','FontSize',13);
axis([0 100 -0.4 0.8])
set(gca,'FontSize',13);
h1=legend('bias=0','bias=+30%','bias=-30%','Location','NorthEast');
set(h1,'box','off');

figure(2);
plot(T,Ero_alp*Rad2Deg,'-b','LineWidth',2); 
hold on; 
plot(T3,Ero_alp3*Rad2Deg,'-.g','LineWidth',2); 
plot(T4,Ero_alp4*Rad2Deg,'--r','LineWidth',2); 
grid on;
xlabel('Time (s)','FontSize',13);
ylabel('e-alpha (deg)','FontSize',13);
axis([0 100 -0.4 0.8])
set(gca,'FontSize',13);
h1=legend('bias=0','bias=+30%','bias=-30%','Location','NorthEast');
set(h1,'box','off');

figure(3);
plot(T,Ero_mu*Rad2Deg,'-b','LineWidth',2); 
hold on; 
plot(T1,Ero_mu1*Rad2Deg,'-.g','LineWidth',2); 
plot(T2,Ero_mu2*Rad2Deg,'--r','LineWidth',2); 
grid on;
xlabel('Time (s)','FontSize',13);
ylabel('e-mu (deg)','FontSize',13);
axis([0 100 -0.4 1.5])
set(gca,'FontSize',13);
h1=legend('bias=0','bias=+30%','bias=-30%','Location','NorthEast');
set(h1,'box','off');

figure(4);
plot(T,Ero_mu*Rad2Deg,'-b','LineWidth',2); 
hold on; 
plot(T1,Ero_mu3*Rad2Deg,'-.g','LineWidth',2); 
plot(T2,Ero_mu4*Rad2Deg,'--r','LineWidth',2); 
grid on;
xlabel('Time (s)','FontSize',13);
ylabel('e-mu (deg)','FontSize',13);
axis([0 100 -0.4 1.5])
set(gca,'FontSize',13);
h1=legend('bias=0','bias=+30%','bias=-30%','Location','NorthEast');
set(h1,'box','off');
% 
% 




