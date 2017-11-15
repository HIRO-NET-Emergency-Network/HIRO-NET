function [DISTANCE_BASE,DISTANCE_POI] = generateDistances(x_base,y_base,x_pois,y_pois,N_poi)
% GENERATEDISTANCES This function computes the Euclidian distance between a given base located at (x_base,y_base) and the PoIs. 
% This function computes the Euclidian distance between a given base located at (x_base,y_base) and the PoIs. 

DISTANCE_BASE = sqrt((x_base-x_pois).^2+(y_base-y_pois).^2);
DISTANCE_POI = zeros(N_poi,N_poi);
for p = 1 : N_poi
    DISTANCE_POI(:,p)=sqrt((x_pois-x_pois(p)).^2+(y_pois-y_pois(p)).^2);
end
end