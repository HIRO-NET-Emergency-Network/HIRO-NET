function [FT_BASE, FT_POI] = gererateFlightTimes(x_base,y_base,x_pois,y_pois,speed,N_poi)
%GENERATEFLIGHTTIMES This function computes the flight time needed by a given drone located at (x_base,y_base) to reach the
%PoIs and go back to the corresponding base. 
%   This function computes the flight time needed by a given drone located at (x_base,y_base) to reach the
%PoIs and go back to the corresponding base.

% Compute the Euclidian Distances
[DISTANCE_BASE,DISTANCE_POI] = generateDistances(x_base,y_base,x_pois,y_pois,N_poi);

% Compute the corresponding flight time
FT_BASE = DISTANCE_BASE./speed;
FT_POI = DISTANCE_POI./speed;
end