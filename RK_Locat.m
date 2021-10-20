%% 龙格库塔积分求解位置微分方程
%输入：
%输出：

function Locat_1 = RK_Locat(Locat, FltSdt_S,h)%龙格库塔求解位置微分方程


K1 = Equ_right_Locat(Locat, FltSdt_S);
K2 = Equ_right_Locat(Locat + (h/2)*K1, FltSdt_S);
K3 = Equ_right_Locat(Locat + (h/2)*K2, FltSdt_S);
K4 = Equ_right_Locat(Locat + h*K3, FltSdt_S);

Locat_1 = Locat + (K1 + 2*K2 +2*K3 + K4) *h /6;
end
%%   方程右边项
function dLocat = Equ_right_Locat(Locat, FltSdt_S)%实际位置方程比较简单，没必要用龙哥库塔积分，但也写成这种形式了
%X_loc = Locat(1); Y_loc = Locat(2); Height = Locat(3);
Veloc = FltSdt_S(4);   gamma = FltSdt_S(5);   chi = FltSdt_S(6);

dX_loc = Veloc *cos(gamma) *cos(chi);
dY_loc = Veloc *cos(gamma) *sin(chi);
dHeight = Veloc *sin(gamma);

dLocat(1) = dX_loc; dLocat(2) = dY_loc; dLocat(3) = dHeight;
end
