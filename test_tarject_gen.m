% define the reference trajectory
figure(1)
% clf

imshow(imread('ist_gmaps_mask.png'));
hold on
x_scale = 0.18107;
disp(['xx scale factor ', num2str(x_scale), ' meters/pixel']);


y_scale = 0.21394;
disp(['yy scale factor ', num2str(y_scale), ' meters/pixel']);

disp('use the mouse to input the world frame origin');
% [xx_org, yy_org, button] = ginput(1);
xx_org = 235;
yy_org = 258;
disp(['world frame origin at image coordinates ', num2str(xx_org), ' ', num2str(yy_org)]);

disp('use the mouse to input via points for the reference trajectory');
disp('--button 3-- to end the input');
button = 1;
k = 1;
while button==1,
    [x(k),y(k),button] = ginput(1);
    plot(x(k),y(k),'r+')
    k = k + 1;
end
drawnow;
disp([ num2str(k-1), ' points to interpolate from '])

trajet=traject_generation([x',y'])

plot(trajet(:,1),trajet(:,2))


