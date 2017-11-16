close all
clear all
clc


%%% Import disaster-striken area - Northeastern University Campus, Boston (USA)

% Load Google Maps Snapshopt of the striken-area
filename = './map/police.png';    %Windows Systems
[y,z] = imread(filename,'png');
MAX_X = size(y,2); % get max x of the imported area
MAX_Y = size(y,1); % get max y of the imported area
scale = 2.2724; % points to meter mapping, obtained from Google Maps

% Identification of the operational bases - 4 Police Stations
N_BASES = 4;
x_BASES = [385; 331; 555; 536]; % Position of the Police Stations on the map - x-axis
y_BASES = [357; 389; 204; 649]; % Position of the Police Stations on the map - y-axis
[voronoi_x,voronoi_y] = voronoi(x_BASES,y_BASES); % Clusterize the imported area according through Voronoi Diagrams

% Fix MTBA T-metro stations as Point-of-Interests (PoIs) and add 50 random point for illustration purposes
N_POI_TOTAL = 40;
x_POIS_total = randi(MAX_X,N_POI_TOTAL,1);
y_POIS_total = randi(MAX_Y,N_POI_TOTAL,1);
x_POIS_total = [x_POIS_total; 194; 30; 179; 414; 423; 613;]; % Add T stations
y_POIS_total = [y_POIS_total; 186; 278; 508; 250; 64; 9;]; % Add T stations

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


% Show Google Maps Snapshot of the striken area
figure(1)
imshow(y);
title('Disaster-striken Area')
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])
% 
% %Show Police Stations only
% figure(2)
% stem(x_BASES,flip(y_BASES),'LineStyle','none','MarkerSize',12,'MarkerFaceColor','b')
% axis([1 1101 1 834])
% set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
% title('Operational Bases - Police stations')
% xlabel('x-axis Location')
% 
% %Show obtained Vornoi Diagrams
% figure(3)
% stem(x_forbase1,flip(y_forbase1),'rs','LineStyle','none','MarkerFaceColor','r','MarkerSize',10)
% hold on
% stem(x_forbase2,flip(y_forbase2),'g^','LineStyle','none','MarkerFaceColor','g','MarkerSize',10)
% stem(x_forbase3,flip(y_forbase3),'co','LineStyle','none','MarkerFaceColor','c','MarkerSize',10)
% stem(x_forbase4,flip(y_forbase4),'m*','LineStyle','none','MarkerFaceColor','m','MarkerSize',10)
% plot(x_BASES,flip(y_BASES),'bo',voronoi_x,voronoi_y,'k:','LineWidth',2,'MarkerSize',12,'MarkerFaceColor','b');
% axis([1 1101 1 834])
% set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
% legend('PoIs Base 1','PoIs Base 2','PoIs Base 3','PoIs Base 4','Police Stations')
% title('Voronoi')
% xlabel('x-axis Location')

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


%%%%%%%%%


%%% Drone-specific Parameters
MAX_FLIGHT_TIME_MINUTES = 25; % Maximum flight time of the drone in minutes
MAX_FLIGHT_TIME = MAX_FLIGHT_TIME_MINUTES*60; % Maximum flight time of the drone in seconds
DRONE_SPEED = 20; % Real-world Speed in m/s
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
REWARDS11 = ones(N_poi11,1);
REWARDS12 = ones(N_poi12,1);
REWARDS21 = ones(N_poi21,1);
REWARDS22 = ones(N_poi22,1);
REWARDS23 = ones(N_poi23,1);
REWARDS31 = ones(N_poi31,1);
REWARDS32 = ones(N_poi32,1);
REWARDS33 = ones(N_poi33,1);
REWARDS41 = ones(N_poi41,1);
REWARDS42 = ones(N_poi42,1);
REWARDS43 = ones(N_poi43,1);

% Compute the optimal search flight plan for each drone. 
% This function is generally executed on each flying drone and computes the
% optimal path that maximizes the rewards (e.g., the number of visited PoIs
% in this specific script) while allowing the drone to return to its
% corresponding base.
[FT_BASE11,FT_POI11,longestPath11,G11,GLP11] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone11,y_fordrone11,speed_on_scaled_map,N_poi11,MAX_FLIGHT_TIME,REWARDS11,1);
[FT_BASE12,FT_POI12,longestPath12,G12,GLP12] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone12,y_fordrone12,speed_on_scaled_map,N_poi12,MAX_FLIGHT_TIME,REWARDS12,1);
[FT_BASE21,FT_POI21,longestPath21,G21,GLP21] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone21,y_fordrone21,speed_on_scaled_map,N_poi21,MAX_FLIGHT_TIME,REWARDS21,2);
[FT_BASE22,FT_POI22,longestPath22,G22,GLP22] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone22,y_fordrone22,speed_on_scaled_map,N_poi22,MAX_FLIGHT_TIME,REWARDS22,2);
[FT_BASE23,FT_POI23,longestPath23,G23,GLP23] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone23,y_fordrone23,speed_on_scaled_map,N_poi23,MAX_FLIGHT_TIME,REWARDS23,2);
[FT_BASE31,FT_POI31,longestPath31,G31,GLP31] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone31,y_fordrone31,speed_on_scaled_map,N_poi31,MAX_FLIGHT_TIME,REWARDS31,3);
[FT_BASE32,FT_POI32,longestPath32,G32,GLP32] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone32,y_fordrone32,speed_on_scaled_map,N_poi32,MAX_FLIGHT_TIME,REWARDS32,3);
[FT_BASE33,FT_POI33,longestPath33,G33,GLP33] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone33,y_fordrone33,speed_on_scaled_map,N_poi33,MAX_FLIGHT_TIME,REWARDS33,3);
[FT_BASE41,FT_POI41,longestPath41,G41,GLP41] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone41,y_fordrone41,speed_on_scaled_map,N_poi41,MAX_FLIGHT_TIME,REWARDS41,4);
[FT_BASE42,FT_POI42,longestPath42,G42,GLP42] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone42,y_fordrone42,speed_on_scaled_map,N_poi42,MAX_FLIGHT_TIME,REWARDS42,4);
[FT_BASE43,FT_POI43,longestPath43,G43,GLP43] = computeOptimalSearchFlightPlan(x_BASES,y_BASES,x_fordrone43,y_fordrone43,speed_on_scaled_map,N_poi43,MAX_FLIGHT_TIME,REWARDS43,4);

