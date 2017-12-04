function [pts] = generateTrajectoryFromPath(x_BASE,y_BASE,x_poisForDrone,y_poisForDrone,longestPath,speed_on_scaled_map,X_axis,Y_axis)
%GENERATETRAJECTORYFROMPATH Summary of this function goes here
%   Detailed explanation goes here

pts = [];
% Reach first PoI and generate the trajectory (LINEAR IN THIS SAMPLE CASE)
distance = sqrt((x_BASE-x_poisForDrone(longestPath(1)))^2 + (y_BASE-y_poisForDrone(longestPath(1)))^2);
xvals = linspace(x_BASE, x_poisForDrone(longestPath(1)), ceil(distance/speed_on_scaled_map));
yvals = linspace(y_BASE, y_poisForDrone(longestPath(1)), ceil(distance/speed_on_scaled_map));
pts = [pts; xvals(:), yvals(:)];
for p = 1 : length(longestPath)-1
    % Reach the next PoI and generate the trajectory (LINEAR IN THIS SAMPLE CASE)
    distance = sqrt((x_poisForDrone(longestPath(p))-x_poisForDrone(longestPath(p+1)))^2 + (y_poisForDrone(longestPath(p))-y_poisForDrone(longestPath(p+1)))^2);
    xvals = linspace(x_poisForDrone(longestPath(p)), x_poisForDrone(longestPath(p+1)), ceil(distance/speed_on_scaled_map));
    yvals = linspace(y_poisForDrone(longestPath(p)), y_poisForDrone(longestPath(p+1)), ceil(distance/speed_on_scaled_map));
    pts = [pts; xvals(:), yvals(:)];
end
% Reach the BASE and generate the trajectory (LINEAR IN THIS SAMPLE CASE)
distance = sqrt((x_BASE-x_poisForDrone(longestPath(p+1)))^2 + (y_BASE-y_poisForDrone(longestPath(p+1)))^2);
xvals = linspace(x_poisForDrone(longestPath(p+1)),x_BASE,ceil(distance/speed_on_scaled_map));
yvals = linspace(y_poisForDrone(longestPath(p+1)),y_BASE,ceil(distance/speed_on_scaled_map));
pts = [pts; xvals(:), yvals(:)];

pts(:,1) = roundtowardvec(pts(:,1),X_axis(1,:),'round');
pts(:,2) = roundtowardvec(pts(:,2),Y_axis(:,1),'round');

end