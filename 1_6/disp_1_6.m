function disp_1_6()

% Displays system and observer dynamics
% Linear dynamical system with unknown input and its observer dynamics
% x_dot: system dynamics
% x_hat_dot: observer dynamics
% 'w' is unknown input and corresponding 'B_w' unknown input matrix
% 'E' is injection term
% Whenever you execute this observer design, you see these dynamics on top of the command window


disp('------------------- SYSTEM AND OBSERVER DYNAMICS -------------------')
disp(' ');
disp('=== System Dynamics ===')
disp('x_dot = A x + B_u u + B_w w')
disp('y = C x + D_u u');
disp(' ')
disp('=== Observer Dynamics ===')
disp('x_hat_dot = A x_hat + B_u u + L (y - y_hat) - B_w E')
disp('y_hat = C x_hat + D_u u' );
disp(' ');








