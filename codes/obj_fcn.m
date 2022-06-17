function cost=obj_fcn(coefs, user_params)
sim_vars = simulate_plant(coefs, user_params);
q_mat = sim_vars.q_mat;
delta_vec = sim_vars.delta_vec;
err_vec = sim_vars.err_vec;
x_ref = sim_vars.x_ref;
y_ref = sim_vars.y_ref;

delta_mean_abs = sum(abs(delta_vec))/numel(delta_vec);
cost = sum(abs(err_vec))/numel(err_vec)+delta_mean_abs;

dist_r2start = sqrt((q_mat(1,end)-x_ref(1))^2+(q_mat(2,end)-y_ref(1))^2);
dist_r2end = sqrt((q_mat(1,end)-x_ref(end))^2+(q_mat(2,end)-y_ref(end))^2);

if dist_r2start < dist_r2end
    cost = 10000 * cost;
end