function sys = example_2_3()

% This is the pre-defined example for a nonlinear dynamical observer
% Respective matrix and vector values are shown below
% Also contain control input vector 'u' and nonlinearity vector 'f'

%% System/Plant Dynamics
% x_dot = A x + B_u u + f(x)
% y = C x + D_u u 

%% dim: structure containing dimensions of randomly generated system
% dim.nx = # of states
% dim.ny = # of outputs

%% sys: structure containing the system of ODEs

%System matrix
sys.A = [-1 3 0; 0 0 1; -1 1 -3]; 

%Input matrix
sys.Bu = [1; 1; 1]; 
sys.u = {'1'};

% output matrix
sys.C = [1 0 0; 0 1 0]; 

sys.Du = zeros(size(sys.C,1),size(sys.Bu,2));

%Nonlinearity in the system  
sys.Bf = [0; 0; 1]; % nonlinearity injection matrix

sys.f = {'sin(x(3))'};
sys.fhat = {'sin(xhat(3)'};
   

sys.beta = 1;


sys.dim.nx = size(sys.A, 1);        % number of states
sys.dim.nu = size(sys.Bu, 2);       % number of control inputs
sys.dim.ny = size(sys.C, 1);        % number of outputs
sys.dim.nf = size(sys.Bf, 2);       % number of nonlinearities




