function run_1_2()

%   title={Linear matrix inequalities in control},
%   author={Scherer, Carsten and Weiland, Siep},
%   journal={Lecture Notes, Dutch Institute for Systems and Control, Delft, The Netherlands},
%   volume={3},
%   year={2000}

% Displays system matrix, input matrix, output matrix, unknown input matrix on the command window
% Require CVX software to run this file
% Initiate semi-definite programming mode

% LMI: A'*P + P*A - Y*C - C'*Y' - mu0*C'*C, P*Bw;...
%    Bw'*P, -mu0*eye(sys.dim.nw)] <= 0
%    P >= eps*eye(sys.dim.nx)

% Avoid strict inequalities in CVX.
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

minimize(0)
subject to
[sys.A'*P + P*sys.A - Y*sys.C - sys.C'*Y' - mu0*sys.C'*sys.C, P*sys.Bw;...
    sys.Bw'*P, -mu0*eye(sys.dim.nw)] <= 0
P >= eps*eye(sys.dim.nx)

cvx_end

mu0
P
L = P\Y %Calculating observer gain

sys.P = P;
sys.L = L;

fprintf(1, '\nStatus of the LMI solver: %s', cvx_status); %Displaying CVX status