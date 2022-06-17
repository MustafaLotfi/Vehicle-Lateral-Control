function q_new=solver(t, q, delta, params)
dt = params.dt;
method = 'r';    % r: runge-kutta, t: taylor expansion
if method == 't'
    qdot = plant(t, q, delta, params);
    q_new = q+dt*qdot;
elseif method == 'r'
    h = dt;
    y = q;
    k1 = plant(t, y, delta, params);
    k2 = plant(t+h/2, y+h*k1/2, delta, params);
    k3 = plant(t+h/2, y+h*k2/2, delta, params);
    k4 = plant(t+h, y+h*k3, delta, params);
    
    y_new = y + h/6*(k1+2*k2+2*k3+k4);
    
    q_new = y_new;
end
