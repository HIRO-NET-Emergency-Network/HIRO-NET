function [mesh_shape] = getMeshShape(N_user_mesh,x_mesh,y_mesh,RADIUS_COVERAGE_SCALED,MAX_X,MAX_Y,N_samples)
%GETMESHSHAPE Summary of this function goes here
%   Detailed explanation goes here

% Generate Mesh Grid to compute the Gaussian Distributions
[X_axis,Y_axis] = meshgrid(linspace(0,MAX_X,N_samples),linspace(0,MAX_Y,N_samples));

mesh_shape = zeros(N_samples,N_samples);
for i = 1 : N_user_mesh
    distance_matrix = sqrt((X_axis - x_mesh(i,1)).^2 + (Y_axis - y_mesh(i,1)).^2); % distance in meters
    idx = find(distance_matrix<=RADIUS_COVERAGE_SCALED);
    mesh_shape(idx) = 1;
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
