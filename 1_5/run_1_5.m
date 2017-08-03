function run_1_5()

%     title={Unknown input observer design for a class of nonlinear systems: an LMI approach},
%     author={Chen, Weitian and Saif, Mehrdad},
%     booktitle={2006 American Control Conference},
%     pages={5--pp},
%     year={2006},
%     organization={IEEE}

% Displays system matrix, input matrix, output matrix, unknown input matrix on the command window
% Require CVX software to run this file
% Initiate semi-definite programming mode

% LMI: ((eye(sys.dim.nx,sys.dim.nx)+U*C)*A)'*P...
%    +P*(eye(sys.dim.nx,sys.dim.nx)+U*C)*A...
%    +(V*C*A)'*Ybar'+Ybar*(V*C*A)...
%    -C'*Kbar'-Kbar*C <= -eps*eye(sys.dim.nx);
% P >= eps*eye(sys.dim.nx)

% Avoid strict inequalities in CVX
% Returns variable observer gain 'L', symmetric matrix 'P',matrices 'N','G','E','M' and 'K'
% Displays status of the CVX output

global sys p

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

temp = (sys.C*sys.Bw).';
U = -sys.Bw*(temp*temp.'\temp);
V = eye(sys.dim.ny,sys.dim.ny)-temp.'*(temp*temp.'\temp);

%cvx semidefinite programming code
disp(' ');
disp('=== Solving LMIs ===')
cvx_begin sdp quiet

variable P(sys.dim.nx, sys.dim.nx) symmetric
variable Ybar(sys.dim.nx, sys.dim.ny)
variable Kbar(sys.dim.nx, sys.dim.ny)

minimize(0)
subject to
((eye(sys.dim.nx,sys.dim.nx)+U*sys.C)*sys.A)'*P...
    +P*(eye(sys.dim.nx,sys.dim.nx)+U*sys.C)*sys.A...
    +(V*sys.C*sys.A)'*Ybar'+Ybar*(V*sys.C*sys.A)...
    -sys.C'*Kbar'-Kbar*sys.C <= -eps*eye(sys.dim.nx);
P >= eps*eye(sys.dim.nx)
cvx_end

Y=P^(-1)*Ybar
K=P^(-1)*Kbar
E=U+Y*V
M=eye(sys.dim.nx,sys.dim.nx)+E*sys.C
N=M*sys.A-K*sys.C
G=M*sys.Bu
L=K*(eye(sys.dim.ny,sys.dim.ny)+sys.C*E)-M*sys.A*E     %Calculating observer gain


sys.N = N;
sys.G = G;
sys.L = L;
sys.E = E;
sys.K = K;
sys.P = P;

fprintf(1, '\nStatus of the LMI solver: %s', cvx_status);   %Displaying CVX status