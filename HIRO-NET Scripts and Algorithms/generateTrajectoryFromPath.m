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
