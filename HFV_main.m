%%通用高超声速飞行wing-cone六自由度仿真平台
%by 张耀坤
%参数定义情况如下：
%6个慢回路飞行状态Flight_State_s有:位置（X_loc,Y_loc,Height）;速度，航迹倾角和航迹偏角（Veloc，gamma,chi）
%9个快回路飞行状态Flight_State_f有：三通道(俯仰、偏航、滚转)的欧拉姿态角(theta,psi,phi)，气动姿态角(alpha,beta,mu)，姿态角速度(q,r,p)
%11个不确定参数有:质量m0，三轴转动惯量Jx,Jy,Jz，空气密度Rho，气动力系数CL,CY,CD和气动力矩系数Cl,Cm,Cn
%6个基本的控制状态：三个指令角：Cmd_alp，Cmd_bet，Cmd_mu；三个实际舵偏：Dlt_e,Dlt_a,Dlt_r
%12个具体的控制状态：三通道角度控制误差：Ero_pit,Ero_yaw,Ero_rol；三通道角速度控制误差：Ero_qw,Ero_rw,Ero_pw；
%             三通道角加速度：Acc_pit,Acc_yaw,Acc_rol；三个等效舵偏：Dlt_alp,Dlt_bet,Dlt_mu
%5个大气环境参数：重力加速度g，空气密度Rho，马赫数Ma，温度Tmprt，声速Vs
% g = Env_para(1);  Rho = Env_para(2);  Ma = Env_para(3);   Tmprt = Env_para(4); Vs = Env_para(5);                
%控制器参数在相应的控制器设计文件中。
%参数对应关系如下：
% xm  =Uncertn(1); xJx =Uncertn(2); xJy =Uncertn(3); xJz =Uncertn(4); xRho = Uncertn(5); 
% xCD = Uncertn(6);  xCY = Uncertn(7);  xCL = Uncertn(8); xCl = Uncertn(9);  xCm = Uncertn(10); xCn = Uncertn(11); 

% X_loc = FltSdt_S(1);   Y_loc = FltSdt_S(2) ;   Height = FltSdt_S(3); %构成位置矢量 Locat = [X_loc, Y_loc, Height];
% Veloc = FltSdt_S(4);   gamma = FltSdt_S(5);   chi = FltSdt_S(6); %构成航迹矢量 Trajct = [Veloc, gamma, chi];

% theta = FltSdt_F(1);   psi = FltSdt_F(2);   phi = FltSdt_F(3); %构成欧拉角矢量 EulerAng = [theta ,psi, phi];
% alpha = FltSdt_F(4);   beta = FltSdt_F(5);   mu = FltSdt_F(6); %构成气动角矢量 AeroAng = [alpha, beta, mu];
% q = FltSdt_F(7);   r = FltSdt_F(8);   p = FltSdt_F(9); %构成角速率矢量 Omega = [q ,r, p];

%Cmd_alp = CtrlSdt_B(1);  Cmd_bet = CtrlSdt_B(2);    Cmd_mu = CtrlSdt_B(3); %构成指令矢量 CmdAng = [Cmd_alp ,Cmd_bet, Cmd_mu];
%Dlt_e = CtrlSdt_B(4);  Dlt_a = CtrlSdt_B(5);    Dlt_r = CtrlSdt_B(6); %构成实际舵偏矢量 DeltaA = [Dlt_e ,Dlt_a, Dlt_r];
  
%Ero_pit = CtrlSdt_P(1);  Ero_yaw = CtrlSdt_P(2);    Ero_rol = CtrlSdt_P(3); %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
%Ero_qw = CtrlSdt_P(4);  Ero_rw = CtrlSdt_P(5);    Ero_pw = CtrlSdt_P(6); %构成角速度控制误差矢量 Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
%Acc_pit = CtrlSdt_P(7);  Acc_yaw = CtrlSdt_P(8);    Acc_rol = CtrlSdt_P(9); %构成角加速度矢量 Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
%Dlt_alp = CtrlSdt_P(10);  Dlt_bet = CtrlSdt_P(11);    Dlt_mu = CtrlSdt_P(12); %构成等效舵偏矢量 DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];
%用于数据保存的30维大数组的变量顺序定义为：
% FltData = [FltSdt_S,FltSdt_F,CtrlSdt_B,CtrlSdt_P];
% FltData = [Locat, Trajct, EulerAng, AeroAng, Omega, CmdAng, Eror_ang, Eror_omg, Accelrt, Delta];
%'_1'表示下一时刻的变量值，不是上一步，与C++的编程习惯有点不一致
clear all
close all
%% 变量定义与参数初始化
%结构参数
global m0;   %%再入飞行质量
global Jx;   %%绕X轴转动惯量 
global Jy;   %%绕X轴转动惯量 
global Jz;   %%绕X轴转动惯量 
global Xcg;  %%质心到参考力矩中心距离
global S;    %%翼展参考面积
global b;    %%翼展
global c;    %%平均气动弦长
global Delta_lim; %%舵偏限幅约束

