function run_1_7()

%     title={State and input estimation for a class of uncertain systems},
%     author={Corless, Martin and Tu, Jay},
%     journal={Automatica},
%     volume={34},
%     number={6},
%     pages={757--764},
%     year={1998},
%     publisher={Elsevier}

% Displays system matrix, input matrix, output matrix, unknown input matrix on the command window
% Require CVX software to run this file
% Initiate semi-definite programming mode

% LMI:  P*A+K*C+(P*A+K*C)'+2*alph*P <=0;
%    P >= eps*eye(sys.dim.nx);
%    Bw'*P == G*C;

% Avoid strict inequalities in CVX
% Adding 'alph' to improve the rate of convergence
% Returns variable observer gain 'L', symmetric matrix 'P',matrix 'G'
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
sys.gamma = 1;
alph = 1;

%cvx semidefinite programming code
disp(' ');
disp('=== Solving LMIs ===')
cvx_begin sdp quiet

variable P(sys.dim.nx, sys.dim.nx) symmetric
variable G(sys.dim.nw, sys.dim.ny)
variable K(sys.dim.nx, sys.dim.ny)
variable L(sys.dim.nx, sys.dim.ny)
variable theta(1,1)

minimize(norm(K))
subject to
    P*sys.A+K*sys.C+(P*sys.A+K*sys.C)'+2*alph*P <=0;
    P >= eps*eye(sys.dim.nx);
    sys.Bw'*P == G*sys.C;
cvx_end

P
G
L=P\K  %Calculating observer gain

sys.L = L;
sys.G = G;

fprintf(1, '\nStatus of the LMI solver: %s', cvx_status);   %Displaying CVX status

