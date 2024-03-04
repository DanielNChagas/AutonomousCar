classdef PedestrianCrossing
    %PedestrianCrossing Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position, % [x1,y1] and [x2,y2] - Starting and ending position of the crossing 
        start_crossing, %Time (in seconds) when the pedestrian starts crossing
        duration, %Duration of the crossing (in seconds)
        

    end
    
    methods
        function obj = StopSign(position, start_crossing, duration)
            obj.position = position;
            obj.start_crossing = start_crossing;
            obj.duration = duration;
        end
        
    end
end