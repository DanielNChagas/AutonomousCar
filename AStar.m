% Code based on the pseudo-code in https://en.wikipedia.org/wiki/A*_search_algorithm#Pseudocode

function [path] = AStar(start, goal, walkableCells)
%ASTAR Summary of this function goes here
%   Detailed explanation goes here

tentative_gScore = 0;

path = 0;

%List of the cells in the openSet. Matrix where each line has 1 cell's coords
%Sorted by lowest fScore
openSet = [start];

% For node i, j, cameFrom(i, j) is the node immediately preceding it on the cheapest path from start
% to i, j currently known.
cameFrom = zeros(size(walkableCells, 1), size(walkableCells, 2), 2);

gScore = ones(size(walkableCells, 1), size(walkableCells, 2)) * 999999;
gScore(start) = 0;

% For node n, fScore[n] := gScore[n] + h(n). fScore[n] represents our current best guess as to
% how short a path from start to finish can be if it goes through n.
fScore = ones(size(walkableCells, 1), size(walkableCells, 2)) * 999999;
fScore(start) = hFunction(start, goal);

neighborCoords = [[0, 1]; [0, -1]; [1, 0]; [-1, 0]; [1, 1]; [-1, -1]; [1, -1]; [-1, 1]];
neighborWeights = [1 1 1 1 1.4 1.4 1.4 1.4];

%while openSet is not empty
while ~isempty(openSet)
    %The openSet is sorted by lowest f-score
    current = openSet(1, :);
    if current(1) == goal(1) && current(2) == goal(2)
        % We found the path!
        path = reconstruct_path(cameFrom, current);
        break;
    end
    
    openSet(1, :) = [];
    
    for i=1:length(neighborCoords)
        weigth = neighborWeights(i);
        
        neighbor = [current(1)+neighborCoords(i, 1) current(2)+neighborCoords(i, 2)];
        
        if neighbor(1) < 1 || neighbor(1) > size(walkableCells, 1) || neighbor(2) < 1 || neighbor(2) > size(walkableCells, 2) 
            %Invalid coords (out of the map)
            continue;
        end
        
        if ~walkableCells(neighbor(1), neighbor(2))
            %This neighbor is not walkable, ignore it
            continue;
        end
        
        % tentative_gScore is the distance from start to the neighbor through current
        tentative_gScore = gScore(current(1), current(2)) + weigth;
        if tentative_gScore < gScore(neighbor(1), neighbor(2))
            % This path to neighbor is better than any previous one. Record it!
            cameFrom(neighbor(1), neighbor(2), :) = current;
            gScore(neighbor(1), neighbor(2)) = tentative_gScore;
            neighborFScore = gScore(neighbor(1), neighbor(2)) + hFunction(neighbor, goal);
            fScore(neighbor(1), neighbor(2)) = neighborFScore;
            
            
            % remove from open set
            [~, index]=ismember(openSet,[1 2],'rows');
            if index
                openSet(index, :) = [];
            end
            
            %Find where to insert in the openSet, so that it remains sorted
            insertAtIndex = size(openSet, 1);
            
            for j=1:size(openSet, 1)
                c = openSet(j, :);
                
                if fScore(c(1), c(2)) >= neighborFScore
                    % We found node with higher f-Score, insert here
                    insertAtIndex = j-1;
                    break;
                end
            end
            
            %Insert
            openSet = [openSet(1:(insertAtIndex),:); neighbor; openSet(insertAtIndex+1:end,:)];
        end
    end
end


end

function val = hFunction(cell, goal)
    val = sqrt((cell(1)-goal(1))^2 + (cell(2)-goal(2))^2);
    %val = 0;
end

function path = reconstruct_path(cameFrom, current)
    path = current;
    while cameFrom(current(1), current(2), 1) ~= 0 
        current = squeeze(cameFrom(current(1), current(2), :))';
        path = [current; path];
    end
end