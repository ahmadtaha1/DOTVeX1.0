function zdot = model_1_4(t, z)

% zdot: output variable and 't','z' are input variables
% xhat: estimated states
% yhat: estimated output vector
% model_1_4: function name
% Evaluates control input 'u', unknown input 'w' and disturbance/attack 'v'
% Calculates system dynamics i.e., sys.A*x + sys.Bu*u + sys.Bw*w 
% Calculates observer dynamics i.e., sys.A*xhat + sys.Bu*u + sys.L*(y-yhat)

global sys

x = z(1:sys.dim.nx);
xhat = z(sys.dim.nx+1:end);

u = zeros(sys.dim.nu,1);
for i=1:sys.dim.nu
    u(i) = eval(sys.u{i});
end

w = zeros(sys.dim.nw,1);
for i=1:sys.dim.nw
    w(i) = eval(sys.w{i});
end

v = zeros(sys.dim.nv,1);
for i=1:sys.dim.nv
    v(i) = eval(sys.v{i});
end

%Calculating output vector
y = sys.C*x + sys.Du*u + sys.Dv*v;

%Calculating proposed observer 
yhat = sys.C*xhat + sys.Du*u;
zdot = [sys.A*x + sys.Bu*u + sys.Bw*w;...
    sys.A*xhat + sys.Bu*u + sys.L*(y-yhat)];