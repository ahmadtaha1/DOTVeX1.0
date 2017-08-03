% Authors: Dr. Ahmad F Taha, Dr. Ankush Chakrabarty, and Raviraj Tavaragondi
% Last edited: March 16, 2017

% This is the main Matlab M-file that users run in the beginning 
% Adds necessary path and displays header before moving onto selections
% 'p.sel_sym' selects either linear dynamical system or nonlinear dynamical system
% 'p.obsv_choice' helps select observer in each category 
% 'p.user_choice' helps select options between pre-defined, custom based dynamics and user-defined systems

clc; close all; clear;
global p 
add_all_paths(); % adding necessary paths
display_header(); %displaying header 

%% Choose custom/pre-define
fprintf(1, '\nDesign estimator for a:\n\n');
fprintf(1, '[1] Custom dynamical system \n[2] Load udef_sys.mat \n[3] Pre-defined example\n\n');
p.user_choice = input('Enter 1--3: ');

while p.user_choice ~= (1:3)
    disp('Please enter appropriate choice');
    disp(' ');
    p.user_choice = input('Enter 1--3: ');
end

clc;
display_header();
%% choose Linear/Nonliner system
fprintf(1,'\nChoose a system:\n\n');
fprintf(1, '[1] Linear dynamical system \n[2] Nonlinear dynamical system\n\n');
p.sel_sys = input('Enter 1--2: ');

while p.sel_sys ~= (1:2)
    disp('Please enter appropriate choice');
    disp(' ');
    p.sel_sys = input('Enter 1--2: ');
end

clc;
display_header();
switch num2str(p.sel_sys)
    case '1'
         str_obsv_chc = print_table();
    cont_str = 'n'; % initialize table dialog
    while strcmp(cont_str, 'N') || strcmp(cont_str, 'n')
        for k = 1:length(str_obsv_chc)
            disp(['[', num2str(k), '] ', str_obsv_chc{k}]);
        end
        disp(' ');

    disp(' ');
    p.obsv_choice = input('Enter observer class [1 -- 7]: ');
    disp(['You have chosen: ', str_obsv_chc{p.obsv_choice}]);
    disp(' ');
    cont_str = 'y'; % input('Continue? [y/n] ', 's');

    end
    clear cont_str
    clear temp
    
    
    case '2'
       str_obsv_chc = print_tableNLS();
    cont_str = 'n'; % initialize table dialog
    while strcmp(cont_str, 'N') || strcmp(cont_str, 'n')
        for k = 1:length(str_obsv_chc)
            disp(['[', num2str(k), '] ', str_obsv_chc{k}]);
        end
        disp(' ');

    disp(' ');
    p.obsv_choice = input('Enter observer class [1 -- 3]: ');
    disp(['You have chosen: ', str_obsv_chc{p.obsv_choice}]);
    disp(' ');
    cont_str = 'y'; % input('Continue? [y/n] ', 's');

    end
    clear cont_str
    clear temp  
        
    otherwise 
        return
end

        
clc; 
display_header();
switch num2str(p.user_choice)
    %% Custom System
    case '1'
        udef_sys = input_the_sys();
         disp(' '), interact_case1(udef_sys);
     %% User-defined system
    case '2'
        disp(' '), interact_case2();
    %% Pre defined examples
    case'3'
        disp(' '), interact_case3();
end 


        