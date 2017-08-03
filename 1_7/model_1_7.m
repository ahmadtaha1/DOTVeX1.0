function zdot = model_1_7(t, z)

% zdot: output variable and 't','z' are input variables
% xhat: estimated states
% model_1_7: function name
% Evaluates control input 'u' and unknown input 'w'
% 'gamma' is positive scalar
% Calculates system dynamics i.e., sys.A*x + sys.Bu*u + sys.Bw*w 
% Calculates observer dynamics i.e., sys.A*xhat + sys.Bu*u + sys.Bw*what + sys.L*(sys.C*xhat-y)
% Calculates unknown input estimates i.e., what=-sys.gamma*sys.G*(sys.C*xhat-y)

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

%Calculating output vector
y = sys.C*x;

%Calculating observer dynamics 
what=-sys.gamma*sys.G*(sys.C*xhat-y);
zdot = [sys.A*x + sys.Bu*u + sys.Bw*w;...
    sys.A*xhat + sys.Bu*u + sys.Bw*what + sys.L*(sys.C*xhat-y) ];

end