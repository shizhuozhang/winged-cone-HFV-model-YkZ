%% 利用几何关系方程求解其余的状态参数(8个角度，知5求3)
% 输入参数：
% 输出参数：
% Flag_geo = 1; %角度几何关系的标志位 %正向几何关系（求解欧拉角）为1，反向几何关系（求解航迹角）为0

% Veloc = FltSdt_S(4);   gamma = FltSdt_S(5);   chi = FltSdt_S(6); %构成航迹矢量 Trajct = [Veloc, gamma, chi];
% theta = FltSdt_F(1);   psi = FltSdt_F(2);   phi = FltSdt_F(3); %构成欧拉角矢量 EulerAng = [theta ,psi, phi];
% alpha = FltSdt_F(4);   beta = FltSdt_F(5);   mu = FltSdt_F(6); %构成气动角矢量 AeroAng = [alpha, beta, mu];
function Ang1 = GometrRelat(Flag_geo, Ang2 , Ang3)%求解下一时刻的欧拉角

if Flag_geo == 1 %正向求解欧拉角 EulerAng = GometrRelat(Flag_geo, AeroAng ,TrajctAng)
    alpha = Ang2(1);   beta = Ang2(2);   mu = Ang2(3);
    gamma = Ang3(2);   chi = Ang3(3);   % Veloc = Ang3(1);
    
    temp1 = cos(alpha)*cos(beta)*sin(gamma) + cos(alpha)*sin(beta)*cos(gamma)*sin(mu) + sin(alpha)*cos(gamma)*cos(mu);
    theta = asin(temp1);   
    temp2 = cos(alpha)*cos(beta)*cos(gamma)*sin(chi) - cos(alpha)*sin(beta)*( sin(gamma)*sin(chi)*sin(mu) + cos(chi)*cos(mu) ) ...
           - sin(alpha)*sin(gamma)*sin(chi)*cos(mu) + sin(alpha)*cos(chi)*sin(mu);    
    psi = asin(temp2 / cos(theta)); 
    temp3 = - sin(beta)*sin(gamma) + cos(beta)*cos(gamma)*sin(mu);    
    phi = asin(temp3 / cos(theta)); 
    
    Ang1(1) = theta; Ang1(2) = psi; Ang1(3) = phi;
else %反向求解航迹角 TrajctAng = GometrRelat(Flag_geo, AeroAng ,EulerAng)
    alpha = Ang2(1);   beta = Ang2(2);  % mu = Ang2(3);    
    theta = Ang3(1);   psi = Ang3(2);   phi = Ang3(3);
    
    temp1 = cos(alpha)*cos(beta)*sin(theta) - cos(theta)*( sin(beta)*sin(phi) + sin(alpha)*cos(beta)*cos(phi) );   
    gamma = asin(temp1);  
    temp2 = cos(alpha)*cos(beta)*cos(theta)*sin(psi) + sin(beta)*( sin(theta)*sin(psi)*sin(phi) + cos(psi)*cos(phi) ) ...
           + sin(alpha)*cos(beta)* ( sin(theta)*sin(psi)*cos(phi) - cos(psi)*sin(phi) );
    chi = asin(temp2 / cos(gamma));  
    temp3 = cos(alpha)*sin(beta)*sin(theta) + cos(theta)*cos(beta)*sin(phi) - cos(theta)*sin(alpha)*sin(beta)*cos(phi);
    mu = asin(temp3 / cos(gamma));
     
    Ang1(1) = mu; Ang1(2) = gamma; Ang1(3) = chi;  %%注意这里写的是倾侧角在前
end

end