function run_1_1()

%   title={Observers for multivariable systems},
%   author={Luenberger, D},
%   journal={IEEE Transactions on Automatic Control},
%   volume={11},
%   number={2},
%   pages={190--197},
%   year={1966},
%   publisher={IEEE}
% }
%      
% Displays system matrix, input matrix, output matrix on the command window
% Require CVX software to run this file
% Initiate semi-definite programming mode

% LMI: A'*P + P*A - Y*C - C'*Y' + 2*alph*P <= 0.

% Avoid strict inequalities in CVX
% Adding 'alph' to improve the rate of convergence
% Returns variable observer gain 'L' & symmetric matrix 'P'
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
Du = sys.Du
disp('System Control Input')
u = sys.u
alph = 0.5;

%cvx semidefinite programming code 
disp(' ');
disp('=== Solving LMIs ===')
cvx_begin sdp quiet

    variable P(sys.dim.nx, sys.dim.nx) symmetric
    variable Y(sys.dim.nx, sys.dim.ny)

    minimize(0)
    subject to
    sys.A'*P + P*sys.A - Y*sys.C - sys.C'*Y' + 2*alph*P <= 0;
    P >= eps*eye(sys.dim.nx);
cvx_end

P       
L = P\Y  

sys.L = L; 
sys.P = P;

fprintf(1, '\nStatus of the LMI solver: %s', cvx_status); %Displaying CVX status
end

