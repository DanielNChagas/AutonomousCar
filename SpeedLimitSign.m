classdef SpeedLimitSign
    %SPEEDLIMITSIGN Summary of this class goes here
    %   Detailed explanation goes here
    
     properties
        box, % x1 y1 x2 y2 - Box where when the car is inside, it should limit his speed
        speed_limit %max speed that the car should have inside the designated area
    end
    
    methods
        function obj = SpeedLimitSign(boxVal, speed_limitVal)
            obj.box = boxVal;
            obj.speed_limit = speed_limitVal;
        end
        

    end
end