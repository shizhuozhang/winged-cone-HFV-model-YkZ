function LnrPara = cal_LinearPara(DeltaA, Env_para, FltSdt_S, FltSdt_F)
global m0;   %%�����������
global Jx;   %%��X��ת������ 
global Jy;   %%��X��ת������ 
global Jz;   %%��X��ת������ 
global Xcg;  %%���ĵ��ο��������ľ���
global S;    %%��չ�ο����
global b;    %%��չ
global c;    %%ƽ�������ҳ�
global Uncertn_flag; %�Ƿ������ⲿ����ţ�������ţ�
global Uncertn_para;
global Coef_aero;  %%����ģ�ͼ����ת��ϵ�� %��Ӧ���û��ȵ��ȵ�ת��ϵ���������������⣬��ʱ���������
%% ������ֵ
%��ȷ������
% xm  = Uncertn_para(1); xJx = Uncertn_para(2);  xJy = Uncertn_para(3); xJz = Uncertn_para(4);
xRho = Uncertn_para(5); 
xCD = Uncertn_para(6);  xCY = Uncertn_para(7);  xCL = Uncertn_para(8);  
xCl = Uncertn_para(9);  xCm = Uncertn_para(10); xCn = Uncertn_para(11);

%��ƫ����
LE = DeltaA(1); RE = DeltaA(2); RUD = DeltaA(3);%%ע���ƫ˳�� e,a,r ������������������е㲻һ��

%����״̬����
%X_loc = FltSdt_S(1);   Y_loc = FltSdt_S(2);  Height = FltSdt_S(3);
Veloc = FltSdt_S(4);   gamma = FltSdt_S(5); %  chi = FltSdt_S(6);

alpha = FltSdt_F(4);   ALPHA = Coef_aero * alpha; 
beta = FltSdt_F(5);    mu = FltSdt_F(6);
q = FltSdt_F(7);       r = FltSdt_F(8);    p = FltSdt_F(9);

%������������
g = Env_para(1);  Rho = Env_para(2);  Ma = Env_para(3);   

[CD_Coe, CY_Coe, CL_Coe, Clw_Coe, Cmw_Coe, Cnw_Coe] = AeroCoefficent(Ma,ALPHA,beta,RE,LE,RUD,p,q,r,Veloc);

%�������޲�ȷ����
if Uncertn_flag == 1
    Rho = Rho*(1 + xRho);%�����ܶȲ�ȷ����
    CD_Coe = CD_Coe*(1 + xCD); CY_Coe = CY_Coe*(1 + xCY); CL_Coe = CL_Coe*(1 + xCL);%����������ȷ����
    Clw_Coe = Clw_Coe*(1 + xCl); Cmw_Coe = Cmw_Coe*(1 + xCm); Cnw_Coe = Cnw_Coe*(1 + xCn);
end

CD = CD_Coe(1); CD_dalp = CD_Coe(2);  CD_dDte = CD_Coe(3);  CD_dDta = CD_Coe(4);  CD_dDtr = CD_Coe(5);
CY = CY_Coe(1);  CY_dalp = CY_Coe(2);  CY_dDte = CY_Coe(3);  CY_dDta = CY_Coe(4);  CY_dDtr = CY_Coe(5); CYb = CY_Coe(6);
CL = CL_Coe(1);  CL_dalp = CL_Coe(2);  CL_dDte = CL_Coe(3);  CL_dDta = CL_Coe(4);
Cl_dalp = Clw_Coe(1); Cl_dDte = Clw_Coe(2); Cl_dDta = Clw_Coe(3); Cl_dDtr = Clw_Coe(4); Clb = Clw_Coe(5); Clp = Clw_Coe(6); Clr = Clw_Coe(7);
Cm_dalp = Cmw_Coe(1); Cm_dDte = Cmw_Coe(2); Cm_dDta = Cmw_Coe(3); Cm_dDtr = Cmw_Coe(4);  Cmq = Cmw_Coe(5);
Cn_dalp = Cnw_Coe(1); Cn_dDte = Cnw_Coe(2); Cn_dDta = Cnw_Coe(3); Cn_dDtr = Cnw_Coe(4); Cnb = Cnw_Coe(5); Cnp = Cnw_Coe(6); Cnr = Cnw_Coe(7); 

q_bar = (Veloc^2)*Rho/2; %%��ѹ�ļ���
%% ��ҪСƫ�����Ի�ϵ�����㣨����ģ�
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
% %%��������
% Acp = [c1p, c2p];  Bcp = [c3p];
% Abp = [b2p, b1p];  Bbp = [b3p]; 
% Acy = [c1y, c2y];  Bcy = [c3y];
% Aby = [b2y, b1y];  Bby = [b3y]; 
% Acr = [c1r, c2r];  Bcr = [c3r];
% Abr = [b2r, b1r];  Bbr = [b3r]; 

