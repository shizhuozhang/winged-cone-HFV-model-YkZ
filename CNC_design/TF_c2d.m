%%���ݺ�����ɢ�����Ա�У���������ʱ�����
clear all;
close all;

Ts = 0.1;  %%��ɢϵͳ�Ĳ���ʱ��
% %  %% test һ�׹��Ի���
% nump = [1];  %[0.0577,0.6928],[0.1924,0.231]�������Ҳ������
% denp = [0.4,1];  %
% Gp = tf(nump,denp); 
% 
% dGp = c2d(Gp,Ts,'zoh'); % ������ɢ
% [numpz,denpz] = tfdata(dGp,'v') % ��ɢ����ȡ���ӷ�ĸ

%% ����ͨ����У������  �ͺ�����
nump = [0.0289,1];  %[0.0577,0.6928],[0.1924,0.231]�������Ҳ������
denp = [0.3464,1];  %
Gp = tf(nump,denp); 

dGp = c2d(Gp,Ts,'zoh') % ������ɢ
[numpz,denpz] = tfdata(dGp,'v'); % ��ɢ����ȡ���ӷ�ĸ

%% ƫ��ͨ����У������  �ͺ�����
numy = [0.0289,1];%0.0577�������Ҳ������
deny = [0.3464,1];%0.6928
Gy = tf(numy,deny); 

dGy = c2d(Gy,Ts,'zoh') % ������ɢ
[numyz,denyz] = tfdata(dGy,'v'); % ��ɢ����ȡ���ӷ�ĸ

%% ��תͨ����У������  �ͺ�����
numr = [0.1763,1];%�������Ҳ������
denr = [5.686,1];%
Gr = tf(numr,denr); 

dGr = c2d(Gr,Ts,'zoh') % ������ɢ
[numrz,denrz] = tfdata(dGr,'v'); % ��ɢ����ȡ���ӷ�ĸ

save('CNCtrl_para.mat','numpz','denpz','numyz','denyz','numrz','denrz');
