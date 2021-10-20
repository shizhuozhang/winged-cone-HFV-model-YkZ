function LnrPara = cal_LinearPara(DeltaA, Env_para, FltSdt_S, FltSdt_F)
global m0;   %%再入飞行质量
global Jx;   %%绕X轴转动惯量 
global Jy;   %%绕X轴转动惯量 
global Jz;   %%绕X轴转动惯量 
global Xcg;  %%质心到参考力矩中心距离
global S;    %%翼展参考面积
global b;    %%翼展
global c;    %%平均气动弦长
global Uncertn_flag; %是否引入外部风干扰（随机干扰）
global Uncertn_para;
global Coef_aero;  %%气动模型计算的转换系数 %本应该用弧度到度的转换系数，但由于有问题，暂时用这个调试
%% 参数赋值
%不确定参数
% xm  = Uncertn_para(1); xJx = Uncertn_para(2);  xJy = Uncertn_para(3); xJz = Uncertn_para(4);
xRho = Uncertn_para(5); 
xCD = Uncertn_para(6);  xCY = Uncertn_para(7);  xCL = Uncertn_para(8);  
xCl = Uncertn_para(9);  xCm = Uncertn_para(10); xCn = Uncertn_para(11);

%舵偏参数
LE = DeltaA(1); RE = DeltaA(2); RUD = DeltaA(3);%%注意舵偏顺序 e,a,r ，和下面的气动函数有点不一致

%飞行状态参数
%X_loc = FltSdt_S(1);   Y_loc = FltSdt_S(2);  Height = FltSdt_S(3);
Veloc = FltSdt_S(4);   gamma = FltSdt_S(5); %  chi = FltSdt_S(6);

alpha = FltSdt_F(4);   ALPHA = Coef_aero * alpha; 
beta = FltSdt_F(5);    mu = FltSdt_F(6);
q = FltSdt_F(7);       r = FltSdt_F(8);    p = FltSdt_F(9);

%大气环境参数
g = Env_para(1);  Rho = Env_para(2);  Ma = Env_para(3);   

[CD_Coe, CY_Coe, CL_Coe, Clw_Coe, Cmw_Coe, Cnw_Coe] = AeroCoefficent(Ma,ALPHA,beta,RE,LE,RUD,p,q,r,Veloc);

%气动极限不确定性
if Uncertn_flag == 1
    Rho = Rho*(1 + xRho);%空气密度不确定性
    CD_Coe = CD_Coe*(1 + xCD); CY_Coe = CY_Coe*(1 + xCY); CL_Coe = CL_Coe*(1 + xCL);%气动参数不确定性
    Clw_Coe = Clw_Coe*(1 + xCl); Cmw_Coe = Cmw_Coe*(1 + xCm); Cnw_Coe = Cnw_Coe*(1 + xCn);
end

CD = CD_Coe(1); CD_dalp = CD_Coe(2);  CD_dDte = CD_Coe(3);  CD_dDta = CD_Coe(4);  CD_dDtr = CD_Coe(5);
CY = CY_Coe(1);  CY_dalp = CY_Coe(2);  CY_dDte = CY_Coe(3);  CY_dDta = CY_Coe(4);  CY_dDtr = CY_Coe(5); CYb = CY_Coe(6);
CL = CL_Coe(1);  CL_dalp = CL_Coe(2);  CL_dDte = CL_Coe(3);  CL_dDta = CL_Coe(4);
Cl_dalp = Clw_Coe(1); Cl_dDte = Clw_Coe(2); Cl_dDta = Clw_Coe(3); Cl_dDtr = Clw_Coe(4); Clb = Clw_Coe(5); Clp = Clw_Coe(6); Clr = Clw_Coe(7);
Cm_dalp = Cmw_Coe(1); Cm_dDte = Cmw_Coe(2); Cm_dDta = Cmw_Coe(3); Cm_dDtr = Cmw_Coe(4);  Cmq = Cmw_Coe(5);
Cn_dalp = Cnw_Coe(1); Cn_dDte = Cnw_Coe(2); Cn_dDta = Cnw_Coe(3); Cn_dDtr = Cnw_Coe(4); Cnb = Cnw_Coe(5); Cnp = Cnw_Coe(6); Cnr = Cnw_Coe(7); 

