function run_1_3()

%   title={Distributed unknown input observers for interconnected nonlinear systems},
%   author={Chakrabarty, Ankush and Sundaram, Shreyas and Corless, Martin J and Buzzard, Gregery T and {\.Z}ak, Stanis{\l}aw H and Rundell, Ann E},
%   booktitle={American Control Conference (ACC), 2016},
%   pages={101--106},
%   year={2016},
%   organization={IEEE}
% }

% Displays system matrix, input matrix, output matrix, unknown input matrix on the command window
% Require CVX software to run this file
% Initiate semi-definite programming mode

% LMI: [A'*P + P*A - Y*C - C'*Y' + alph*P, P*Bw;...
% Bw'*P, -alph*eye(sys.dim.nw)] <= 0
% P >= mu0*eps*eye(sys.dim.nx)

% Avoid strict inequalities in CVX
% Adding 'alph' to improve the rate of convergence
% Returns variable observer gain 'L', symmetric matrix 'P' and scalar 'mu0'
% Displays status of the CVX output

global sys p

%Displaying system dynamics values
disp(' ');
if p.user_choice == 3 
disp('=== Exemplar System ===')
end

A = sys.A
Bu = sys.Bu
Bw = sys.Bw
C = sys.C
Du = sys.Du
disp('System Control Input')
u = sys.u
disp('Unknown Input')
w = sys.w

%cvx semidefinite programming code 
disp(' ');
disp('=== Solving LMIs ===')
cvx_begin sdp quiet

variable P(sys.dim.nx, sys.dim.nx) symmetric
variable Y(sys.dim.nx, sys.dim.ny)
variable mu0(1,1)
alph = 0.5;

minimize(0)
subject to
[sys.A'*P + P*sys.A - Y*sys.C - sys.C'*Y' + alph*P, P*sys.Bw;...
    sys.Bw'*P, -alph*eye(sys.dim.nw)] <= 0
P >= mu0*eps*eye(sys.dim.nx)

cvx_end

mu0
P
L = P\Y  %Calculating observer gain

sys.P = P;
sys.L = L;

fprintf(1, '\nStatus of the LMI solver: %s', cvx_status); %Displaying CVX status