function str_obsv_chc = print_tableNLS()

% Shows all observers that listed under nonlinear dynamical system 
% Displays system dynamics and authors name along with the name of the observer

str_obsv_chc = {'Unknown Input Observer for Nonlinear Systems with Unknown Inputs (w)  [ x_dot = A x + B_u u + phi(x) + B_w w ; y = C x +D_u u]';...
         'Observer for One-sided Lipschitz Nonlinear Systems [ x_dot = A x + B_u u + phi(x) ; y = C x +D_u u ]';
         'Observer for Gloabally Lipschitz Nonlinear Systems [ x_dot = A x + B_u u + phi(x) ; y = C x +D_u u ]'};
