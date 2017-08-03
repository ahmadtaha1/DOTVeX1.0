function disp_1_7()

% Displays system and observer dynamics
% Linear dynamical system with unknown input and its observer dynamics
% x_dot: system dynamics
% x_hat_dot,y_dot & w_hat: observer dynamics
% 'w' is unknown input and corresponding 'B_w' unknown input matrix.
% Whenever you execute this observer design, you see these dynamics on top of the command window


disp('------------------- SYSTEM AND OBSERVER DYNAMICS -------------------')
disp(' ');
disp('=== System/Plant Dynamics ===')
disp(' ');
disp('x_dot = A x + B_u u + B_w w' )
disp('y = C x');
disp(' ')
disp('=== Observer Dynamics ===')
disp('x_hat_dot = A x_hat + B_u u + B_w w_hat + L (y_hat - y)')
disp('y_hat = C x_hat' );
disp('w_hat = w0_hat - gamma G (y_hat - y)' );
disp(' ');