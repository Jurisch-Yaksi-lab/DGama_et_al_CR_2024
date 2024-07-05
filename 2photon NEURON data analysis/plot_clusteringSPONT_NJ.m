function plot_clusteringSPONT_NJ (path, results) 

% uses the following function
% - sortrow from MATLAB
% - plotTraces from LL

% the outputs are two figures
% - figure 1, saved as _CLUSTERING is a heatmap of of the activity of cluster cells and 3D scatter
% - figure 2, saved as _CLUSTERING2 will be the average activity per cluster and the
% location of the cells

DFF=results.DFF;
idx=results.CLUSTERidx; % idx is the index of the cell
cfg=results.CLUSTERcfg;

% figure CLUSTERING will be a heatmap of the activity and 3D scatter
figure 
set(gcf, 'Position',[100 100 1800 650]);

% This will plot sorted traces based on the clustering 
sortedTraces=sortrows([idx DFF], 1);
ax1 = subplot(1, 5, 1:3);
plot_Traces(sortedTraces, -20, 80, cfg) 
ax2 = subplot(1, 5, 4:5);
% this will show each cluster in a different color, the colorbar will be
% reflecting which cluster is which color
color=jet;
for j=1:cfg.K
    kk=[];
kk=idx==j;
scatter3(results.xyz(kk,1),results.xyz(kk,2),results.xyz(kk,3),'filled', 'MarkerFaceColor',color(j*50,:), 'MarkerFaceAlpha', 0.5)
hold on
colormap(jet)
view(360,90); %new orientation
end
colorbar
saveas(gcf,[path, results.fishNb,'CLUSTERING_SPONTANEOUS.png'])


% figure CLUSTERING2 will be the average activity per cluster and the
% location of the cells
figure 
suptitle(num2str(results.fishNb))
set(gcf,  'Position',[50 50 1500 900])
title('mean activity cluster')
for i=1:cfg.K
    indexesNeurons{i}=find(idx==i);
    index=indexesNeurons{i};

brainRegion=[num2str(i), 'th cluster'];
DFF_selectedNeurons=[]; %empty the variable to ensure there are no problems
DFF_selectedNeurons=DFF(index, :);
subplot(cfg.K, 2, 2*i-1), plot(results.time(1:end)/60,mean(DFF_selectedNeurons,1)), title (['average activity for cluster ', num2str(i), ' with # cells ', num2str(length(index))])
xlabel ('min')
ylabel('% DFF')
box off
end
% this will show each cluster in a different color, the colorbar will be
% reflecting which cluster is which color
for i=1:cfg.K
kk=[];
subplot(cfg.K,2,2*i),
color=jet;
kk=idx==i;
scatter(results.xyz(kk,1),results.xyz(kk,2),'filled', 'MarkerFaceColor',color(i*50,:), 'MarkerFaceAlpha', 0.5)
xlim([0 max(results.xyz(:,1))])
ylim([0 max(results.xyz(:,2))])
axis off
end
colormap(gcf, 'jet')
saveas(gcf, [path, results.fishNb,'CLUSTERING.png'])
