%参数对应关系如下：
% Acp = [c1p, c2p, c4p, c5p, c7p, c8p];  Bcp = [c3p, c6p, c9p];
% Abp = [b2p, b1p, b5p, b4p, b8p, b7p];  Bbp = [b3p, b6p, b9p]; 
% Acy = [c4y, c5y, c1y, c2y, c7y, c8y];  Bcy = [c6y, c3y, c9y];
% Aby = [b5y, b4y, b2y, b1y, b8y, b7y];  Bby = [b6y, b3y, b9y]; 
% Acr = [c4r, c5r, c7r, c8r, c1r, c2r];  Bcr = [c6r, c9r, c3r];
% Abr = [b5r, b4r, b8r, b7r, b2r, b1r];  Bbr = [b6r, b9r, b3r]; 
% 
% LnrPara = [Acp,Bcp,Abp,Bbp,Acy,Bcy, Aby,Bby, Acr,Bcr, Abr,Bbr];%合成一个总的系数54维向量，用的时候再分解

% function DataAnalys2()
clear all;
close all;
%  load LnrPara_std11;
% load Lnepara_bias1-1-3; 
load Lnepara_bias1-16-3; 
 %load Lnepara_bias2-1-30; 
%  load Lnepara_bias2-16-30; 
A = LnrPara_std; %%转存一下

T = A(:,1);
c1p = A(:,2);  c2p = A(:,3);  c4p = A(:,4);  c5p = A(:,5);   c7p = A(:,6);   c8p = A(:,7);   c3p = A(:,8);   c6p = A(:,9);   c9p = A(:,10);
b2p = A(:,11); b1p = A(:,12); b5p = A(:,13); b4p = A(:,14);  b8p = A(:,15);  b7p = A(:,16);  b3p = A(:,17);  b6p = A(:,18);  b9p = A(:,19);
c4y = A(:,20); c5y = A(:,21); c1y = A(:,22); c2y = A(:,23);  c7y = A(:,24);  c8y = A(:,25);  c6y = A(:,26);  c3y = A(:,27);  c9y = A(:,28);
b5y = A(:,29); b4y = A(:,30); b2y = A(:,31); b1y = A(:,32);  b8y = A(:,33);  b7y = A(:,34);  b6y = A(:,35);  b3y = A(:,36);  b9y = A(:,37);
c4r = A(:,38); c5r = A(:,39); c7r = A(:,40); c8r = A(:,41);  c1r = A(:,42);  c2r = A(:,43);  c6r = A(:,44);  c9r = A(:,45);  c3r = A(:,46);
b5r = A(:,47); b4r = A(:,48); b8r = A(:,49); b7r = A(:,50);  b2r = A(:,51);  b1r = A(:,52);  b6r = A(:,53);  b9r = A(:,54);  b3r = A(:,55);

Acp = [T,c1p, c2p,c3p]; 
Bbp = [T,b2p, b1p,b3p];  
Acy = [T,c1y, c2y,c3y];  
Bby = [T,b2y, b1y,b3y];  
Acr = [T,c1r, c2r,c3r];  
Bbr = [T,b2r, b1r,b3r]; 
%save('LnrPara_PYR1-1-3','Acp','Bbp','Acy','Bby','Acr','Bbr');
save('LnrPara_PYR1-16-3','Acp','Bbp','Acy','Bby','Acr','Bbr');
 %save('LnrPara_PYR2-1-30','Acp','Bbp','Acy','Bby','Acr','Bbr');
