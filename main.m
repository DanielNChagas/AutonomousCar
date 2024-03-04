app=app1;
energy_budget = 30000000; current_energy=30000000;
%app = app1;
fig = figure();

%Car dimentions
car_length = 3.332;
car_width = 1.508;
car_wheelbase = 2.2;
car_length_out_wheelbase = car_length - car_wheelbase;
Lr = 0.566;

%  car polygon constructed 
car_polygon = [ -Lr, -car_width/2;
                car_wheelbase + Lr, -car_width/2;
                car_wheelbase + Lr, car_width/2;
                -Lr, car_width/2 ];


imshow(imread('ist_gmaps_mask.png'), 'Parent',app.Plot);
hold(app.Plot, 'on')
% hold on;
pathfinding;
% hold on;
hold(app.Plot, 'on')
[traject,thetaref] = traject_generation(new_path);
traject = traject* 8 + 8/2 - 8;

previous_vt=0;  %velocity from previous time interval (to help compute acceleration)

max_speed=40; %predefined max speed of the car

vmax=max_speed; %Speed that the car shouldn't overtake at a given time

plot(app.Plot, traject(:,2), traject(:,1));
% plot(traject(:,2), traject(:,1));


point=10;

x = traject(1,2);
y = traject(1,1);
theta = thetaref(1);


delta_t = 0.1;

hold on;

skip_stop = 0;

stop_signs = [StopSign([1, 166, 17, 183], [9 182]), ...
              StopSign([1, 300, 17, 320], [9 319])];
speed_limit_signs =[ SpeedLimitSign([1, 25, 20, 125], 20), ...
                      SpeedLimitSign([1, 150, 20, 250], 10)];
plot_stop_signs(stop_signs,speed_limit_signs, app.Plot);
hold(app.Plot, 'on')
% Inside which stop sign the car is. 0 mean none
inside_stop_sign = 0;
% Inside which speed limit sign the car is. 0 mean none
inside_speed_limit_sign = 0;
% If the car is inside the stop, and can move again
stop_sign_car_can_start = 0;

for aaa = 1:2000    
    %% Handle stop signs
    %Detects which stop it's inside of
    inside_index = inside_stop_sign_box(x, y, stop_signs);
    
    if inside_index ~= 0 && inside_stop_sign ~= inside_index
        % Car entered a stop sign box.
        inside_stop_sign = inside_index;
        stop_sign_car_can_start = 0;
    elseif inside_index == 0
        inside_stop_sign = 0;
    end
    
    
    if inside_stop_sign ~= 0
        % Car is inside a stop box
        if vt < 0.1
            % The car has stopped, and now can move again
            stop_sign_car_can_start = 1;
        end
    end
    
    
    
    %Go towards the stop sign if it's inside the box, and it hasn't stopped
    %already (skip_stop)
    go_towards_stop = inside_stop_sign ~= 0 && ~stop_sign_car_can_start;
    
    if go_towards_stop
        %xref = stop_signs(inside_stop_sign).stopping_place(1);
%         dir = 
%         
%         xref = dir(1) * stop_signs(inside_stop_sign).stopping_place(1) + (1-dir(1)) * x;
%         yref = dir(2) * stop_signs(inside_stop_sign).stopping_place(2) + (1-dir(2)) * y;
        xref = x;
        yref = stop_signs(inside_stop_sign).stopping_place(2);
    else
        xref = traject(point,2);
        yref = traject(point,1);
    end
    

    %% Move
    
    J = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
    
%     if go_towards_stop
%         [vt, d, w] = robot_controller(x, y, theta, ...
%             xref, yref, delta_t, J, 0);
%     else
        [vt, d, w] = robot_controller(x, y, theta, ...
            xref, yref, delta_t, J, vmax);
%     end
    acceleration = (vt-previous_vt)/delta_t;
    if abs(acceleration) > 20
        acceleration = 20*sign(acceleration);
        vt = previous_vt + acceleration*delta_t;
    end
    
    [x, y, theta] = robot_model(x, y, theta, ...
        vt, d, w, delta_t, J);
    
%     % Plot the position
%     if mod(aaa, 20) == 0
         %scatter(app.Plot,x, y);
%     end

    if mod(aaa, 5) == 0
        %scatter(app.Plot,x, y);
        hold(app.Plot, 'on')
        plot_car(x,y,theta,car_polygon, app.Plot);
        hold(app.Plot, 'on')
%         scatter(x, y);
         app.velocidade.Value = vt;
        %app.VelocidadeGauge.Value = vt;
    end
    
    treshold_next_traject_point = 80;
    display(vt);
    if ~go_towards_stop
        if(norm(xref-x)^2+norm(yref-y)^2 < treshold_next_traject_point)
            if(point ~= size(traject,1))
                point = point + 20;
            end
        end
    end
    vmax= set_speed_limit(x, y, speed_limit_signs);
    [current_energy,app.energia_out.Value]=energy_consumed(acceleration,vt,delta_t,current_energy,energy_budget);
    previous_vt=vt; %updates previous velocity
    pause(delta_t);
end
