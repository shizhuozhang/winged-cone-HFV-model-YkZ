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
% T = Acp(:,1);  %�ò������ʱ��
% c1p = Acp(:,2); c3p = Acp(:,4);  c2p = 1;%c2p = Acp(:,3); 
% b2p = Bbp(:,2); b1p = Bbp(:,3); b3p = Bbp(:,4); 
% c1y = Acy(:,2); c2y = Acy(:,3); c3y = Acy(:,4);
% b2y = Bby(:,2); b1y = Bby(:,3); b3y = Bby(:,4);
% c1r = Acr(:,2); c2r = Acr(:,3); c3r =0; % c3r = Acr(:,4);
% b1r = Bbr(:,3); b3r = Bbr(:,4); b2r =0; % b2r = Bbr(:,2);


% save('Linrpara_ind.mat','T','c1p','c3p','c2p','b2p','b1p','b3p','c1y','c2y','c3y','b2y','b1y','b3y','c1r','c2r','c3r','b1r','b3r','b2r');
% load('Linrpara_ind.mat');%��׼������Сƫ������

Channel = 3;%1������2ƫ����3��ת

FP_abs = [1,10,20,30,45,60,80,99];%������������ ��ʹ�õ��Ǿ���ʱ��
% k=1; %����ѭ���ı�����ȡֵ 1-8,%1,10,20,30,45,60,80,100;
% FP_k = find(T == FP_abs(k));

Kin_p = -1000*[4, 3.75, 3.65, 3.75, 3.75, 3.15, 2.05, 1.2];  %%%����ͨ���ڻ�����  %%%���ڸ���ͨ�� 2,3,4,5�⼸�������ƣ�1,6��ϸ΢���7��8������
Kin_y =  1000*[5, 5.2, 5.05, 5, 4.7, 3.95, 2.6, 1.5];  %%%ƫ��ͨ���ڻ�����  %%%����ƫ��ͨ�� 1,2,3,4,5�⼸�������ƣ�6��7��8���ϴ�
Kin_r = -1000*[2.8, 2.7, 2.6, 2.7, 2.65, 2.25, 1.45, 0.87];  %%%��תͨ���ڻ�����  %%%���ڹ�תͨ�� 1,2,3,4,5�⼸�������ƣ�6��7��8���ϴ�
Kout_p =10;
Kout_y = -10; %�����ڵ��ڻ�����
Kout_r = 10;
Gm_in1 = zeros(1,12); Gm_in = zeros(1,12); Pm_in = zeros(1,12); Wcg_in =zeros(1,12); Wcp_in =zeros(1,12);Buffer=zeros(1,200);
count=0;

% % ���
% numd = [1];
% dend= [1/75^2,2*0.707/75,1];
% Gd = tf(numd,dend);

%% ����������ģ��,�����ƿ�ͼ�и����������ģ��
%  figure(1);
for k = 2
    
    FP_k = find(T == FP_abs(k));
    
    if(Channel==1)  %����ͨ��
        c1 = c1p(FP_k);    c2 = c2p;    c3 = c3p(FP_k);
        b1 = b1p(FP_k);    b2 = b2p(FP_k);    b3 = b3p(FP_k);  
        
          %%����ͨ����У������  �ͺ�����
        nump = [0.0289,1];  %[0.0577,0.6928],[0.1924,0.231]�������Ҳ������
        denp = [0.3464,1];  %
        Gp = tf(nump,denp); 
        
        Kin = Kin_p(k); %�����ڵ��ڻ�����-1000��-4000
        Kout = Kout_p;
    elseif(Channel==2)  %ƫ��ͨ��
        c1 = c1y(FP_k);    c2 = c2y(FP_k);    c3 = c3y(FP_k);
        b1 = b1y(FP_k);    b2 = b2y(FP_k);    b3 = b3y(FP_k);    
        
       %%%%ƫ��ͨ����У������  �ͺ�����
        nump = [0.0289,1];%0.0577�������Ҳ������
        denp = [0.3464,1];%0.6928
        Gp = tf(nump,denp); 
        
        Kin = Kin_y(k); %�����ڵ��ڻ�����800��4000
        Kout = Kout_y;
    elseif(Channel==3)  %��תͨ��
        c1 = c1r(FP_k);    c2 = c2r(FP_k);    c3 = 0;
        b1 = b1r(FP_k);    b2 = 0;           b3 = b3r(FP_k);    
                  
        %%��תͨ����У������  �ͺ�����
