function run_2_1()

%     title={Unknown input observer design for a class of nonlinear systems: an LMI approach},
%     author={Chen, Weitian and Saif, Mehrdad},
%     booktitle={2006 American Control Conference},
%     pages={5--pp},
%     year={2006},
%     organization={IEEE}

% Displays system matrix, input matrix, output matrix, unknown input matrix on the command window.
% Require CVX software to run this file.
% Initiate semi-definite programming mode.

% LMI:((eye(sys.dim.nx)+U*C)*A)'*P + P*((eye(sys.dim.nx)+U*C)*A) + ...
%    (V*C*A)'*Ybar' + Ybar*(V*C*A) - C'*Kbar' - Kbar*C + ...
%    sys.gamma*eye(length(Kbar*C)), sqrt(sys.gamma)*(P*(eye(sys.dim.nx)+U*C)+Ybar*(V*C));
%    (sqrt(sys.gamma)*(P*(eye(sys.dim.nx)+U*C)+Ybar*(V*C)))' , -eye(sys.dim.nx)] <= 0;
%  P >= eps*eye(sys.dim.nx);

% Avoid strict inequalities in CVX.
% Returns variable observer gain 'L', symmetric matrix 'P',matrices 'N','M','G','E' and 'K'
% Displays status of the CVX output.

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
Bf = sys.Bf
Du = sys.Du
disp('System Control Input')
u = sys.u
disp('Unknown input')
w = sys.w
disp('Nonlinearity')
f = sys.f



sys.gamma = 1; 

U = -sys.Bw*pinv(sys.C*sys.Bw);
V = eye(length(sys.C*sys.Bw))-(sys.C*sys.Bw)*pinv(sys.C*sys.Bw);

%cvx semidefinite programming code 
disp(' ');
disp('=== Solving LMIs ===')
cvx_begin sdp quiet

variable P(sys.dim.nx, sys.dim.nx) symmetric
variable Ybar(sys.dim.nx, sys.dim.ny)
variable Kbar(sys.dim.nx, sys.dim.ny)

minimize(0)
subject to

[((eye(sys.dim.nx)+U*sys.C)*sys.A)'*P + P*((eye(sys.dim.nx)+U*sys.C)*sys.A) + ...
    (V*sys.C*sys.A)'*Ybar' + Ybar*(V*sys.C*sys.A) - sys.C'*Kbar' - Kbar*sys.C + ...
    sys.gamma*eye(length(Kbar*sys.C)), sqrt(sys.gamma)*(P*(eye(sys.dim.nx)+U*sys.C)+Ybar*(V*sys.C));
    (sqrt(sys.gamma)*(P*(eye(sys.dim.nx)+U*sys.C)+Ybar*(V*sys.C)))' , -eye(sys.dim.nx)] <= 0;
P >= eps*eye(sys.dim.nx);

cvx_end

Y=P\Ybar
K=P\Kbar
E=U+Y*V
M=eye(sys.dim.nx)+E*sys.C
N=M*sys.A-K*sys.C
G=M*sys.Bu
L=K*(eye(sys.dim.ny)+sys.C*E)-M*sys.A*E  %Calculating observer gain

sys.L = L;   
sys.K = K;
sys.E = E;
sys.M = M;
sys.N = N;
sys.G = G; 


fprintf(1, '\nStatus of the LMI solver: %s', cvx_status); %Displaying CVX status