m0 = 63500;    %%单位 kg 
Jx = 637234;  %%单位 kg*m2  
Jy = 6101181; %%单位 kg*m2 
Jz = 6101181; %%单位 kg*m2 
Xcg = 4.4668; %%单位 m 
S = 334.73;   %%单位 m2
b = 18.288;   %%单位 m
c = 24.384;   %%单位 m
Delta_lim = 20;%%单位 deg

%仿真参数
global h_step;   %%仿真步长
global step;     %%记录仿真步数
global Time;   %%实际仿真时间
global T_term; %选取要研究的拉偏情况
global sim_case; %%选择仿真情形，分为六自由度仿真和三自由度仿真
global ctrl_case; %%选择控制情形，分为全弹道控制和单点控制
global ctrler_type; %%控制器类型选择标志位，1为校正网络
global Ft_point; %%选择的特征点
global My_PI;    %%自定义精度的PI值
global Rad2Deg;  %%弧度转换为度
global Coef_aero;  %%气动模型计算的转换系数 %本应该用弧度到度的转换系数，但由于有问题，暂时用这个调试
global Distb_flag; %是否引入外部风干扰（随机干扰）
global Distb_para;
global Uncertn_flag; %是否引入外部风干扰（随机干扰）
global Uncertn_para;
global Bias_case; %选取要研究的拉偏情况

step=0;  %初始值为0
sim_case = 2; %%1为六自由度仿真，2为三自由度仿真（仅制导方程，用于求取标准弹道） 
ctrl_case = 1; %%1为全弹道仿真，2为单点仿真
ctrler_type = 1; %%控制器类型选择标志位，1为校正网络,2为普通滑模控制
if sim_case == 2 
    h_step = 0.1; %%单位 s
else 
    h_step = 0.005; %%单位 s 控制步长要足够小
end
Ft_point = [1,10,20,30,45,60,80,99];%%暂定为每个十秒取一个特征点
My_PI = 3.14159;
Rad2Deg = 180 / My_PI; 
Coef_aero =5; %%气动模型计算的转换系数 %本应该用弧度到度的转换系数，但由于有问题，暂时用这个调试
Distb_flag = 0;     %%0为不加入干扰，1为加入干扰
Uncertn_flag = 0;   %%0为不加入不确定，1为加入不确定
Bias_case = 0; %0为不拉偏
Distb_para = zeros(1,6);    %初始值均设为0
Uncertn_para = zeros(1,11); %初始值均设为0

%%其他用到的变量定义
T_term = 100 - h_step;  %%仿真时长 开环12s
count =0;
LnrParaBufb = zeros(1,55);
% LnrParaBufs = zeros(1,19);
AfnParaBuf = zeros(15,3);
%% 仿真初始化
[FltSdt_S, FltSdt_F] = Parameter_Init(1); %飞行初始状态赋值,其中有对不确定性和干扰的赋值

%%按照初始的参数计算初始配平舵偏
CmdAng = LoadCommand(0);%加载制导指令 对于单点仿真是周期正负阶跃信号，对于全弹道仿真是设定的某种连续曲线 
TrimDelta = calTrimDelta(CmdAng,FltSdt_S);%求解力矩配平舵偏大小,相当于控制器模块
DeltaA = TrimDelta; %给出实际舵偏角  %%舵偏顺序 e,a,r 单位 deg
DeltaE = zeros(1,3); %单位deg
%% 非线性仿真   
%%% 进行三自由度仿真，没有控制器的设计，目的是为了求取标称弹道数据 %%%%
if sim_case == 2  
    FltBuf1 =zeros(1,22); %用于记录仿真数据的大数组
    FltData1 = zeros((T_term + h_step)/h_step,22);%用于记录仿真数据的多维大数组  
    LnrPara_std = zeros((T_term + h_step)/h_step/5,55); %线性化系数矩阵，9*6的矩阵
    AfnPara_std = zeros((T_term + h_step)/h_step/10,3,16); %线性化系数矩阵，15*3的矩阵
    T4store = zeros(3,1);%时间向量
