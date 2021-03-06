% clear all;
% close all;
%  load LnrPara_PYR.mat
%  
% % % Acp = [T,c1p, c2p,c3p]; 
% % % Bbp = [T,b2p, b1p,b3p];  
% % % Acy = [T,c1y, c2y,c3y];  
% % % Bby = [T,b2y, b1y,b3y];  
% % % Acr = [T,c1r, c2r,c3r];  
% % % Bbr = [T,b2r, b1r,b3r];  
%  
% 
% T = Acp(:,1);  %用不到这个时间
% c1p = Acp(:,2); c3p = Acp(:,4);  c2p = 1;%c2p = Acp(:,3); 
% b2p = Bbp(:,2); b1p = Bbp(:,3); b3p = Bbp(:,4); 
% c1y = Acy(:,2); c2y = Acy(:,3); c3y = Acy(:,4);
% b2y = Bby(:,2); b1y = Bby(:,3); b3y = Bby(:,4);
% c1r = Acr(:,2); c2r = Acr(:,3); c3r =0; % c3r = Acr(:,4);
% b1r = Bbr(:,3); b3r = Bbr(:,4); b2r =0; % b2r = Bbr(:,2);


% save('Linrpara_ind.mat','T','c1p','c3p','c2p','b2p','b1p','b3p','c1y','c2y','c3y','b2y','b1y','b3y','c1r','c2r','c3r','b1r','b3r','b2r');
% load('Linrpara_ind.mat');%标准弹道的小偏差数据

Channel = 3;%1俯仰，2偏航，3滚转

FP_abs = [1,10,20,30,45,60,80,99];%待求解的特征点 ，使用的是绝对时刻
% k=1; %用于循环的变量，取值 1-8,%1,10,20,30,45,60,80,100;
% FP_k = find(T == FP_abs(k));

Kin_p = -1000*[4, 3.75, 3.65, 3.75, 3.75, 3.15, 2.05, 1.2];  %%%俯仰通道内环增益  %%%对于俯仰通道 2,3,4,5这几个点相似，1,6有细微差别，7，8差别最大
Kin_y =  1000*[5, 5.2, 5.05, 5, 4.7, 3.95, 2.6, 1.5];  %%%偏航通道内环增益  %%%对于偏航通道 1,2,3,4,5这几个点相似，6，7，8差别较大
Kin_r = -1000*[2.8, 2.7, 2.6, 2.7, 2.65, 2.25, 1.45, 0.87];  %%%滚转通道内环增益  %%%对于滚转通道 1,2,3,4,5这几个点相似，6，7，8差别较大
Kout_p =10;
Kout_y = -10; %待调节的内环增益
Kout_r = 10;
Gm_in1 = zeros(1,12); Gm_in = zeros(1,12); Pm_in = zeros(1,12); Wcg_in =zeros(1,12); Wcp_in =zeros(1,12);Buffer=zeros(1,200);
count=0;

% % 舵机
% numd = [1];
% dend= [1/75^2,2*0.707/75,1];
% Gd = tf(numd,dend);

%% 飞行器本体模型,即控制框图中各独立组件的模型
%  figure(1);
for k = 2
    
    FP_k = find(T == FP_abs(k));
    
    if(Channel==1)  %俯仰通道
        c1 = c1p(FP_k);    c2 = c2p;    c3 = c3p(FP_k);
        b1 = b1p(FP_k);    b2 = b2p(FP_k);    b3 = b3p(FP_k);  
        
          %%俯仰通道的校正网络  滞后网络
        nump = [0.0289,1];  %[0.0577,0.6928],[0.1924,0.231]这组参数也可以用
        denp = [0.3464,1];  %
        Gp = tf(nump,denp); 
        
        Kin = Kin_p(k); %待调节的内环增益-1000至-4000
        Kout = Kout_p;
    elseif(Channel==2)  %偏航通道
        c1 = c1y(FP_k);    c2 = c2y(FP_k);    c3 = c3y(FP_k);
        b1 = b1y(FP_k);    b2 = b2y(FP_k);    b3 = b3y(FP_k);    
        
       %%%%偏航通道的校正网络  滞后网络
        nump = [0.0289,1];%0.0577这组参数也可以用
        denp = [0.3464,1];%0.6928
        Gp = tf(nump,denp); 
        
        Kin = Kin_y(k); %待调节的内环增益800至4000
        Kout = Kout_y;
    elseif(Channel==3)  %滚转通道
        c1 = c1r(FP_k);    c2 = c2r(FP_k);    c3 = 0;
        b1 = b1r(FP_k);    b2 = 0;           b3 = b3r(FP_k);    
                  
        %%滚转通道的校正网络  滞后网络
