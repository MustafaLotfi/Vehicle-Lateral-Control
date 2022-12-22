%% Project Information
% Trajectory tracking of a vehicle using PID Controller
% Programmer: Mostafa Lotfi
clc;
clear;
close all;

%% User parameters
find_best_coefs = false;
default_coefs = [65, 71, 2];    % [65, 71, 2] is a good set
dynamic_plot = true;

L = 0.2;
v = 0.1;
x0 = 0.5;
y0 = 0;
theta0 = 0;
delta_min = -pi/4;
delta_max = pi/4;

% Gathering data
user_params.x0 = x0;
user_params.y0 = y0;
user_params.theta0 = theta0;
user_params.L = L;
user_params.v = v;
user_params.delta_min = delta_min;
user_params.delta_max = delta_max;

if find_best_coefs
    %% Start of optimization
    % Objective function and constraints
    lb_val = -10;
    ub_val = 100;
    lb = ones(1, 3)*lb_val;
    ub=ones(1, 3)*ub_val;
    nvar=numel(lb);
    %% Optimization
    k0=lb+rand(1,nvar).*(ub-lb);
    final_obj_func = @(k) obj_fcn(k, user_params);
    options=optimoptions('fmincon','Display','iter','Algorithm',...
        'sqp','MaxIterations',10);
    coefs=fmincon(final_obj_func,k0,[],[],[],[],lb,ub,[],options);
else
    coefs = default_coefs;
end

%% Showing results
disp('controller coefficients: ')
disp(coefs)

vars = simulate_plant(coefs, user_params);
sim_plots(vars, dynamic_plot)