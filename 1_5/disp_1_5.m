function disp_1_5()

% Displays system and observer dynamics
% Linear dynamical system with unknown input and its observer dynamics
% x_dot: system dynamics
% z_dot & x_hat: observer dynamics
% 'w' is unknown input and corresponding 'B_w' unknown input matrix
% Whenever you execute this observer design, you see these dynamics on top of the command window


disp('------------------- SYSTEM AND OBSERVER DYNAMICS -------------------')
disp(' ');
disp('=== System Dynamics ===')
disp('x_dot = A x + B_u u + B_w w')
disp('y = C x + D_u u');
disp(' ')
disp('=== Observer Dynamics ===')
disp('z_dot = N z + G u + L y')
disp('x_hat = z - E y');
disp(' ');