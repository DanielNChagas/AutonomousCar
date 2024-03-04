function [max_speed] = set_speed_limit(x, y, speed_limit_signs, max_speed)
    max_speed=40; %predefined max speed of the car
    
    %iterates every speed limit sing and check if the car is inside theire
    %area
    for i=1:length(speed_limit_signs)   
        inside_box = x >= speed_limit_signs(i).box(1) && x <= speed_limit_signs(i).box(3) && y >= speed_limit_signs(i).box(2) && y <= speed_limit_signs(i).box(4);
        
        %the second condition is for when the car is inside more than one
        %speed limit sign it chooses the one with less speed limit
        if inside_box && speed_limit_signs(i).speed_limit < max_speed
            max_speed = speed_limit_signs(i).speed_limit;
        end
        
    end
    
end