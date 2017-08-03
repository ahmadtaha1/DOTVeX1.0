function run_2_2()

%     title={Full-order and reduced-order observers for one-sided Lipschitz nonlinear systems using Riccati equations},
%     author={Zhang, Wei and Su, Housheng and Wang, Hongwei and Han, Zhengzhi},
%     journal={Communications in Nonlinear Science and Numerical Simulation},
%     volume={17},
%     number={12},
%     pages={4968--4977},
%     year={2012},
%     publisher={Elsevier}

% Displays system matrix, input matrix, output matrix, unknown input matrix on the command window
% Require CVX software to run this file
% Initiate semi-definite programming mode
% Please refer Nonlinear Observer Design for one-sided Lipschitz Systems by Abbaszadeh M and Marquez H J
   % to know more about Lipschitz constants
   
% LMI: A'*P+P*A+(eps1*sys.rho+eps2*sys.delta)*eye(sys.dim.nx)-sigg*(C'*C),...
%    P+((sys.varphi*eps2-eps1)/(2))*eye(sys.dim.nx);
%   (P+((sys.varphi*eps2-eps1)/(2))*eye(sys.dim.nx))', ...
%   -eps2*eye(sys.dim.nx)] <= 0;

% Users are allowed to enter Lipschitz parameters i.e., rho, phi and delta
% Avoid strict inequalities in CVX
% Returns variable observer gain 'L', symmetric matrix 'P', scalars eps1, eps2 and sigg
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

%Picking Lipschitz constant values
if p.user_choice == (2 || 3 )
sys.varphi=-100;
sys.rho=0;
sys.delta=-99;
end


varphi=sys.varphi
rho=sys.rho
delta=sys.delta

%cvx semidefinite programming code 
disp(' ');
disp('=== Solving LMIs ===')
cvx_begin sdp quiet

variable P(sys.dim.nx,sys.dim.nx) symmetric
variable eps1(1,1)
variable eps2(1,1)
variable sigg(1,1)

minimize(0)
subject to
eps1 >= eps;
eps2 >= eps;
sigg >= eps;
P >= 0;

[sys.A'*P+P*sys.A+(eps1*sys.rho+eps2*sys.delta)*eye(sys.dim.nx)-sigg*(sys.C'*sys.C),...
    P+((sys.varphi*eps2-eps1)/(2))*eye(sys.dim.nx);
   (P+((sys.varphi*eps2-eps1)/(2))*eye(sys.dim.nx))', ...
   -eps2*eye(sys.dim.nx)] <= 0;
   
cvx_end
P
L = 0.5*sigg*inv(P)*sys.C' %Calculating observer gain

sys.P = P; 
sys.L = L;
eps1
eps2
sigg
fprintf(1, '\nStatus of the LMI solver: %s', cvx_status); %Displaying CVX status