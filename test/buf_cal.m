
% m =64000;
% xcg = 1.6210E-10*m^2 - 5.5226E-05*m +7.3578
% Jx = -7.8809E-05* m^2 +25.8857*m -6.9683E05
% Jy = -8.289E-04* m^2 + 265.9889*m -7.3048E06

% syms m
% eq = -7.8809E-05* m^2 +25.8857*m -6.9683E05 - 637234;
% [m] = solve(eq,'m')
% m0 = double(m)

syms m
eq = 1.6210E-10*m^2 - 5.5226E-05*m +7.3578 -4;
[m] = solve(eq,'m');
m0 = double(m)