%%У�����������
%˫�����ƣ����룺ָ��ǣ�ʵ�ʽǣ����ٶ�
%������Ƕȿ��������ٶȿ������Ǽ��ٶȣ���Ч��ƫ
% alpha = FltSdt_F(4);   beta = FltSdt_F(5);   mu = FltSdt_F(6); %����������ʸ�� AeroAng = [alpha, beta, mu];
% q = FltSdt_F(7);   r = FltSdt_F(8);   p = FltSdt_F(9); %���ɽ�����ʸ�� Omega = [q ,r, p];
%Cmd_alp = CtrlSdt_B(1);  Cmd_bet = CtrlSdt_B(2);    Cmd_mu = CtrlSdt_B(3); %����ָ��ʸ�� CmdAng = [Cmd_alp ,Cmd_bet, Cmd_mu];
%Ero_pit = CtrlSdt_P(1);  Ero_yaw = CtrlSdt_P(2);    Ero_rol = CtrlSdt_P(3); %���ɿ������ʸ�� Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
%Ero_qw = CtrlSdt_P(4);  Ero_rw = CtrlSdt_P(5);    Ero_pw = CtrlSdt_P(6); %���ɽ��ٶȿ������ʸ�� Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
%Acc_pit = CtrlSdt_P(7);  Acc_yaw = CtrlSdt_P(8);    Acc_rol = CtrlSdt_P(9); %���ɽǼ��ٶ�ʸ�� Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
%Dlt_alp = CtrlSdt_P(10);  Dlt_bet = CtrlSdt_P(11);    Dlt_mu = CtrlSdt_P(12); %���ɵ�Ч��ƫʸ�� DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];
function [Eror_ang, Eror_omg, DeltaE] = Ctrller_CNC(CmdAng, AeroAng, Omega)

load CNCtrl_para.mat   %У������Ĳ��� 'numpz','denpz','numyz','denyz','numrz','denrz'
%load Kin_para1000.mat    %�ڻ�����'Kinp','Kiny','Kinr'  ��ֵ��Χ0: 0.01: 100;
 load Kin_para1500.mat    %�ڻ�����'Kinp','Kiny','Kinr'  ��ֵ��Χ0: 0.01: 100;
% load Kin_para2000.mat    %�ڻ�����'Kinp','Kiny','Kinr'  ��ֵ��Χ0: 0.01: 100;
% load Kin_para2500.mat    %�ڻ�����'Kinp','Kiny','Kinr'  ��ֵ��Χ0: 0.01: 100;
global step;     %%��¼���沽��,�����������
%�¶����ȫ�ֱ�����Ϊ�˼�¼�м�ֵ���������
global u_lst; %��ͨ�����ڻ������ϴ������¼ֵ
global Dlt_lst; %��ͨ�����ڻ������ϴ������¼ֵ

if step==1
    u_lst = [0,0,0]; %��ʼ������
    Dlt_lst = [0,0,0]; %��ʼ������
end

Kinpt = Kinp(round((step-1)/2) +1); %��ȡ��ֵ���ڻ�����
Kinyt = Kiny(round((step-1)/2) +1); %��ȡ��ֵ���ڻ�����
Kinrt = Kinr(round((step-1)/2) +1); %��ȡ��ֵ���ڻ�����

%�����ڵ��⻷����
Koutp = 10;
Kouty = -6; 
Koutr = 10;

 Eror_ang = CmdAng - AeroAng;  %�Ƕȿ���������ָ��Ǽ�ʵ�ʽǶ�
%Eror_ang = AeroAng - CmdAng;  %�Ƕȿ���������ָ��Ǽ�ʵ�ʽǶ�
q_act = Omega(1); r_act = Omega(2); p_act = Omega(3); %ʵ�ʽ��ٶ�
%% ����ͨ������ �Ƕ�alpha�����ٶ�q
                        %%%%%%%%%%% �⻷���Ƕȿ���, ʹ�õ������⻷����kout%%%%%%%%%%%
e_alp = Eror_ang(1);   %�Ƕȿ������
q_exp = e_alp*Koutp;  %�⻷�������������Ϊ�ڻ�����������
                        %%%%%%%%%%% �ڻ����ٶȿ���,ʹ���ͺ�У������ %%%%%%%%%%%
e_q = q_exp - q_act;  %���ٶȿ������
u_q = e_q*Kinpt;  %�ȳ����ڻ�����
u_q_lst = u_lst(1);  Dlt_a_lst = Dlt_lst(1); %��ȡ�ϴμ�¼ֵ
Dlt_a = DifEquNet(u_q, u_q_lst, Dlt_a_lst, denpz, numpz);  %�ͺ�����

u_lst(1) = u_q;  Dlt_lst(1) = Dlt_a; %���±��μ�¼ֵ

%% ƫ��ͨ������ �Ƕ�beta�����ٶ�r
                        %%%%%%%%%%% �⻷���Ƕȿ���, ʹ�õ������⻷����kout%%%%%%%%%%%
e_bta = Eror_ang(2);   %�Ƕȿ������
r_exp = e_bta*Kouty;  %�⻷�������������Ϊ�ڻ�����������
                        %%%%%%%%%%% �ڻ����ٶȿ���,ʹ���ͺ�У������ %%%%%%%%%%%
e_r = r_exp - r_act;  %���ٶȿ������
u_r = e_r*Kinyt;  %�ȳ����ڻ�����
u_r_lst = u_lst(2);  Dlt_b_lst = Dlt_lst(2); %��ȡ�ϴμ�¼ֵ
Dlt_b = DifEquNet(u_r, u_r_lst, Dlt_b_lst, denyz, numyz);  %�ͺ�����

u_lst(2) = u_r;  Dlt_lst(2) = Dlt_b; %���±��μ�¼ֵ

%% ��תͨ������ �Ƕ�mu�����ٶ�p
                        %%%%%%%%%%% �⻷���Ƕȿ���, ʹ�õ������⻷����kout%%%%%%%%%%%
e_mu = Eror_ang(3);   %�Ƕȿ������
p_exp = e_mu*Koutr;  %�⻷�������������Ϊ�ڻ�����������
                        %%%%%%%%%%% �ڻ����ٶȿ���,ʹ���ͺ�У������ %%%%%%%%%%%
e_p = p_exp - p_act;  %���ٶȿ������
u_p = e_p*Kinrt;  %�ȳ����ڻ�����
u_p_lst = u_lst(3);  Dlt_m_lst = Dlt_lst(3); %��ȡ�ϴμ�¼ֵ
Dlt_m = DifEquNet(u_p, u_p_lst, Dlt_m_lst, denrz, numrz);  %�ͺ�����

u_lst(3) = u_p;  Dlt_lst(3) = Dlt_m; %���±��μ�¼ֵ

%% ��������
Eror_omg(1) = e_q;   Eror_omg(2) = e_r;   Eror_omg(3) = e_p;
DeltaE(1) = Dlt_a;   DeltaE(2) = Dlt_b;   DeltaE(3) = Dlt_m;
end 

%% һ�������Z�任�Ĳ�ַ�����ʽ
%�����������ǰ�������룬ǰһ�����룬ǰһ����������崫���ķ��ӷ�ĸ
%�����������ǰ���
function [Yout] = DifEquNet(U, U_lst, Y_lst, denz, numz)

Yout = - denz(2)*Y_lst + numz(1)*U + numz(2)*U_lst;

end