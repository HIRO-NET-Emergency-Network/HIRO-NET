function [longestPath,reward,cost]=runBruteForceLongestPath(N_poi,MAX_FT,FT_BASE,FT_POI,REWARDS)

theEnd = false;
reward = 0;
cost = 0;
longestPath = 0;

while ~theEnd

    %ciclo su i percorsi possibili al contrario
    for k = N_poi : -1 : 1
        Z = combinator(N_poi,k,'p');
        
        for z = 1 : length(Z)
            longestpath = Z(z,:);
            reward_temp = sum(REWARDS(longestpath)); %sommo le reward del path
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