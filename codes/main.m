%% Project Information
%%% Vehicle Lateral Control
%%% Programmer: Mostafa Lotfi
%%% Date: 5/5/2022
%%% Matlab version: 2021a
%%% Brief description: In this project, lateral movement of a vehicle
%%% (a nonholonomic robot) has been controlled. A harmonic path has been
%%% considered as the trajectory of the robot in the 2D space.
%%% The robot model is a simple bicycle model which is
%%% suitable when the velocity is lower than 15 km/h. The controller is a
%%% modified PID. To find the best PID gains, a Gradient Descent
%%% Optimization Algorithm was utilized.
clc;
clear;
close all;

%% User parameters
find_best_coefs = false;
default_coefs = [65, 71, 2];    % [65, 71, 2] is a good set
dynamic_plot = true;

L = 0.2;        % Rear and front axes distances
v = 0.1;        % Longitudinal velocities
x0 = 0.5;       % Initial position in horizontal direction
y0 = 0;         % Initial position in vertical direction
theta0 = 0;     % Initial robot head angle
delta_min = -pi/4;  % Lower bound for steering wheel
delta_max = pi/4;   % Upper bound for steering whell

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
    lb_val = -10;   % Lower bound for coefficients
    ub_val = 100;   % Upper bound for coefficients
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