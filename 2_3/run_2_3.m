function run_2_3()

%   title={Observers for Lipschitz nonlinear systems},
%   author={Rajamani, Rajesh},
%   journal={IEEE transactions on Automatic Control},
%   volume={43},
%   number={3},
%   pages={397--401},
%   year={1998},
%   publisher={IEEE}

% Displays system matrix, input matrix, output matrix, unknown input matrix on the command window
% Require CVX software to run this file
% Initiate semi-definite programming mode

% LMI: [P*A + A'*P - Y*C - C'*Y' + 0.1*P + kap*sys.beta^2*eye(sys.dim.nx), P*sys.Bf;...
%     sys.Bf'*P, -kap*eye(sys.dim.nf)] <= 0
% P >= eps*eye(sys.dim.nx) % eps is a very small number in MATLAB
% kap >= 0

% Users are allowed to enter 'beta' value
% Avoid strict inequalities in CVX
% Returns variable observer gain 'L', symmetric matrix 'P', and 'kap'
% Displays status of the CVX output

global sys p

%Displaying system dynamics values
disp(' ')
if p.user_choice == 3 
disp('=== Exemplar System ===')
end

A = sys.A
Bu = sys.Bu
C = sys.C 
Bf = sys.Bf
Du = sys.Du
disp('System Control Input')
u = sys.u
disp('Nonlinearity')
f = sys.f

if p.user_choice == (2 || 3 )
sys.beta = 1;
end

%cvx semidefinite programming code 
disp(' ');
disp('=== Solving LMIs ===')
cvx_begin sdp quiet
	
% Variable definition
variable P(sys.dim.nx, sys.dim.nx) symmetric
variable Y(sys.dim.nx, sys.dim.ny)
variable kap(1,1)

% LMIs
[P*sys.A + sys.A'*P - Y*sys.C - sys.C'*Y' + 0.1*P + kap*sys.beta^2*eye(sys.dim.nx), P*sys.Bf;...
    sys.Bf'*P, -kap*eye(sys.dim.nf)] <= 0
P >= eps*eye(sys.dim.nx) % eps is a very small number in MATLAB
kap >= 0

cvx_end

P
L = P\Y
kap
sys.P = P;
sys.L = L;

fprintf(1, '\nStatus of the LMI solver: %s', cvx_status); %Displaying CVX status

