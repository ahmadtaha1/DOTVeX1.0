function []=detectability()
global sys

while(true)
flag=0;    
if(rank(obsv(sys.A,sys.C))==size(sys.A,1))   %need check
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
