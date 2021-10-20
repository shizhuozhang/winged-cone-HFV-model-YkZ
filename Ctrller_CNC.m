%%校正网络控制器
%双环控制，输入：指令角，实际角，角速度
%输出：角度控制误差，角速度控制误差，角加速度，等效舵偏
% alpha = FltSdt_F(4);   beta = FltSdt_F(5);   mu = FltSdt_F(6); %构成气动角矢量 AeroAng = [alpha, beta, mu];
% q = FltSdt_F(7);   r = FltSdt_F(8);   p = FltSdt_F(9); %构成角速率矢量 Omega = [q ,r, p];
%Cmd_alp = CtrlSdt_B(1);  Cmd_bet = CtrlSdt_B(2);    Cmd_mu = CtrlSdt_B(3); %构成指令矢量 CmdAng = [Cmd_alp ,Cmd_bet, Cmd_mu];
%Ero_pit = CtrlSdt_P(1);  Ero_yaw = CtrlSdt_P(2);    Ero_rol = CtrlSdt_P(3); %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
%Ero_qw = CtrlSdt_P(4);  Ero_rw = CtrlSdt_P(5);    Ero_pw = CtrlSdt_P(6); %构成角速度控制误差矢量 Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
%Acc_pit = CtrlSdt_P(7);  Acc_yaw = CtrlSdt_P(8);    Acc_rol = CtrlSdt_P(9); %构成角加速度矢量 Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
%Dlt_alp = CtrlSdt_P(10);  Dlt_bet = CtrlSdt_P(11);    Dlt_mu = CtrlSdt_P(12); %构成等效舵偏矢量 DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];
function [Eror_ang, Eror_omg, DeltaE] = Ctrller_CNC(CmdAng, AeroAng, Omega)

load CNCtrl_para.mat   %校正网络的参数 'numpz','denpz','numyz','denyz','numrz','denrz'
%load Kin_para1000.mat    %内环增益'Kinp','Kiny','Kinr'  插值范围0: 0.01: 100;
 load Kin_para1500.mat    %内环增益'Kinp','Kiny','Kinr'  插值范围0: 0.01: 100;
% load Kin_para2000.mat    %内环增益'Kinp','Kiny','Kinr'  插值范围0: 0.01: 100;
% load Kin_para2500.mat    %内环增益'Kinp','Kiny','Kinr'  插值范围0: 0.01: 100;
global step;     %%记录仿真步数,用于增益调度
%新定义的全局变量，为了记录中间值而不被清除
global u_lst; %三通道的内环网络上次输入记录值
global Dlt_lst; %三通道的内环网络上次输出记录值

if step==1
    u_lst = [0,0,0]; %初始化参数
    Dlt_lst = [0,0,0]; %初始化参数
end

Kinpt = Kinp(round((step-1)/2) +1); %获取插值的内环增益
Kinyt = Kiny(round((step-1)/2) +1); %获取插值的内环增益
Kinrt = Kinr(round((step-1)/2) +1); %获取插值的内环增益

%待调节的外环增益
Koutp = 10;
Kouty = -6; 
Koutr = 10;

 Eror_ang = CmdAng - AeroAng;  %角度控制误差，期望指令角减实际角度
%Eror_ang = AeroAng - CmdAng;  %角度控制误差，期望指令角减实际角度
q_act = Omega(1); r_act = Omega(2); p_act = Omega(3); %实际角速度
%% 俯仰通道控制 角度alpha，角速度q
                        %%%%%%%%%%% 外环，角度控制, 使用单独地外环增益kout%%%%%%%%%%%
e_alp = Eror_ang(1);   %角度控制误差
q_exp = e_alp*Koutp;  %外环控制器，结果作为内环的输入期望
                        %%%%%%%%%%% 内环角速度控制,使用滞后校正网络 %%%%%%%%%%%
e_q = q_exp - q_act;  %角速度控制误差
u_q = e_q*Kinpt;  %先乘以内环增益
u_q_lst = u_lst(1);  Dlt_a_lst = Dlt_lst(1); %读取上次记录值
Dlt_a = DifEquNet(u_q, u_q_lst, Dlt_a_lst, denpz, numpz);  %滞后网络

u_lst(1) = u_q;  Dlt_lst(1) = Dlt_a; %更新本次记录值

%% 偏航通道控制 角度beta，角速度r
                        %%%%%%%%%%% 外环，角度控制, 使用单独地外环增益kout%%%%%%%%%%%
e_bta = Eror_ang(2);   %角度控制误差
r_exp = e_bta*Kouty;  %外环控制器，结果作为内环的输入期望
                        %%%%%%%%%%% 内环角速度控制,使用滞后校正网络 %%%%%%%%%%%
e_r = r_exp - r_act;  %角速度控制误差
u_r = e_r*Kinyt;  %先乘以内环增益
u_r_lst = u_lst(2);  Dlt_b_lst = Dlt_lst(2); %读取上次记录值
Dlt_b = DifEquNet(u_r, u_r_lst, Dlt_b_lst, denyz, numyz);  %滞后网络

u_lst(2) = u_r;  Dlt_lst(2) = Dlt_b; %更新本次记录值

%% 滚转通道控制 角度mu，角速度p
                        %%%%%%%%%%% 外环，角度控制, 使用单独地外环增益kout%%%%%%%%%%%
e_mu = Eror_ang(3);   %角度控制误差
p_exp = e_mu*Koutr;  %外环控制器，结果作为内环的输入期望
                        %%%%%%%%%%% 内环角速度控制,使用滞后校正网络 %%%%%%%%%%%
e_p = p_exp - p_act;  %角速度控制误差
u_p = e_p*Kinrt;  %先乘以内环增益
u_p_lst = u_lst(3);  Dlt_m_lst = Dlt_lst(3); %读取上次记录值
Dlt_m = DifEquNet(u_p, u_p_lst, Dlt_m_lst, denrz, numrz);  %滞后网络

u_lst(3) = u_p;  Dlt_lst(3) = Dlt_m; %更新本次记录值

%% 参数传递
Eror_omg(1) = e_q;   Eror_omg(2) = e_r;   Eror_omg(3) = e_p;
DeltaE(1) = Dlt_a;   DeltaE(2) = Dlt_b;   DeltaE(3) = Dlt_m;
end 

%% 一阶网络的Z变换的差分方程形式
%输入参量：当前网络输入，前一步输入，前一步输出，脉冲传函的分子分母
%输出参量：当前输出
function [Yout] = DifEquNet(U, U_lst, Y_lst, denz, numz)

Yout = - denz(2)*Y_lst + numz(1)*U + numz(2)*U_lst;

end