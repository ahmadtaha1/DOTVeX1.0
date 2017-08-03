function sys = input_the_sys()

% This is used exclusively for entering values into DOTVeX while using Custom based systems
% As soon as system matrix 'A' and output matrix values are entered,
   % switches to observer selected previously
   
% 'p.sel_sym' selects either linear dynamical system or nonlinear dynamical system
% 'p.obsv_choice' helps select observer in each category 


global p

disp(' ');
figure, imshow('matlab_entry.png');
sys.A = input('Enter A: ');
sys.C = input('Enter C: ');

sys.dim.nx = size(sys.A, 1);    % number of states
sys.dim.ny = size(sys.C, 1);    % number of outputs

%% Checking dimension of output vector
while size(sys.A, 1) ~= size(sys.C, 2) 
    disp('Invalid dimension of C');
    disp(' ')
    sys.C = input('Please enter valid dimension C: ');
end

disp(' ');

     switch num2str(p.sel_sys)
       case '1'
    switch num2str(p.obsv_choice)
        
       case '1'        %Luenberger Observer for Nominal LTI Systems [Luenberger 1966] 
       disp(' ');
       disp('This classic observer neither supports unknown input w(t) nor disturbances/attack v(t) ');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');                  %number of control inputs
       sys.dim.nw = 0 ;                                                             %number of unknown inputs
       sys.dim.nv = 0 ;                                                             %number of disturbances/attack
       
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
             
            % Checking dimensions of 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
             
            % Checking dimensions of 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
        
            disp('Checking sufficient and necessary conditions...');
            pause(5)
            
            % Checks whether entered values satisfying rank matching consitions
            
  while(true)
            flag=0;    
            if(rank(obsv(sys.A,sys.C)))==rank(sys.A)   
            disp('OK. The system is observable')
            disp('')
            break;
            end
            
           eigval=eig(sys.A);
