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


% my_frame
% LPD/LPI Scheme Transmitter
% Copyright (c) 2017 WiNES Lab, Northeastern University,
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.