% save('LnrPara_PYR2-16-30','Acp','Bbp','Acy','Bby','Acr','Bbr');
% Acp1 = [T,c1p, c2p,c3p]; 
% Bbp1 = [T,b2p, b1p,b3p];  
% Acy1 = [T,c1y, c2y,c3y];  
% Bby1 = [T,b2y, b1y,b3y];  
% Acr1 = [T,c1r, c2r,c3r];  
% Bbr1 = [T,b2r, b1r,b3r]; 
% save('LnrPara_PYR1-1','Acp1','Bbp1','Acy1','Bby1','Acr1','Bbr1');
% Acp2 = [T,c1p, c2p,c3p]; 
% Bbp2 = [T,b2p, b1p,b3p];  
% Acy2 = [T,c1y, c2y,c3y];  
% Bby2 = [T,b2y, b1y,b3y];  
% Acr2 = [T,c1r, c2r,c3r];  
% Bbr2 = [T,b2r, b1r,b3r]; 
% save('LnrPara_PYR2-1','Acp2','Bbp2','Acy2','Bby2','Acr2','Bbr2');
% Acp3 = [T,c1p, c2p,c3p]; 
% Bbp3 = [T,b2p, b1p,b3p];  
% Acy3 = [T,c1y, c2y,c3y];  
% Bby3 = [T,b2y, b1y,b3y];  
% Acr3 = [T,c1r, c2r,c3r];  
% Bbr3 = [T,b2r, b1r,b3r]; 
% save('LnrPara_PYR2-16','Acp3','Bbp3','Acy3','Bby3','Acr3','Bbr3');
%% Acp = [c1p, c2p, c4p, c5p, c7p, c8p];  Bcp = [c3p, c6p, c9p];
% figure(1);
% plot(T,c1p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c1p','FontSize',12);
% 
% figure(2);
% plot(T,c2p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c2p ','FontSize',12);
% 
% figure(3);
% plot(T,c4p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c4p','FontSize',12);
% 
% figure(4);
% plot(T,c5p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c5p','FontSize',12);
% 
% figure(5);
% plot(T,c7p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c7p ','FontSize',12);
% 
% figure(6);
% plot(T,c8p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c8p','FontSize',12);
% 
% figure(7);
% plot(T,c3p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c3p','FontSize',12);
% 
% figure(8);
% plot(T,c6p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c6p','FontSize',12);
% 
% figure(9);
% plot(T,c9p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c9p ','FontSize',12);
% % %通过上面的曲线分析：
% % % c1p的范围是（1~5）*E-2； c2p=1; c3p的范围是（-1~-5）*E-4；
% % % c7p的范围是（-6~6）*E-4,仅在有滚转的情况下不为0；其余系数都为0 
                  
%%  Abp = [b2p, b1p, b5p, b4p, b8p, b7p];  Bbp = [b3p, b6p, b9p]; 
% figure(1);
% plot(T,b2p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b2p','FontSize',12);
% 
% figure(2);
% plot(T,b1p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b1p','FontSize',12);
% 
% figure(3);
% plot(T,b5p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b5p','FontSize',12);
% 
% figure(4);
% plot(T,b4p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b4p','FontSize',12);
% 
% figure(5);
% plot(T,b8p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b8p','FontSize',12);
% 
% figure(6);
% plot(T,b7p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b7p','FontSize',12);
% 
% figure(7);
% plot(T,b3p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b3p','FontSize',12);
% 
% figure(8);
% plot(T,b6p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b6p','FontSize',12);
% 
% figure(9);
% plot(T,b9p,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b9p','FontSize',12);
% % % % %通过上面的曲线分析：
% % %b1p的范围是（-0.1~-0.2）； b2p的范围是（2~8）； b3p的范围是（-0.05~-0.2）； 
% % %b6p的范围是（0~3）*E-5；       b9p的范围是（0~3）*E-19,这两个系数较小，可忽略；其余系数均为0

%% Acy = [c4y, c5y, c1y, c2y, c7y, c8y];  Bcy = [c6y, c3y, c9y];
% figure(1);
% plot(T,c4y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c4y','FontSize',12);
% 
% figure(2);
% plot(T,c5y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c5y','FontSize',12);
% 
% figure(3);
% plot(T,c1y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c1y','FontSize',12);
% 
% figure(4);
% plot(T,c2y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c2y','FontSize',12);
% 
% figure(5);
% plot(T,c7y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c7y','FontSize',12);
% 
% figure(6);
% plot(T,c8y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c8y','FontSize',12);
% 
% figure(7);
% plot(T,c6y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c6y','FontSize',12);
% 
% figure(8);
% plot(T,c3y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c3y','FontSize',12);
% 
% figure(9);
% plot(T,c9y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c9y','FontSize',12);

% % %通过上面的曲线分析：
% %c4y的范围是（-1~1）*E-3；c1y的范围是（-0.06~-0.24）； c2y的范围是（-1~-0.9）；c3y的范围是（-0.2~-2）*E-4； c7y的范围是（2.1~2.4）*E-3；
% %c8y的范围是（0~0.35）；c6y的范围是（0.5~4）*E-23；c9y的范围是（-0.5~-4.5）*E-7；这两个系数较小，可忽略；其余系数都为0 

%% Aby = [b5y, b4y, b2y, b1y, b8y, b7y];  Bby = [b6y, b3y, b9y]; 
% figure(1);
% plot(T,b5y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b5y','FontSize',12);
% 
% figure(2);
% plot(T,b4y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b4y','FontSize',12);
% 
% figure(3);
% plot(T,b2y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b2y','FontSize',12);
% 
% figure(4);
% plot(T,b1y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b1y','FontSize',12);
% 
% figure(5);
% plot(T,b8y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b8y','FontSize',12);
% 
% figure(6);
% plot(T,b7y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b7y','FontSize',12);
% 
% figure(7);
% plot(T,b6y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b6y','FontSize',12);
% 
% figure(8);
% plot(T,b3y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b3y','FontSize',12);
% 
% figure(9);
% plot(T,b9y,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b9y','FontSize',12);

% % % %通过上面的曲线分析：
% %b5y的范围是（0.3~-0.3）； b2y的范围是（-8~-28）；  b1y的范围是（-0.1~-0.5）；  b3y的范围是（0.04~0.2）； 
% %b7y的范围是（1~4）*E-2；  b9y的范围是（0.4~-1.6）*E-2； b6y的范围是（0.5~3）*E-18,这个系数较小，可忽略；其余系数均为0
%% Acr = [c4r, c5r, c7r, c8r, c1r, c2r];  Bcr = [c6r, c9r, c3r];
% figure(1);
% plot(T,c4r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c4r','FontSize',12);
% 
% figure(2);
% plot(T,c5r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c5r','FontSize',12);
% 
% figure(3);
% plot(T,c7r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c7r','FontSize',12);
% 
% figure(4);
% plot(T,c8r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c8r','FontSize',12);
% 
% figure(5);
% plot(T,c1r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c1r','FontSize',12);
% 
% figure(6);
% plot(T,c2r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c2r','FontSize',12);
% 
% figure(7);
% plot(T,c6r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c6r','FontSize',12);
% 
% figure(8);
% plot(T,c9r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c9r','FontSize',12);
% 
% figure(9);
% plot(T,c3r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('c3r','FontSize',12);

% % %通过上面的曲线分析：
% %c4r的范围是（0~-4）*E-4,仅滚转时不为0； c3r的范围是（0~2.5）*E-8；c8r的范围是（0~-0.35）； c1r的范围是（0~1.2）*E-4；c2r的范围是（1~0.95）；
% %c6r的范围是（0~-4）*E-6,仅滚转时不为0；c7r的范围是（0~-3）*E-3；c9r的范围是（0~8）*E-6；其余系数都为0 

%% Abr = [b5r, b4r, b8r, b7r, b2r, b1r];  Bbr = [b6r, b9r, b3r]; 
% figure(1);
% plot(T,b5r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b5r','FontSize',12);
% 
% figure(2);
% plot(T,b4r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b4r','FontSize',12);
% 
% figure(3);
% plot(T,b8r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b8r','FontSize',12);
% 
% figure(4);
% plot(T,b7r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b7r','FontSize',12);
% 
% figure(5);
% plot(T,b2r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b2r','FontSize',12);
% 
% figure(6);
% plot(T,b1r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b1r','FontSize',12);
% 
% figure(7);
% plot(T,b6r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b6r','FontSize',12);
% 
% figure(8);
% plot(T,b9r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b9r','FontSize',12);
% 
% figure(9);
% plot(T,b3r,'-.r','LineWidth',2); 
% grid on;
% xlabel('Time (s)','FontSize',12);
% ylabel('b3r','FontSize',12);
% 
% % % %通过上面的曲线分析：
% % %b3r的范围是（-0.2~-1.4）； b8r的范围是（-20~-80； b7r的范围是（0.1~0.6）； b1r的范围是（-0.1~-0.5）；b9r的范围是（-0.1~-0.3）；
% % %b5r的范围是（1~3.5）*E-16,b6r的范围是（0~-6）*E-17,该系数较小，可忽略；其余系数都为0 
% 
% Acp = [T,c1p, c2p,c3p]; 
% Bbp = [T,b2p, b1p,b3p];  
% Acy = [T,c1y, c2y,c3y];  
% Bby = [T,b2y, b1y,b3y];  
% Acr = [T,c1r, c2r,c3r];  
% Bbr = [T,b2r, b1r,b3r]; 
% save('LnrPara_PYR','Acp','Bbp','Acy','Bby','Acr','Bbr');

% end