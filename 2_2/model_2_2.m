function zdot = model_2_2(t, z)

% zdot: output variable and 't','z' are input variables
% xhat: estimated states
% model_2_2: function name
% Evaluates control input 'u' and nonlinearity 'f'
% Calculates system dynamics i.e., sys.A*x + sys.Bu*u + sys.Bf*f
% Calculates observer dynamics i.e.,  sys.A*xhat + sys.Bu*u + sys.Bf*fhat + sys.L*(y-sys.C*xhat)

global sys 

x = z(1:sys.dim.nx);
xhat = z(sys.dim.nx+1:end);

u = zeros(sys.dim.nu,1);
for i = 1:sys.dim.nu
    u(i) = eval(sys.u{i});
end

sys.fhat = strrep(sys.f,'x','xhat');

f = zeros(sys.dim.nf,1);
for i = 1:sys.dim.nf
    f(i) = eval(sys.f{i});
end


fhat = zeros(sys.dim.nf,1);
for i = 1:sys.dim.nf
    fhat(i) = eval(sys.fhat{i});
end


%Calculating output vector
y = sys.C*x + sys.Du*u ;

%Calculating observer dynamics
zdot = [sys.A*x + sys.Bu*u + sys.Bf*f; sys.A*xhat + sys.Bu*u + sys.Bf*fhat + sys.L.*(y-sys.C*xhat)];
end


