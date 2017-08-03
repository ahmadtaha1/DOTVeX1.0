function disp_2_1()

% Displays system and observer dynamics
% Nonlinear dynamical system with unknown input and its observer dynamics
% x_dot: system dynamics
% x_hat_dot &z_dot : observer dynamics
% f(x) is nonlinearity in the system
% 'fhat' is estimates of the nonlinearity
% Whenever you execute this observer design, you see these dynamics on top of the command window

disp('------------------- SYSTEM AND OBSERVER DYNAMICS -------------------')
disp(' ');
disp('=== System/Plant Dynamics ===')
disp('x_dot = A x + B_u u + f(x) + B_w w' )
disp('y = C x');
disp(' ')
disp('=== Observer Dynamics ===')
disp('z_dot = N z + G u + L y + M  f(xhat)')
disp('x_hat = z - E y');
disp(' ');