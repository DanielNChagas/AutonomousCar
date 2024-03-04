classdef StopSign
    %STOPSIGN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        box, % x1 y1 x2 y2 - Box where when the car is inside, it should stop
        stopping_place, % Position where the car should stop 
        
        % trigger_velocity, % The velocity at which the car will trigger the stop (0 = always stopped)
        % active_duration, % How long it will stay active
        % triggered_time, % When it was triggered in the simulation
        % active % If it is 
    end
    
    methods
        function obj = StopSign(boxVal, stopping_placeVal)
            obj.box = boxVal;
            obj.stopping_place = stopping_placeVal;
        end
        
%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end

