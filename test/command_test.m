%%�趨�Ƶ�ָ��
%�������Ϊ:��ǰʱ��T
%�������Ϊ����ǰʱ�̵���̬��ָ��������̬��(alpha,beta,mu)��

My_PI = 3.14159;
Rad2Deg = 180 / My_PI; 
sim_case = 2;
h_step = 0.01; %%��λ s
step = 0;%��¼���沽��
alpha = zeros(100/h_step,1);
mu = zeros(100/h_step,1);
t = zeros(100/h_step,1);
for Time=0:h_step:100 %%����ʱ��100�� 
    step = step + 1;%��¼���沽��
    t(step) = Time;
%% 100sȫ�������� �Լ����о���Ƶ��Ƶ�ָ��
    if sim_case==1  
        if (Time >= 0)&&(Time <= 5)   
            alpha(step) = 0; %����ָ��
            mu(step) = 0;    %����ָ��
        elseif (Time > 5)&&(Time <= 10) 
            alpha(step) = (-2*Time+10)/Rad2Deg; %����ָ�� б��Ϊ-2��б��ָ��
            mu(step) = 0;    %����ָ��
        elseif (Time > 10)&&(Time <= 20) 
            alpha(step) = -10/Rad2Deg; %����ָ��
            mu(step) = 0;    %����ָ��        
        elseif (Time > 20)&&(Time <= 40) 
            alpha(step) = (Time-30)/Rad2Deg; %����ָ�� б��Ϊ1��б��ָ��
            mu(step) = 0;    %����ָ��        
        elseif (Time > 40)&&(Time <= 60) 
            alpha(step) = 10/Rad2Deg; %����ָ��
            mu(step) = 0;    %����ָ��
        elseif (Time > 60)&&(Time <= 61.5) 
            alpha(step) =  (-4*Time+250)/Rad2Deg; %����ָ�� б��Ϊ-4��б��ָ��
            mu(step) = 0;    %����ָ��        
        elseif (Time > 61.5)&&(Time <= 65) 
            alpha(step) = 4/Rad2Deg; %����ָ��
            mu(step) = 0;    %����ָ��        
        elseif (Time > 65)&&(Time <= 80) 
            alpha(step) = 4/Rad2Deg; %����ָ��
            mu(step) = (1.2*Time - 78)/Rad2Deg; %����ָ�� б��Ϊ1.2��б��ָ��        
        elseif (Time > 80)&&(Time <= 90) 
            alpha(step) = 4/Rad2Deg; %����ָ��
            mu(step) = 18/Rad2Deg;    %����ָ��       
        elseif (Time > 90)&&(Time <= 100) 
            alpha(step) = 4/Rad2Deg; %����ָ��
            mu(step) = (-1.8*Time +180)/Rad2Deg; %����ָ�� б��Ϊ1.2��б��ָ��
        else
            alpha(step) = 0; %����ָ��
            mu(step) = 0;    %����ָ��       
        end
    
%% �������   �����Ľ�Ծָ��
    else  
        if (Time > 5)&&(Time <= 20) 
            alpha(step) = 15/Rad2Deg; %����ָ�� 
            mu(step) = 15/Rad2Deg;    %����ָ��
        elseif (Time > 20)&&(Time <= 35)   
            alpha(step) = -10/Rad2Deg; %����ָ��
            mu(step) = -10/Rad2Deg;    %����ָ��
        elseif (Time > 35)&&(Time <= 50) 
            alpha(step) = 15/Rad2Deg; %����ָ�� 
            mu(step) = 15/Rad2Deg;    %����ָ��    
        elseif (Time > 50)&&(Time <= 65)   
            alpha(step) = -10/Rad2Deg; %����ָ��
            mu(step) = -10/Rad2Deg;    %����ָ��
        elseif (Time > 65)&&(Time <= 80) 
            alpha(step) = 15/Rad2Deg; %����ָ�� 
            mu(step) = 15/Rad2Deg;    %����ָ��   
        elseif (Time > 80)&&(Time <= 95)   
            alpha(step) = -10/Rad2Deg; %����ָ��
            mu(step) = -10/Rad2Deg;    %����ָ��
        else
            alpha(step) = 0; %����ָ�� 
            mu(step) = 0;    %����ָ��
        end
    end
end

plot(t,(alpha*Rad2Deg),'--r','LineWidth',2);
hold on;
plot(t,(mu*Rad2Deg),'-b','LineWidth',2);
grid on;
axis([0 100 -15 20]);
