function interact_case3()

% This is for pre-defined examples
% Initially displays system and observer dynamics
% Displays pre-defined matrix values
% Next, executes M-file which contains CVX code
% After computing system and observer dynamics, next M-file plots states and error dynamics norm
% 'p.sel_sym' selects either linear dynamical system or nonlinear dynamical system
% 'p.obsv_choice' helps select observer in each category 
% After end of each observer execution .png file flashes on screen which contain details of the respective observer 

global sys p

 %% Choose code corresponding to user choice
    clc; display_header();
    switch num2str(p.sel_sys)
        case '1'
       switch num2str(p.obsv_choice)
        case '1'  %Luenberger Observer for Nominal LTI Systems [Luenberger 1966]
            disp_1_1();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_1_1();
            run_1_1();                      % simulate observer
            pre_1_1([]);                    % plot observer simulation results
            figure, imshow('1-1.png');

            
        case '2' %Robust Observer for LTI Systems with Unknown Inputs [Scherer-Weiland 2000]
            disp_1_2();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_1_2();
            run_1_2();                     % simulate observer
            pre_1_2([]);               % plot observer simulation results   
            figure, imshow('1-2.png');
        
        case '3' % Unknown Input Observer for LTI Systems with Unknown Inputs (1) [Chakrabarty-Sundaram 2016]
            disp_1_3();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_1_3();
            run_1_3();                        % simulate observer
            pre_1_3([]);                % plot observer simulation results
            figure, imshow('1-3.png');

       case '4' % L-Infinity Observer with Unknown Inputs (w) and (v) [Chakrabarty-Coreless 2016]
            disp_1_4();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_1_4();
            run_1_4();                     % simulate observer
            pre_1_4([]);                 % plot observer simulation results
            figure, imshow('1-4.png');
            
        case '5'  % Unknown Input Observer for LTI Systems with Unknown Inputs (2)(w) [Chen-Saif 2006]
            disp_1_5();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_1_5();
            run_1_5(); 
            pre_1_5([]);  
            figure, imshow('1-5.png');
            
        case '6'  % Unknown Input Sliding Mode Observer for LTI Systems with Unknown Inputs (w) [Hui-Zak 2005]
            disp_1_6();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_1_6();
            run_1_6(); 
            pre_1_6([]); 
            figure, imshow('1-6.png');
            
        case '7' % Robust Observer for Uncertain LTI Systems with Unknown Inputs (w) [Corless-Tu 1998]
            disp_1_7();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_1_7();
            run_1_7(); 
            pre_1_7([]);
            figure, imshow('1-7.png');

          otherwise
            return
        end     
            
 case '2'
    switch num2str(p.obsv_choice)   
        case '1'  % Unknown Input Observer for Nonlinear Systems with Unknown Inputs (w) [Chen-Saif 2006] 
            disp_2_1();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_2_1();
            run_2_1(); 
            pre_2_1([]);
            figure, imshow('2-1.png');
            
        case '2'   % Observer for One-sided Lipschitz Nonlinear Systems  [Zhang-Su 2012]
            disp_2_2();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_2_2();
            run_2_2(); 
            pre_2_2([]);      
            figure, imshow('2-2.png');
            
              
        case '3'  % Observer for Gloabally Lipschitz Nonlinear Systems [Rajamani 1998] 
            disp_2_3();
            disp('------------------------ LOADING SYSTEM ------------------------'); 
            sys = example_2_3();
            run_2_3(); 
            pre_2_3([]); 
            figure, imshow('2-3.png');
   
        otherwise
            return
    end        
    end