q_bar = (Veloc^2)*Rho/2; %%动压的计算
%% 主要小偏差线性化系数计算（解耦的）
% c1p = - S*q_bar*CL_dalp/m0/Veloc;
% c2p = 1;
% c3p = S*q_bar*(CL_dDte + CL_dDta)/m0/Veloc;
% b1p = c^2*S*q_bar*Cmq/2/Jy/Veloc;
% b2p = (S*q_bar/Jy)*(c*Cm_dalp + Xcg* ((CL_dalp + CD)*cos(alpha) + (CD_dalp - CL)*sin(alpha)));
% b3p = (S*q_bar/Jy)*(- c*(Cm_dDte + Cm_dDta) - Xcg* ((CD_dDta + CD_dDte)*sin(alpha) + (CL_dDta + CL_dDte)*cos(alpha)));
% 
% c1y = 0;
% c2y = - cos(alpha);
% c3y = - S*q_bar*CY_dDtr/m0/Veloc;
% b1y = b^2*S*q_bar*Cnr/2/Jz/Veloc;
% b2y = b*S*q_bar*Cnb/Jz;
% b3y = (S*q_bar/Jz)*(- b*Cn_dDtr + Xcg*CY_dDtr);
% 
% c1r = - S*q_bar*tan(gamma)*( CY*sin(mu) + CL*cos(mu) )/m0/Veloc;
% c2r = cos(alpha);
% c3r = (S*q_bar/m0/Veloc)*((CY_dDte - CY_dDta)*cos(mu) - (CL_dDte - CL_dDta)*sin(mu))*tan(gamma);
% b1r = b^2*S*q_bar*Clp/2/Jx/Veloc;
% b2r = 0;
% b3r = b*S*q_bar*( Cl_dDte - Cl_dDta)/Jx;
% 
% %%参数整合
% Acp = [c1p, c2p];  Bcp = [c3p];
% Abp = [b2p, b1p];  Bbp = [b3p]; 
% Acy = [c1y, c2y];  Bcy = [c3y];
% Aby = [b2y, b1y];  Bby = [b3y]; 
% Acr = [c1r, c2r];  Bcr = [c3r];
% Abr = [b2r, b1r];  Bbr = [b3r]; 

%% 全部小偏差线性化系数计算（非解耦的）
c1p = - S*q_bar*CL_dalp/m0/Veloc;
c2p = 1;
c3p = S*q_bar*(CL_dDte + CL_dDta)/m0/Veloc;
c4p = p*cos(alpha);  %%角度单位是rad;
c5p = 0;
c6p = 0;
c7p = - g*cos(gamma)*sin(mu)/Veloc;
c8p = 0;
c9p = S*q_bar*(CL_dDta - CL_dDte)/m0/Veloc;
% %通过曲线分析：
%c1p的范围是（1~5）*E-2； c2p=1; c3p的范围是（-1~-5）*E-4；
%c7p的范围是（-6~6）*E-4,仅在有滚转的情况下不为0；其余系数都为0 

b1p = c^2*S*q_bar*Cmq/2/Jy/Veloc;
b2p = (S*q_bar/Jy)*(c*Cm_dalp + Xcg* ((CL_dalp + CD)*cos(alpha) + (CD_dalp - CL)*sin(alpha)));
b3p = -(S*q_bar/Jy)*(c*(Cm_dDte + Cm_dDta) + Xcg* ((CD_dDta + CD_dDte)*sin(alpha) + (CL_dDta + CL_dDte)*cos(alpha)));
b4p = (Jz - Jx)*p/Jy;
b5p = 0;
b6p = -(S*q_bar/Jy)*(c*Cm_dDtr + Xcg*CD_dDtr *sin(alpha));
b7p = 0;
b8p = 0;
b9p = (S*q_bar/Jy)*(c*(Cm_dDte - Cm_dDta) + Xcg* ((CD_dDte - CD_dDta)*sin(alpha) + (CL_dDte - CL_dDta)*cos(alpha)));
% % 通过曲线分析：
%b1p的范围是（-0.1~-0.6）*E-2； b2p的范围是（2~11）； b3p的范围是（-0.05~-0.3）； 
%b6p的范围是（0~4）*E-5；       b9p的范围是（0~3）*E-19,这两个系数较小，可忽略；其余系数均为0

c1y =  S*q_bar*CYb/m0/Veloc;  
c2y = - cos(alpha);
c3y = - S*q_bar*CY_dDtr/m0/Veloc;
c4y = p*cos(alpha) + S*q_bar*CY_dalp/m0/Veloc;
c5y = 0;
c6y = - S*q_bar*(CY_dDte + CY_dDta)/m0/Veloc;
c7y = g*cos(gamma)*cos(mu)/Veloc;
c8y = sin(alpha);
c9y = S*q_bar*(CY_dDte - CY_dDta)/m0/Veloc;
% % 通过上面的曲线分析：
% % c1y的范围是（~）；c2y的范围是（-1~-0.9）；c3y的范围是（-0.2~-2）*E-4；c4y的范围是（-2~2）*E-3；c7y的范围是（2.1~2.4）*E-3；
% %c8y的范围是（0~0.35）； c6y的范围是（0.5~4）*E-7；c9y的范围是（-0.5~-4.5）*E-7；这两个系数较小，可忽略；其余系数都为0 

