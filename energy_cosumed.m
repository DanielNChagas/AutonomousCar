% Description: this function computes the energy used in the last tim
% interval updates the energy that is still available
% Inputs:   a - acceleration of the car
%           v - velocity of the car
%           delta_t - time interval
%           E - current energy
% Output:   Energy - updated current energy
function [Energy]= energy_cosumed(a,v,delta_t, E)
M=810;  %car's mass
Po=1;   %comsumption TODO: check this value

delta_E=(M*abs(a)*abs(v) + Po) * delta_t;

Energy = E - delta_E;
end