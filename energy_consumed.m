% Description: this function computes the energy used in the last tim
% interval updates the energy that is still available
% Inputs:   a - acceleration of the car
%           v - velocity of the car
%           delta_t - time interval
%           E - current energy
% Output:   Energy - updated current energy
function [Energy,Energy_percentage]= energy_consumed(a,v,delta_t, energy_left,energy_budget)
M=810;  %car's mass
Po=5000;   %comsumption TODO: check this value

delta_E=(M*abs(a)*abs(v) + Po) * delta_t;

Energy = energy_left - delta_E;
Energy_percentage = cast(Energy/energy_budget * 100,'int32');

end