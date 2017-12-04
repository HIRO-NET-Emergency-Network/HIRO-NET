close all
clear all
clc


%%% Import disaster-striken area - Northeastern University Campus, Boston (USA)

% Load Google Maps Snapshopt of the striken-area
filename = './map/police.png';    %Windows Systems
img = imread(filename,'png');
MAX_X = size(img,2); % get max x of the imported area
MAX_Y = size(img,1); % get max y of the imported area
scale = 2.2724; % points to meter mapping, obtained from Google Maps

% Identification of the operational bases - 4 Police Stations
N_BASES = 4;
x_BASES = [385; 331; 555; 536]; % Position of the Police Stations on the map - x-axis
y_BASES = [477; 445; 630; 185]; % Position of the Police Stations on the map - y-axis
[voronoi_x,voronoi_y] = voronoi(x_BASES,y_BASES); % Clusterize the imported area according through Voronoi Diagrams

% Fix MTBA T-metro stations as Point-of-Interests (PoIs) and add 50 random point for illustration purposes
N_POI_TOTAL = 500;
x_POIS_total = randi(MAX_X,N_POI_TOTAL,1);
y_POIS_total = randi(MAX_Y,N_POI_TOTAL,1);
x_POIS_total = [x_POIS_total; 194; 30; 179; 414; 423; 613;]; % Add T stations
y_POIS_total = [y_POIS_total; 648; 556; 326; 584; 770; 825;]; % Add T stations

% Assign PoIs to the nearest neighboring Police Station
IDX = knnsearch([x_BASES y_BASES],[x_POIS_total y_POIS_total]);

% Get PoIs' coordinates for each Police Station
x_forbase1 = x_POIS_total(IDX==1);
y_forbase1 = y_POIS_total(IDX==1);
x_forbase2 = x_POIS_total(IDX==2);
y_forbase2 = y_POIS_total(IDX==2);
x_forbase3 = x_POIS_total(IDX==3);
y_forbase3 = y_POIS_total(IDX==3);
x_forbase4 = x_POIS_total(IDX==4);
y_forbase4 = y_POIS_total(IDX==4);

% Here we assume that Police Station 1 is equipped with 2 flying drones, while the remaining stations have 3 flying drones each
N_drones_for_base = [2 3 3 3];

% Assign PoIs in Police Station 1 Cluster to each drone
idx1 = kmeans([x_forbase1 y_forbase1],N_drones_for_base(1),'Distance','cityblock',...
    'Replicates',5);

% Get coordinates for each PoI
x_fordrone11 = x_forbase1(idx1==1);
y_fordrone11 = y_forbase1(idx1==1);
x_fordrone12 = x_forbase1(idx1==2);
y_fordrone12 = y_forbase1(idx1==2);

% Assign PoIs in Police Station 2 Cluster to each drone
idx2 = kmeans([x_forbase2 y_forbase2],N_drones_for_base(2),'Distance','cityblock',...
    'Replicates',5);

% Get coordinates for each PoI
x_fordrone21 = x_forbase2(idx2==1);
y_fordrone21 = y_forbase2(idx2==1);
x_fordrone22 = x_forbase2(idx2==2);
y_fordrone22 = y_forbase2(idx2==2);
x_fordrone23 = x_forbase2(idx2==3);
y_fordrone23 = y_forbase2(idx2==3);

% Assign PoIs in Police Station 3 Cluster to each drone
idx3 = kmeans([x_forbase3 y_forbase3],N_drones_for_base(3),'Distance','cityblock',...
    'Replicates',5);

% Get coordinates for each PoI
x_fordrone31 = x_forbase3(idx3==1);
y_fordrone31 = y_forbase3(idx3==1);
x_fordrone32 = x_forbase3(idx3==2);
y_fordrone32 = y_forbase3(idx3==2);
x_fordrone33 = x_forbase3(idx3==3);
y_fordrone33 = y_forbase3(idx3==3);

% Assign PoIs in Police Station 4 Cluster to each drone
idx4 = kmeans([x_forbase4 y_forbase4],N_drones_for_base(4),'Distance','cityblock',...
    'Replicates',5);

