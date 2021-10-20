% n为变量个数
%返回值为(2^n)*n的矩阵
 function [BCas] = Limit_bias(n,mx) 

A1 = [1;-1]; 
A2 = [ 1, 1;
      -1, 1;
       1,-1;
      -1,-1];  
x = ones(2^2,1); 
x_m = -1 * ones(2^2,1);
A3_1 = [A2, x];
A3_2 = [A2, x_m];
A3 =[A3_1;A3_2];

x = ones(2^3,1); 
x_m = -1 * ones(2^3,1);
A4_1 = [A3, x];
A4_2 = [A3, x_m];
A4 =[A4_1;A4_2];

x = ones(2^4,1); 
x_m = -1 * ones(2^4,1);
A5_1 = [A4, x];
A5_2 = [A4, x_m];
A5 =[A5_1;A5_2];

switch n
    case 1
        BCas = A1;
    case 2
        BCas = A2;
    case 3
        BCas = A3;
    case 4
        BCas = A4;
    case 5
        BCas = A5;
    otherwise
        BCas = [];
end 

BCas = mx*BCas;

end