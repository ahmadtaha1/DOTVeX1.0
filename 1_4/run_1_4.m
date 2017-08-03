function run_1_4()

% @article{chakrabartystate,
%     title={State and Unknown Input Observers for Nonlinear Systems with Bounded Exogenous Inputs},
%     author={Chakrabarty, Ankush and Corless, Martin J and Buzzard, Gregery T and Zak, Stanis{\l}aw H and Rundell, Ann E}
% }

% Displays system matrix, input matrix, output matrix, unknown input matrix and disturbance/attack matrix 
% on the command window

% Require CVX software to run this file
% Initiate semi-definite programming mode

% LMI: [A'*P + P*A - Y*C - C'*Y' + alpha*P, P*Bw, Y*Dv;...
% Bw'*P, -alpha*eye(sys.dim.nw), zeros(sys.dim.nw,sys.dim.nv);...
% Dv'*Y', zeros(sys.dim.nv,sys.dim.nw), -alpha*eye(sys.dim.nv)] <= 0
% P >= mu0*eye(sys.dim.nx)
% mu0 >= eps

% Avoid strict inequalities in CVX
% Adding 'alpha' to improve the rate of convergence
% Returns variable observer gain 'L', symmetric matrix 'P' and scalar 'mu0'
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
Dv = sys.Dv
disp('System Control Input')
u = sys.u
disp('Unknown Input')
w = sys.w
disp('Disturbances/attack')
v = sys.v
    
%cvx semidefinite programming code 
disp(' ');
disp('=== Solving LMIs ===')
cvx_begin sdp quiet

variable P(sys.dim.nx, sys.dim.nx) symmetric
variable Y(sys.dim.nx, sys.dim.ny)
variables mu0(1,1)
alpha = 1;

minimize(-mu0)
subject to
[sys.A'*P + P*sys.A - Y*sys.C - sys.C'*Y' + alpha*P, P*sys.Bw, Y*sys.Dv;...
    sys.Bw'*P, -alpha*eye(sys.dim.nw), zeros(sys.dim.nw,sys.dim.nv);...
    sys.Dv'*Y', zeros(sys.dim.nv,sys.dim.nw), -alpha*eye(sys.dim.nv)] <= 0
P >= mu0*eye(sys.dim.nx)
mu0 >= eps

cvx_end

P
mu0
L = P\Y  %Calculating observer gain

sys.mu0 = mu0;
sys.L = L;
sys.P = P;

fprintf(1, '\nStatus of the LMI solver: %s', cvx_status);  %Displaying CVX status