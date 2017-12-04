function [random_meshes_pattern_BT,random_meshes_pattern_WIFI,x_centers,y_centers,overall_network_mesh_pattern_BT,overall_network_mesh_pattern_WIFI,N_user_mesh] = generateMultipleRandomMeshes(N_samples,N_random_meshes,N_max_user_per_mesh,MAX_X,MAX_Y,RADIUS_COVERAGE_SCALED_BT,RADIUS_COVERAGE_SCALED_WIFI,X_axis,Y_axis)
%GENERATEMULTIPLERANDOMMESHES Summary of this function goes here
%   Detailed explanation goes here
random_meshes_pattern_BT = zeros(N_samples,N_samples,N_random_meshes); %this will not be known at the base side, just to test the algorithms
random_meshes_pattern_WIFI = zeros(N_samples,N_samples,N_random_meshes); %this will not be known at the base side, just to test the algorithms
x_centers = [];
y_centers = [];
overall_network_mesh_pattern_BT = zeros(N_samples,N_samples);
overall_network_mesh_pattern_WIFI = zeros(N_samples,N_samples);
N_user_mesh = zeros(N_random_meshes,1);

for n = 1 : N_random_meshes
    N_user_mesh(n) = randi(N_max_user_per_mesh,1);
    [random_meshes_pattern_BT(:,:,n),x_centers_tmp,y_centers_tmp] = generateRandomMesh(N_user_mesh(n),MAX_X,MAX_Y,RADIUS_COVERAGE_SCALED_BT,N_samples,X_axis,Y_axis,x_centers,y_centers);
    x_centers = [x_centers; x_centers_tmp];
    y_centers = [y_centers; y_centers_tmp];
    [random_meshes_pattern_WIFI(:,:,n)] = getMeshShapeWIFI(N_user_mesh(n),x_centers_tmp,y_centers_tmp,RADIUS_COVERAGE_SCALED_WIFI,MAX_X,MAX_Y,N_samples);
    overall_network_mesh_pattern_BT = overall_network_mesh_pattern_BT + random_meshes_pattern_BT(:,:,n);
    overall_network_mesh_pattern_WIFI = overall_network_mesh_pattern_WIFI + random_meshes_pattern_WIFI(:,:,n);
    
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
