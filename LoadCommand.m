%%�趨�Ƶ�ָ��
%�������Ϊ:��ǰʱ��T
%�������Ϊ����ǰʱ�̵���̬��ָ��������̬��(alpha,beta,mu)��
function ComdAng = LoadCommand(Time) %���еĽǶȵ�λΪrad

global ctrl_case; %%ѡ��������Σ���Ϊ�����ɶȷ���������ɶȷ���
global sim_case; %%ѡ��������Σ���Ϊ�����ɶȷ���������ɶȷ���
global Rad2Deg;  %%����ת��Ϊ��
global ComdAng_lst; %��¼��һ�εĽǶ�
global InAng_lst; %��¼��һ�ε�����Ƕ�
Com_beta = 0;    %�໬ʼ���趨Ϊ0

if Time==0
    if ctrl_case ==1  
        ComdAng_lst = [0,0]/Rad2Deg; %��ʼ������
        InAng_lst = [0,0]/Rad2Deg; %��ʼ������
    else
         ComdAng_lst = [0,0]; %��ʼ������   
         InAng_lst = [0,0]; %��ʼ������
    end
end

%% 100sȫ�������� �Լ����о���Ƶ��Ƶ�ָ��
if ctrl_case ==1  
%     if (Time >= 0)&&(Time <= 2)   
%         In_alpha = 2/Rad2Deg; %����ָ��
%         In_mu = 0/Rad2Deg;    %����ָ��
%     elseif (Time > 2)&&(Time <= 10) 
%         In_alpha = (2*Time-2)/Rad2Deg; %����ָ�� б��Ϊ-2��б��ָ��
%         In_mu = 0;    %����ָ��
    if (Time >= 0)&&(Time <= 1)   
        In_alpha = 0/Rad2Deg; %����ָ��
        In_mu = 0/Rad2Deg;    %����ָ��
    elseif (Time > 1)&&(Time <= 10) 
        In_alpha = (2*(Time-1))/Rad2Deg; %����ָ�� б��Ϊ-2��б��ָ��
        In_mu = 0;    %����ָ��
    elseif (Time > 10)&&(Time <= 25) 
        In_alpha = 18/Rad2Deg; %����ָ��
        In_mu = 0;    %����ָ��        
    elseif (Time > 25)&&(Time <= 35) 
        In_alpha = (-Time + 43)/Rad2Deg; %����ָ�� б��Ϊ1��б��ָ��
        In_mu = 0;    %����ָ��        
    elseif (Time > 35)&&(Time <= 50) 
        In_alpha = 8/Rad2Deg; %����ָ��
        In_mu = 0;    %����ָ��     
    elseif (Time > 50)&&(Time <= 64) 
        In_alpha = 8/Rad2Deg; %����ָ��
        In_mu = (-Time + 50)/Rad2Deg;    %����ָ��        
     elseif (Time > 64)&&(Time <= 80) 
        In_alpha = 8/Rad2Deg; %����ָ��
        In_mu = -14/Rad2Deg; %����ָ�� б��Ϊ1.2��б��ָ��            
    elseif (Time > 80)&&(Time <= 90) 
        In_alpha = 8/Rad2Deg; %����ָ��
        In_mu = (2*Time -174)/Rad2Deg; %����ָ�� б��Ϊ1.2��б��ָ��
    elseif (Time > 90)&&(Time <= 100) 
        In_alpha = 8/Rad2Deg; %����ָ��
        In_mu = 6/Rad2Deg; %����ָ�� б��Ϊ1.2��б��ָ��
    else
        In_alpha = 0; %����ָ��
        In_mu = 0;    %����ָ��       
    end

