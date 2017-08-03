function sys = example_1_5()

% This is the pre-defined example for sliding mode observer with unknown input
% Respective matrix and vector values are shown below.
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

%System matrix
sys.A = [-1 -1 0;-1 0 0;0 -1 -1];

%Input matrix
sys.Bu = zeros(3,2);

%Control inputs
sys.u = {'0'; '0'};

%Output matrix  
sys.C = [1 0 0 ; 0 0 1];

%Unknown input vector
sys.Bw = [-1;0;0];
sys.w = {'10*square(5*t)'};

sys.Du = zeros(size(sys.C,1),size(sys.Bu,2));

%Disturbance/attack vector
sys.Dv = zeros(size(sys.C,1));


sys.dim.nx = size(sys.A, 1);        % number of states
sys.dim.nu = size(sys.Bu, 2);       % number of control inputs
sys.dim.nw = size(sys.Bw, 2);       % number of unknown inputs
sys.dim.ny = size(sys.C, 1);        % number of outputs
