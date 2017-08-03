function pre_1_6(x0)

% This function mainly used for predefined example
% x0: system initial condition
% xhat0: observer initial condition
% Initial conditions, time of simulation and step size are predefined
% Calls model_1_6.m to solve system and observer dynamics before plotting
% 't' is time vector and 'z' is solution vector
% Extracts actual and estimated state values
% Plots system states, error dynamics norm, error dynamics, and unknown input
% Font size, font style, line width are predefined
% Added text to a graph that includes mathematical expressions using LaTeX
% Red dotted lines indicate estimated states and the solid blue line indicates actual states

global h sys 

%% Simulating System
fprintf(1, '\n\n');

%Specifying initial conditions for system and observer
disp('=== System Initial Conditions ===')

x0 = [ 303.4923; 72.5404; -6.3055; 71.4743; -20.4966 ];
x0

disp(' ');
disp('=== Observer Initial Conditions ===')
xhat0 = [0;0;0;0;0];
xhat0

%Specifying time span
disp(' ');
tspan = 0:0.01:5;


disp(' ');
disp('Solving ODE...')
[t, z] = ode15s(@model_1_6, tspan, [x0; xhat0], []); %Solving ODE's through ode suit
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

%Plot unknwon state disturbance
for k = 1:sys.dim.nw
    figure;
    plot(t, eval(sys.w{k}), 'linewidth', 2.5);
    grid on
    grid minor
    xlabel('Time (s)','interpreter','latex','FontSize',fs);
    ylabel(['$w_',num2str(k),'(t)$'],'interpreter','latex','FontSize',fs); 
    set(gca,'FontName','Times New Roman','fontsize',fs);
end

figure;
plot(t, nor, 'LineWidth', 2.5);
grid on
grid minor
xlabel('Time (s)','interpreter','latex','FontSize',fs);
ylabel('$\|x-\hat{x}\|$','interpreter','latex','FontName','Times New Roman','FontSize',fs); 
set(gca,'FontName','Times New Roman','fontsize',fs);
end