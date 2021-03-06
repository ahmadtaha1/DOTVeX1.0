function latexit(A, dp)

% April 11, 2015
% Author: Ankush Chakrabarty, Purdue University, ECE

% Variable List
% A: arbitrary matrix
% dp: the number of decimal places to be displayed
%
% USAGE:
% Suppose we have a matrix A = [2.3343 3.4029; 1.003 0.003; 1.3452 2.3334]
% and we want LaTeX code for the same with only 2 decimal places.
% Then input-> latexit(A, 2)
% Output = \begin{bmatrix} 2.33 & 3.40 \\ 1.00 & 0.00 \\ 1.34 & 2.33 \end{bmatrix}

A = (round(10^dp.*A)/10^dp);
disp('\begin{bmatrix}')

for i=1:size(A,1)
    for j=1:size(A,2)-1
        fprintf(1, '%g & ', A(i,j));
    end
    if size(A,2)==1
        fprintf(1, '%g \\\\ \n', A(i,1));
    elseif size(A,1)==1
        fprintf(1, '%g \n', A(i,j+1));
    else
        fprintf(1, '%g \\\\ \n', A(i,j+1));
    end
end

disp('\end{bmatrix}')