% Get coordinates for each PoI
x_fordrone41 = x_forbase4(idx4==1);
y_fordrone41 = y_forbase4(idx4==1);
x_fordrone42 = x_forbase4(idx4==2);
y_fordrone42 = y_forbase4(idx4==2);
x_fordrone43 = x_forbase4(idx4==3);
y_fordrone43 = y_forbase4(idx4==3);

% Show assignment of PoIs to multiple drones and police stations
% figure(4)
% title('Operational Bases and their PoIs')
% imshow(img,z);
% Show assignment of PoIs to multiple drones and police stations
figure(4)
title('Operational Bases and their PoIs')
image(flip(img,1));
set(gca,'YDir','normal');
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])
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


%%%%%%%%%


%%% Drone-specific Parameters
MAX_FLIGHT_TIME_MINUTES = 15; % Maximum flight time of the drone in minutes
MAX_FLIGHT_TIME = MAX_FLIGHT_TIME_MINUTES*60; % Maximum flight time of the drone in seconds
DRONE_SPEED = 15; % Real-world Speed in m/s
speed_on_scaled_map = DRONE_SPEED/scale; % Relative speed in the considered snapshot in points/s

% Number of PoIs assigned to each drone
N_poi11 = length(x_fordrone11);
N_poi12 = length(x_fordrone12);
N_poi21 = length(x_fordrone21);
N_poi22 = length(x_fordrone22);
N_poi23 = length(x_fordrone23);
N_poi31 = length(x_fordrone31);
N_poi32 = length(x_fordrone32);
N_poi33 = length(x_fordrone33);
N_poi41 = length(x_fordrone41);
N_poi42 = length(x_fordrone42);
N_poi43 = length(x_fordrone43);

% Generation of the reward vectors. Those vector contain the reward achieved by each drone when visiting a PoI.
% For the sake of illustration, we assume that all PoIs are equal and uniform.
% However, the reward vector can be any real-valued vector with non-negative values.
% As an example, it can be used to measure the expected number of users at a given PoI,
% or can be used to measure the importance of the PoI itself.
REWARDS11 = rand(N_poi11,1);
REWARDS12 = rand(N_poi12,1);
REWARDS21 = rand(N_poi21,1);
REWARDS22 = rand(N_poi22,1);
REWARDS23 = rand(N_poi23,1);
REWARDS31 = ones(N_poi31,1);
REWARDS32 = rand(N_poi32,1);
REWARDS33 = rand(N_poi33,1);
REWARDS41 = rand(N_poi41,1);
REWARDS42 = rand(N_poi42,1);
REWARDS43 = rand(N_poi43,1);


% FT_BASE é distanza fra PoI e Base 4 x 1
% FT_POI é distanza fra poi e poi 4 x 4 con diagonale 0
% [FT_BASE11, FT_POI11] = gererateFlightTimes(x_BASES(1),y_BASES(1),x_fordrone11,y_fordrone11,speed_on_scaled_map,N_poi11);
% [FT_BASE12, FT_POI12] = gererateFlightTimes(x_BASES(1),y_BASES(1),x_fordrone12,y_fordrone12,speed_on_scaled_map,N_poi12);
% [FT_BASE21, FT_POI21] = gererateFlightTimes(x_BASES(2),y_BASES(2),x_fordrone21,y_fordrone21,speed_on_scaled_map,N_poi21);
% [FT_BASE22, FT_POI22] = gererateFlightTimes(x_BASES(2),y_BASES(2),x_fordrone22,y_fordrone22,speed_on_scaled_map,N_poi22);
% [FT_BASE23, FT_POI23] = gererateFlightTimes(x_BASES(2),y_BASES(2),x_fordrone23,y_fordrone23,speed_on_scaled_map,N_poi23);
[FT_BASE31, FT_POI31] = gererateFlightTimes(x_BASES(3),y_BASES(3),x_fordrone31,y_fordrone31,speed_on_scaled_map,N_poi31);
% [FT_BASE32, FT_POI32] = gererateFlightTimes(x_BASES(3),y_BASES(3),x_fordrone32,y_fordrone32,speed_on_scaled_map,N_poi32);
% [FT_BASE33, FT_POI33] = gererateFlightTimes(x_BASES(3),y_BASES(3),x_fordrone33,y_fordrone33,speed_on_scaled_map,N_poi33);
% [FT_BASE41, FT_POI41] = gererateFlightTimes(x_BASES(4),y_BASES(4),x_fordrone41,y_fordrone41,speed_on_scaled_map,N_poi41);
% [FT_BASE42, FT_POI42] = gererateFlightTimes(x_BASES(4),y_BASES(4),x_fordrone42,y_fordrone42,speed_on_scaled_map,N_poi42);
% [FT_BASE43, FT_POI43] = gererateFlightTimes(x_BASES(4),y_BASES(4),x_fordrone43,y_fordrone43,speed_on_scaled_map,N_poi43);