% Plot the overall searh plan of the considered area
figure(5)
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
h = plot(G11,'XData',[x_BASES(1); x_fordrone11],'YData',[y_BASES(1); y_fordrone11],'NodeColor','r','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP11,'NodeColor','r','EdgeColor','k','LineWidth',4,'LineStyle','-');
h = plot(G12,'XData',[x_BASES(1); x_fordrone12],'YData',[y_BASES(1); y_fordrone12],'NodeColor','r','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP12,'NodeColor','r','EdgeColor','k','LineWidth',4,'LineStyle',':');
h = plot(G21,'XData',[x_BASES(2); x_fordrone21],'YData',[y_BASES(2); y_fordrone21],'NodeColor','g','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP21,'NodeColor','g','EdgeColor','k','LineWidth',4,'LineStyle','-');
h = plot(G22,'XData',[x_BASES(2); x_fordrone22],'YData',[y_BASES(2); y_fordrone22],'NodeColor','g','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP22,'NodeColor','g','EdgeColor','k','LineWidth',4,'LineStyle',':');
h = plot(G23,'XData',[x_BASES(2); x_fordrone23],'YData',[y_BASES(2); y_fordrone23],'NodeColor','g','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP23,'NodeColor','g','EdgeColor','k','LineWidth',4,'LineStyle','--');
h = plot(G31,'XData',[x_BASES(3); x_fordrone31],'YData',[y_BASES(3); y_fordrone31],'NodeColor','c','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP31,'NodeColor','c','EdgeColor','k','LineWidth',4,'LineStyle','-');
h = plot(G32,'XData',[x_BASES(3); x_fordrone32],'YData',[y_BASES(3); y_fordrone32],'NodeColor','c','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP32,'NodeColor','c','EdgeColor','k','LineWidth',4,'LineStyle',':');
h = plot(G33,'XData',[x_BASES(3); x_fordrone33],'YData',[y_BASES(3); y_fordrone33],'NodeColor','c','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP33,'NodeColor','c','EdgeColor','k','LineWidth',4,'LineStyle','--');
h = plot(G41,'XData',[x_BASES(4); x_fordrone41],'YData',[y_BASES(4); y_fordrone41],'NodeColor','m','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP41,'NodeColor','m','EdgeColor','k','LineWidth',4,'LineStyle','-');
h = plot(G42,'XData',[x_BASES(4); x_fordrone42],'YData',[y_BASES(4); y_fordrone42],'NodeColor','m','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP42,'NodeColor','m','EdgeColor','k','LineWidth',4,'LineStyle',':');
h = plot(G43,'XData',[x_BASES(4); x_fordrone43],'YData',[y_BASES(4); y_fordrone43],'NodeColor','m','MarkerSize',2,'LineStyle','none','NodeLabel',{});
hold on
highlight(h,GLP43,'NodeColor','m','EdgeColor','k','LineWidth',4,'LineStyle','--');
plot(x_BASES,y_BASES,'bo',voronoi_x,voronoi_y,'k:','LineWidth',2,'MarkerSize',12,'MarkerFaceColor','k');
stem(x_BASES(1),y_BASES(1),'ro','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','r');
stem(x_BASES(2),y_BASES(2),'go','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','g');
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','c');
stem(x_BASES(4),y_BASES(4),'mo','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','m');
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
    'Base 1','Base 2','Base 3','Base 4', ...
    'Search Path, Drone 1 - Base 1', ...
    'Search Path, Drone 2 - Base 1', ...
    'Search Path, Drone 1 - Base 2', ...
    'Search Path, Drone 2 - Base 2', ...
    'Search Path, Drone 3 - Base 2', ...
    'Search Path, Drone 1 - Base 3', ...
    'Search Path, Drone 2 - Base 3', ...
    'Search Path, Drone 3 - Base 3', ...
    'Search Path, Drone 1 - Base 4', ...
    'Search Path, Drone 2 - Base 4', ...
    'Search Path, Drone 3 - Base 4')

% The saved data might be used in the file
% test_AlgorithmToGenerateNewPoIs.m
% save('test_data.mat')

% my_frame
% LPD/LPI Scheme Transmitter
% Copyright (c) 2016 Emrecan Demirors and Tommaso Melodia, WiNES Lab, Northeastern University,
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
