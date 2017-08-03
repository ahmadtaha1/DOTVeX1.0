function zdot = model_1_6(t, z)

% zdot: output variable and 't','z' are input variables
% xhat: estimated states
% yhat: estimated output vector
% model_1_6: function name
% Computes injection term i.e.,injec_term
% 'nu' and 'rho' are design parameters
% Evaluates control input 'u' and unknown input 'w'
% Calculates system dynamics i.e., sys.A*x + sys.Bu*u + sys.Bw*w 
% Calculates observer dynamics i.e., sys.A*xhat + sys.Bu*u + sys.L*(y-yhat)+ sys.Bw*injec_term

global sys

x = z(1:sys.dim.nx);
xhat = z(sys.dim.nx+1:end);

u = zeros(sys.dim.nu,1);
for i = 1:sys.dim.nu
    u(i) = eval(sys.u{i});
end

w = zeros(sys.dim.nw,1);
for i = 1:sys.dim.nw
    w(i) = eval(sys.w{i});
end

%Calculating actual and estimated output vector
y = sys.C*x;
yhat=sys.C*xhat;

%For SISO case
temp = sys.F*(y-yhat);
injec_term = sys.rho*temp/(norm(temp)+sys.nu);
zdot = [sys.A*x + sys.Bu*u + sys.Bw*w;...
    sys.A*xhat + sys.Bu*u + sys.L*(y-yhat) + sys.Bw*injec_term];

end