% [longestPath11,G11,GLP11,flight_time11] = computeGreedyLongestPath(REWARDS11,FT_BASE11,N_poi11,FT_POI11,MAX_FLIGHT_TIME);
% [longestPath12,G12,GLP12,flight_time12] = computeGreedyLongestPath(REWARDS12,FT_BASE12,N_poi12,FT_POI12,MAX_FLIGHT_TIME);
% [longestPath21,G21,GLP21,flight_time21] = computeGreedyLongestPath(REWARDS21,FT_BASE21,N_poi21,FT_POI21,MAX_FLIGHT_TIME);
% [longestPath22,G22,GLP22,flight_time22] = computeGreedyLongestPath(REWARDS22,FT_BASE22,N_poi22,FT_POI22,MAX_FLIGHT_TIME);
% [longestPath23,G23,GLP23,flight_time23] = computeGreedyLongestPath(REWARDS23,FT_BASE23,N_poi23,FT_POI23,MAX_FLIGHT_TIME);
[longestPath31,G31,GLP31,flight_time31] = computeGreedyLongestPath(REWARDS31,FT_BASE31,N_poi31,FT_POI31,MAX_FLIGHT_TIME);
% [longestPath32,G32,GLP32,flight_time32] = computeGreedyLongestPath(REWARDS32,FT_BASE32,N_poi32,FT_POI32,MAX_FLIGHT_TIME);
% [longestPath33,G33,GLP33,flight_time33] = computeGreedyLongestPath(REWARDS33,FT_BASE33,N_poi33,FT_POI33,MAX_FLIGHT_TIME);
% [longestPath41,G41,GLP41,flight_time41] = computeGreedyLongestPath(REWARDS41,FT_BASE41,N_poi41,FT_POI41,MAX_FLIGHT_TIME);
% [longestPath42,G42,GLP42,flight_time42] = computeGreedyLongestPath(REWARDS42,FT_BASE42,N_poi42,FT_POI42,MAX_FLIGHT_TIME);
% [longestPath43,G43,GLP43,flight_time43] = computeGreedyLongestPath(REWARDS43,FT_BASE43,N_poi43,FT_POI43,MAX_FLIGHT_TIME);