%% ȫ��Сƫ�����Ի�ϵ�����㣨�ǽ���ģ�
c1p = - S*q_bar*CL_dalp/m0/Veloc;
c2p = 1;
c3p = S*q_bar*(CL_dDte + CL_dDta)/m0/Veloc;
c4p = p*cos(alpha);  %%�Ƕȵ�λ��rad;
c5p = 0;
c6p = 0;
c7p = - g*cos(gamma)*sin(mu)/Veloc;
c8p = 0;
c9p = S*q_bar*(CL_dDta - CL_dDte)/m0/Veloc;
% %ͨ�����߷�����
%c1p�ķ�Χ�ǣ�1~5��*E-2�� c2p=1; c3p�ķ�Χ�ǣ�-1~-5��*E-4��
%c7p�ķ�Χ�ǣ�-6~6��*E-4,�����й�ת������²�Ϊ0������ϵ����Ϊ0 

b1p = c^2*S*q_bar*Cmq/2/Jy/Veloc;
b2p = (S*q_bar/Jy)*(c*Cm_dalp + Xcg* ((CL_dalp + CD)*cos(alpha) + (CD_dalp - CL)*sin(alpha)));
b3p = -(S*q_bar/Jy)*(c*(Cm_dDte + Cm_dDta) + Xcg* ((CD_dDta + CD_dDte)*sin(alpha) + (CL_dDta + CL_dDte)*cos(alpha)));
b4p = (Jz - Jx)*p/Jy;
b5p = 0;
b6p = -(S*q_bar/Jy)*(c*Cm_dDtr + Xcg*CD_dDtr *sin(alpha));
b7p = 0;
b8p = 0;
b9p = (S*q_bar/Jy)*(c*(Cm_dDte - Cm_dDta) + Xcg* ((CD_dDte - CD_dDta)*sin(alpha) + (CL_dDte - CL_dDta)*cos(alpha)));
% % ͨ�����߷�����
%b1p�ķ�Χ�ǣ�-0.1~-0.6��*E-2�� b2p�ķ�Χ�ǣ�2~11���� b3p�ķ�Χ�ǣ�-0.05~-0.3���� 
%b6p�ķ�Χ�ǣ�0~4��*E-5��       b9p�ķ�Χ�ǣ�0~3��*E-19,������ϵ����С���ɺ��ԣ�����ϵ����Ϊ0

c1y =  S*q_bar*CYb/m0/Veloc;  
c2y = - cos(alpha);
c3y = - S*q_bar*CY_dDtr/m0/Veloc;
c4y = p*cos(alpha) + S*q_bar*CY_dalp/m0/Veloc;
c5y = 0;
c6y = - S*q_bar*(CY_dDte + CY_dDta)/m0/Veloc;
c7y = g*cos(gamma)*cos(mu)/Veloc;
c8y = sin(alpha);
c9y = S*q_bar*(CY_dDte - CY_dDta)/m0/Veloc;
% % ͨ����������߷�����
% % c1y�ķ�Χ�ǣ�~����c2y�ķ�Χ�ǣ�-1~-0.9����c3y�ķ�Χ�ǣ�-0.2~-2��*E-4��c4y�ķ�Χ�ǣ�-2~2��*E-3��c7y�ķ�Χ�ǣ�2.1~2.4��*E-3��
% %c8y�ķ�Χ�ǣ�0~0.35���� c6y�ķ�Χ�ǣ�0.5~4��*E-7��c9y�ķ�Χ�ǣ�-0.5~-4.5��*E-7��������ϵ����С���ɺ��ԣ�����ϵ����Ϊ0 

b1y = b^2*S*q_bar*Cnr/2/Jz/Veloc;
b2y = b*S*q_bar*Cnb/Jz;
b3y = (S*q_bar/Jz)*(- b*Cn_dDtr + Xcg*CY_dDtr);
b4y = (Jx - Jy)*p/Jz;
b5y = (S*q_bar/Jz)*(b*Cn_dalp - Xcg*CY_dalp);
b6y = (S*q_bar/Jz)*( - b*(Cn_dDta + Cn_dDte) + Xcg* (CY_dDte + CY_dDta));
b7y = (Jx - Jy)*q/Jz + b^2*S*q_bar*Cnp/2/Jz/Veloc;
b8y = 0;
b9y = (S*q_bar/Jz)*( b*(Cn_dDte - Cn_dDta) + Xcg* (CY_dDta - CY_dDte));
% % %ͨ����������߷�����
% b1y�ķ�Χ�ǣ�-0.1~-0.7���� b2y�ķ�Χ�ǣ�-10~-40����   b3y�ķ�Χ�ǣ�0.04~-0.25���� b5y�ķ�Χ�ǣ�0.3~-0.3����
%b7y�ķ�Χ�ǣ�1~5��*E-2��  b9y�ķ�Χ�ǣ�0.4~-1.6��*E-2�� b6y�ķ�Χ�ǣ�0.5~3��*E-18,���ϵ����С���ɺ��ԣ�����ϵ����Ϊ0

