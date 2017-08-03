function zdot = model_1_1(t, z)

% zdot: output variable and 't','z' are input variables
% xhat: estimated states
% yhat: estimated output vector
% model_1_1: function name
% Evaluates control input 'u'
% Calculates system dynamics i.e., sys.A*x + sys.Bu*u 
% Calculates observer dynamics i.e., sys.A*xhat + sys.Bu*u + sys.L*(y-yhat)


global sys

x = z(1:sys.dim.nx);
xhat = z(sys.dim.nx+1:end);

u = zeros(sys.dim.nu,1);
for i = 1:sys.dim.nu
    u(i) = eval(sys.u{i});
end

%Calculating output vector
y = sys.C*x + sys.Du*u;

%Calculating observer dynamics
yhat = sys.C*xhat + sys.Du*u;
zdot = [sys.A*x + sys.Bu*u; sys.A*xhat + sys.Bu*u + sys.L*(y-yhat)];

end