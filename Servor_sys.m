%%�ŷ���ϵͳ
%�����������Чָ���
%���������ʵ�ʶ�ڽ�
function [DeltaA_1] = Servor_sys(DeltaE_1,DeltaA)

global h_step;   %%���沽��
global Rad2Deg;  %%����ת��Ϊ��
global Delta_lim; %%��ƫ�޷�Լ��  Delta_lim = 20;%%��λ deg
Delta_e = DeltaA(1); Delta_a = DeltaA(2); Delta_r = DeltaA(3);
%% ת��Ϊʵ�ʶ�ƫ
V2R = -1 * [1,0,-1; 1,0,1; 0,1,0];  %%�ɵ�Ч�Ķ�ָ��ת��Ϊʵ�ʵĶ�ƫ ��-1����Ϊ����Ч��ƫ�Ķ���Ϊ���Ķ�ƫ����������̬��
Delta = V2R * DeltaE_1'; %%��ƫ˳�� e,a,r
DeltaA_1 = Delta';
%% �������׹��Ի���  %��ʱ�����룬��ϵͳ
%���ݺ���%1/(3*E-05s^2+0.02s+1)
%��ɢ��
%���ʵ��ֵ
%Delta_Real = ;

%% �޷�Լ��
if abs(DeltaA_1(1)-Delta_e)/h_step > 10*Rad2Deg   %%����Լ��
    DeltaA_1(1) = Delta_e + sign(DeltaA_1(1)-Delta_e)*h_step*10*Rad2Deg;
end
if abs(DeltaA_1(2)-Delta_a)/h_step > 10*Rad2Deg   %%����Լ��
    DeltaA_1(2) = Delta_a + sign(DeltaA_1(2)-Delta_a)*h_step*10*Rad2Deg;
end
if abs(DeltaA_1(3)-Delta_r)/h_step > 10*Rad2Deg   %%����Լ��
    DeltaA_1(3) = Delta_r + sign(DeltaA_1(3)-Delta_r)*h_step*10*Rad2Deg;
end

if abs(DeltaA_1(1)) > Delta_lim   %%��ֵԼ��
    DeltaA_1(1) = sign(DeltaA_1(1)) * Delta_lim;   %%������Χ��ȡ�߽�ֵ
end
if abs(DeltaA_1(2)) > Delta_lim  %%��ֵԼ��
    DeltaA_1(2) = sign(DeltaA_1(2)) * Delta_lim;   %%������Χ��ȡ�߽�ֵ
end
if( abs(DeltaA_1(3)) > Delta_lim)  %%��ֵԼ��
    DeltaA_1(3) = sign(DeltaA_1(3)) * Delta_lim;   %%������Χ��ȡ�߽�ֵ
end