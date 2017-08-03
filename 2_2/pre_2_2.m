function pre_2_2(x0)

% This function mainly used for predefined example
% x0: system initial condition
% xhat0: observer initial condition
% Initial conditions, time of simulation and step size are predefined.
% Calls model_2_2.m to solve system and observer dynamics before plotting
% 't' is time vector and 'z' is solution vector
% Extracts actual and estimated state values
% Plots system states, error dynamics norm and error dynamics 
% Added text to a graph that includes mathematical expressions using LaTeX
% Red dotted lines indicate estimated states and the solid blue line indicates actual states

global h sys

%% Simulating System
fprintf(1, '\n\n');
disp('=== System Initial Conditions ===')

x0 =  [ 0; 1.2 ];
x0

disp(' ');
disp('=== Observer Initial Conditions ===')
xhat0 = [ 0.5; -1.5 ];
xhat0

disp(' ');
tspan = 0:0.01:20;

disp(' ');
disp('Solving ODE...')
[t, z] = ode15s(@model_2_2, tspan, [x0; xhat0], []);
disp('Done!')     

x = z(:, 1:sys.dim.nx);
xhat= z(:,sys.dim.nx+1:end);

disp(' ');
disp('Plotting...')
%Plot states
for k=1:sys.dim.nx
    subplot(ceil(sys.dim.nx/2),2,k)
    plot(t, z(:,k), t,xhat(:,k), 'r--','LineWidth',2.5);
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
    plot(t, z(:,k)-xhat(:,k),'LineWidth',2.5);
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

figure;
plot(t, nor, 'LineWidth',2.5);
grid on
grid minor
xlabel('Time (s)','interpreter','latex','FontSize',fs);
ylabel('$\|x-\hat{x}\|$','interpreter','latex','FontName','Times New Roman','FontSize',fs); 
set(gca,'FontName','Times New Roman','fontsize',fs);
end