%   LnrPara_std = zeros((T_term + h_step)/h_step/5,19); %线性化系数矩阵，3*6的矩阵
    for Time = 0 : h_step: T_term  %%初始时刻记为0，仿真时长100秒
        step = step + 1;%记录仿真步数  
%         if(rem(Time,1)==0)
%             disp(Time);
%         end

%        Height = FltSdt_S(3); Veloc = FltSdt_S(4); 
        Env_para = calEnv_para(FltSdt_S(3), FltSdt_S(4));%计算当前的大气环境参数        
        [Force_t, Force_a, Moment] = cal_F_M( DeltaA, Env_para, FltSdt_S, FltSdt_F); %计算当前时刻受力情况
       
        if(rem(Time,1)==0)
            count = count+1;
            disp(Time);
            LnrParaBufb = cal_LinearPara(DeltaA, Env_para, FltSdt_S, FltSdt_F);  %%标称轨迹下的小偏差系数计算
            LnrPara_std(count,:) =[Time, LnrParaBufb]; 
        end    
        
%         if(rem(Time,1)==0)
%             count = count+1;
%             disp(Time);
%             AfnParaBuf = AfnNonlnrPara(DeltaA, Env_para, FltSdt_S, FltSdt_F);  %%标称轨迹下的小偏差系数计算
%             T4store = [Time;0;0];
%             AfnPara_std(count,:,:) =[T4store, AfnParaBuf]; 
%         end   
        
       %%数值积分求解三自由度姿态动力学微分方程组，得到下一时刻的飞行状态
        %航迹矢量Trajct = [Veloc, gamma, chi];
        Trajct = [FltSdt_S(4), FltSdt_S(5), FltSdt_S(6)];   %当前航迹参数
        Trajct_1 = RK_Trajct(Trajct, Force_t, h_step); %数值积分求解下一时刻的航迹参数     
        %位置矢量Locat = [X_loc, Y_loc, Height];
        Locat = [FltSdt_S(1), FltSdt_S(2), FltSdt_S(3)];
        Locat_1 = RK_Locat(Locat, FltSdt_S,h_step);%龙格库塔求解位置微分方程
        
        FltSdt_S(4) = Trajct_1(1);  FltSdt_S(5) = Trajct_1(2); FltSdt_S(6) = Trajct_1(3);   %更新下一时刻的航迹参数         
        FltSdt_S(1) = Locat_1(1);   FltSdt_S(2) = Locat_1(2);  FltSdt_S(3) = Locat_1(3);   %更新下一时刻的位置参数
  
        CmdAng_1 = LoadCommand(Time + h_step);%下一时刻的制导指令
        TrimDelta_1 = calTrimDelta(CmdAng_1, FltSdt_S);%求解步配平舵偏大小,相当于控制器模块，
        DeltaA_1= TrimDelta_1; %得到下一时刻的实际舵偏角 
        CtrlSdt_B(1) = CmdAng_1(1); CtrlSdt_B(2) = CmdAng_1(2); CtrlSdt_B(3) = CmdAng_1(3); 
        CtrlSdt_B(4) = DeltaA_1(1); CtrlSdt_B(5) = DeltaA_1(2);  CtrlSdt_B(6) = DeltaA_1(3);   
        
        %%利用几何关系方程求解其余的状态参数 
        AeroAng_1 = CmdAng_1;  %指令角即认为是气动角 
        EulerAng_1 = GometrRelat(1, AeroAng_1 ,Trajct_1);%求解下一时刻的欧拉角
        FltSdt_F(4) = AeroAng_1(1);   FltSdt_F(5) = AeroAng_1(2);   FltSdt_F(6) = AeroAng_1(3);  %%更新下一时刻的气动角参数      
        FltSdt_F(1) = EulerAng_1(1);   FltSdt_F(2) = EulerAng_1(2);   FltSdt_F(3) = EulerAng_1(3); %%更新下一时刻的欧拉角参数         
        %由于三自由度仿真基于瞬态平衡假设，不考虑转动，因此角速率不考虑,均为0
        %FltSdt_F(7) = Omega(1);   FltSdt_F(8) = Omega(2);   FltSdt_F(9) = Omega(3); %%更新下一时刻的角速率参数
  
         %%%记录仿真结果
         FltBuf1 = [(Time + h_step),FltSdt_S,FltSdt_F,CtrlSdt_B];
         FltData1(step,:) = FltBuf1;
       
