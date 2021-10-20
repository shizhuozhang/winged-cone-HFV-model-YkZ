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

% load Lnepara_k3_bias0;
%load Lnepara_k3_bias1-1-30;
% load Lnepara_k3_bias1-16-30;
 load Lnepara_k3_bias2-1-30;
%  load Lnepara_k3_bias2-16-30;
% A = LnrPara_std; %%转存一下
A = LnrPara_ins; %%转存一下

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
save('LnrPara_k3_PYR2-1-30','Acp','Bbp','Acy','Bby','Acr','Bbr');

% end