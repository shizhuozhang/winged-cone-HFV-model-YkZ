%������Ӧ��ϵ���£�
% Acp = [c1p, c2p, c4p, c5p, c7p, c8p];  Bcp = [c3p, c6p, c9p];
% Abp = [b2p, b1p, b5p, b4p, b8p, b7p];  Bbp = [b3p, b6p, b9p]; 
% Acy = [c4y, c5y, c1y, c2y, c7y, c8y];  Bcy = [c6y, c3y, c9y];
% Aby = [b5y, b4y, b2y, b1y, b8y, b7y];  Bby = [b6y, b3y, b9y]; 
% Acr = [c4r, c5r, c7r, c8r, c1r, c2r];  Bcr = [c6r, c9r, c3r];
% Abr = [b5r, b4r, b8r, b7r, b2r, b1r];  Bbr = [b6r, b9r, b3r]; 
% 
% LnrPara = [Acp,Bcp,Abp,Bbp,Acy,Bcy, Aby,Bby, Acr,Bcr, Abr,Bbr];%�ϳ�һ���ܵ�ϵ��54ά�������õ�ʱ���ٷֽ�

% function DataAnalys2()
clear all;
close all;
load LnrPara_std11;
 
A = LnrPara_std; %%ת��һ��

T = A(:,1);
c1p = A(:,2);  c2p = A(:,3);  c4p = A(:,4);  c5p = A(:,5);   c7p = A(:,6);   c8p = A(:,7);   c3p = A(:,8);   c6p = A(:,9);   c9p = A(:,10);
b2p = A(:,11); b1p = A(:,12); b5p = A(:,13); b4p = A(:,14);  b8p = A(:,15);  b7p = A(:,16);  b3p = A(:,17);  b6p = A(:,18);  b9p = A(:,19);
c4y = A(:,20); c5y = A(:,21); c1y = A(:,22); c2y = A(:,23);  c7y = A(:,24);  c8y = A(:,25);  c6y = A(:,26);  c3y = A(:,27);  c9y = A(:,28);
b5y = A(:,29); b4y = A(:,30); b2y = A(:,31); b1y = A(:,32);  b8y = A(:,33);  b7y = A(:,34);  b6y = A(:,35);  b3y = A(:,36);  b9y = A(:,37);
c4r = A(:,38); c5r = A(:,39); c7r = A(:,40); c8r = A(:,41);  c1r = A(:,42);  c2r = A(:,43);  c6r = A(:,44);  c9r = A(:,45);  c3r = A(:,46);
b5r = A(:,47); b4r = A(:,48); b8r = A(:,49); b7r = A(:,50);  b2r = A(:,51);  b1r = A(:,52);  b6r = A(:,53);  b9r = A(:,54);  b3r = A(:,55);

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
% % %ͨ����������߷�����
% % % c1p�ķ�Χ�ǣ�1~5��*E-2�� c2p=1; c3p�ķ�Χ�ǣ�-1~-5��*E-4��
% % % c7p�ķ�Χ�ǣ�-6~6��*E-4,�����й�ת������²�Ϊ0������ϵ����Ϊ0 
                  
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
% % % % %ͨ����������߷�����
% % %b1p�ķ�Χ�ǣ�-0.1~-0.2���� b2p�ķ�Χ�ǣ�2~8���� b3p�ķ�Χ�ǣ�-0.05~-0.2���� 
% % %b6p�ķ�Χ�ǣ�0~3��*E-5��       b9p�ķ�Χ�ǣ�0~3��*E-19,������ϵ����С���ɺ��ԣ�����ϵ����Ϊ0

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

% % %ͨ����������߷�����
% %c4y�ķ�Χ�ǣ�-1~1��*E-3��c1y�ķ�Χ�ǣ�-0.06~-0.24���� c2y�ķ�Χ�ǣ�-1~-0.9����c3y�ķ�Χ�ǣ�-0.2~-2��*E-4�� c7y�ķ�Χ�ǣ�2.1~2.4��*E-3��
% %c8y�ķ�Χ�ǣ�0~0.35����c6y�ķ�Χ�ǣ�0.5~4��*E-23��c9y�ķ�Χ�ǣ�-0.5~-4.5��*E-7��������ϵ����С���ɺ��ԣ�����ϵ����Ϊ0 

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

% % % %ͨ����������߷�����
% %b5y�ķ�Χ�ǣ�0.3~-0.3���� b2y�ķ�Χ�ǣ�-8~-28����  b1y�ķ�Χ�ǣ�-0.1~-0.5����  b3y�ķ�Χ�ǣ�0.04~0.2���� 
% %b7y�ķ�Χ�ǣ�1~4��*E-2��  b9y�ķ�Χ�ǣ�0.4~-1.6��*E-2�� b6y�ķ�Χ�ǣ�0.5~3��*E-18,���ϵ����С���ɺ��ԣ�����ϵ����Ϊ0
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

% % %ͨ����������߷�����
% %c4r�ķ�Χ�ǣ�0~-4��*E-4,����תʱ��Ϊ0�� c3r�ķ�Χ�ǣ�0~2.5��*E-8��c8r�ķ�Χ�ǣ�0~-0.35���� c1r�ķ�Χ�ǣ�0~1.2��*E-4��c2r�ķ�Χ�ǣ�1~0.95����
% %c6r�ķ�Χ�ǣ�0~-4��*E-6,����תʱ��Ϊ0��c7r�ķ�Χ�ǣ�0~-3��*E-3��c9r�ķ�Χ�ǣ�0~8��*E-6������ϵ����Ϊ0 

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
% % % %ͨ����������߷�����
% % %b3r�ķ�Χ�ǣ�-0.2~-1.4���� b8r�ķ�Χ�ǣ�-20~-80�� b7r�ķ�Χ�ǣ�0.1~0.6���� b1r�ķ�Χ�ǣ�-0.1~-0.5����b9r�ķ�Χ�ǣ�-0.1~-0.3����
% % %b5r�ķ�Χ�ǣ�1~3.5��*E-16,b6r�ķ�Χ�ǣ�0~-6��*E-17,��ϵ����С���ɺ��ԣ�����ϵ����Ϊ0 
% 
Acp = [T,c1p, c2p,c3p]; 
Bbp = [T,b2p, b1p,b3p];  
Acy = [T,c1y, c2y,c3y];  
Bby = [T,b2y, b1y,b3y];  
Acr = [T,c1r, c2r,c3r];  
Bbr = [T,b2r, b1r,b3r];  
save('LnrPara_PYR','Acp','Bbp','Acy','Bby','Acr','Bbr');

% end