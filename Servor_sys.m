%%伺服舵系统
%输入参数：等效指令角
%输出参数：实际舵摆角
function [DeltaA_1] = Servor_sys(DeltaE_1,DeltaA)

global h_step;   %%仿真步长
global Rad2Deg;  %%弧度转换为度
global Delta_lim; %%舵偏限幅约束  Delta_lim = 20;%%单位 deg
Delta_e = DeltaA(1); Delta_a = DeltaA(2); Delta_r = DeltaA(3);
%% 转化为实际舵偏
V2R = -1 * [1,0,-1; 1,0,1; 0,1,0];  %%由等效的舵指令转化为实际的舵偏 乘-1是因为，等效舵偏的定义为正的舵偏产生正的姿态角
Delta = V2R * DeltaE_1'; %%舵偏顺序 e,a,r
DeltaA_1 = Delta';
%% 经过二阶惯性环节  %暂时不加入，简化系统
%传递函数%1/(3*E-05s^2+0.02s+1)
%离散化
%输出实际值
%Delta_Real = ;

%% 限幅约束
if abs(DeltaA_1(1)-Delta_e)/h_step > 10*Rad2Deg   %%速率约束
    DeltaA_1(1) = Delta_e + sign(DeltaA_1(1)-Delta_e)*h_step*10*Rad2Deg;
end
if abs(DeltaA_1(2)-Delta_a)/h_step > 10*Rad2Deg   %%速率约束
    DeltaA_1(2) = Delta_a + sign(DeltaA_1(2)-Delta_a)*h_step*10*Rad2Deg;
end
if abs(DeltaA_1(3)-Delta_r)/h_step > 10*Rad2Deg   %%速率约束
    DeltaA_1(3) = Delta_r + sign(DeltaA_1(3)-Delta_r)*h_step*10*Rad2Deg;
end

if abs(DeltaA_1(1)) > Delta_lim   %%幅值约束
    DeltaA_1(1) = sign(DeltaA_1(1)) * Delta_lim;   %%超出范围则取边界值
end
if abs(DeltaA_1(2)) > Delta_lim  %%幅值约束
    DeltaA_1(2) = sign(DeltaA_1(2)) * Delta_lim;   %%超出范围则取边界值
end
if( abs(DeltaA_1(3)) > Delta_lim)  %%幅值约束
    DeltaA_1(3) = sign(DeltaA_1(3)) * Delta_lim;   %%超出范围则取边界值
end