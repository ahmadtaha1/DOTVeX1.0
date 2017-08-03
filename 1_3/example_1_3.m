function sys = example_1_3()

% This is the pre-defined example for a linear observer with unknown input
% Respective matrix and vector values are shown below
% Also contain control input vector 'u' and unknown input vector 'w'

%% System/Plant Dynamics

% x_dot = A x + B_u u + B_w w
% y = C x + D_u u 

%% dim: structure containing dimensions of randomly generated system
% dim.nx = # of states
% dim.ny = # of outputs
% dim.nw = # of unknown inputs
% dim.nv = # of noisy sensors

%% sys: structure containing the system of ODEs
% Model is of DC motor taken from Raff + Allgower
p.rs = 20.5;
p.ls = 0.5;
p.rr = 0.05;
p.lr = 0.003;
p.J = 15;
p.f = 0.1;
p.kc = 0.0166;
p.x1e = 20;
p.x2e = 5;
p.x3e = -10;
p.x4e = -5;

%System matrix
sys.A = [-p.rs/p.ls, 0, 0, 0;...
    -(p.kc*p.ls*p.x3e/p.lr), -p.rr/p.lr, -(p.kc*p.ls*p.x1e)/p.lr, 0;...
    (p.kc*p.ls*p.x2e/p.J), (p.kc*p.ls*p.x1e)/p.J, -p.f/p.J, 0;...
    0, 0, 1, 0];

%Input matrix
sys.Bu = [1/p.ls 0;0 1/p.lr;0 0; 0 0];

%Control inputs
sys.u = {'sin(t)' ; 'cos(t)'};

%Output matrix  
sys.C = [1 0 0 0;
             0 0 0 1];  
         
%Unknown state disturbance        
sys.Bw = [1/p.ls; 0; 0; 0];
sys.w = {'2*square(5*t)'};

sys.Du = zeros(size(sys.C,1),size(sys.Bu,2));

sys.dim.nx = size(sys.A, 1);    % number of states
sys.dim.nu = size(sys.Bu, 2);   % number of control inputs
sys.dim.nw = size(sys.Bw, 2);   % number of unknown inputs 
sys.dim.ny = size(sys.C, 1);    % number of outputs


% save('sys.mat', 'sys');