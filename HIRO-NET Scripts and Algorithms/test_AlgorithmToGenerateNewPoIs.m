clear all
close all
clc

% Load data generated by the testingDroneSearchAlgorithm.m script
load('test_data.mat')

% Show Google Maps Snapshot of the striken area
figure(1)
imshow(y);
title('Disaster-striken Area')
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])

% Focus on Drone 1 at Base 1

% Coverage radius of the flying drone
RADIUS_COVERAGE_REAL = 100; % Coverage radius in meters
RADIUS_COVERAGE_SCALED = ceil(RADIUS_COVERAGE_REAL/scale); %Relative coverage radius in points

% Maximum number of newly generated PoIs 
MAX_NEW_POIS = 5;

% System parameters related to PoIs assigned to Drone 1 in Base 3
x_original_pois = x_fordrone31;
y_original_pois = y_fordrone31;
n_old = REWARDS31;
n = n_old;

% Parameters used to generate the synthetic Gaussian distributions to compute
% the new PoIs to be visited
R = 10000;
N_samples = 1000;
variance_gaussian_narrow = (RADIUS_COVERAGE_SCALED)^2 ;
variance_gaussian_broad = (2*RADIUS_COVERAGE_SCALED)^2;
variance_gaussian_newpois = (RADIUS_COVERAGE_SCALED/3)^2;

% Generate Mesh Grid to compute the Gaussian Distributions
[X_axis,Y_axis] = meshgrid(linspace(0,MAX_X,N_samples),linspace(0,MAX_Y,N_samples));

%Compute the synthetic Gaussian Distributions for the already existing PoIs
old_poi_narrow = zeros(N_samples);
old_poi_broad = zeros(N_samples);
for k = 1 : length(n)
    old_poi_narrow=old_poi_narrow+exp(-((X_axis-x_original_pois(k)).^2/(variance_gaussian_narrow))-((Y_axis-y_original_pois(k)).^2/(variance_gaussian_narrow)));
    old_poi_broad=old_poi_broad+exp(-((X_axis-x_original_pois(k)).^2/(variance_gaussian_broad))-((Y_axis-y_original_pois(k)).^2/(variance_gaussian_broad)));
end

% Plot the already existing PoIs and their Gaussian Distribution
figure(2)
imshow(y);
title('PoIs for Base 3 and Drone 1')
hold on
surf(X_axis,Y_axis,old_poi_narrow./max(max(old_poi_narrow)),'LineStyle','none')
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])
view([0 90]);

% Plot the already existing PoIs and their cumulative Gaussian Distribution
figure(3)
imshow(y);
title('Synthetic Gaussian Distribution of PoIs for Base 3 and Drone 1')
hold on
surf(X_axis,Y_axis,old_poi_broad./max(max(old_poi_broad)),'LineStyle','none')
view([0 90]);
hold on
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])

