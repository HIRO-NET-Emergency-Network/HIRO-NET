function [selected_path,G,GLP,flight_time] = updateGreedyLongestPath(REWARDS,FT_BASE,N_poi,FT_POI,oldPath,visitedPoIs,removedPoIs,residual_FT,MAX_FLIGHT_TIME,x_drone,y_drone,x_poi,y_poi,speed_on_scaled_map,nextPoI)
%COMPUTEGREEDYLONGESTPATH Summary of this function goes here
%   Detailed explanation goes here
exhausted = false;

% Check if the removed PoIs are in the path, otherwise return the old path
% with no changes
[~,indexContains] = ismember(removedPoIs,oldPath);

% Compute flight time to reach each PoI from the current position (x_drone,y_drone)
FT_POI_FROM_CURRENT_POSITION = sqrt((x_drone-x_poi).^2+(y_drone-y_poi).^2)./speed_on_scaled_map;

if sum(indexContains) > 0 && sum(visitedPoIs>0)<N_poi
    % First Removed PoI (must not be already visited)
    indexContains (indexContains==0) = [];
    indexNextPoIOnOldPath = find(oldPath == nextPoI);
    
    % Use i to reuse the old code
    i = indexNextPoIOnOldPath;
    
    selected_path = oldPath(1:i-1);
%     
    % Set negative rewards for visited or removed PoIs
    REWARDS(visitedPoIs) = -10;
    REWARDS(removedPoIs) = -10;
    
    while ~exhausted
        
        if i == indexNextPoIOnOldPath % Need to decide the next PoI when the drone is somewhere on the map at (x_drone,y_drone)
            evaluationarray = [REWARDS./FT_POI_FROM_CURRENT_POSITION (1:N_poi)']; % Define array of scores
            evaluationarray(selected_path,:) = []; % Remove visited nodes
            evaluationarray(find(evaluationarray<0),:) = [];
            evaluationarray = sortrows(evaluationarray,1,'descend'); % Sort them in descending order
            
            selected_poi = [];
            
            while ~isempty(evaluationarray) && isempty(selected_poi) % Check that the removal process has not removed all PoIs from the list
                % Pick the best which satisfy the flight time constraint
                if residual_FT - FT_POI_FROM_CURRENT_POSITION(evaluationarray(1,2)) - FT_BASE(evaluationarray(1,2)) < 0 % Check if the time to get there and go back is positive (IT WONT NEVER HAPPEN THOUGH)
                    evaluationarray(1,:) = []; % Remove PoI as unfeasible
                else
                    selected_poi = evaluationarray(1,2); % Pick the best
                end
            end
            if isempty(evaluationarray)
                exhausted = true;
            else
                residual_FT = residual_FT - FT_POI_FROM_CURRENT_POSITION(selected_poi); % Remove Flight Time from residual time
                selected_path = [selected_path; selected_poi]; % Add Selected node to the path
            end
        else
            evaluationarray = [REWARDS./FT_POI(:,selected_path(i-1)) (1:N_poi)']; % Define array of scores from current node
            evaluationarray(selected_path,:) = []; % Remove visited nodes
            evaluationarray(find(evaluationarray<0),:) = [];
            evaluationarray = sortrows(evaluationarray,1,'descend'); % Sort them in descending order
            
            selected_poi = [];
            
            while ~isempty(evaluationarray) && isempty(selected_poi) % Check that the removal process has not removed all PoIs from the list
                % Pick the best which satisfy the flight time constraint
                if residual_FT - FT_POI(evaluationarray(1,2),selected_path(i-1)) - FT_BASE(evaluationarray(1,2)) < 0
                    evaluationarray(1,:) = []; % Remove PoI as unfeasible
                else
                    selected_poi = evaluationarray(1,2); % Pick the best
                end
            end
            if isempty(evaluationarray)
                exhausted = true;
            else
                residual_FT = residual_FT - FT_POI(evaluationarray(1,2),selected_path(i-1)); % Remove Flight Time from residual time
                selected_path = [selected_path; selected_poi]; % Add Selected node to the path
            end
        end
        
        i = i + 1;
        
        if length(selected_path) == N_poi
            exhausted = true;
        end
        
    end
    
    % Remember that we have not yet removed the FT to reach the base again
    residual_FT = residual_FT - FT_BASE(selected_path(length(selected_path)));
    flight_time = MAX_FLIGHT_TIME - residual_FT;
    
else
    selected_path = oldPath;
end

% Generate the graph from the flight plan, it can be plotted easily
[G,GLP] = generateGraphsFromPath(N_poi,selected_path);

end

