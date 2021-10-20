%%��ʼ���������
%����������������κ�������
%�������ʼ�ķ���״̬�����Ͳ�ȷ�����趨ֵ
function [FltSdt_S, FltSdt_F] = Parameter_Init(Ft_p)

global m0;   %%�����������
global Jx;   %%��X��ת������ 
global Jy;   %%��X��ת������ 
global Jz;   %%��X��ת������ 

global ctrl_case; %%ѡ��������Σ���Ϊȫ�������ƺ͵������
global Rad2Deg;  %%����ת��Ϊ��
global Uncertn_flag; %�Ƿ������ⲿ����ţ�������ţ�
global Uncertn_para;
global Bias_case; %ѡȡҪ�о�����ƫ���

%% ��ȷ�����趨����������������ƫ���������������������ƫ���������趨30%��ƫ��
%��ȷ������˳��;    xm0; xJx; xJy; xJz; xRho; xCD; xCY; xCL; xCl; xCm; xCn ; 
Uncertn_para = zeros(1,11); %��ʼֵ����Ϊ0
H_L = 0.3; %��ƫ�����趨�����0.3
%����������ƫ����Ϊ�ṹ�������������������֣������������������ַ�Ϊ��������ͨ�������о���
if Uncertn_flag == 1
    switch Bias_case 
        case 1  % �Խṹ����������ƫ xm0; xJx; xJy; xJz;  
            BCas_s = Limit_bias(4,H_L);
            csx =16; %%�ڼ�����ƫ���� ��Χ1~2^4,��һ����ȫ������ƫ�����һ����ȫ������ƫ
            xm  = BCas_s(csx,1); xJx = BCas_s(csx,2);  xJy = BCas_s(csx,3); xJz = BCas_s(csx,4);   
            m0 = m0*(1 + xm); %������ȷ����
            Jx = Jx*(1 + xJx); Jy = Jy*(1 + xJy); Jz = Jz*(1 + xJz);%ת��������ȷ����
            Uncertn_para(1) = xm;  Uncertn_para(2) = xJx;   Uncertn_para(3) = xJy;  Uncertn_para(4) = xJz;
        case 2  % �Ը��������������������ƫ xRho; xCD; xCL; xCm;
            BCas_p = Limit_bias(4,H_L);
            csx =1; %%�ڼ�����ƫ����
            xRho = BCas_p(csx,1);  xCD = BCas_p(csx,2);   xCL = BCas_p(csx,3);  xCm = BCas_p(csx,4);
            Uncertn_para(5) = xRho; Uncertn_para(6) = xCD; Uncertn_para(8) = xCL; Uncertn_para(10) = xCm;  
        case 3 % �Թ�ת�����������������ƫ xRho; xCl;
            BCas_r = Limit_bias(2,H_L);
            csx =1; %%�ڼ�����ƫ����
            xRho = BCas_r(csx,1);xCl = BCas_r(csx,2);  
            Uncertn_para(5) = xRho;  Uncertn_para(9) = xCl; 
        case 4 % ��ƫ�������������������ƫ xRho; xCY; xCn ;
            BCas_y = Limit_bias(3,H_L);           
            csx =1; %%�ڼ�����ƫ����
            xRho = BCas_y(csx,1);  xCY = BCas_y(csx,2); xCn = BCas_y(csx,3);
            Uncertn_para(5) = xRho; Uncertn_para(7) = xCY;  Uncertn_para(11) = xCn;
        otherwise 
            Uncertn_para = zeros(1,11); 
    end
end

%%�����趨 ��Χ0-0.2  ���ʺͲ�ȷ���Բ�� ��Ӧ����ʱ��ģ�������ﲻ����ʼ���������ļ��㺯�������

%% 100sȫ��������
if ctrl_case==1  %���˸߶ȡ��ٶ���������ȫ������
    X_loc = 0;    Y_loc = 0;    Height = 33000;
    Veloc = 4590;    gamma = 0/Rad2Deg;    chi = 0/Rad2Deg;
    alpha = 2/Rad2Deg;    beta = 0/Rad2Deg;    mu = -2/Rad2Deg;
    q = 0;    r = 0;    p = 0;   
    
%% �������   ���ݱ�Ƶ����������㴦�ľ���״̬�趨
else  
    switch Ft_p
        case 1
            X_loc = 0;    Y_loc = 0;    Height = 33000;
            Veloc = 4590;    gamma = 0/Rad2Deg;    chi = 0/Rad2Deg;
            alpha = 0/Rad2Deg;    beta = 0/Rad2Deg;    mu = 0/Rad2Deg;
            q = 0;    r = 0;    p = 0;  
        case 10  
            X_loc = 0;    Y_loc = 0;    Height = 325130;
            Veloc = 4559;    gamma = -0.98/Rad2Deg;    chi = 0/Rad2Deg;
            alpha = 14/Rad2Deg;    beta = 0/Rad2Deg;    mu = -2/Rad2Deg;
            q = 0;    r = 0;    p = 0;  
    end 
end

%ͨ�����ι�ϵ��ŷ����̬��
AeroAng = [alpha, beta, mu];
Trajct = [Veloc, gamma, chi];
EulerAng = GometrRelat(1, AeroAng ,Trajct);%���ŷ����
theta = EulerAng(1); psi = EulerAng(2); phi = EulerAng(3);

FltSdt_S(1) = X_loc;   FltSdt_S(2) = Y_loc;   FltSdt_S(3) = Height;
FltSdt_S(4) = Veloc;   FltSdt_S(5) = gamma;   FltSdt_S(6) = chi;

FltSdt_F(1) = theta;   FltSdt_F(2) = psi;   FltSdt_F(3) = phi;
FltSdt_F(4) = alpha;   FltSdt_F(5) = beta;   FltSdt_F(6) = mu;
FltSdt_F(7) = q;   FltSdt_F(8) = r;   FltSdt_F(9) = p;
end
