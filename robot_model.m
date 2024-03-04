function [x, y, theta] = robot_model(x, y, theta, vt, d, w, delta_t, J)
%ROBOT_MODEL Summary of this function goes here
%   Detailed explanation goes here
pos_ori = [x; y; theta] + delta_t*J* [vt; d; w];
x = pos_ori(1);
y = pos_ori(2);
theta = pos_ori(3);
end

