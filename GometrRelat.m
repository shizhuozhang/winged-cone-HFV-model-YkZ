%% ���ü��ι�ϵ������������״̬����(8���Ƕȣ�֪5��3)
% ���������
% ���������
% Flag_geo = 1; %�Ƕȼ��ι�ϵ�ı�־λ %���򼸺ι�ϵ�����ŷ���ǣ�Ϊ1�����򼸺ι�ϵ����⺽���ǣ�Ϊ0

% Veloc = FltSdt_S(4);   gamma = FltSdt_S(5);   chi = FltSdt_S(6); %���ɺ���ʸ�� Trajct = [Veloc, gamma, chi];
% theta = FltSdt_F(1);   psi = FltSdt_F(2);   phi = FltSdt_F(3); %����ŷ����ʸ�� EulerAng = [theta ,psi, phi];
% alpha = FltSdt_F(4);   beta = FltSdt_F(5);   mu = FltSdt_F(6); %����������ʸ�� AeroAng = [alpha, beta, mu];
function Ang1 = GometrRelat(Flag_geo, Ang2 , Ang3)%�����һʱ�̵�ŷ����

if Flag_geo == 1 %�������ŷ���� EulerAng = GometrRelat(Flag_geo, AeroAng ,TrajctAng)
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
else %������⺽���� TrajctAng = GometrRelat(Flag_geo, AeroAng ,EulerAng)
    alpha = Ang2(1);   beta = Ang2(2);  % mu = Ang2(3);    
    theta = Ang3(1);   psi = Ang3(2);   phi = Ang3(3);
    
    temp1 = cos(alpha)*cos(beta)*sin(theta) - cos(theta)*( sin(beta)*sin(phi) + sin(alpha)*cos(beta)*cos(phi) );   
    gamma = asin(temp1);  
    temp2 = cos(alpha)*cos(beta)*cos(theta)*sin(psi) + sin(beta)*( sin(theta)*sin(psi)*sin(phi) + cos(psi)*cos(phi) ) ...
           + sin(alpha)*cos(beta)* ( sin(theta)*sin(psi)*cos(phi) - cos(psi)*sin(phi) );
    chi = asin(temp2 / cos(gamma));  
    temp3 = cos(alpha)*sin(beta)*sin(theta) + cos(theta)*cos(beta)*sin(phi) - cos(theta)*sin(alpha)*sin(beta)*cos(phi);
    mu = asin(temp3 / cos(gamma));
     
    Ang1(1) = mu; Ang1(2) = gamma; Ang1(3) = chi;  %%ע������д����������ǰ
end

end