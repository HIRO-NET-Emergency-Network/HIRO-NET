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
