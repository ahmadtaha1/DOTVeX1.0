function run_1_6()

%   title={Observer design for systems with unknown inputs},
%   author={Hui, Stefen and Zak, Stanis{\l}aw H},
%   journal={International Journal of Applied Mathematics and Computer Science},
%   volume={15},
%   number={4},
%   pages={431},
%   year={2005},
%   publisher={University of Zielona Gora Press}

% Displays system matrix, input matrix, output matrix, unknown input matrix on the command window
% Require CVX software to run this file
% Initiate semi-definite programming mode

% LMI: A'*P + P*A - Y*C - C'*Y' + 2*alph*P <= 0
% F*C-Bw'*P == 0
% P >= eps*eye(sys.dim.nx)

% Avoid strict inequalities in CVX
% Adding 'alph' to improve the rate of convergence
% 'nu' and 'rho' are design parameter
% Returns variable observer gain 'L', symmetric matrix 'P' and matrix 'F'
% Displays status of the CVX output

global sys p

disp(' ');
if p.user_choice == 3 
disp('=== Exemplar System ===')
end

A = sys.A
Bu = sys.Bu
C = sys.C               
Bw = sys.Bw
disp('System Control Input')
u = sys.u
disp('Unknown Input')
w = sys.w

alph = 1;
sys.rho=2;
sys.nu=1e-2;

%cvx semidefinite programming code
disp(' ');
disp('=== Solving LMIs ===')
cvx_begin sdp quiet

variable P(sys.dim.nx, sys.dim.nx) symmetric
variable Y(sys.dim.nx, sys.dim.ny)
variable F(sys.dim.nw, sys.dim.ny)

minimize(0)
subject to
sys.A'*P + P*sys.A - Y*sys.C - sys.C'*Y' + 2*alph*P <= 0
F*sys.C-sys.Bw'*P == 0
P >= eps*eye(sys.dim.nx)

cvx_end

P
F
L = P\Y  %Calculating observer gain

sys.L = L;
sys.F = F;

fprintf(1, '\nStatus of the LMI solver: %s', cvx_status);  %Displaying CVX status