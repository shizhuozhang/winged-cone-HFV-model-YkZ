%% 绕机体Z轴的气动力矩系数Cn的计算，改变偏航角速度r
%输入参数：马赫，速度，攻角，侧滑角，三个舵偏角，滚转角速度p和偏航角速度r
%输出参数：总的偏航力矩系数C_n
function Cnw = funC_nw(Ma,ALPHA,beta,RE,LE,RUD,p,r,V) %注意1）大写的alpha 单位是度，2）舵偏顺序是，右、左、方向

global b;  %全局恒值变量，翼展，单位m

Cnb = funCnb(Ma,ALPHA);
Cn_RE = funCn_RE(Ma,ALPHA,RE);
Cn_LE = funCn_LE(Ma,ALPHA,LE);
Cn_RUD = funCn_RUD(Ma,ALPHA,RUD);
Cnp = funCnp(Ma,ALPHA);
Cnr = funCnr(Ma,ALPHA);

Cnw = Cnb*beta + Cn_RE + Cn_LE + Cn_RUD + Cnp*(p*b/V/2) + Cnr*(r*b/V/2);%该式里的角度是弧度值
end

%% 侧滑引起的偏航力矩系数
function Cnb = funCnb(Ma,ALPHA)
% Cnb = + 3.68E-01 + 6.03E-16*ALPHA + 9.79E-02*Ma - 3.84E-16*(ALPHA^2) + 1.24E-02*(Ma^2) + 8.58E-17*(ALPHA^3) - 8.05E-04*(Ma^3) ...
%       - 7.75E-18*(ALPHA^4) + 2.57E-05*(Ma^4) + 2.42E-19*(ALPHA^5) - 3.20E-07*(Ma^5); %原数据，貌似不对
Cnb = + 6.998E-04*ALPHA + 5.9115E-02*Ma -7.525E-05*(ALPHA*Ma) + 2.516E-04*((ALPHA).^2) -1.4824E-02*(Ma^2) - 2.1924E-07*((ALPHA*Ma)^2) ...
      - 1.0777E-04*(ALPHA^3) + 1.2692E-03*(Ma^3) + 1.0707E-08 *((ALPHA*Ma)^3) ...
      + 9.4989E-06*(ALPHA^4) - 4.7098E-05*(Ma^4) - 5.5472E-11*((ALPHA*Ma)^4) ...
      - 2.5953E-07*(ALPHA^5) + 6.4284E-07*(Ma^5) + 8.5863E-14*((ALPHA*Ma)^5);        
end

%% 右舵引起的偏航力矩系数
function Cn_RE = funCn_RE(Ma,ALPHA,RE)
Cn_RE = + 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
        - 1.30E-05*RE - 8.93E-08*(ALPHA*Ma)*RE + 1.97E-06*(RE^2) + 1.41E-11*((ALPHA*Ma*RE)^2) ;
end

%% 左舵引起的偏航力矩系数
function Cn_LE = funCn_LE(Ma,ALPHA,LE)
Cn_LE = -( 2.10E-04 + 1.83E-05*ALPHA - 3.56E-05*Ma -6.39E-07*(ALPHA^2) + 8.16E-07*(Ma^2) ...
        - 1.30E-05*LE - 8.93E-08*(ALPHA*Ma)*LE + 1.97E-06*(LE^2) + 1.41E-11*((ALPHA*Ma*LE)^2)) ;
end

%% 方向舵引起的偏航力矩系数
function Cn_RUD = funCn_RUD(Ma,ALPHA,RUD)
Cn_RUD = + 2.85E-18 - 3.59E-19 *ALPHA -1.26E-19*Ma + 1.57E-20*(ALPHA*Ma) ...
         - 5.28E-04*RUD + 1.39E-05*(ALPHA*RUD) + 1.65E-05*(Ma*RUD) - 3.13E-07*(ALPHA*Ma)*RUD ;
end

%% 滚转角速度引起的偏航力矩系数
function Cnp = funCnp(Ma,ALPHA)
%Cnp = + 3.68E-01 - 9.79E-02*Ma + 9.55E-16*ALPHA - 2.79E-17*(ALPHA*Ma)+ 1.24E-02*Ma^2 - 4.26E-16*ALPHA^2 + 7E-20*(ALPHA*Ma)^2 ...
%        - 8.05E-04*Ma^3 + 9.4E-17*ALPHA^3 + 2.57E-05*Ma^4 - 8.9E-18*ALPHA^4 -3.20E-07* Ma^5 + 2.99E-19*ALPHA^5 ;
Cnp = + 3.68E-01 - 9.79E-02*Ma + 7.61E-16*ALPHA + 1.24E-02*(Ma^2) - 4.64E-16*(ALPHA^2) - 8.05E-04*(Ma^3) + 1.01E-16*(ALPHA^3) ...
      + 2.57E-05*(Ma^4) - 9.18E-18*(ALPHA^4) - 3.20E-07*(Ma^5) + 2.96E-19*(ALPHA^5);
end

%% 偏航角速度引起的偏航力矩系数
function Cnr = funCnr(Ma,ALPHA)
Cnr = - 2.41 + 5.96E-01*Ma - 2.74E-03*ALPHA + 2.09E-04*(ALPHA*Ma) - 7.57E-02*(Ma^2) + 1.15E-03*(ALPHA^2) - 6.53E-08*((ALPHA*Ma)^2) ...
      + 4.90E-03*(Ma^3) - 3.87E-04*(ALPHA^3) - 1.57E-04*(Ma^4) + 3.60E-05*(ALPHA^4) + 1.96E-06*(Ma^5) - 1.18E-06*(ALPHA^5);
end

%通过曲线可知，偏航力矩系数系数主要是侧滑角（E-2量级）和方向舵（E-3量级）引起
%俯仰舵舵偏引起的偏航力矩系数较小（E-4量级）
%方向舵引起的偏航力矩系数（E-3量级）较大
% 角速率引起的偏航力矩系数（E-1量级），但由于除以速度，总的影响较小
%因此，当侧滑角为0，偏航力矩主要受方向舵影响（E-3量级）