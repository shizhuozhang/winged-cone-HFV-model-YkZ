%%设定制导指令
%输入参数为:当前时刻T
%输出参数为：当前时刻的姿态角指令气动姿态角(alpha,beta,mu)，
function ComdAng = LoadCommand(Time) %其中的角度单位为rad

global ctrl_case; %%选择仿真情形，分为六自由度仿真和三自由度仿真
global sim_case; %%选择仿真情形，分为六自由度仿真和三自由度仿真
global Rad2Deg;  %%弧度转换为度
global ComdAng_lst; %记录上一次的角度
global InAng_lst; %记录上一次的输入角度
Com_beta = 0;    %侧滑始终设定为0

if Time==0
    if ctrl_case ==1  
        ComdAng_lst = [0,0]/Rad2Deg; %初始化参数
        InAng_lst = [0,0]/Rad2Deg; %初始化参数
    else
         ComdAng_lst = [0,0]; %初始化参数   
         InAng_lst = [0,0]; %初始化参数
    end
end

%% 100s全弹道仿真 自己按感觉设计的制导指令
if ctrl_case ==1  
%     if (Time >= 0)&&(Time <= 2)   
%         In_alpha = 2/Rad2Deg; %攻角指令
%         In_mu = 0/Rad2Deg;    %倾侧角指令
%     elseif (Time > 2)&&(Time <= 10) 
%         In_alpha = (2*Time-2)/Rad2Deg; %攻角指令 斜率为-2的斜坡指令
%         In_mu = 0;    %倾侧角指令
    if (Time >= 0)&&(Time <= 1)   
        In_alpha = 0/Rad2Deg; %攻角指令
        In_mu = 0/Rad2Deg;    %倾侧角指令
    elseif (Time > 1)&&(Time <= 10) 
        In_alpha = (2*(Time-1))/Rad2Deg; %攻角指令 斜率为-2的斜坡指令
        In_mu = 0;    %倾侧角指令
    elseif (Time > 10)&&(Time <= 25) 
        In_alpha = 18/Rad2Deg; %攻角指令
        In_mu = 0;    %倾侧角指令        
    elseif (Time > 25)&&(Time <= 35) 
        In_alpha = (-Time + 43)/Rad2Deg; %攻角指令 斜率为1的斜坡指令
        In_mu = 0;    %倾侧角指令        
    elseif (Time > 35)&&(Time <= 50) 
        In_alpha = 8/Rad2Deg; %攻角指令
        In_mu = 0;    %倾侧角指令     
    elseif (Time > 50)&&(Time <= 64) 
        In_alpha = 8/Rad2Deg; %攻角指令
        In_mu = (-Time + 50)/Rad2Deg;    %倾侧角指令        
     elseif (Time > 64)&&(Time <= 80) 
        In_alpha = 8/Rad2Deg; %攻角指令
        In_mu = -14/Rad2Deg; %倾侧角指令 斜率为1.2的斜坡指令            
    elseif (Time > 80)&&(Time <= 90) 
        In_alpha = 8/Rad2Deg; %攻角指令
        In_mu = (2*Time -174)/Rad2Deg; %倾侧角指令 斜率为1.2的斜坡指令
    elseif (Time > 90)&&(Time <= 100) 
        In_alpha = 8/Rad2Deg; %攻角指令
        In_mu = 6/Rad2Deg; %倾侧角指令 斜率为1.2的斜坡指令
    else
        In_alpha = 0; %攻角指令
        In_mu = 0;    %倾侧角指令       
    end

%  ComdAng(1) = In_alpha; ComdAng(2) = Com_beta; ComdAng(3) = In_mu;    
%% 单点仿真   单纯的阶跃指令 加了一个一阶惯性滤波环节
else     
%     if (Time > 1.9)&&(Time <= 2.1) 
%         In_alpha = 30*(Time - 1.9)/Rad2Deg; %攻角指令 
%         In_mu = 0;%5*(-Time+5)/Rad2Deg;    %倾侧角指令
%     elseif (Time > 2.1)&&(Time <= 5.9)   
%         In_alpha = 6/Rad2Deg; %攻角指令
%         In_mu = 0;%-2/Rad2Deg;    %倾侧角指令   
%     elseif (Time > 5.9)&&(Time <= 6.1) 
%         In_alpha = (-20*(Time - 5.9)+6)/Rad2Deg; %攻角指令 24
%         In_mu = 0;    %倾侧角指令
%     elseif (Time > 6.1)&&(Time <=10)   
%         In_alpha = 2/Rad2Deg; %攻角指令
%         In_mu = 0/Rad2Deg;    %倾侧角指令   

        
%     if (Time > 1.9)&&(Time <= 2.1) 
%         In_alpha = 30*(Time - 1.9)/Rad2Deg; %攻角指令 
%         In_mu = 0;%5*(-Time+5)/Rad2Deg;    %倾侧角指令
%     elseif (Time > 2.1)&&(Time <= 9.9)   
%         In_alpha = 6/Rad2Deg; %攻角指令
%         In_mu = 0;%-2/Rad2Deg;    %倾侧角指令   
%     elseif (Time > 9.9)&&(Time <= 10.3) 
%         In_alpha = (-20*(Time - 9.9)+6)/Rad2Deg; %攻角指令 24
%         In_mu = 0;    %倾侧角指令
%     elseif (Time > 10.3)&&(Time <=19.9)   
%         In_alpha = -2/Rad2Deg; %攻角指令
%         In_mu = 0/Rad2Deg;    %倾侧角指令   
%     elseif (Time > 19.9)&&(Time <=20)   
%         In_alpha = (20*(Time - 19.9)-2)/Rad2Deg;
%         In_mu = 0/Rad2Deg;    %倾侧角指令  
    if (Time > 2)&&(Time <= 6) 
        In_alpha = 3*(Time - 2)/Rad2Deg; %攻角指令 
        In_mu = 0/Rad2Deg;    %倾侧角指令
    elseif (Time > 6)&&(Time <= 10)   
        In_alpha = 12/Rad2Deg; %攻角指令
        In_mu = 0/Rad2Deg;    %倾侧角指令   
    else
        In_alpha = 0; %攻角指令 
        In_mu = 0;    %倾侧角指令
    end
%      ComdAng(1) = In_alpha; ComdAng(2) = Com_beta; ComdAng(3) = In_mu;    

end
    % % % % % %    指令加一个滤波环节，变成连续可导信号 时间常数0.4s
    if sim_case==2 
        Com_alpha_1 = 0.7788*ComdAng_lst(1) + 0.2212* InAng_lst(1);%制导，步长0.1
        Com_mu_1 = 0.7788*ComdAng_lst(2) + 0.2212* InAng_lst(2);%制导，步长0.1
    else
        Com_alpha_1 = 0.9876*ComdAng_lst(1) + 0.0124* InAng_lst(1); %控制，步长0.05
        Com_mu_1 = 0.9876*ComdAng_lst(2) + 0.0124* InAng_lst(2); %控制，步长0.05      
%         Com_alpha_1 = 0.9753*ComdAng_lst(1) + 0.0247* InAng_lst(1); %控制，步长0.05
%         Com_mu_1 = 0.9753*ComdAng_lst(2) + 0.0247* InAng_lst(2); %控制，步长0.05   
    end
    InAng_lst(1) = In_alpha;  InAng_lst(2) = In_mu;
    ComdAng_lst(1) = Com_alpha_1; ComdAng_lst(2) = Com_mu_1;
    ComdAng(1) = Com_alpha_1; ComdAng(2) = Com_beta; ComdAng(3) = Com_mu_1; 

end