b1y = b^2*S*q_bar*Cnr/2/Jz/Veloc;
b2y = b*S*q_bar*Cnb/Jz;
b3y = (S*q_bar/Jz)*(- b*Cn_dDtr + Xcg*CY_dDtr);
b4y = (Jx - Jy)*p/Jz;
b5y = (S*q_bar/Jz)*(b*Cn_dalp - Xcg*CY_dalp);
b6y = (S*q_bar/Jz)*( - b*(Cn_dDta + Cn_dDte) + Xcg* (CY_dDte + CY_dDta));
b7y = (Jx - Jy)*q/Jz + b^2*S*q_bar*Cnp/2/Jz/Veloc;
b8y = 0;
b9y = (S*q_bar/Jz)*( b*(Cn_dDte - Cn_dDta) + Xcg* (CY_dDta - CY_dDte));
% % %通过上面的曲线分析：
% b1y的范围是（-0.1~-0.7）； b2y的范围是（-10~-40）；   b3y的范围是（0.04~-0.25）； b5y的范围是（0.3~-0.3）；
%b7y的范围是（1~5）*E-2；  b9y的范围是（0.4~-1.6）*E-2； b6y的范围是（0.5~3）*E-18,这个系数较小，可忽略；其余系数均为0

c1r = - S*q_bar*tan(gamma)*( CY*sin(mu) + CL*cos(mu) )/m0/Veloc;
c2r = cos(alpha);
c3r = (S*q_bar/m0/Veloc)*((CY_dDte - CY_dDta)*cos(mu) - (CL_dDte - CL_dDta)*sin(mu))*tan(gamma);
c4r = - p*sin(alpha) + S*q_bar*tan(gamma)*( CY_dalp*cos(mu) - CL_dalp*sin(mu) )/m0/Veloc;
c5r = 0;
c6r = (S*q_bar/m0/Veloc)*((CL_dDte + CL_dDta)*sin(mu) - (CY_dDte + CY_dDta)*cos(mu))*tan(gamma);
c7r = - S*q_bar*CL/m0/Veloc;
c8r = sin(alpha);
c9r = - S*q_bar*tan(gamma)*cos(mu)*CY_dDtr/m0/Veloc;
% % %通过上面的曲线分析：
% %c4r的范围是（0~-4）*E-4,仅滚转时不为0； c3r的范围是（0~2.5）*E-8；c8r的范围是（0~-0.35）； c1r的范围是（0~1.2）*E-4；c2r的范围是（1~0.95）；
% %c6r的范围是（0~-4）*E-6,仅滚转时不为0；c7r的范围是（0.5~-3）*E-3；c9r的范围是（0~1.2）*E-5；其余系数都为0 

b1r = b^2*S*q_bar*Clp/2/Jx/Veloc;
b2r = 0;
b3r = b*S*q_bar*( Cl_dDte - Cl_dDta)/Jx;
b4r = (Jy - Jz)*r/Jx;
b5r = b*S*q_bar*Cl_dalp/Jx;
b6r = - b*S*q_bar*( Cl_dDte +Cl_dDta)/Jx;
b7r = (Jy - Jz)*q/Jx + b^2*S*q_bar*Clr/2/Jx/Veloc;
b8r = b*S*q_bar*Clb/Jx;
b9r = - b*S*q_bar*Cl_dDtr/Jx;
% % %通过上面的曲线分析：
% %b3r的范围是（-0.2~-1.4）； b8r的范围是（-20~-100；b7r的范围是（0.1~0.7）； b1r的范围是（-0.1~-0.5）；b9r的范围是（-0.1~-0.4）；
% %b5r的范围是（1~5）*E-16,该系数较小，可忽略；其余系数都为0 

%%参数整合
Acp = [c1p, c2p, c4p, c5p, c7p, c8p];  Bcp = [c3p, c6p, c9p];
Abp = [b2p, b1p, b5p, b4p, b8p, b7p];  Bbp = [b3p, b6p, b9p]; 
Acy = [c4y, c5y, c1y, c2y, c7y, c8y];  Bcy = [c6y, c3y, c9y];
Aby = [b5y, b4y, b2y, b1y, b8y, b7y];  Bby = [b6y, b3y, b9y]; 
Acr = [c4r, c5r, c7r, c8r, c1r, c2r];  Bcr = [c6r, c9r, c3r];
Abr = [b5r, b4r, b8r, b7r, b2r, b1r];  Bbr = [b6r, b9r, b3r]; 

LnrPara = [Acp,Bcp,Abp,Bbp,Acy,Bcy, Aby,Bby, Acr,Bcr, Abr,Bbr];%合成一个总的系数54维向量，用的时候再分解

% A = [Acp; Abp; Acy; Aby; Acr; Abr];
% B = [Bcp; Bbp; Bcy; Bby; Bcr; Bbr];
% LnrPara = [A, B];  %合成一个总的系数矩阵，用的时候再分解
end