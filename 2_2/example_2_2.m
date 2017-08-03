function sys = example_2_2()

% This is the pre-defined example for a nonlinear dynamical observer
% Respective matrix and vector values are shown below
% rho, delta, and phi are Lipschitz parameters
% Also contain control input vector 'u' and nonlinearity vector 'f'

%% System/Plant Dynamics
% x_dot = A x + B_u u + f(x)
% y = C x + D_u u 

%% dim: structure containing dimensions of randomly generated system
% dim.nx = # of states
% dim.ny = # of outputs
% dim.nw = # of unknown inputs
% dim.nv = # of noisy sensors

%% sys: structure containing the system of ODEs

%System matrix
sys.A = [1 1 ;-1 1];

%Input vector
sys.Bu = [0;0];

%Control inputs
sys.u = {'0'};

%Output vector  
sys.C = [1,0];  

sys.Du = zeros(size(sys.C,1),size(sys.Bu,2));

%Nonlinearity in the system  
sys.Bf = eye(2);
sys.f = {'-x(1)*(x(1)^2+x(2)^2)';...
    '-x(2)*(x(1)^2+x(2)^2)'};
sys.fhat = {'-xhat(1)*(xhat(1)^2+xhat(2)^2)';...
    '-xhat(2)*(xhat(1)^2+xhat(2)^2)'};
    
sys.varphi=-100;
sys.rho=0;
sys.delta=-99;

sys.dim.nx = size(sys.A, 1);        % number of states
sys.dim.nu = size(sys.Bu, 2);       % number of control inputs
sys.dim.ny = size(sys.C, 1);        % number of outputs
sys.dim.nf = size(sys.Bf, 2);       % number of nonlinearities
% save('sys.mat', 'sys');