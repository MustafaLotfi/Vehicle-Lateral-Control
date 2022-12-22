function sim_plots(vars, dynamic_plot)
t_vec = vars.t_vec;
q_mat = vars.q_mat;
delta_vec = vars.delta_vec;
err_vec = vars.err_vec;
x_ref = vars.x_ref;
y_ref = vars.y_ref;
L = vars.L;

figure(1)
plot(x_ref, y_ref, 'g', "LineWidth", 8, "DisplayName", "Reference Path")
hold on
plot(q_mat(1,1), q_mat(2,1), 'pb', "DisplayName", "Start")
plot(q_mat(1,end), q_mat(2,end), 'or', "DisplayName", "End")
plot(q_mat(1,:), q_mat(2,:), "DisplayName", "Vehicle Path")
legend show
axis equal
xlabel("x (m)")
ylabel("y (m)")
title("Static trajectory of vehicle, controlled by PID")

figure(2)
plot(t_vec, delta_vec*180/pi)
xlabel("t (sec)")
ylabel("\delta (degree)")
title("Input: Steering wheel")

figure(3)
plot(t_vec, err_vec)
xlabel("t (sec)")
ylabel("Trajectory error (m)")

% Dynamic plot
if dynamic_plot
    for i=1:size(q_mat,2)
        figure(4)
        plot(x_ref, y_ref, 'g', "LineWidth", 20)
        axis equal
        hold on
        plot([q_mat(1,i),q_mat(1,i)+L*cos(q_mat(3,i))],[q_mat(2,i),...
            q_mat(2,i)+L*sin(q_mat(3,i))],...
            'b', "LineWidth",8)
        hold off
        pause(0.00001)
    end
end