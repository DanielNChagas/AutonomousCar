function [vt, d, w] = robot_controller(x, y, theta, xref, yref, delta_t, J,vmax, reference_theta)
%ROBOT_CONTROLLER Summary of this function goes here
%   Detailed explanation goes here

% delta_t 1
% K1 = 0.5;
% K2 = 0.5;
% K3 = 0.4;

% delta_t 0.25
% K1 = 0.25;
% K2 = 0.25;
% K3 = 0.2;

K1 = 2*delta_t;
K2 = 2*delta_t;
K3 = 3*delta_t;
K = [K1 0 0; 0 K2 0; 0 0 K3]/delta_t;

if exist('reference_theta','var')
    thetaref = reference_theta;
else
    thetaref = atan2(yref - y, xref - x);
end

%Inverse robot Model
controls = J\(K*[xref-x; yref-y; thetaref-theta]);
vt = min(controls(1), vmax);
d = 0;%controls(2);
w = controls(3);

end

