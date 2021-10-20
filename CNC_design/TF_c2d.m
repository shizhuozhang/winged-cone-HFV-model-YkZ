%%传递函数离散化，以便校正网络可以时域计算
clear all;
close all;

Ts = 0.1;  %%离散系统的采样时间
% %  %% test 一阶惯性环节
% nump = [1];  %[0.0577,0.6928],[0.1924,0.231]这组参数也可以用
% denp = [0.4,1];  %
% Gp = tf(nump,denp); 
% 
% dGp = c2d(Gp,Ts,'zoh'); % 传函离散
% [numpz,denpz] = tfdata(dGp,'v') % 离散后提取分子分母

%% 俯仰通道的校正网络  滞后网络
nump = [0.0289,1];  %[0.0577,0.6928],[0.1924,0.231]这组参数也可以用
denp = [0.3464,1];  %
Gp = tf(nump,denp); 

dGp = c2d(Gp,Ts,'zoh') % 传函离散
[numpz,denpz] = tfdata(dGp,'v'); % 离散后提取分子分母

%% 偏航通道的校正网络  滞后网络
numy = [0.0289,1];%0.0577这组参数也可以用
deny = [0.3464,1];%0.6928
Gy = tf(numy,deny); 

dGy = c2d(Gy,Ts,'zoh') % 传函离散
[numyz,denyz] = tfdata(dGy,'v'); % 离散后提取分子分母

%% 滚转通道的校正网络  滞后网络
numr = [0.1763,1];%这组参数也可以用
denr = [5.686,1];%
Gr = tf(numr,denr); 

dGr = c2d(Gr,Ts,'zoh') % 传函离散
[numrz,denrz] = tfdata(dGr,'v'); % 离散后提取分子分母

save('CNCtrl_para.mat','numpz','denpz','numyz','denyz','numrz','denrz');
