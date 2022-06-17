function [dist, dist_arg]=find_distance(x, y, x_ref, y_ref)
[dist, dist_arg] = min(sqrt(sum([x-x_ref;y-y_ref].^2)));