%%%% 进行六自由度仿真，设计控制器，进行姿态控制 %%%%  
    end
 %%%% 进行六自由度仿真，控制器的设计     
else
    FltBuf2 = zeros(1,35); %用于记录仿真数据的大数组
    FltData2 = zeros((T_term + h_step)/h_step,35);%用于记录仿真数据的多维大数组
    LnrPara_ins = zeros((T_term + h_step)/h_step/5,55); %线性化系数矩阵，9*6的矩阵
%   LnrPara_ins = zeros((T_term + h_step)/h_step/5,19); %线性化系数矩阵，3*6的矩阵

    for Time = 0: h_step: T_term %%初始时刻记为0，仿真时长100秒
        step = step + 1;%记录仿真步数
        if(rem(Time,5)==0)
            disp(Time);
        end
        
%        Height = FltSdt_S(3); Veloc = FltSdt_S(4); 
        Env_para = calEnv_para(FltSdt_S(3), FltSdt_S(4));%计算当前的大气环境参数        
        [Force_t, Force_a, Moment] = cal_F_M( DeltaA, Env_para, FltSdt_S, FltSdt_F); %计算当前时刻受力情况         
       
         %计算实时的线性化系数
        if(rem(Time,0.5)==0)
            count = count+1;
%            disp(Time);
            LnrParaBufb = cal_LinearPara(DeltaA, Env_para, FltSdt_S, FltSdt_F);  %%标称轨迹下的小偏差系数计算
            LnrPara_ins(count,:) =[Time, LnrParaBufb]; 
        end   
        
       
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  数值积分求解下一时刻的飞行状态  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%三自由度运动学微分方程组
       %航迹矢量Trajct = [Veloc, gamma, chi];
       Trajct = [FltSdt_S(4), FltSdt_S(5), FltSdt_S(6)];   %当前航迹参数
       %位置矢量Locat = [X_loc, Y_loc, Height];  %%可以不求解位置方程
       Locat = [FltSdt_S(1), FltSdt_S(2), FltSdt_S(3)];
        if ctrl_case==1  %%只在全弹道仿真时才更新位置和速度、航迹        
            Trajct_1 = RK_Trajct(Trajct, Force_t, h_step); %数值积分求解下一时刻的航迹参数     
            Locat_1 = RK_Locat(Locat, FltSdt_S,h_step);%龙格库塔求解位置微分方程 
        else
            Trajct_1 = Trajct; %%直接赋值，不更新
            Locat_1 = Locat;
        end 
        %%姿态运动方程组
        %角速度矢量 Omega = [q ,r, p];
        Omega = [FltSdt_F(7), FltSdt_F(8), FltSdt_F(9)];   %当前角速度参数
        Omega_1 = RK_Omega(Omega, Moment, h_step); %数值积分求解下一时刻的角速度        
        Accelrt = (Omega_1 - Omega)/h_step; %求解角加速度
        
        %气动角矢量 AeroAng = [alpha, beta, mu];
        AeroAng = [FltSdt_F(4), FltSdt_F(5), FltSdt_F(6)];   %当前气动角参数
        AeroAng_1 = RK_AeroAng(AeroAng, Omega, Force_a, FltSdt_S(4), h_step); %数值积分求解下一时刻的气动角  

        % 欧拉角矢量 EulerAng = [theta ,psi, phi];
