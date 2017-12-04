function [mesh_shape] = getMeshShapeWIFI(N_user_mesh,x_mesh,y_mesh,RADIUS_COVERAGE_SCALED_WIFI,MAX_X,MAX_Y,N_samples)
%GETMESHSHAPE Summary of this function goes here
%   Detailed explanation goes here

% Generate Mesh Grid to compute the Gaussian Distributions
[X_axis,Y_axis] = meshgrid(linspace(0,MAX_X,N_samples),linspace(0,MAX_Y,N_samples));

mesh_shape = zeros(N_samples,N_samples);
for i = 1 : N_user_mesh
    distance_matrix = sqrt((X_axis - x_mesh(i,1)).^2 + (Y_axis - y_mesh(i,1)).^2); %distanza in metri
    idx = find(distance_matrix<=RADIUS_COVERAGE_SCALED_WIFI);
    mesh_shape(idx) = 1;
end
end