function zdot = model_2_1(t, z)

% zdot: output variable and 't','z' are input variables
% zhat: estimated states
% model_2_1: function name
% Evaluates control input 'u', unknown input 'w' and nonlinearity 'f'
% Calculates system dynamics i.e., sys.A*x + sys.Bu*u + sys.Bw*w + sys.Bf*f
% Calculates observer dynamics i.e.,  sys.N*zhat + sys.G*u+ sys.L*y+sys.M*sys.Bf*fhat

global sys

x = z(1:sys.dim.nx);
zhat = z(sys.dim.nx+1:end);

u = zeros(sys.dim.nu,1);
for i = 1:sys.dim.nu
    u(i) = eval(sys.u{i});
end

w = zeros(sys.dim.nw,1);
for i = 1:sys.dim.nw
    w(i) = eval(sys.w{i});
end

%Calculating output vector
y = sys.C*x + sys.Du*u;

xhat = zhat - sys.E*y; % do not delete this line

sys.fhat = strrep(sys.f,'x','xhat');

f = zeros(sys.dim.nf,1);
for i = 1:sys.dim.nf
    f(i) = eval(sys.f{i});
end

fhat = zeros(sys.dim.nf,1);
for i = 1:sys.dim.nf
    fhat(i) = eval(sys.fhat{i});
end

%Calculating proposed observer 
zdot = [sys.A*x + sys.Bu*u + sys.Bw*w + sys.Bf*f;...
   sys.N*zhat + sys.G*u+ sys.L*y+sys.M*sys.Bf*fhat];
 
end