c1r = - S*q_bar*tan(gamma)*( CY*sin(mu) + CL*cos(mu) )/m0/Veloc;
c2r = cos(alpha);
c3r = (S*q_bar/m0/Veloc)*((CY_dDte - CY_dDta)*cos(mu) - (CL_dDte - CL_dDta)*sin(mu))*tan(gamma);
c4r = - p*sin(alpha) + S*q_bar*tan(gamma)*( CY_dalp*cos(mu) - CL_dalp*sin(mu) )/m0/Veloc;
c5r = 0;
c6r = (S*q_bar/m0/Veloc)*((CL_dDte + CL_dDta)*sin(mu) - (CY_dDte + CY_dDta)*cos(mu))*tan(gamma);
c7r = - S*q_bar*CL/m0/Veloc;
c8r = sin(alpha);
c9r = - S*q_bar*tan(gamma)*cos(mu)*CY_dDtr/m0/Veloc;
% % %ͨ����������߷�����
% %c4r�ķ�Χ�ǣ�0~-4��*E-4,����תʱ��Ϊ0�� c3r�ķ�Χ�ǣ�0~2.5��*E-8��c8r�ķ�Χ�ǣ�0~-0.35���� c1r�ķ�Χ�ǣ�0~1.2��*E-4��c2r�ķ�Χ�ǣ�1~0.95����
% %c6r�ķ�Χ�ǣ�0~-4��*E-6,����תʱ��Ϊ0��c7r�ķ�Χ�ǣ�0.5~-3��*E-3��c9r�ķ�Χ�ǣ�0~1.2��*E-5������ϵ����Ϊ0 

b1r = b^2*S*q_bar*Clp/2/Jx/Veloc;
b2r = 0;
b3r = b*S*q_bar*( Cl_dDte - Cl_dDta)/Jx;
b4r = (Jy - Jz)*r/Jx;
b5r = b*S*q_bar*Cl_dalp/Jx;
b6r = - b*S*q_bar*( Cl_dDte +Cl_dDta)/Jx;
b7r = (Jy - Jz)*q/Jx + b^2*S*q_bar*Clr/2/Jx/Veloc;
b8r = b*S*q_bar*Clb/Jx;
b9r = - b*S*q_bar*Cl_dDtr/Jx;
% % %ͨ����������߷�����
% %b3r�ķ�Χ�ǣ�-0.2~-1.4���� b8r�ķ�Χ�ǣ�-20~-100��b7r�ķ�Χ�ǣ�0.1~0.7���� b1r�ķ�Χ�ǣ�-0.1~-0.5����b9r�ķ�Χ�ǣ�-0.1~-0.4����
% %b5r�ķ�Χ�ǣ�1~5��*E-16,��ϵ����С���ɺ��ԣ�����ϵ����Ϊ0 

%%��������
Acp = [c1p, c2p, c4p, c5p, c7p, c8p];  Bcp = [c3p, c6p, c9p];
Abp = [b2p, b1p, b5p, b4p, b8p, b7p];  Bbp = [b3p, b6p, b9p]; 
Acy = [c4y, c5y, c1y, c2y, c7y, c8y];  Bcy = [c6y, c3y, c9y];
Aby = [b5y, b4y, b2y, b1y, b8y, b7y];  Bby = [b6y, b3y, b9y]; 
Acr = [c4r, c5r, c7r, c8r, c1r, c2r];  Bcr = [c6r, c9r, c3r];
Abr = [b5r, b4r, b8r, b7r, b2r, b1r];  Bbr = [b6r, b9r, b3r]; 

LnrPara = [Acp,Bcp,Abp,Bbp,Acy,Bcy, Aby,Bby, Acr,Bcr, Abr,Bbr];%�ϳ�һ���ܵ�ϵ��54ά�������õ�ʱ���ٷֽ�

% A = [Acp; Abp; Acy; Aby; Acr; Abr];
% B = [Bcp; Bbp; Bcy; Bby; Bcr; Bbr];
% LnrPara = [A, B];  %�ϳ�һ���ܵ�ϵ�������õ�ʱ���ٷֽ�
end