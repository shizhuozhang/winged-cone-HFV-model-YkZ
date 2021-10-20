%%内环增益参数插值
clear all;
close all;
h_step = 0.01; %%单位 s 控制步长要足够小
Ft_point = [0,10,20,30,45,60,80,100];%%暂定为每个十秒取一个特征点
Kin_p = -2000*[4, 3.75, 3.65, 3.75, 3.75, 3.15, 2.05, 1.15];  %%%俯仰通道内环增益 
Kin_y =  2000*[5, 5.2, 5.05, 5, 4.7, 3.95, 2.6, 1.45];  %%%偏航通道内环增益  
Kin_r = -2000*[2.8, 2.7, 2.6, 2.7, 2.65, 2.25, 1.45, 0.86];  %%%滚转通道内环增益 
Time = 0: h_step: 100;

Kinp = interp1(Ft_point, Kin_p, Time,'linear');
Kiny = interp1(Ft_point, Kin_y, Time,'linear');
Kinr = interp1(Ft_point, Kin_r, Time,'linear');

save('Kin_para2000.mat','Kinp','Kiny','Kinr');