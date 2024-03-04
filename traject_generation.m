function [traject, theta] = traject_generation(path)

n = size(path,1);        % number of via points from the generated path, including initial and final
n_via = 0:1:n-1;
time = [0:0.01:n-1];

%pchip interpolation
xx = pchip(n_via,path(:,1),time);
yy = pchip(n_via,path(:,2),time);

%traject generated
traject=[xx', yy'];
theta= zeros(1,size(xx,2));
for i=1:size(xx,2)-1
    theta(i)=atan2(xx(i+1)-xx(i),yy(i+1)-yy(i));
end
end