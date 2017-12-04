function [longestPath,reward,cost]=runBruteForceLongestPath(N_poi,MAX_FT,FT_BASE,FT_POI,REWARDS)

theEnd = false;
reward = 0;
cost = 0;
longestPath = 0;

while ~theEnd

    % Find the best path through backwards induction
    for k = N_poi : -1 : 1
        Z = combinator(N_poi,k,'p');
        
        for z = 1 : length(Z)
            longestpath = Z(z,:);
            reward_temp = sum(REWARDS(longestpath)); % Get the overall reward
            length_temp = FT_BASE(longestpath(1));
            for i = 1 : k
                if i == k
                    length_temp = length_temp + FT_BASE(longestpath(k));
                else
                    length_temp = length_temp + FT_POI(longestpath(i),longestpath(i+1));
                end
            end
            if reward_temp>reward && length_temp<=MAX_FT
                longestPath = longestpath;
                reward = reward_temp;
                cost = length_temp;
            elseif reward_temp==reward && length_temp<=cost
                longestPath = longestpath;
                reward = reward_temp;
                cost = length_temp;
            end
        end
    end
    theEnd = true;
end

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
