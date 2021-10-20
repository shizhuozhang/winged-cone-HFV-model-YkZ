%% 气动侧向力系数CY的计算
%输入参数：马赫，攻角，侧滑角，三个舵偏角
%输出参数：侧向力系数C_Y
function C_Y = funC_Y(Ma,ALPHA,beta,RE,LE,RUD)%注意1）大写的alpha 单位是度，2）舵偏顺序是，右、左、方向

CYb = funCYb(Ma,ALPHA);
CY_RE = funCY_RE(Ma,ALPHA,RE);
CY_LE = funCY_LE(Ma,ALPHA,LE);
CY_RUD = funCY_RUD(Ma,ALPHA,RUD);
C_Y = CYb*beta + CY_RE + CY_LE + CY_RUD;   
end

%% 攻角引起的侧向力系数
function CYb = funCYb(Ma,ALPHA)
% CYb =  1.76 + 4.58E-01*Ma - 3.26E-03*ALPHA + 3.8E-05*ALPHA*Ma - 6.36E-02*(Ma^2) + 2.36E-03*(ALPHA^2) + 3.45E-07*((ALPHA*Ma)^2) ...
%       + 4.44E-03*(Ma^3) - 6.03E-04*(ALPHA^3) - 1.51E-04*(Ma^4) + 4.52E-05*(ALPHA^4) + 1.98E-06*(Ma^5) - 1.09E-06*(ALPHA^5);%原数据，似乎不对
CYb =  -2.9253E-01*Ma + 2.8803E-03*ALPHA - 2.8943E-04*(ALPHA*Ma)+ 5.4822E-02*(Ma^2) + 7.3535E-04*(ALPHA^2) ...
      - 4.6490E-09*((ALPHA*(Ma^2))^2) - 2.0675E-08*(((ALPHA^2)*Ma)^2) + 4.6205E-06*((ALPHA*Ma)^2) + 2.6144E-11*(((ALPHA^2)* (Ma^2))^2) ...
      - 4.3203E-03*(Ma^3) - 3.7405E-04*(ALPHA^3) + 1.5495E-04*(Ma^4) + 2.8183E-05*(ALPHA^4) ...
      - 2.0829E-06*(Ma^5) -5.2083E-07*(ALPHA^5);      
end

%% 右舵引起的侧向力系数
function CY_RE = funCY_RE(Ma,ALPHA,RE)
CY_RE = -1.02E-06 - 1.12E-07*ALPHA + 4.48E-07*Ma + 2.82E-09*(ALPHA^2) - 2.36E-08*(Ma^2) ...
        + 2.27E-07*RE + 4.11E-09*ALPHA*Ma*RE - 5.04E-08*(RE^2) + 4.5E-14*((ALPHA*Ma*RE)^2);
end

%% 左舵引起的侧向力系数
function CY_LE = funCY_LE(Ma,ALPHA,LE)
CY_LE = -(-1.02E-06 - 1.12E-07*ALPHA + 4.48E-07*Ma + 2.82E-09*(ALPHA^2) - 2.36E-08*(Ma^2) ...
        + 2.27E-07*LE + 4.11E-09*ALPHA*Ma*LE - 5.04E-08*(LE^2) + 4.5E-14*(ALPHA*Ma*LE)^2);
end

%% 方向舵引起的侧向力系数?
function CY_RUD = funCY_RUD(Ma,ALPHA,RUD)
CY_RUD = -1.43E-18 + 4.86E-20*ALPHA + 1.86E-19*Ma + 3.84E-04*RUD - 1.17E-05*ALPHA*RUD - 1.07E-05*Ma*RUD + 2.6E-07*ALPHA*Ma*RUD;
end

%通过曲线可知，侧向力系数主要是侧滑角引起的侧向力（E-1量级）
%俯仰舵舵偏引起的侧向力系数可以忽略（E-6量级）
%方向舵 不为0时，引起一定的侧向力（E-3量级）
%因此，当侧滑角为0，，侧向力可忽略（方向舵偏为0时，E-18量级；方向舵偏为10时，E-3量级）