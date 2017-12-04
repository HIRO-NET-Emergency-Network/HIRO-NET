function [selected_path,G,GLP,flight_time] = computeGreedyLongestPath(REWARDS,FT_BASE,N_poi,FT_POI,MAX_FLIGHT_TIME)
%COMPUTEGREEDYLONGESTPATH Summary of this function goes here
%   Detailed explanation goes here
exhausted = false;
selected_path = [];
i = 1;
residual_FT = MAX_FLIGHT_TIME;

while ~exhausted
    
    if i == 1 % Need to decide the first PoI
        evaluationarray = [REWARDS./FT_BASE (1:N_poi)']; % Define array of scores
        evaluationarray = sortrows(evaluationarray,1,'descend'); % Sort them in descending order
        
        selected_poi = [];
        
        while ~isempty(evaluationarray) && isempty(selected_poi) % Check that the removal process has not removed all PoIs from the list
            % Pick the best which satisfy the flight time constraint
            if residual_FT - FT_BASE(evaluationarray(1,2)) - FT_BASE(evaluationarray(1,2)) < 0 % Check if the time to get there and go back is positive (IT WONT NEVER HAPPEN THOUGH)
                evaluationarray(1,:) = []; % Remove PoI as unfeasible
            else
                selected_poi = evaluationarray(1,2); % Pick the best
            end
        end
        if isempty(evaluationarray)
            exhausted = true;
        else
            residual_FT = residual_FT - FT_BASE(selected_poi); % Remove Flight Time from residual time
            selected_path = [selected_path; selected_poi]; % Add Selected node to the path
        end
    else
        evaluationarray = [REWARDS./FT_POI(:,selected_path(i-1)) (1:N_poi)']; % Define array of scores from current node
        evaluationarray(selected_path,:) = []; % Remove visited nodes
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

residual_FT = residual_FT - FT_BASE(selected_path(length(selected_path)));

% Generate the graph from the flight plan, it can be plotted easily
[G,GLP] = generateGraphsFromPath(N_poi,selected_path);

% Remember that we have not yet removed the FT to reach the base again
flight_time = MAX_FLIGHT_TIME - residual_FT;

end

