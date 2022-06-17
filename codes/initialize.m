function init_params=initialize(user_params)
%% Problem parameters and variables
% System
L = user_params.L;
v = user_params.v;

% Initial conditions
x0 = user_params.x0;
y0 = user_params.y0;
theta0 = user_params.theta0;

% Constraints
delta_min = user_params.delta_min;
delta_max = user_params.delta_max;

% Simulation
dt = 0.05;
t_vec = 0;

% Initilization
x_ref = linspace(0, 10, 1000);
y_ref = sin(x_ref);
q_mat = [x0, y0, theta0]';
delta_vec = 0;
err_vec = 0;
err_mat = [];

init_params.L = L;
init_params.v = v;
init_params.delta_min = delta_min;
init_params.delta_max = delta_max;
init_params.dt = dt;
init_params.t_vec = t_vec;
init_params.x_ref = x_ref;
init_params.y_ref = y_ref;
init_params.q_mat = q_mat;
init_params.delta_vec = delta_vec;
init_params.err_vec = err_vec;
init_params.err_mat = err_mat;