% Plot the overall searh plan of the considered area
figure(5)
title('Operational Bases and their PoIs')
image(flip(img,1));
set(gca,'YDir','normal');
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
% h = plot(G11,'XData',[x_BASES(1); x_fordrone11],'YData',[y_BASES(1); y_fordrone11],'NodeColor','r','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP11,'NodeColor','r','EdgeColor','k','LineWidth',4,'LineStyle','-');
% h = plot(G12,'XData',[x_BASES(1); x_fordrone12],'YData',[y_BASES(1); y_fordrone12],'NodeColor','r','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP12,'NodeColor','r','EdgeColor','k','LineWidth',4,'LineStyle',':');
% h = plot(G21,'XData',[x_BASES(2); x_fordrone21],'YData',[y_BASES(2); y_fordrone21],'NodeColor','g','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP21,'NodeColor','g','EdgeColor','k','LineWidth',4,'LineStyle','-');
% h = plot(G22,'XData',[x_BASES(2); x_fordrone22],'YData',[y_BASES(2); y_fordrone22],'NodeColor','g','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP22,'NodeColor','g','EdgeColor','k','LineWidth',4,'LineStyle',':');
% h = plot(G23,'XData',[x_BASES(2); x_fordrone23],'YData',[y_BASES(2); y_fordrone23],'NodeColor','g','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP23,'NodeColor','g','EdgeColor','k','LineWidth',4,'LineStyle','--');
h = plot(G31,'XData',[x_BASES(3); x_fordrone31],'YData',[y_BASES(3); y_fordrone31],'NodeColor','c','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP31,'NodeColor','c','EdgeColor','k','LineWidth',4,'LineStyle','-');
% h = plot(G32,'XData',[x_BASES(3); x_fordrone32],'YData',[y_BASES(3); y_fordrone32],'NodeColor','c','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP32,'NodeColor','c','EdgeColor','k','LineWidth',4,'LineStyle',':');
% h = plot(G33,'XData',[x_BASES(3); x_fordrone33],'YData',[y_BASES(3); y_fordrone33],'NodeColor','c','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP33,'NodeColor','c','EdgeColor','k','LineWidth',4,'LineStyle','--');
% h = plot(G41,'XData',[x_BASES(4); x_fordrone41],'YData',[y_BASES(4); y_fordrone41],'NodeColor','m','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP41,'NodeColor','m','EdgeColor','k','LineWidth',4,'LineStyle','-');
% h = plot(G42,'XData',[x_BASES(4); x_fordrone42],'YData',[y_BASES(4); y_fordrone42],'NodeColor','m','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP42,'NodeColor','m','EdgeColor','k','LineWidth',4,'LineStyle',':');
% h = plot(G43,'XData',[x_BASES(4); x_fordrone43],'YData',[y_BASES(4); y_fordrone43],'NodeColor','m','MarkerSize',2,'LineStyle','none','NodeLabel',{});
% hold on
% highlight(h,GLP43,'NodeColor','m','EdgeColor','k','LineWidth',4,'LineStyle','--');
plot(x_BASES,y_BASES,'bo',voronoi_x,voronoi_y,'k:','LineWidth',2,'MarkerSize',12,'MarkerFaceColor','k');
stem(x_BASES(1),y_BASES(1),'ro','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','r');
stem(x_BASES(2),y_BASES(2),'go','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','g');
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','c');
stem(x_BASES(4),y_BASES(4),'mo','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','m');
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])
% legend('PoIs, Drone 1 - Base 1', ...
%     'PoIs, Drone 2 - Base 1', ...
%     'PoIs, Drone 1 - Base 2', ...
%     'PoIs, Drone 2 - Base 2', ...
%     'PoIs, Drone 3 - Base 2', ...
%     'PoIs, Drone 1 - Base 3', ...
%     'PoIs, Drone 2 - Base 3', ...
%     'PoIs, Drone 3 - Base 3', ...
%     'PoIs, Drone 1 - Base 4', ...
%     'PoIs, Drone 2 - Base 4', ...
%     'PoIs, Drone 3 - Base 4', ...
%     'Base 1','Base 2','Base 3','Base 4', ...
%     'Search Path, Drone 1 - Base 1', ...
%     'Search Path, Drone 2 - Base 1', ...
%     'Search Path, Drone 1 - Base 2', ...
%     'Search Path, Drone 2 - Base 2', ...
%     'Search Path, Drone 3 - Base 2', ...
%     'Search Path, Drone 1 - Base 3', ...
%     'Search Path, Drone 2 - Base 3', ...
%     'Search Path, Drone 3 - Base 3', ...
%     'Search Path, Drone 1 - Base 4', ...
%     'Search Path, Drone 2 - Base 4', ...
%     'Search Path, Drone 3 - Base 4')

% Number of Points to generate the mesh grid
N_samples = 1000;

% Generate Mesh Grid to compute the Gaussian Distributions
[X_axis,Y_axis] = meshgrid(linspace(0,MAX_X,N_samples),linspace(0,MAX_Y,N_samples));

%%%%% UPDATE PROCESS
% Coverage radius of the flying drone
RADIUS_COVERAGE_REAL_WIFI = 100; % Coverage radius in meters
RADIUS_COVERAGE_SCALED_WIFI = ceil(RADIUS_COVERAGE_REAL_WIFI/scale); %Relative coverage radius in points
RADIUS_COVERAGE_REAL_BT = 60; % Coverage radius in meters
RADIUS_COVERAGE_SCALED_BT = ceil(RADIUS_COVERAGE_REAL_BT/scale); %Relative coverage radius in points

% Generate Random Meshes - USED FOR SIMULATIONS
N_random_meshes = 50;
N_max_user_per_mesh = 10;

% This function generates N_random_meshes random meshes with at most
% N_max_user_per_mesh survivors per mesh
[random_meshes_pattern_BT,random_meshes_pattern_WIFI,x_centers,y_centers,overall_random_meshes_pattern_BT,overall_network_mesh_pattern_WIFI,N_users_per_mesh] = generateMultipleRandomMeshes(N_samples,N_random_meshes,N_max_user_per_mesh,MAX_X,MAX_Y,RADIUS_COVERAGE_SCALED_BT,RADIUS_COVERAGE_SCALED_WIFI,X_axis,Y_axis);
% [random_meshes_pattern_BT,random_meshes_pattern_WIFI,x_centers,y_centers,overall_network_mesh_pattern_BT,overall_network_mesh_pattern_WIFI,N_user_mesh] = generateMultipleRandomMeshes(N_samples,N_random_meshes,N_max_user_per_mesh,MAX_X,MAX_Y,RADIUS_COVERAGE_SCALED_BT,RADIUS_COVERAGE_SCALED_WIFI,X_axis,Y_axis)
figure(100)
surf(X_axis,Y_axis,overall_random_meshes_pattern_BT,'LineStyle','none')
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
hold on
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',30,'MarkerFaceColor','c');
axis([1 1101 1 834])
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
view([0 90]);

figure(11111)
title('Operational Bases and their PoIs')
image(flip(img,1));
set(gca,'YDir','normal');
hold on
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','c');
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])

figure(11112)
title('Operational Bases and their PoIs')
image(flip(img,1));
set(gca,'YDir','normal');
hold on
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','c');



% Generate Trajectory on the mesgrid map, it is not the actual position of
% the drone, but it is relative to the underlying meshgrid
[pts31] = generateTrajectoryFromPath(x_BASES(3),y_BASES(3),x_fordrone31,y_fordrone31,longestPath31,speed_on_scaled_map,X_axis,Y_axis);

% Some variables
discovered_meshes31 = [];
N_users_discovered_meshes31 = [];
discoveredMesh31 = zeros(N_random_meshes,1);
overall_discovered_meshes_pattern31 = zeros(N_samples,N_samples);
visitedPoIsAll31 = zeros(N_poi31,1);
PoIsInPath31 = longestPath31;
actualFT31 = 0;
nextPoI31 = longestPath31(1);

for t = 1 : ceil(length(pts31)/3)
    x_drone = pts31(t,1);
    y_drone = pts31(t,2);
    
    % Update FLIGHT TIME
    if t > 1
        actualFT31 = actualFT31 + sqrt((x_drone-pts31(t-1,1))^2+(y_drone-pts31(t-1,2))^2)/speed_on_scaled_map;
    end
    
    %     pause(0.00001);
    
    % Sense meshes and Update info - In reality, this step is performed by using wifi
    % antennas, and the number of meshes is not known in advance. This is
    % just an example
    i = 1; % count the number of discovered networks
    for m = 1 : N_random_meshes
        % Remember that X_axis in the picture represents columns, while y
        % represents rows. Thus, in the following if we must use this
        % order Y,X, and not the intuitive X,Y. IMPORTANT
        if random_meshes_pattern_BT(Y_axis(:,1)==y_drone,X_axis(1,:)==x_drone,m) == 1 && ~discoveredMesh31(m) % Sensing of meshes, it means that the drone is inside the sensing range of the drone
            discovered_meshes31(:,:,i) = random_meshes_pattern_BT(:,:,m); % Get info
            N_users_discovered_meshes31(i) = N_users_per_mesh(m);
            discoveredMesh31(m) = 1;
            overall_discovered_meshes_pattern31 = overall_discovered_meshes_pattern31 + discovered_meshes31(:,:,i); % Update the discovery Map
            i = i + 1;
            
            figure(11112)
            stem(x_drone,y_drone,'k','filled','LineStyle','none')
            set(gcf, 'Position', [1+1071.2000000000003, 1, 1071.2000000000003, 771.2000])
            axis([1 1101 1 834])
            hold on
            surf(X_axis,Y_axis,overall_discovered_meshes_pattern31,'LineStyle','none')
        end
    end
    
    % Check if the drone is on top of the PoI
    if sqrt((x_drone-x_fordrone31(nextPoI31))^2+(y_drone-y_fordrone31(nextPoI31))^2) < 2
        if ~isempty(PoIsInPath31) % Select next PoI and remove the visited one
            visitedPoIsAll31(nextPoI31) = 1;
            nextPoI31 = PoIsInPath31(1);
            PoIsInPath31(1) = [];
        end
    end
    
    
    figure(11111)
    stem(x_drone,y_drone,'k','filled','LineStyle','none')
end

residual_FT =MAX_FLIGHT_TIME - actualFT31;
N_poi = N_poi31;
removedPoIs = datasample(PoIsInPath31,randi(ceil(length(PoIsInPath31)/3)));
visitedPoIs = find(visitedPoIsAll31);
oldPath  =longestPath31;
REWARDS = REWARDS31;
FT_POI = FT_POI31;
FT_BASE  = FT_BASE31;
x_poi  = x_fordrone31;
y_poi  = y_fordrone31;
nextPoI = nextPoI31;

[selected_path,G,GLP,flight_time] = updateGreedyLongestPath(REWARDS31,FT_BASE31,N_poi31,FT_POI31,longestPath31,find(visitedPoIsAll31),removedPoIs,residual_FT,MAX_FLIGHT_TIME,x_drone,y_drone,x_fordrone31,y_fordrone31,speed_on_scaled_map,nextPoI31);

for t = 1 + ceil(length(pts31)/3) : length(pts31)
    x_drone = pts31(t,1);
    y_drone = pts31(t,2);
    
    % Update FLIGHT TIME
    if t > 1
        actualFT31 = actualFT31 + sqrt((x_drone-pts31(t-1,1))^2+(y_drone-pts31(t-1,2))^2)/speed_on_scaled_map;
    end
    
    %     pause(0.00001);
    
    % Sense meshes and Update info - In reality, this step is performed by using wifi
    % antennas, and the number of meshes is not known in advance. This is
    % just an example
    i = 1; % count the number of discovered networks
    for m = 1 : N_random_meshes
        % Remember that X_axis in the picture represents columns, while y
        % represents rows. Thus, in the following if we must use this
        % order Y,X, and not the intuitive X,Y. IMPORTANT
        if random_meshes_pattern_BT(Y_axis(:,1)==y_drone,X_axis(1,:)==x_drone,m) == 1 && ~discoveredMesh31(m) % Sensing of meshes, it means that the drone is inside the sensing range of the drone
            discovered_meshes31(:,:,i) = random_meshes_pattern_BT(:,:,m); % Get info
            N_users_discovered_meshes31(i) = N_users_per_mesh(m);
            discoveredMesh31(m) = 1;
            overall_discovered_meshes_pattern31 = overall_discovered_meshes_pattern31 + discovered_meshes31(:,:,i); % Update the discovery Map
            i = i + 1;
            
            figure(11112)
            stem(x_drone,y_drone,'k','filled','LineStyle','none')
            set(gcf, 'Position', [1+1071.2000000000003, 1, 1071.2000000000003, 771.2000])
            axis([1 1101 1 834])
            hold on
            surf(X_axis,Y_axis,overall_discovered_meshes_pattern31,'LineStyle','none')
        end
    end
    
    % Check if the drone is on top of the PoI
    if sqrt((x_drone-x_fordrone31(nextPoI31))^2+(y_drone-y_fordrone31(nextPoI31))^2) < 2
        if ~isempty(PoIsInPath31) % Select next PoI and remove the visited one
            visitedPoIsAll31(nextPoI31) = 1;
            nextPoI31 = PoIsInPath31(1);
            PoIsInPath31(1) = [];
        end
    end
    
    
    figure(11111)
    stem(x_drone,y_drone,'k','filled','LineStyle','none')
end

figure(5)
h = plot(G,'XData',[x_BASES(3); x_fordrone31],'YData',[y_BASES(3); y_fordrone31],'NodeColor','c','MarkerSize',2,'LineStyle','none');
hold on
highlight(h,GLP,'NodeColor','c','EdgeColor','r','LineWidth',4,'LineStyle','--');
stem(x_drone,y_drone,'ko','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','r');


figure(11114)
title('Operational Bases and their PoIs')
image(flip(img,1));
set(gca,'YDir','normal');
hold on
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','c');
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])

% Generate Trajectory on the mesgrid map, it is not the actual position of
% the drone, but it is relative to the underlying meshgrid
[pts31] = generateTrajectoryFromPath(x_BASES(3),y_BASES(3),x_fordrone31,y_fordrone31,selected_path,speed_on_scaled_map,X_axis,Y_axis);

% Some variables
discovered_meshes31 = [];
N_users_discovered_meshes31 = [];
discoveredMesh31 = zeros(N_random_meshes,1);
overall_discovered_meshes_pattern31 = zeros(N_samples,N_samples);
visitedPoIsAll31 = zeros(N_poi31,1);
PoIsInPath31 = longestPath31;
actualFT31 = 0;
nextPoI31 = longestPath31(1);

for t = 1 : length(pts31)
    x_drone = pts31(t,1);
    y_drone = pts31(t,2);
    
    % Update FLIGHT TIME
    if t > 1
        actualFT31 = actualFT31 + sqrt((x_drone-pts31(t-1,1))^2+(y_drone-pts31(t-1,2))^2)/speed_on_scaled_map;
    end
    
    %     pause(0.00001);
    
    % Sense meshes and Update info - In reality, this step is performed by using wifi
    % antennas, and the number of meshes is not known in advance. This is
    % just an example
    i = 1; % count the number of discovered networks
    for m = 1 : N_random_meshes
        % Remember that X_axis in the picture represents columns, while y
        % represents rows. Thus, in the following if we must use this
        % order Y,X, and not the intuitive X,Y. IMPORTANT
        if random_meshes_pattern_BT(Y_axis(:,1)==y_drone,X_axis(1,:)==x_drone,m) == 1 && ~discoveredMesh31(m) % Sensing of meshes, it means that the drone is inside the sensing range of the drone
            discovered_meshes31(:,:,i) = random_meshes_pattern_BT(:,:,m); % Get info
            N_users_discovered_meshes31(i) = N_users_per_mesh(m);
            discoveredMesh31(m) = 1;
            overall_discovered_meshes_pattern31 = overall_discovered_meshes_pattern31 + discovered_meshes31(:,:,i); % Update the discovery Map
            i = i + 1;
            
            figure(11116)
            stem(x_drone,y_drone,'k','filled','LineStyle','none')
            set(gcf, 'Position', [1+1071.2000000000003, 1, 1071.2000000000003, 771.2000])
            axis([1 1101 1 834])
            hold on
            surf(X_axis,Y_axis,overall_discovered_meshes_pattern31,'LineStyle','none')
        end
    end
    
    % Check if the drone is on top of the PoI
    if sqrt((x_drone-x_fordrone31(nextPoI31))^2+(y_drone-y_fordrone31(nextPoI31))^2) < 2
        if ~isempty(PoIsInPath31) % Select next PoI and remove the visited one
            visitedPoIsAll31(nextPoI31) = 1;
            nextPoI31 = PoIsInPath31(1);
            PoIsInPath31(1) = [];
        end
    end
    
    
    figure(11114)
    stem(x_drone,y_drone,'r','filled','LineStyle','none')
end

% save('test_data.mat')