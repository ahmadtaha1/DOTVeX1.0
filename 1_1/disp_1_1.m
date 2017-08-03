function disp_1_1()

% Displays system and observer dynamics
% Classical linear dynamical system and its observer dynamics
% x_dot: system dynamics
% x_hat_dot: observer dynamics
% Whenever you execute this observer design, you see these dynamics on top of the command window

disp('------------------- SYSTEM AND OBSERVER DYNAMICS -------------------')
disp(' ');
disp('=== System Dynamics ===')
disp('x_dot = A x + B_u u')
disp('y = C x + D_u u');
disp(' ')
disp('=== Observer Dynamics ===')
disp('x_hat_dot = A x_hat + B_u u + L(y - yhat)')
disp('y_hat = C x_hat + D_u u');
disp(' ');