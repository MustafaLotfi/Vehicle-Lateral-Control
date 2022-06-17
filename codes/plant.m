function qdot=plant(t, q, delta, params)
L = params.L;
v = params.v;
qdot = v*[cos(delta+q(3)), sin(delta+q(3)), sin(delta)/L]';
