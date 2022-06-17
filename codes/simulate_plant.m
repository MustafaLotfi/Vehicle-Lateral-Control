function vars=simulate_plant(coefs, user_params)
init_params=initialize(user_params);
L = init_params.L;
v = init_params.v;
delta_min = init_params.delta_min;
delta_max = init_params.delta_max;
dt = init_params.dt;
t_vec = init_params.t_vec;
x_ref = init_params.x_ref;
y_ref = init_params.y_ref;
q_mat = init_params.q_mat;
delta_vec = init_params.delta_vec;
err_vec = init_params.err_vec;
err_mat = init_params.err_mat;

params.L = L;
params.v = v;
params.dt = dt;

% Controller
kp = coefs(1);
kd = coefs(2);
ki = coefs(3);
%% Simulation Loop
i = 1;
while true
    [err, nearest_arg]=find_distance(q_mat(1,end), q_mat(2,end),...
        x_ref, y_ref);
    if nearest_arg == numel(x_ref)
        break
    end
    
    % Input (Steering wheel)
    coef1 = y_ref(nearest_arg) - q_mat(2,end);
    err_pid = [err, (err-err_vec(end))/dt, dt*trapz(err_vec)]';
    delta = coef1*(kp*err_pid(1)+kd*err_pid(2)+ki*err_pid(3));
    
    % Constraints
    if delta < delta_min
        delta = delta_min;
    elseif delta > delta_max
        delta = delta_max;
    end
    
    % solve state equation
    q_new = solver(t_vec(end), q_mat(:, end), delta, params);
    
    t_vec = [t_vec, t_vec(end)+dt];
    q_mat = [q_mat, q_new];
    delta_vec = [delta_vec, delta];
    err_vec = [err_vec, err];
    err_mat = [err_mat, err_pid];

    % Uregent Stopping
    if i == 10000
        break
    end
    i = i + 1;
end

vars.t_vec = t_vec;
vars.q_mat = q_mat;
vars.delta_vec = delta_vec;
vars.err_vec = err_vec;
vars.x_ref = x_ref;
vars.y_ref = y_ref;
vars.L = L;