%         EulerAng = [FltSdt_F(1), FltSdt_F(2), FltSdt_F(3)];   %当前欧拉角参数
%         EulerAng_1 = RK_EulrAng(EulerAng, Omega, h_step); %数值积分求解下一时刻的欧拉角      
        %%利用几何关系方程求解欧拉角 (两种求解欧拉角的方法任选其一)
         EulerAng_1 = GometrRelat(1, AeroAng_1 ,Trajct_1);%求解下一时刻的欧拉角
         
        FltSdt_S(1) = Locat_1(1);   FltSdt_S(2) = Locat_1(2);  FltSdt_S(3) = Locat_1(3);   %更新下一时刻的位置参数  
        FltSdt_S(4) = Trajct_1(1);  FltSdt_S(5) = Trajct_1(2); FltSdt_S(6) = Trajct_1(3);   %更新下一时刻的航迹参数    
        FltSdt_F(1) = EulerAng_1(1); FltSdt_F(2) = EulerAng_1(2); FltSdt_F(3) = EulerAng_1(3); %%更新下一时刻的欧拉角参数  
        FltSdt_F(4) = AeroAng_1(1);  FltSdt_F(5) = AeroAng_1(2);  FltSdt_F(6) = AeroAng_1(3);  %%更新下一时刻的气动角参数 
        FltSdt_F(7) = Omega_1(1);    FltSdt_F(8) = Omega_1(2);    FltSdt_F(9) = Omega_1(3); %%更新下一时刻的角速率参数                                    
        
        CmdAng_1 = LoadCommand(Time + h_step);  %下一时刻的制导指令
        CtrlSdt_B(1) = CmdAng_1(1); CtrlSdt_B(2) = CmdAng_1(2); CtrlSdt_B(3) = CmdAng_1(3);
       
        %控制器输出虚拟控制量,计算下一步的舵偏
        if ctrler_type==1
            [Eror_ang_1, Eror_omg_1, DeltaE_1] = Ctrller_CNC(CmdAng_1, AeroAng_1, Omega_1); %%使用校正网络控制器
        elseif ctrler_type==2
%             AfnPara = AfnNonlnrPara(DeltaA, Env_para, FltSdt_S, FltSdt_F); 
%            [Eror_ang_1, Eror_omg_1, DeltaE_1] = Ctrller_SMC(AfnPara, CmdAng_1, AeroAng_1, Omega_1); %%使用sliding mode 滑模控制器            
        elseif ctrler_type==3
%              [Eror_ang_1, Eror_omg_1, DeltaE_1] = Ctrller_PPFSMC(CmdAng_1, AeroAng_1, Omega_1); %%使用具有预设性能的滑模控制    
        else
%            Eror_ang_1 = [0,0,0];   Eror_omg_1 = [0,0,0];   Accelrt_1 = [0,0,0];  DeltaE_1 = [0,0,0];            
        end
        
        %控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
        CtrlSdt_P(1) = Eror_ang_1(1);  CtrlSdt_P(2) = Eror_ang_1(2);  CtrlSdt_P(3) = Eror_ang_1(3);
        %构成角速度控制误差矢量 Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
        CtrlSdt_P(4) = Eror_omg_1(1);  CtrlSdt_P(5) = Eror_omg_1(2);  CtrlSdt_P(6) = Eror_omg_1(3);
        %构成角加速度矢量 Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
        CtrlSdt_P(7) = Accelrt(1);   CtrlSdt_P(8) = Accelrt(2);   CtrlSdt_P(9) = Accelrt(3);
        %构成等效舵偏矢量 DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];
        CtrlSdt_P(10)= DeltaE_1(1);   CtrlSdt_P(11)= DeltaE_1(2);     CtrlSdt_P(12)= DeltaE_1(3);
        
        %经过舵伺服系统
        [DeltaA_1] = Servor_sys(DeltaE_1,DeltaA); %%将虚拟的控制指令分配到实际舵 
        CtrlSdt_B(4) = DeltaA_1(1); CtrlSdt_B(5) = DeltaA_1(2);  CtrlSdt_B(6) = DeltaA_1(3); 
        
        DeltaA = DeltaA_1; %%记录下一次的当前舵偏值，本次计算结束，进入下一个步长的计算
        
         %%%记录仿真结果      
         FltBuf2 = [(Time + h_step), Env_para(3), FltSdt_S, FltSdt_F, CtrlSdt_B, CtrlSdt_P];%%全部的状态量1+1+6+9+6+12=35
         FltData2(step,:) = FltBuf2;
         
         if (Eror_ang_1(1)>30)||(Eror_ang_1(2)>30)||(Eror_ang_1(3)>30)
            disp('ERROR!!!');%%误差过大，认为是发散了
            break
        end
    end           
end
save('3DOF.mat','FltData1');
%save('Lnepara_bias2-16-30.mat','LnrPara_std');
% save('Lnepara_k10_bias0.mat','LnrPara_ins');%2-1-30
% save('FltData_k10_bias0.mat','FltData2');%2-1-30
%% 数据分析与曲线绘制
% DataAnalys1();%数据分析
% my_plot1();%曲线绘制
% my_plot2();%曲线绘制
% my_plot3();%曲线绘制
% my_plot4();%曲线绘制










  