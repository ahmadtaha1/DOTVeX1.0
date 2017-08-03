function zdot = model_1_5(t, z)

% zdot: output variable and 't','z' are input variables
% zt: estimated states
% model_1_5: function name
% Evaluates control input 'u' and unknown input 'w'
% Calculates system dynamics i.e., sys.A*x + sys.Bu*u + sys.Bw*w 
% Calculates observer dynamics i.e., sys.N*zt + sys.G*u + sys.L*y

global sys 

x = z(1:sys.dim.nx);
zt = z(sys.dim.nx+1:end);

u = zeros(sys.dim.nu,1);
for i = 1:sys.dim.nu
    u(i) = eval(sys.u{i});
end


w = zeros(sys.dim.nw,1);
for i = 1:sys.dim.nw
    w(i) = eval(sys.w{i});
end

%Calculating output vector
y = sys.C*x +sys.Du*u; 

%Calculating proposed observer 
zdot = [sys.A*x + sys.Bu*u + sys.Bw*w;...
    sys.N*zt + sys.G*u + sys.L*y];