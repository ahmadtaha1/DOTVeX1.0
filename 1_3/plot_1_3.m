function plot_1_3(x0)

% This function mainly used for user-defined and custom based dynamic systems
% x0: system initial condition
% xhat0: observer initial condition
% Default initial conditions are generated using the random key
% [Y/N] is case sensitive, please make an appropriate selection
% Users are allowed to enter initial conditions, time of simulation and step size of their choice
% Checks dimension of system and observer initial conditions i.e., x0 and xhat0
% 'tend' stores time of simulation
% 'deg' stores step size

% Calls model_1_3.m to solve system and observer dynamics before plotting
% 't' is time vector and 'z' is solution vector
% Extracts actual and estimated state values
% Plots system states, error dynamics norm, error dynamics, and unknown input
% Font size, font style, line width are predefined
% Added text to a graph that includes mathematical expressions using LaTeX
% Red dotted lines indicate estimated states and the solid blue line indicates actual states 

% Tests error dynamics norm plot to check whether plot is converging or not
% Change 'threshold' value based on the requirements
% boundary_point is the end value of the error dynamics norm
% This is not a tool to determine the accuracy of the plots
% Only upper bound is set

global h sys p

%% Simulating System
fprintf(1, '\n\n');
disp('=== Initial Conditions ===')
disp(' ')

%Initial conditions can be either default or specified
p.pck = input('Use default initial conditions ? [Y/N]:','s');
disp(' ')
if p.pck == 'Y'
x0 = 100*randn(sys.dim.nx, 1);
disp(' ')
xhat0 = zeros(sys.dim.nx,1);
disp(' ');

elseif p.pck == 'N'
    x0 = input('Enter system initial conditions :')
    disp(' ')
    xhat0 = input('Enter observer initial conditions :')
end

while size(x0,1) ~= size(sys.A, 1)
        disp('Invalid dimension of x0');
        disp(' ');
        x0 = input( 'Please enter valid dimension of x0: ');
end

while size(xhat0,1) ~= size(sys.A, 1)
        disp('Invalid dimension of xhat0');
        disp(' ');
        xhat0 = input( 'Please enter valid dimension of xhat0: ');
 end
x0
xhat0 

%Specifying time span 
disp(' ');
tend = input('Enter Time of Simulation: ');

%Specifying step size
disp(' ');
deg = input('Enter step size: ');
tspan = 0: deg: tend;

disp(' ');
disp('Solving ODE...')
[t, z] = ode15s(@model_1_3, tspan, [x0; xhat0], []);  % solving ODE's through ode suit
disp('Done!')     

%Extracting actual and estimated states values 
x = z(:, 1:sys.dim.nx);
xhat= z(:,sys.dim.nx+1:end);

%Plotting begings from here
disp(' ');
disp('Plotting...')

%Plot states
for k=1:sys.dim.nx
    subplot(ceil(sys.dim.nx/2),2,k)
    plot(t, x(:,k), t,xhat(:,k), 'r--','LineWidth',2.5);
    grid on
    grid minor
    fs=16;
    %% plot setting  "$x_$4$-\hat{x}$4
    xlabel('Time (s)','FontName','Times New Roman','FontSize',fs);
    ylabel(['$x_',num2str(k),'(t)$'],'interpreter','latex','FontSize',16); 
    set(gca,'FontName','Times New Roman','fontsize',fs);
    h = legend('Actual','Estimated','Location','northeast');
    set(h,'Fontsize',fs)
end

%% Plot Error
fs=16;
figure;
for k=1:sys.dim.nx
    subplot(ceil(sys.dim.nx/2),2,k)    
    plot(t, x(:,k)-xhat(:,k),'LineWidth',2.5);
    grid on
    grid minor
    xlabel('Time (s)','interpreter','latex','FontSize',fs);
    ylabel(['$x_',num2str(k),'(t)','-\hat{x}_',num2str(k),'(t)$'],...
        'interpreter','latex','FontSize',16); 
    set(gca,'FontName','Times New Roman','fontsize',fs);
end

% Plot Error norm
ts = size(x, 1);
e = zeros(ts, sys.dim.nx);
nor = zeros(ts, 1);
for k=1:ts
    e(k,:) = x(k,:) - xhat(k,:);
    nor(k) = norm(e(k,:));    
end

%Plot unknown state disturbance
for k = 1:sys.dim.nw
    figure;
    plot(t, eval(sys.w{k}), 'linewidth', 2.5);
    grid on
    grid minor
    xlabel('Time (s)','interpreter','latex','FontSize',fs);
    ylabel(['$w_',num2str(k),'(t)$'],'interpreter','latex','FontName','Times New Roman','FontSize',fs); 
    set(gca,'FontName','Times New Roman','fontsize',fs);
end

figure;
plot(t, nor, 'LineWidth', 2.5);
grid on
grid minor
xlabel('Time (s)','interpreter','latex','FontSize',fs);
ylabel('$\|x-\hat{x}\|$','interpreter','latex','FontName','Times New Roman','FontSize',fs); 
set(gca,'FontName','Times New Roman','fontsize',fs);

%% Checking accurate plots
threshold = 5;
t_final = find(t==tend);
boundary_point = nor(t_final);

if boundary_point > threshold
    disp(' ');
    disp('The assigned observer failed to accurately estimate the states');
else
    disp(' ');
    disp('The assigned observer accurately estimated the states');
end

%Saving all data into a .mat file
%Saving workspace with current date and time as filename
disp(' ');
r = datestr(clock,0);
disp(['Saving data into file name ', r]);
save ([r(1:11),'-',r(13:14),'-',r(16:17),'-',r(19:20)]);
disp(' ');
disp('Done!');

end