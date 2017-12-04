function [mesh_shape_temp,x_mesh,y_mesh] = generateRandomMesh(N_user_mesh,MAX_X,MAX_Y,RADIUS_COVERAGE_SCALED,N_samples,X_axis,Y_axis,x_centers,y_centers)
%GENERATERANDOMMESHES Summary of this function goes here
%   Detailed explanation goes here

intersect = true;
if ~isempty(x_centers)
    while intersect
        x_mesh = randi(MAX_X,1);
        y_mesh = randi(MAX_Y,1);
        intersect = sum(sum((sqrt((x_mesh-x_centers).^2 + (y_mesh-y_centers).^2)<=RADIUS_COVERAGE_SCALED)))>0;
    end
else
    x_mesh = randi(MAX_X,1);
    y_mesh = randi(MAX_Y,1);
end


for n = 2 : N_user_mesh
    [mesh_shape_temp] = getMeshShape(n-1,x_mesh,y_mesh,RADIUS_COVERAGE_SCALED,MAX_X,MAX_Y,N_samples);
    idx = find(mesh_shape_temp==1);
    if ~isempty(x_centers)
        intersect = true;
        while intersect
            rand_index = datasample(idx,1);
            intersect = sum(sum((sqrt((X_axis(rand_index)-x_centers).^2 + (Y_axis(rand_index)-y_centers).^2)<=RADIUS_COVERAGE_SCALED)))>0;
        end
    else
        rand_index = datasample(idx,1);
    end
    x_mesh = [x_mesh; X_axis(rand_index);];
    y_mesh = [y_mesh; Y_axis(rand_index);];
end

[mesh_shape_temp] = getMeshShape(N_user_mesh,x_mesh,y_mesh,RADIUS_COVERAGE_SCALED,MAX_X,MAX_Y,N_samples);

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