%         nump = [0.2203,1];%[0.3525,11.372][0.2938,9.4765]这组参数也可以用
%         denp = [7.1075,1];%
        nump = [0.1763,1];%这组参数也可以用
        denp = [5.686,1];%
        Gp = tf(nump,denp); 
         
        Kin = Kin_r(k); %待调节的内环增益-500至-1500
        Kout = Kout_r;
    end
      
    %角度对舵的传递函数
    num = [c3, (b3*c2 - b1*c3)];
    den = [1, -(b1+c1), (c1*b1 -c2*b2)];
    Gad = tf(num,den);

    %角速度对舵的传递函数        
    num = [b3, (b2*c3 - c1*b3)];
    den = [1, -(b1+c1), (c1*b1 -c2*b2)];
    Gwd = tf(num,den);

    %角度对角速度的传递函数
    num = [c3, (b3*c2 - b1*c3)];
    den= [b3, (b2*c3 - c1*b3)];
    Gaw = tf(num,den);

%      Gp =1; %%校正网络
    
    Ga = Kin*Gp*Gwd;    % 内环角速度本体的开环传递函数

    %%%角速度本体特性
 %    figure(1);
%      margin(Ga);
%      hold on;
%       grid on;
     
    % 内环闭环传递函数
     Gin = feedback(Ga,1);
%     figure(2);      
%     step(Gin,5);
%     grid on;
     % 外环闭环传递函数
     Gb = Kout*Gin*Gaw;  %外环开环传递函数
     figure(3);
     margin(Gb);
     
     Gout = feedback(Gb,1);%外环闭环传递函数 
      figure(4);
     step(Gout,2);
     axis([0, 2, 0, 1.3]);
     grid on;
end
%         %四个参数分别为：幅值裕度（单位不是dB,要取20log）；相角裕度（单位：度）；剪切（截止）频率和-180度穿越频率（单位rad/s）
%         %注意开环截止频率和闭环带宽正相关，但大小并不相同
%         %该函数只计算值不画图
%         [Gm_in1(k),Pm_in(k),Wcg_in(k),Wcp_in(k)]=margin(Ga); %开环传函的福相特性，得到裕度大小
%         Gm_in(k) = 20*log10(Gm_in1(k));  %转换为dB为单位

% %外环
% Gm_out1=zeros(1,110); Gm_out=zeros(1,110); Pm_out=zeros(1,110);
% Wcg_out=zeros(1,110); Wcp_out=zeros(1,110);
% 


% for k=1:1:110
%     Kout = 0.2*k+1; 
%     Gb = Kout*Gin*Gaw;  %外环开环传递函数
%     Gout = feedback(Gb,1);%外环闭环传递函数
% 
%     [Gm_out1(k),Pm_out(k),Wcg_out(k),Wcp_out(k)]=margin(Gb);
%     Gm_out(k) = 20*log10(Gm_out1(k));    %转换为dB为单位
% %     if Pm_out > 90
% %         Pm_out= Pm_out - 90;
% %     end
% end
% %[X,Y,Z]=triscatteredinterp(Gm_out,Pm_out,Wcp_out,linspace(min(Gm_out),max(Gm_out))',linspace(min(Pm_out),max(Pm_out)),'v4');
% [X,Y,Z]=griddata(Gm_out,Pm_out,Wcp_out,linspace(min(Gm_out),max(Gm_out))',linspace(min(Pm_out),max(Pm_out)),'v4');
% %pcolor(X,Y,Z);shading interp;legend('pxolor')%伪彩色图
% figure(3);
% contourf(X,Y,Z,'showText','on');legend('Wcp_{out}');%等高线图
% xlabel('Gm_{out}','FontSize',12);
% ylabel('Pm_{out}','FontSize',12);
