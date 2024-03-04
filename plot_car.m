function plot_car(x, y,theta, car_polygon,plot_app)

    x_scale = 0.18107;
    y_scale = 0.21394;
    for p=1:4
        rot_car_polygon(p,:) = ([cos(theta), -sin(theta); sin(theta), cos(theta)]*car_polygon(p,:)')';
    end
    rot_car_polygon=[rot_car_polygon; rot_car_polygon(1,:)];
    plot(rot_car_polygon(:,1)/x_scale+x, rot_car_polygon(:,2)/y_scale+y, 'Parent', plot_app);
end