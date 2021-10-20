%%Éè¶¨ÖÆµ¼Ö¸Áî
%ÊäÈë²ÎÊýÎª:µ±Ç°Ê±¿ÌT
%Êä³ö²ÎÊýÎª£ºµ±Ç°Ê±¿ÌµÄ×ËÌ¬½ÇÖ¸ÁîÆø¶¯×ËÌ¬½Ç(alpha,beta,mu)£¬

My_PI = 3.14159;
Rad2Deg = 180 / My_PI; 
sim_case = 2;
h_step = 0.01; %%µ¥Î» s
step = 0;%¼ÇÂ¼·ÂÕæ²½Êý
alpha = zeros(100/h_step,1);
mu = zeros(100/h_step,1);
t = zeros(100/h_step,1);
for Time=0:h_step:100 %%·ÂÕæÊ±³¤100Ãë 
    step = step + 1;%¼ÇÂ¼·ÂÕæ²½Êý
    t(step) = Time;
%% 100sÈ«µ¯µÀ·ÂÕæ ×Ô¼º°´¸Ð¾õÉè¼ÆµÄÖÆµ¼Ö¸Áî
    if sim_case==1  
        if (Time >= 0)&&(Time <= 5)   
            alpha(step) = 0; %¹¥½ÇÖ¸Áî
            mu(step) = 0;    %Çã²à½ÇÖ¸Áî
        elseif (Time > 5)&&(Time <= 10) 
            alpha(step) = (-2*Time+10)/Rad2Deg; %¹¥½ÇÖ¸Áî Ð±ÂÊÎª-2µÄÐ±ÆÂÖ¸Áî
            mu(step) = 0;    %Çã²à½ÇÖ¸Áî
        elseif (Time > 10)&&(Time <= 20) 
            alpha(step) = -10/Rad2Deg; %¹¥½ÇÖ¸Áî
            mu(step) = 0;    %Çã²à½ÇÖ¸Áî        
        elseif (Time > 20)&&(Time <= 40) 
            alpha(step) = (Time-30)/Rad2Deg; %¹¥½ÇÖ¸Áî Ð±ÂÊÎª1µÄÐ±ÆÂÖ¸Áî
            mu(step) = 0;    %Çã²à½ÇÖ¸Áî        
        elseif (Time > 40)&&(Time <= 60) 
            alpha(step) = 10/Rad2Deg; %¹¥½ÇÖ¸Áî
            mu(step) = 0;    %Çã²à½ÇÖ¸Áî
        elseif (Time > 60)&&(Time <= 61.5) 
            alpha(step) =  (-4*Time+250)/Rad2Deg; %¹¥½ÇÖ¸Áî Ð±ÂÊÎª-4µÄÐ±ÆÂÖ¸Áî
            mu(step) = 0;    %Çã²à½ÇÖ¸Áî        
        elseif (Time > 61.5)&&(Time <= 65) 
            alpha(step) = 4/Rad2Deg; %¹¥½ÇÖ¸Áî
            mu(step) = 0;    %Çã²à½ÇÖ¸Áî        
        elseif (Time > 65)&&(Time <= 80) 
            alpha(step) = 4/Rad2Deg; %¹¥½ÇÖ¸Áî
            mu(step) = (1.2*Time - 78)/Rad2Deg; %Çã²à½ÇÖ¸Áî Ð±ÂÊÎª1.2µÄÐ±ÆÂÖ¸Áî        
        elseif (Time > 80)&&(Time <= 90) 
            alpha(step) = 4/Rad2Deg; %¹¥½ÇÖ¸Áî
            mu(step) = 18/Rad2Deg;    %Çã²à½ÇÖ¸Áî       
        elseif (Time > 90)&&(Time <= 100) 
            alpha(step) = 4/Rad2Deg; %¹¥½ÇÖ¸Áî
            mu(step) = (-1.8*Time +180)/Rad2Deg; %Çã²à½ÇÖ¸Áî Ð±ÂÊÎª1.2µÄÐ±ÆÂÖ¸Áî
        else
            alpha(step) = 0; %¹¥½ÇÖ¸Áî
            mu(step) = 0;    %Çã²à½ÇÖ¸Áî       
        end
    
%% µ¥µã·ÂÕæ   µ¥´¿µÄ½×Ô¾Ö¸Áî
    else  
        if (Time > 5)&&(Time <= 20) 
            alpha(step) = 15/Rad2Deg; %¹¥½ÇÖ¸Áî 
            mu(step) = 15/Rad2Deg;    %Çã²à½ÇÖ¸Áî
        elseif (Time > 20)&&(Time <= 35)   
            alpha(step) = -10/Rad2Deg; %¹¥½ÇÖ¸Áî
            mu(step) = -10/Rad2Deg;    %Çã²à½ÇÖ¸Áî
        elseif (Time > 35)&&(Time <= 50) 
            alpha(step) = 15/Rad2Deg; %¹¥½ÇÖ¸Áî 
            mu(step) = 15/Rad2Deg;    %Çã²à½ÇÖ¸Áî    
        elseif (Time > 50)&&(Time <= 65)   
            alpha(step) = -10/Rad2Deg; %¹¥½ÇÖ¸Áî
            mu(step) = -10/Rad2Deg;    %Çã²à½ÇÖ¸Áî
        elseif (Time > 65)&&(Time <= 80) 
            alpha(step) = 15/Rad2Deg; %¹¥½ÇÖ¸Áî 
            mu(step) = 15/Rad2Deg;    %Çã²à½ÇÖ¸Áî   
        elseif (Time > 80)&&(Time <= 95)   
            alpha(step) = -10/Rad2Deg; %¹¥½ÇÖ¸Áî
            mu(step) = -10/Rad2Deg;    %Çã²à½ÇÖ¸Áî
        else
            alpha(step) = 0; %¹¥½ÇÖ¸Áî 
            mu(step) = 0;    %Çã²à½ÇÖ¸Áî
        end
    end
end

plot(t,(alpha*Rad2Deg),'--r','LineWidth',2);
hold on;
plot(t,(mu*Rad2Deg),'-b','LineWidth',2);
grid on;
axis([0 100 -15 20]);