for i=1:size(sys.A,1)
        if (rank([eigval(i)*eye(size(sys.A, 1))-sys.A;sys.C])~=size(sys.A,1) && real(eigval(i))>=0  )
           flag=1;
            disp('The system is not detectable, please enter A and C again:')
            sys.A=input('Enter A =');
            sys.C=input('Enter C =');
            break;    
       end
 
 end
 if(flag==1)
     continue;
 end
      disp('OK. The system is detectable')
      break;
 
  end
            

       case '2'      %Robust Observer for LTI Systems with Unknown Inputs [Scherer-Weiland 2000]
       disp(' ');
       disp('This observer supports unknown input w(t) only');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');              %number of control inputs
       sys.dim.nw = input('Enter number of unknown inputs (w): ');              %number of unknown inputs
       sys.dim.nv = 0 ;                                                         %number of disturbances/attack
       
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
            
            % Checking dimensions of matrix 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
            
            % Checking dimensions of matrix 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
       
            if sys.dim.nw == 0
                sys.w = zeros(sys.dim.nw, 1);
                sys.Bw = zeros(sys.dim.nx, sys.dim.nw);
            else
                sys.w = input('Enter w: ');
                sys.Bw = input('Enter Bw: ');
            end
            
             % Checking dimensions of matrix 'Bw'
            while size(sys.Bw, 2) ~= size(sys.w,1) || size(sys.A, 1) ~= size(sys.Bw, 1) 
                disp('Invalid dimension Of Bw');
                disp(' ');
                sys.Bw = input('Please enter valid dimension Bw: ');
            end
       
            disp('Checking sufficient and necessary conditions...');
            pause(5)
            
            % Checks whether entered values satisfying rank matching consitions
            if rank(sys.C*sys.Bw) == rank(sys.Bw)
            disp(' ');
            disp('The rank matching conditions are satisfied');
            else 
            disp('The rank of C*Bw and Bw must be equivalent');
            disp(' ');
            disp('The rank matching conditions are not satisfied, hence observer might show diverging plots');
            end
                
            
       case '3'  % Unknown Input Observer for LTI Systems with Unknown Inputs (1) [Chakrabarty-Sundaram 2016]
       disp(' ');
       disp('This observer supports unknown input w(t) only');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');              %number of control inputs
       sys.dim.nw = input('Enter number of unknown inputs (w): ');              %number of unknown inputs
       sys.dim.nv = 0 ;                                                         %number of disturbances/attack
       
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
            
            % Checking dimensions of matrix 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
            
            % Checking dimensions of matrix 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
       
            if sys.dim.nw == 0
                sys.w = zeros(sys.dim.nw, 1);
                sys.Bw = zeros(sys.dim.nx, sys.dim.nw);
            else
                sys.w = input('Enter w: ');
                sys.Bw = input('Enter Bw: ');
            end
            
            % Checking dimensions of matrix 'Bw'
            while size(sys.Bw, 2) ~= size(sys.w,1) || size(sys.A, 1) ~= size(sys.Bw, 1) 
                disp('Invalid dimension Of Bw');
                disp(' ');
                sys.Bw = input('Please enter valid dimension Bw: ');
            end
            
            disp('Checking sufficient and necessary conditions...');
            pause(5)
            
            % Checks whether entered values satisfying rank matching consitions
            if rank(sys.C*sys.Bw) == rank(sys.Bw)
            disp(' ');
            disp('The rank matching conditions are satisfied');
            else 
            disp('The rank of C*Bw and Bw must be equivalent');
            disp(' ');
            disp('The rank matching conditions are not satisfied, hence observer might show diverging plots');
            end
           
            
       case'4'  % L-Infinity Observer with Unknown Inputs (w) and (v) [Chakrabarty-Coreless 2016]
       disp(' ');
       disp('This observer supports unknown input w(t) and disturbances/attack v(t)');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');              %number of control inputs
       sys.dim.nw = input('Enter number of unknown inputs (w): ');              %number of unknown inputs
       sys.dim.nv = input('Enter number of measurement disturbances (v): ');    %number of disturbances/attack
       
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
             
            % Checking dimensions of matrix 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
            
            % Checking dimensions of matrix 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
       
            if sys.dim.nw == 0
                sys.w = zeros(sys.dim.nw, 1);
                sys.Bw = zeros(sys.dim.nx, sys.dim.nw);
            else
                sys.w = input('Enter w: ');
                sys.Bw = input('Enter Bw: ');
            end
            
            % Checking dimensions of matrix 'Bw'
            while size(sys.Bw, 2) ~= size(sys.w,1) || size(sys.A, 1) ~= size(sys.Bw, 1) 
                disp('Invalid dimension Of Bw');
                disp(' ');
                sys.Bw = input('Please enter valid dimension Bw: ');
            end
       
            if sys.dim.nv == 0
                sys.v = zeros(sys.dim.nv, 1);
                sys.Dv = zeros(sys.dim.ny, sys.dim.nv);
            else
                sys.v = input('Enter v: ');
                sys.Dv = input('Enter Dv: ');
            end
            
            % Checking dimensions of matrix 'Dv'
            while size(sys.Dv, 2) ~=  size(sys.v,1) || size(sys.C, 1) ~= size(sys.Dv, 1)
                disp('Invalid dimension Of Dv');
                disp(' ');
                sys.Dv = input('Please enter valid dimension Dv: ');
            end
            
       case'5'   % Unknown Input Observer for LTI Systems with Unknown Inputs (2)(w) [Chen-Saif 2006]
       disp(' ');
       disp('This observer supports unknown input w(t) only');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');              %number of control inputs
       sys.dim.nw = input('Enter number of unknown inputs (w): ');              %number of unknown inputs
       sys.dim.nv = 0 ;                                                         %number of disturbances/attack
       
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
            
            % Checking dimensions of matrix 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
            
            % Checking dimensions of matrix 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
       
            if sys.dim.nw == 0
                sys.w = zeros(sys.dim.nw, 1);
                sys.Bw = zeros(sys.dim.nx, sys.dim.nw);
            else
                sys.w = input('Enter w: ');
                sys.Bw = input('Enter Bw: ');
            end
            
            % Checking dimensions of matrix 'Bw'
            while size(sys.Bw, 2) ~= size(sys.w,1) || size(sys.A, 1) ~= size(sys.Bw, 1) 
                disp('Invalid dimension Of Bw');
                disp(' ');
                sys.Bw = input('Please enter valid dimension Bw: ');
            end
            
             disp('Checking sufficient and necessary conditions...');
             pause(5)
             
            % Checks whether entered values satisfying rank matching consitions
            if rank(sys.C*sys.Bw) == rank(sys.Bw)
            disp(' ');
            disp('The rank matching conditions are satisfied');
            else 
            disp('The rank of C*Bw and Bw must be equivalent');
            disp(' ');
            disp('The rank matching conditions are not satisfied, hence observer might show diverging plots');
            end
           
            
        case '6'   % Unknown Input Sliding Mode Observer for LTI Systems with Unknown Inputs (w) [Hui-Zak 2005]
       disp(' ');
       disp('This observer supports unknown input w(t) only');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');              %number of control inputs
       sys.dim.nw = input('Enter number of unknown inputs (w): ');              %number of unknown inputs
       sys.dim.nv = 0 ;                                                         %number of disturbances/attack
       
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
            
            % Checking dimensions of matrix 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
            
            % Checking dimensions of matrix 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
       
            if sys.dim.nw == 0
                sys.w = zeros(sys.dim.nw, 1);
                sys.Bw = zeros(sys.dim.nx, sys.dim.nw);
            else
                sys.w = input('Enter w: ');
                sys.Bw = input('Enter Bw: ');
            end
            
            % Checking dimensions of matrix 'Bw'
            while size(sys.Bw, 2) ~= size(sys.w,1) || size(sys.A, 1) ~= size(sys.Bw, 1) 
                disp('Invalid dimension Of Bw');
                disp(' ');
                sys.Bw = input('Please enter valid dimension Bw: ');
            end
            
            disp('Checking sufficient and necessary conditions...');
            pause(5)
            
            % Checks whether entered values satisfying rank matching consitions
            if rank(sys.C*sys.Bw) == rank(sys.Bw)
            disp(' ');
            disp('The rank matching conditions are satisfied');
            else 
            disp('The rank of C*Bw and Bw must be equivalent');
            disp(' ');
            disp('The rank matching conditions are not satisfied, hence observer might show diverging plots');
            end
            
  while(true)
            flag=0;    
          if(rank(obsv(sys.A,sys.C)))==rank(sys.A)   
            disp('OK. The system is observable')
            disp('')
          end
            
           eigval=eig(sys.A);
  for i=1:size(sys.A,1)
        if (rank([eigval(i)*eye(size(sys.A, 1))-sys.A;sys.C])~=size(sys.A,1) && real(eigval(i))>=0  )
           flag=1;
            disp('The system is not detectable, please enter A and C again:')
            sys.A=input('Enter A =');
            sys.C=input('Enter C =');
            break;    
       end
 
 end
 if(flag==1)
     continue;
 end
      disp('OK. The system is detectable')
      break;
 
  end
                                                
            
        case '7'    % Robust Observer for Uncertain LTI Systems with Unknown Inputs (w) [Corless-Tu 1998]
       disp(' ');
       disp('This observer supports unknown input w(t) only');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');              %number of control inputs
       sys.dim.nw = input('Enter number of unknown inputs (w): ');              %number of unknown inputs
       sys.dim.nv = 0 ;                                                         %number of disturbances/attack
       
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
            
            % Checking dimensions of matrix 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
            
            % Checking dimensions of matrix 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
       
            if sys.dim.nw == 0
                sys.w = zeros(sys.dim.nw, 1);
                sys.Bw = zeros(sys.dim.nx, sys.dim.nw);
            else
                sys.w = input('Enter w: ');
                sys.Bw = input('Enter Bw: ');
            end
            
            % Checking dimensions of matrix 'Bw'
            while size(sys.Bw, 2) ~= size(sys.w,1) || size(sys.A, 1) ~= size(sys.Bw, 1) 
                disp('Invalid dimension Of Bw');
                disp(' ');
                sys.Bw = input('Please enter valid dimension Bw: ');
            end
            
            disp('Checking sufficient and necessary conditions...');
            pause(5)
            
            % Checks whether entered values satisfying rank matching consitions
            if rank(sys.C*sys.Bw) == rank(sys.Bw)
            disp(' ');
            disp('The rank matching conditions are satisfied');
            else 
            disp('The rank of C*Bw and Bw must be equivalent');
            disp(' ');
            disp('The rank matching conditions are not satisfied, hence observer might show diverging plots');
            end
            
  while(true)
            flag=0;    
        if(rank(obsv(sys.A,sys.C)))==rank(sys.A)   
            disp('OK. The system is observable')
            disp('')
            %break;
        end
            
           eigval=eig(sys.A);
      for i=1:size(sys.A,1)
           if (rank([eigval(i)*eye(size(sys.A, 1))-sys.A;sys.C])~=size(sys.A,1) && real(eigval(i))>=0  )
           flag=1;
            disp('The system is not detectable, please enter A and C again:')
            sys.A=input('Enter A =');
            sys.C=input('Enter C =');
            break;    
           end
      end
      
  if(flag==1)
     continue;
 end
      disp('OK. The system is detectable')
      break;
 
  end
                                              
        otherwise 
            return
    end
  % End of observervers supporting linear dynamical system
    
  % Beginning of observers supporting nonlinear dynamical system
    case '2'
    switch num2str(p.obsv_choice)   
       
       case '1'  % Unknown Input Observer for Nonlinear Systems with Unknown Inputs (w) [Chen-Saif 2006]                                                
       disp(' ');
       disp('This observer supports unknown input w(t) only');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');              %number of control inputs
       sys.dim.nw = input('Enter number of unknown inputs (w): ');              %number of unknown inputs
       sys.dim.nv = 0 ;                                                         %number of disturbances/attack
       sys.dim.nf = input('Enter number of nonlinearities in the system : ');   %number of nonlinearities
            
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
            
             % Checking dimensions of matrix 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
            
             % Checking dimensions of matrix 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
       
            if sys.dim.nw == 0
                sys.w = zeros(sys.dim.nw, 1);
                sys.Bw = zeros(sys.dim.nx, sys.dim.nw);
            else
                sys.w = input('Enter w: ');
                sys.Bw = input('Enter Bw: ');
            end
            
             % Checking dimensions of matrix 'Bw'
            while size(sys.Bw, 2) ~= size(sys.w,1) || size(sys.A, 1) ~= size(sys.Bw, 1) 
                disp('Invalid dimension Of Bw');
                disp(' ');
                sys.Bw = input('Please enter valid dimension Bw: ');
            end
            
                                                    
            if sys.dim.nf == 0
                sys.f = zeros(sys.dim.nf, 1);
                sys.Bf = zeros(sys.dim.nx, sys.dim.nf);
            else
                sys.f = input('Enter nonlinearity in the system f: ');
                sys.Bf = input('Enter Bf: ');
            end
            
            % Checking dimensions of matrix 'Bf'
            while size(sys.Bf, 2) ~= size(sys.f,1) || size(sys.A, 1) ~= size(sys.Bf, 1) 
                disp('Invalid dimension Of Bf');
                disp(' ');
                sys.Bf = input('Please enter valid dimension Bf: ');
            end

            disp('Checking sufficient and necessary conditions...');
            pause(5)
            
            % Checks whether entered values satisfying rank matching consitions
            if rank(sys.C*sys.Bw) == rank(sys.Bw)
            disp(' ');
            disp('The rank matching conditions are satisfied');
            else 
            disp('The rank of C*Bw and Bw must be equivalent');
            disp(' ');
            disp('The rank matching conditions are not satisfied, hence observer might show diverging plots');
            end
            
            
       case '2'    % Observer for One-sided Lipschitz Nonlinear Systems  [Zhang-Su 2012]                                                                 % Zhnag's Observer
       disp(' ');
       disp('This observer neither supports Unknown state disturbance w(t) nor disturbances/attack v(t) ');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');                  %number of control inputs
       sys.dim.nw = 0 ;                                                             %number of unknown inputs
       sys.dim.nv = 0 ;                                                             %number of disturbances/attack
       sys.dim.nf = input('Enter number of nonlinearities in the system : ');       %number of nonlinearities
            
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
            
            % Checking dimensions of matrix 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
            
            % Checking dimensions of matrix 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
            
            if sys.dim.nf == 0
                sys.f = zeros(sys.dim.nf, 1);
                sys.Bf = zeros(sys.dim.nx, sys.dim.nf);
            else
                disp(' ');
                disp('Suppose nonlinear function f(x,u) is assumed to be one-sidedlipschitz');
                disp('there exists $rho$ such that for all $x,z$ ');
                disp('<f(x,u)-f(z,u),x-z> <= $rho$ |x-z|^2' );
                disp('where $rho$ is one sided lipschitz constat');
                disp(' ');
                disp('Suppose nonlinear function f(x,u) is assumed to be quadratically inner-boundedness');
                disp('there exists $delta$ $phi$ such that for all $x,z$ ');
                disp('(f(x,u)-f(z,u))^T (f(x,u)-f(z,u)) <= $delta$ |x-z|^2 + $phi$ <f(x,u)-f(z,u),x-z>'  );
                disp(' ');
                disp('If a function is Lipschitz it is both one-sided Lipschitz and quadratically inner-boundedness ');
                disp(' ');
                sys.f = input('Enter nonlinearity in the system f: ');
                sys.Bf = input('Enter Bf: ');
                disp(' ');
            end
            
            % Checking dimensions of matrix 'Bf'
            while size(sys.Bf, 2) ~= size(sys.f,1) || size(sys.A, 1) ~= size(sys.Bf, 1) 
                disp('Invalid dimension Of Bf');
                disp(' ');
                sys.Bf = input('Please enter valid dimension Bf: ');
                disp(' ');
            end
            
 p.NL_pck = input('Based on nonlinear function, can you estimate the values of Lipschitz parameters mathematically? [Y/N]:','s');
          if p.NL_pck == 'Y'
             sys.rho = input('Enter One-sided Lipschitz constant i.e., $rho$ :');
             disp(' ')
             sys.varphi = input('Enter Lipschitz constant i.e., $phi$ :');
             disp(' ')
             sys.delta = input('Enter Lipschitz constant i.e., $delta$ :');
          
          elseif p.NL_pck == 'N'
              sys.varphi=-100;
              sys.rho=0;
              sys.delta=-99;
          end
            
       case '3'    % Observer for Gloabally Lipschitz Nonlinear Systems [Rajamani 1998]                                                               % Zhnag's Observer
       disp(' ');
       disp('This observer neither supports Unknown state disturbance w(t) nor disturbances/attack v(t) ');
       disp(' ');
       sys.dim.nu = input('Enter number of control inputs (u): ');                  %number of control inputs
       sys.dim.nw = 0 ;                                                             %number of unknown inputs
       sys.dim.nv = 0 ;                                                             %number of disturbances/attack
       sys.dim.nf = input('Enter number of nonlinearities in the system : ');       %number of nonlinearities
            
            if sys.dim.nu == 0
                sys.u = zeros(sys.dim.nu, 1);
                sys.Bu = zeros(sys.dim.nx, sys.dim.nu);
            else
                sys.u = input('Enter u: ');
                sys.Bu = input('Enter Bu: ');
            end
            
            % Checking dimensions of matrix 'Bu'
            while size(sys.Bu, 2) ~= size(sys.u,1) || size(sys.A, 1) ~= size(sys.Bu, 1) 
                disp('Invalid dimension Of Bu');
                disp(' ');
                sys.Bu = input('Please enter valid dimension Bu: ');
            end

            if sys.dim.nu == 0
            sys.Du = zeros(sys.dim.ny, sys.dim.nu);
            else
            sys.Du = input('Enter Du: ');
            end
            
            % Checking dimensions of matrix 'Du'
            while size(sys.Du, 2) ~=  size(sys.u,1) || size(sys.C, 1) ~= size(sys.Du, 1)
                disp('Invalid dimension Of Du');
                disp(' ');
                sys.Du = input('Please enter valid dimension Du: ');
            end
            
            if sys.dim.nf == 0
                sys.f = zeros(sys.dim.nf, 1);
                sys.Bf = zeros(sys.dim.nx, sys.dim.nf);
            else
                disp(' ');
                disp('The nonlinear function f(x) satisfies following property');
                disp('for all $x,z$ there exists $beta$ > 0 such that');
                disp('||f(x)-f(z)|| <= $beta$ ||x-z||' );
                disp(' ');
                disp('Bad estimate of $beta$ might affect the convergence');
                disp(' ');
                sys.f = input('Enter nonlinearity in the system f: ');
                sys.Bf = input('Enter Bf: ');
                disp(' ');
            end
            
            % Checking dimensions of matrix 'Bf'
            while size(sys.Bf, 2) ~= size(sys.f,1) || size(sys.A, 1) ~= size(sys.Bf, 1) 
                disp('Invalid dimension Of Bf');
                disp(' ');
                sys.Bf = input('Please enter valid dimension Bf: ');
                disp(' ');
            end

    p.NL_pck = input('Based on nonlinear function, can you estimate the values of  Lipschitz constant beta mathematically? [Y/N]:','s');
          if p.NL_pck == 'Y'
              disp(' ');
             sys.beta = input('Enter Lipschitz constant i.e., beta :');
             
          
          elseif p.NL_pck == 'N'
              sys.beta = 1;

          end
          
        otherwise
            return
    end


%% Saving customized system into user defined 
disp(' ');
chc = input('Save sys into udef_sys.mat [1 = Yes, 0 = No]? ');
if chc == 1
    save('udef_sys.mat','sys');
    disp('The customized system has been stored in: udef_sys.mat');
    
         
end
end