%         nump = [0.2203,1];%[0.3525,11.372][0.2938,9.4765]�������Ҳ������
%         denp = [7.1075,1];%
        nump = [0.1763,1];%�������Ҳ������
        denp = [5.686,1];%
        Gp = tf(nump,denp); 
         
        Kin = Kin_r(k); %�����ڵ��ڻ�����-500��-1500
        Kout = Kout_r;
    end
      
    %�ǶȶԶ�Ĵ��ݺ���
    num = [c3, (b3*c2 - b1*c3)];
    den = [1, -(b1+c1), (c1*b1 -c2*b2)];
    Gad = tf(num,den);

    %���ٶȶԶ�Ĵ��ݺ���        
    num = [b3, (b2*c3 - c1*b3)];
    den = [1, -(b1+c1), (c1*b1 -c2*b2)];
    Gwd = tf(num,den);

    %�ǶȶԽ��ٶȵĴ��ݺ���
    num = [c3, (b3*c2 - b1*c3)];
    den= [b3, (b2*c3 - c1*b3)];
    Gaw = tf(num,den);

%      Gp =1; %%У������
    
    Ga = Kin*Gp*Gwd;    % �ڻ����ٶȱ���Ŀ������ݺ���

    %%%���ٶȱ�������
 %    figure(1);
%      margin(Ga);
%      hold on;
%       grid on;
     
    % �ڻ��ջ����ݺ���
     Gin = feedback(Ga,1);
%     figure(2);      
%     step(Gin,5);
%     grid on;
     % �⻷�ջ����ݺ���
     Gb = Kout*Gin*Gaw;  %�⻷�������ݺ���
     figure(3);
     margin(Gb);
     
     Gout = feedback(Gb,1);%�⻷�ջ����ݺ��� 
      figure(4);
     step(Gout,2);
     axis([0, 2, 0, 1.3]);
     grid on;
end
%         %�ĸ������ֱ�Ϊ����ֵԣ�ȣ���λ����dB,Ҫȡ20log�������ԣ�ȣ���λ���ȣ������У���ֹ��Ƶ�ʺ�-180�ȴ�ԽƵ�ʣ���λrad/s��
%         %ע�⿪����ֹƵ�ʺͱջ���������أ�����С������ͬ
%         %�ú���ֻ����ֵ����ͼ
%         [Gm_in1(k),Pm_in(k),Wcg_in(k),Wcp_in(k)]=margin(Ga); %���������ĸ������ԣ��õ�ԣ�ȴ�С
%         Gm_in(k) = 20*log10(Gm_in1(k));  %ת��ΪdBΪ��λ

% %�⻷
% Gm_out1=zeros(1,110); Gm_out=zeros(1,110); Pm_out=zeros(1,110);
% Wcg_out=zeros(1,110); Wcp_out=zeros(1,110);
% 


% for k=1:1:110
%     Kout = 0.2*k+1; 
%     Gb = Kout*Gin*Gaw;  %�⻷�������ݺ���
%     Gout = feedback(Gb,1);%�⻷�ջ����ݺ���
% 
%     [Gm_out1(k),Pm_out(k),Wcg_out(k),Wcp_out(k)]=margin(Gb);
%     Gm_out(k) = 20*log10(Gm_out1(k));    %ת��ΪdBΪ��λ
% %     if Pm_out > 90
% %         Pm_out= Pm_out - 90;
% %     end
% end
% %[X,Y,Z]=triscatteredinterp(Gm_out,Pm_out,Wcp_out,linspace(min(Gm_out),max(Gm_out))',linspace(min(Pm_out),max(Pm_out)),'v4');
% [X,Y,Z]=griddata(Gm_out,Pm_out,Wcp_out,linspace(min(Gm_out),max(Gm_out))',linspace(min(Pm_out),max(Pm_out)),'v4');
% %pcolor(X,Y,Z);shading interp;legend('pxolor')%α��ɫͼ
% figure(3);
% contourf(X,Y,Z,'showText','on');legend('Wcp_{out}');%�ȸ���ͼ
% xlabel('Gm_{out}','FontSize',12);
% ylabel('Pm_{out}','FontSize',12);