%  ComdAng(1) = In_alpha; ComdAng(2) = Com_beta; ComdAng(3) = In_mu;    
%% �������   �����Ľ�Ծָ�� ����һ��һ�׹����˲�����
else     
%     if (Time > 1.9)&&(Time <= 2.1) 
%         In_alpha = 30*(Time - 1.9)/Rad2Deg; %����ָ�� 
%         In_mu = 0;%5*(-Time+5)/Rad2Deg;    %����ָ��
%     elseif (Time > 2.1)&&(Time <= 5.9)   
%         In_alpha = 6/Rad2Deg; %����ָ��
%         In_mu = 0;%-2/Rad2Deg;    %����ָ��   
%     elseif (Time > 5.9)&&(Time <= 6.1) 
%         In_alpha = (-20*(Time - 5.9)+6)/Rad2Deg; %����ָ�� 24
%         In_mu = 0;    %����ָ��
%     elseif (Time > 6.1)&&(Time <=10)   
%         In_alpha = 2/Rad2Deg; %����ָ��
%         In_mu = 0/Rad2Deg;    %����ָ��   

        
%     if (Time > 1.9)&&(Time <= 2.1) 
%         In_alpha = 30*(Time - 1.9)/Rad2Deg; %����ָ�� 
%         In_mu = 0;%5*(-Time+5)/Rad2Deg;    %����ָ��
%     elseif (Time > 2.1)&&(Time <= 9.9)   
%         In_alpha = 6/Rad2Deg; %����ָ��
%         In_mu = 0;%-2/Rad2Deg;    %����ָ��   
%     elseif (Time > 9.9)&&(Time <= 10.3) 
%         In_alpha = (-20*(Time - 9.9)+6)/Rad2Deg; %����ָ�� 24
%         In_mu = 0;    %����ָ��
%     elseif (Time > 10.3)&&(Time <=19.9)   
%         In_alpha = -2/Rad2Deg; %����ָ��
%         In_mu = 0/Rad2Deg;    %����ָ��   
%     elseif (Time > 19.9)&&(Time <=20)   
%         In_alpha = (20*(Time - 19.9)-2)/Rad2Deg;
%         In_mu = 0/Rad2Deg;    %����ָ��  
    if (Time > 2)&&(Time <= 6) 
        In_alpha = 3*(Time - 2)/Rad2Deg; %����ָ�� 
        In_mu = 0/Rad2Deg;    %����ָ��
    elseif (Time > 6)&&(Time <= 10)   
        In_alpha = 12/Rad2Deg; %����ָ��
        In_mu = 0/Rad2Deg;    %����ָ��   
    else
        In_alpha = 0; %����ָ�� 
        In_mu = 0;    %����ָ��
    end
%      ComdAng(1) = In_alpha; ComdAng(2) = Com_beta; ComdAng(3) = In_mu;    

end
    % % % % % %    ָ���һ���˲����ڣ���������ɵ��ź� ʱ�䳣��0.4s
    if sim_case==2 
        Com_alpha_1 = 0.7788*ComdAng_lst(1) + 0.2212* InAng_lst(1);%�Ƶ�������0.1
        Com_mu_1 = 0.7788*ComdAng_lst(2) + 0.2212* InAng_lst(2);%�Ƶ�������0.1
    else
        Com_alpha_1 = 0.9876*ComdAng_lst(1) + 0.0124* InAng_lst(1); %���ƣ�����0.05
        Com_mu_1 = 0.9876*ComdAng_lst(2) + 0.0124* InAng_lst(2); %���ƣ�����0.05      
%         Com_alpha_1 = 0.9753*ComdAng_lst(1) + 0.0247* InAng_lst(1); %���ƣ�����0.05
%         Com_mu_1 = 0.9753*ComdAng_lst(2) + 0.0247* InAng_lst(2); %���ƣ�����0.05   
    end
    InAng_lst(1) = In_alpha;  InAng_lst(2) = In_mu;
    ComdAng_lst(1) = Com_alpha_1; ComdAng_lst(2) = Com_mu_1;
    ComdAng(1) = Com_alpha_1; ComdAng(2) = Com_beta; ComdAng(3) = Com_mu_1; 

end

