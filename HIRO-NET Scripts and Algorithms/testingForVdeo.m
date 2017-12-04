close all
clear all
clc

load('./test_data_video.mat')

figure(4)
title('Operational Bases and their PoIs')
image(flip(img,1));
set(gca,'YDir','normal');
set(gcf, 'Position', [1200, 800, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])
hold on
pause
stem(x_BASES(1),y_BASES(1),'ro','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','r');
stem(x_BASES(2),y_BASES(2),'go','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','g');
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','c');
stem(x_BASES(4),y_BASES(4),'mo','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','m');
pause
s11 = stem(x_fordrone11,y_fordrone11,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s12 = stem(x_fordrone12,y_fordrone12,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s21 = stem(x_fordrone21,y_fordrone21,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s22 =stem(x_fordrone22,y_fordrone22,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s23 =stem(x_fordrone23,y_fordrone23,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s31 =stem(x_fordrone31,y_fordrone31,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s32 =stem(x_fordrone32,y_fordrone32,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s33 =stem(x_fordrone33,y_fordrone33,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s41 =stem(x_fordrone41,y_fordrone41,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s42 =stem(x_fordrone42,y_fordrone42,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
s43 =stem(x_fordrone43,y_fordrone43,'ks','LineStyle','none','MarkerFaceColor','k','MarkerSize',10);
pause
p_voronoi = plot(voronoi_x,voronoi_y,'k:','LineWidth',4);
pause
stem(x_fordrone11,y_fordrone11,'r>','LineStyle','none','MarkerFaceColor','r','MarkerSize',10);
stem(x_fordrone12,y_fordrone12,'rd','LineStyle','none','MarkerFaceColor','r','MarkerSize',10);
stem(x_fordrone21,y_fordrone21,'g>','LineStyle','none','MarkerFaceColor','g','MarkerSize',10);
stem(x_fordrone22,y_fordrone22,'gd','LineStyle','none','MarkerFaceColor','g','MarkerSize',10);
stem(x_fordrone23,y_fordrone23,'gs','LineStyle','none','MarkerFaceColor','g','MarkerSize',10);
stem(x_fordrone31,y_fordrone31,'c>','LineStyle','none','MarkerFaceColor','c','MarkerSize',10);
stem(x_fordrone32,y_fordrone32,'cd','LineStyle','none','MarkerFaceColor','c','MarkerSize',10);
stem(x_fordrone33,y_fordrone33,'cs','LineStyle','none','MarkerFaceColor','c','MarkerSize',10);
stem(x_fordrone41,y_fordrone41,'m>','LineStyle','none','MarkerFaceColor','m','MarkerSize',10);
stem(x_fordrone42,y_fordrone42,'md','LineStyle','none','MarkerFaceColor','m','MarkerSize',10);
stem(x_fordrone43,y_fordrone43,'ms','LineStyle','none','MarkerFaceColor','m','MarkerSize',10);
delete(s11)
delete(s12)
delete(s21)
delete(s22)
delete(s23)
delete(s31)
delete(s32)
delete(s33)
delete(s41)
delete(s42)
delete(s43)
delete(p_voronoi)
p_voronoi = plot(voronoi_x,voronoi_y,'k:','LineWidth',4);
legend1 = legend('Base 1','Base 2','Base 3','Base 4', ...
    'PoIs, Drone 1 - Base 1', ...
    'PoIs, Drone 2 - Base 1', ...
    'PoIs, Drone 1 - Base 2', ...
    'PoIs, Drone 2 - Base 2', ...
    'PoIs, Drone 3 - Base 2', ...
    'PoIs, Drone 1 - Base 3', ...
    'PoIs, Drone 2 - Base 3', ...
    'PoIs, Drone 3 - Base 3', ...
    'PoIs, Drone 1 - Base 4', ...
    'PoIs, Drone 2 - Base 4', ...
    'PoIs, Drone 3 - Base 4')
set(legend1,...
    'Position',[0.742600415243804 0.23054979253112 0.161127709950681 0.681448828052848]);
pause

% Plot the overall searh plan of the considered area
figure(5)
% title('Operational Bases and their PoIs')
image(flip(img,1));
set(gca,'YDir','normal');
set(gcf, 'Position', [1200, 800, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])
hold on
pause
stem(x_fordrone31,y_fordrone31,'c>','LineStyle','none','MarkerFaceColor','c','MarkerSize',10)
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','c');
pause
h = plot(GLP31,'XData',[x_BASES(3); x_fordrone31],'YData',[y_BASES(3); y_fordrone31],'NodeColor','c','MarkerSize',2,'LineWidth',2,'NodeLabel',{},'EdgeColor','k');
stem(x_fordrone31(outsidePathPoIs),y_fordrone31(outsidePathPoIs),'c>','LineStyle','none','MarkerFaceColor','r','MarkerSize',10)
legend2 = legend('PoIs, Drone 1 - Base 3', ...
    'Base 1', ...
    'Search Path, Drone 1 - Base 3', ...
    'PoIs not included in the pre-loaded flight plan')
set(legend2,'Position',[0.61656708450854 0.341113413847664 0.272404785045855 0.111514525294798]);
pause

% This function generates N_random_meshes random meshes with at most
% N_max_user_per_mesh survivors per mesh
% Uso RADIUS_COVERAGE_SCALED_WIFI per generare le mesh networks per il
% discovery almeno, in realtá dorebbe essere BT, bisogna ragionarci
% [random_meshes_pattern_BT,random_meshes_pattern_WIFI,x_centers,y_centers,overall_random_meshes_pattern_BT,overall_random_meshes_pattern_WIFI,N_users_per_mesh] = generateMultipleRandomMeshes(N_samples,N_random_meshes,N_max_user_per_mesh,MAX_X,MAX_Y,RADIUS_COVERAGE_SCALED_WIFI,RADIUS_COVERAGE_SCALED_WIFI,X_axis,Y_axis);
%
% figure(100)
% surf(X_axis,Y_axis,overall_random_meshes_pattern_BT,'LineStyle','none')
% hold on
% stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',30,'MarkerFaceColor','c');
% axis([1 1101 1 834])
% set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
% view([0 90]);

figure(101)
surf(X_axis,Y_axis,overall_random_meshes_pattern_WIFI,'LineStyle','none')
hold on
stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',30,'MarkerFaceColor','c');
axis([1 1101 1 834])
set(gcf, 'Position', [1, 1, 1071.2000000000003, 771.2000])
view([0 90]);
pause


% figure(11114)
% % title('Operational Bases and their PoIs')
% image(flip(img,1));
% set(gca,'YDir','normal');
% set(gcf, 'Position', [1200, 800, 1071.2000000000003, 771.2000])
% axis([1 1101 1 834])
% hold on
% pause
% stem(x_fordrone31,y_fordrone31,'c>','LineStyle','none','MarkerFaceColor','c','MarkerSize',10)
% stem(x_BASES(3),y_BASES(3),'co','LineStyle','none','LineWidth',2,'MarkerSize',19,'MarkerFaceColor','c');
% pause
% h = plot(GLP31,'XData',[x_BASES(3); x_fordrone31],'YData',[y_BASES(3); y_fordrone31],'NodeColor','c','MarkerSize',2,'LineWidth',2,'NodeLabel',{},'EdgeColor','k');
% stem(x_fordrone31(outsidePathPoIs),y_fordrone31(outsidePathPoIs),'c>','LineStyle','none','MarkerFaceColor','r','MarkerSize',10)
% legend('PoIs, Drone 1 - Base 3', ...
%     'Base 1', ...
%     'Search Path, Drone 1 - Base 3', ...
%     'PoIs not included in the Path')

% Some variables
discovered_meshes31 = [];
N_users_discovered_meshes31 = [];
discoveredMesh31 = zeros(N_random_meshes,1);
overall_discovered_meshes_pattern31 = zeros(N_samples,N_samples);
visitedPoIsAll31 = zeros(N_poi31,1);
PoIsInPath31 = longestPath31;
actualFT31 = 0;
nextPoI31 = longestPath31(1);

figure(11116)
surf(X_axis,Y_axis,overall_discovered_meshes_pattern31,'LineStyle','none')
set(gcf, 'Position', [1+1071.2000000000003, 1, 1071.2000000000003, 771.2000])
axis([1 1101 1 834])
hold on
pause

for t = 1 : length(pts31)
    x_drone = pts31(t,1);
    y_drone = pts31(t,2);
    
    % Update FLIGHT TIME
    if t > 1
        actualFT31 = actualFT31 + sqrt((x_drone-pts31(t-1,1))^2+(y_drone-pts31(t-1,2))^2)/speed_on_scaled_map;
    end
    
    if t == ceil(length(pts31)/3)
        figure(5)
        stem(x_fordrone31(removedPoIs),y_fordrone31(removedPoIs),'c>','LineStyle','none','MarkerFaceColor','k','MarkerSize',10,'DisplayName','PoIs removed from the discovery phase')
        drawnow
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
        if random_meshes_pattern_WIFI(Y_axis(:,1)==y_drone,X_axis(1,:)==x_drone,m) == 1 && ~discoveredMesh31(m) % Sensing of meshes, it means that the drone is inside the sensing range of the drone
            discovered_meshes31(:,:,i) = random_meshes_pattern_WIFI(:,:,m); % Get info
            N_users_discovered_meshes31(i) = N_users_per_mesh(m);
            discoveredMesh31(m) = 1;
            overall_discovered_meshes_pattern31 = overall_discovered_meshes_pattern31 + discovered_meshes31(:,:,i); % Update the discovery Map
            i = i + 1;
            
            figure(11116)
            %             stem(x_drone,y_drone,'k','filled','LineStyle','none')
            %             set(gcf, 'Position', [1+1071.2000000000003, 1, 1071.2000000000003, 771.2000])
            %             axis([1 1101 1 834])
            %             hold on
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
    
    if t == 1
        figure(5)
        s = stem(x_drone,y_drone,'r','filled','LineStyle','none','DisplayName','Actual flight path')
    else
        figure(5)
        s = stem(x_drone,y_drone,'r','filled','LineStyle','none');
        s.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end

% save('test_data.mat')