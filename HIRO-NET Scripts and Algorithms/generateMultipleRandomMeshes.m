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