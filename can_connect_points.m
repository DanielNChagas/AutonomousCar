function [can_connect] = can_connect_points(p1, p2, img)
%CAN_CONNECT_POINTS Summary of this function goes here
%   Detailed explanation goes here


can_connect = 1;

line_raster = bresenham(p1(1), p1(2), p2(1), p2(2));

for i=1:length(line_raster)
    is_walkable = img(line_raster(i, 1), line_raster(i, 2)) > 254 && img(line_raster(i, 1)+3, line_raster(i, 2)) > 254 && img(line_raster(i, 1)-3, line_raster(i, 2)) > 254 && img(line_raster(i, 1), line_raster(i, 2)+3) > 254 && img(line_raster(i, 1), line_raster(i, 2)-3) > 254;
    if ~is_walkable
        % cannot connect points
        can_connect = 0;
        return;
    end
end

% hold on;
% % creates a straight line between the points using Bresenham's line algorithm
% delta_row = p2(1) - p1(1);
% delta_col = p2(2) - p1(2);
% deltaerr = abs(delta_row / delta_col);    % Assume deltax != 0 (line is not vertical)
% error = 0; % No error at start
% if deltaerr < 1
%     y = p1(1);
%     for x=p1(2):p2(2)
%         fill([x, x+1, x+1, x], [y, y, y+1, y+1], 'g');
% 
%         error = error + deltaerr;
%         if error >= 0.5
%             y = y + sign(delta_col);
%             error = error - 1;
%         end
%     end
% else
%     x = p1(2);
%     for y=p1(1):p2(1)
%         fill([x, x+1, x+1, x], [y, y, y+1, y+1], 'g');
% 
%         error = error + 1/deltaerr;
%         if error >= 0.5
%             x = x + sign(delta_row);
%             error = error - 1;
%         end
%     end
% end




end

