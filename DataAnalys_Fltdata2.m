clear all;
close all;
load FltData2_SMC.mat;

My_PI = 3.14159;
Rad2Deg = 180 / My_PI; 

T = FltData2(:,1);  Ma= FltData2(:,2);  
X_loc = FltData2(:,3);   Y_loc = FltData2(:,4) ;   Height = FltData2(:,5); %����λ��ʸ�� Locat = [X_loc, Y_loc, Height];
Veloc = FltData2(:,6);   gamma = FltData2(:,7);   chi = FltData2(:,8); %���ɺ���ʸ�� Trajct = [Veloc, gamma, chi];

theta = FltData2(:,9);   psi = FltData2(:,10);   phi = FltData2(:,11); %����ŷ����ʸ�� EulerAng = [theta ,psi, phi];
alpha = FltData2(:,12);   beta = FltData2(:,13);   mu = FltData2(:,14); %����������ʸ�� AeroAng = [alpha, beta, mu];
q = FltData2(:,15);   r = FltData2(:,16);   p = FltData2(:,17); %���ɽ�����ʸ�� Omega = [q ,r, p];

Cmd_alp = FltData2(:,18);  Cmd_bet = FltData2(:,19);    Cmd_mu = FltData2(:,20); %����ָ��ʸ�� CmdAng = [Cmd_alp ,Cmd_bet, Cmd_mu];
Dlt_e = FltData2(:,21);  Dlt_a = FltData2(:,22);    Dlt_r = FltData2(:,23); %����ʵ�ʶ�ƫʸ�� DeltaA = [Dlt_a ,Dlt_e, Dlt_r];

Ero_alp = FltData2(:,24);   Ero_bta = FltData2(:,25);  Ero_mu = FltData2(:,26);   %���ɿ������ʸ�� Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
Ero_qw = FltData2(:,27);   Ero_rw = FltData2(:,28);  Ero_pw = FltData2(:,29);  %���ɽ��ٶȿ������ʸ�� Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
Acc_pit = FltData2(:,30);  Acc_yaw = FltData2(:,31);  Acc_rol = FltData2(:,32);  %���ɽǼ��ٶ�ʸ�� Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
Dlt_alp = FltData2(:,33);  Dlt_bet = FltData2(:,34);  Dlt_mu = FltData2(:,35);  %���ɵ�Ч��ƫʸ�� DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];

%% ����
%  
% figure(1);
% plot(T,Cmd_alp*Rad2Deg,'-r','LineWidth',2);    
% figure(2);
% plot(T,Cmd_bet*Rad2Deg,'-r','LineWidth',2);   
% figure(3);
% plot(T,Cmd_mu*Rad2Deg,'-r','LineWidth',2);   
%  figure(4);
% plot(T,Veloc,'-r','LineWidth',2);    
% figure(5);
% plot(T,Height,'-r','LineWidth',2);   
% figure(6);
% plot(T,Veloc,'-r','LineWidth',2); 

 figure(1);
 plot(T,Ero_alp*Rad2Deg,'-r','LineWidth',2); 
 figure(2);
 plot(T,Ero_bta*Rad2Deg,'-r','LineWidth',2);  
 figure(3);
 plot(T,Ero_mu*Rad2Deg,'-r','LineWidth',2); 
  
 figure(4);
 plot(T,Ero_qw*Rad2Deg,'-r','LineWidth',2); 
 figure(5);
 plot(T,Ero_rw*Rad2Deg,'-r','LineWidth',2);  
 figure(6);
 plot(T,Ero_pw*Rad2Deg,'-r','LineWidth',2);
 
%  figure(7);
%  plot(T,Dlt_e,'-r','LineWidth',2); 
%  figure(8);
%  plot(T,Dlt_a,'-r','LineWidth',2);  
%  figure(9);
%  plot(T,Dlt_r,'-r','LineWidth',2);
%   
%  figure(10);
%  plot(T,Dlt_alp,'-r','LineWidth',2); 
%  figure(11);
%  plot(T,Dlt_bet,'-r','LineWidth',2);  
%  figure(12);
%  plot(T,Dlt_mu,'-r','LineWidth',2);
 
 
% figure(1);
% plot(T,alpha*Rad2Deg,'-r','LineWidth',2);        
% hold on
% plot(T,beta*Rad2Deg,'--g','LineWidth',2);
% plot(T,mu*Rad2Deg,'-.b','LineWidth',2); 
% grid on
% xlabel('Time (s)','FontSize',12);
% ylabel('Angles (deg)','FontSize',12);
% axis([0 12 -60 160])
% h1=legend('alpha','\beta','\mu','Location','SouthWest');
% set(h1,'box','off');
% 
% figure(3);
% plot(T,q*Rad2Deg,'-r','LineWidth',2);  
% hold on;
% plot(T,r*Rad2Deg,'-.g','LineWidth',2);  
% plot(T,p*Rad2Deg,'--b','LineWidth',2);  
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('Omega (deg/s)','FontSize',12);
% h1=legend('q','r','p','Location','SouthEast');
% set(h1,'box','off');
% 
% figure(4);
% plot3(X_loc/1000,Y_loc/1000,Height/1000,'-k','LineWidth',2);
% xlabel('X (km)','FontSize',12);
% ylabel('Y (km)','FontSize',12);
% zlabel('H (km)','FontSize',12);
% grid on;
% 
% figure(5);
% plot(T,Veloc,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('V (m/s)','FontSize',12);
% 
% figure(6);
% plot(T,gamma*Rad2Deg,'-r','LineWidth',2); 
% hold on;
% plot(T,chi*Rad2Deg,'--b','LineWidth',2);
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('Angle (deg)','FontSize',12);
% h1=legend('\gamma','\chi','Location','SouthWest');
% set(h1,'box','off');
% 
% figure(7);
% plot(T,theta*Rad2Deg,'-r','LineWidth',2);
% hold on;
% plot(T,psi*Rad2Deg,'-.g','LineWidth',2);
% plot(T,phi*Rad2Deg,'--b','LineWidth',2);
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('Angle (deg)','FontSize',12);
% h1=legend('\theta','\psi','\phi','Location','SouthEast');
% set(h1,'box','off');