% Show assignment of PoIs to multiple drones and police stations
figure(4)
imshow(y);
title('Operational Bases and their PoIs')
hold on
stem(x_fordrone11,y_fordrone11,'r>','LineStyle','none','MarkerFaceColor','r','MarkerSize',10)
stem(x_fordrone12,y_fordrone12,'rd','LineStyle','none','MarkerFaceColor','r','MarkerSize',10)
stem(x_fordrone21,y_fordrone21,'g>','LineStyle','none','MarkerFaceColor','g','MarkerSize',10)
stem(x_fordrone22,y_fordrone22,'gd','LineStyle','none','MarkerFaceColor','g','MarkerSize',10)
stem(x_fordrone23,y_fordrone23,'gs','LineStyle','none','MarkerFaceColor','g','MarkerSize',10)
stem(x_fordrone31,y_fordrone31,'c>','LineStyle','none','MarkerFaceColor','c','MarkerSize',10)
stem(x_fordrone32,y_fordrone32,'cd','LineStyle','none','MarkerFaceColor','c','MarkerSize',10)
stem(x_fordrone33,y_fordrone33,'cs','LineStyle','none','MarkerFaceColor','c','MarkerSize',10)
stem(x_fordrone41,y_fordrone41,'m>','LineStyle','none','MarkerFaceColor','m','MarkerSize',10)
stem(x_fordrone42,y_fordrone42,'md','LineStyle','none','MarkerFaceColor','m','MarkerSize',10)
stem(x_fordrone43,y_fordrone43,'ms','LineStyle','none','MarkerFaceColor','m','MarkerSize',10)
stem(x_BASES(1),y_BASES(1),'ro','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','r');
stem(x_BASES(2),y_BASES(2),'go','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','g');
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','c');
stem(x_BASES(4),y_BASES(4),'mo','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','m');
plot(voronoi_x,voronoi_y,'k:','LineWidth',4);
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])
legend('PoIs, Drone 1 - Base 1', ...
    'PoIs, Drone 2 - Base 1', ...
    'PoIs, Drone 1 - Base 2', ...
    'PoIs, Drone 2 - Base 2', ...
    'PoIs, Drone 3 - Base 2', ...
    'PoIs, Drone 1 - Base 3', ...
    'PoIs, Drone 2 - Base 3', ...
    'PoIs, Drone 3 - Base 3', ...
    'PoIs, Drone 1 - Base 4', ...
    'PoIs, Drone 2 - Base 4', ...
    'PoIs, Drone 3 - Base 4', ...
    'Base 1','Base 2','Base 3','Base 4')


% Generate a Random Path that visits all PoIs. For illustrative purposes,
% we assume that the drone follows a straight-line trajectory. In reality,
% (xvals,yvals) will represents the actual trajectory of the drone.
sequence_visitedPoIs = randperm(N_poi31);
pts = [];
NumberOfSamples = 100;
for p = 1 : length(sequence_visitedPoIs)-1
    xvals = linspace(x_original_pois(p), x_original_pois(p+1), NumberOfSamples+2);
    yvals = linspace(y_original_pois(p), y_original_pois(p+1), NumberOfSamples+2);
    pts = [pts; xvals(:), yvals(:)];
end

% Start removing the already visited portion of the map
old_poi_broad_temporary = old_poi_broad ; 
for i = 1 : length(pts)
    x_temp = pts(i,1);
    y_temp = pts(i,2);
    distance_matrix = sqrt((X_axis - x_temp).^2 + (Y_axis - y_temp).^2); % distance in meters
    idx = find(distance_matrix<=RADIUS_COVERAGE_SCALED);
    remove_function = exp(-((X_axis-x_temp).^2/(variance_gaussian_newpois))-((Y_axis-y_temp).^2/(variance_gaussian_newpois)));
    old_poi_broad_temporary(idx) = old_poi_broad_temporary(idx)-remove_function(idx);
    old_poi_broad_temporary(old_poi_broad_temporary<0) = 0;
end

% Plot the synthetic Gaussian Distribution where we have removed the
% already visited portion of the map
figure(5)
imshow(y);
title('Drones'' path and visited area')
hold on
surf(X_axis,Y_axis,old_poi_broad_temporary,'LineStyle','none')
view([0 90]);
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])

% Initialize the structures to store the new generated PoIs
added_pois = [];
x_added_but_old_pois = [];
y_added_but_old_pois = [];

% Compute an underestimation of the minimum distance between the newly
% generated PoIs. This is helpful to avoid the generation of PoIs which
% lies in the coverage radius of the drone.
distance_min = floor(2/3*RADIUS_COVERAGE_SCALED*N_samples/MAX_X);
distance_min(mod(distance_min,2)<1) = distance_min(mod(distance_min,2)<1)-1; % We need it to be an uneven integer number to compute generateNewPoIsPathAware()

% Compute the new PoIs.
[x_NEW_POIS,y_NEW_POIS,old_poi_narrow,new_poi_narrow] = generateNewPoIsPathAware(MAX_NEW_POIS,N_samples,variance_gaussian_narrow,X_axis,Y_axis,n,x_original_pois,y_original_pois,x_added_but_old_pois,y_added_but_old_pois,old_poi_broad_temporary,distance_min,y);


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
