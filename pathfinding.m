tic

CELL_SIZE = 8;

%This value is the size outside each cell will also be veryfied if is
%walkable (prevents from running too close to walls)
CELL_CHECK_BORDER_SIZE = 2;

mask = rgb2gray(imread('ist_gmaps_mask.png'));
%imshow(imread('ist_gmaps_mask.png'));

height = size(mask, 1);
width = size(mask, 2);

num_rows = ceil(height/CELL_SIZE);
num_cols = ceil(width/CELL_SIZE);

walkableCells = zeros(num_rows, num_cols);


%% Marks the cells as walkable or not
for i=1:num_rows
    for j=1:num_cols
        % The upper left edge of this cell
        row_start = max((i-1)*CELL_SIZE + 1 - CELL_CHECK_BORDER_SIZE, 1);
        col_start = max((j-1)*CELL_SIZE + 1 - CELL_CHECK_BORDER_SIZE, 1);
        %The lower right edge of this cell (could be cropped if it's on the edge of the image)
        row_end = min(i*CELL_SIZE + CELL_CHECK_BORDER_SIZE, height);
        col_end = min(j*CELL_SIZE + CELL_CHECK_BORDER_SIZE, width);
        
        average = mean(mean(mask(row_start:row_end, col_start:col_end)));
        if average == 255
            walkableCells(i, j) = 1;
            %patch([col_start, col_end, col_end, col_start], [row_start, row_start, row_end, row_end], 'g', 'FaceAlpha', 0.3);
        end
    end
end

toc

%% Find a path
% path = AStar([130 1], [149 58], walkableCells);
path = AStar([1 1], [149 58], walkableCells);
%path = path(20:end, :);
toc

% %% Path optimization (removes consecutive points if they are in the same direction)
% %directions(i) contains the direction of movement from path(i) to path(i+1)
% directions = path(1:(length(path)-1), :) - path(2:length(path), :);
% % Contains the indices of the points where there is a direction change
% indices_direction_change = find(sum(abs(diff(directions)), 2)) + 1;
% % Stores only the first and those points where there is a direction change
% new_path = path([1; indices_direction_change], :);
%new_path = path;

%% Plot the path
% hold on;
% for i=1:(length(new_path)-1)
%     a = new_path(i, :);
%     b = new_path(i+1, :);
%     
%     plot([(a(2)-1)*CELL_SIZE+CELL_SIZE/2 (b(2)-1)*CELL_SIZE+CELL_SIZE/2], [(a(1)-1)*CELL_SIZE+CELL_SIZE/2  (b(1)-1)*CELL_SIZE+CELL_SIZE/2], 'r');
% end

toc

%% Find best path, by joining non-consecutive waypoints
best_path_indices = [1]; %contains the indices of new_path that form the best path
new_path = [path(1, :)];

current_point = best_path_indices(1);
while current_point < length(path)
    
    
    
    connect_to = current_point+1;
    for i=(current_point+2):length(path)
        %% checks if it can connect point (current_point) to (i)
        can_connect_to_i = can_connect_points((path(current_point, :)-1)*CELL_SIZE+CELL_SIZE/2, (path(i, :)-1)*CELL_SIZE+CELL_SIZE/2, mask);
        if can_connect_to_i
            connect_to = i;
%             a = new_path(current_point, :);
%             b = new_path(connect_to, :);
%             hold on;
%             plot([(a(2)-1)*CELL_SIZE+CELL_SIZE/2 (b(2)-1)*CELL_SIZE+CELL_SIZE/2], [(a(1)-1)*CELL_SIZE+CELL_SIZE/2  (b(1)-1)*CELL_SIZE+CELL_SIZE/2], 'r');
        end
    end
    
    best_path_indices = [best_path_indices connect_to];
    new_path = [new_path; path(connect_to, :)];
    
    %plot
    a = path(current_point, :);
    b = path(connect_to, :);
    hold on;
    plot([(a(2)-1)*CELL_SIZE+CELL_SIZE/2 (b(2)-1)*CELL_SIZE+CELL_SIZE/2], [(a(1)-1)*CELL_SIZE+CELL_SIZE/2  (b(1)-1)*CELL_SIZE+CELL_SIZE/2], 'r', 'Parent', app.Plot);
    
    current_point = connect_to;
end


%% plot
% hold on;
% for i=1:(length(best_path_indices)-1)
%     a = new_path(best_path_indices(i), :);
%     b = new_path(best_path_indices(i+1), :);
%     
%     plot([(a(2)-1)*CELL_SIZE+CELL_SIZE/2 (b(2)-1)*CELL_SIZE+CELL_SIZE/2], [(a(1)-1)*CELL_SIZE+CELL_SIZE/2  (b(1)-1)*CELL_SIZE+CELL_SIZE/2], 'r');
% end

%% TODO:
% O path ainda está em coordenadas das células na grelha. é preciso
% (coord-1)*CELL_SIZE + CELL_SIZE/2 para ter o centro delas nas coordenadas
% da imagem, acho eu.
% Na verdade maybe o melhor é passar para metros

%Depois, pegar na pos real do carro(pode nao estar no centro da celula), e
%ir marcando waypoints onde ele consegue ir corretamente (ver imagem TODO.pdn)
