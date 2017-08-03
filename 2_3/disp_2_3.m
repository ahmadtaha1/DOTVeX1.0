function disp_2_3()

% Displays system and observer dynamics
% Nonlinear dynamical system and its observer dynamics
% x_dot: system dynamics
% x_hat_dot &y_dot : observer dynamics
% f(x) is nonlinearity in the system
% fhat(x) is estimates of the nonlinearity
% Whenever you execute this observer design, you see these dynamics on top of the command window



disp('------------------- SYSTEM AND OBSERVER DYNAMICS -------------------')
disp(' ');
disp('=== System Dynamics ===')
disp('x_dot = A x + B_u u + f(x)')
disp('y = C x + D_u u');
disp(' ')
disp('=== Observer Dynamics ===')
disp('x_hat_dot = A x_hat + B_u u + fhat(x) + L(y - yhat)')
disp('y_hat = C x_hat + D_u u');
disp(' ');