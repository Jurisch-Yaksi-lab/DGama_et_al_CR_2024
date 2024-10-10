function nj_correlatonVSdistance_v2(ctrlFish, mutFish, cfg)

%% THIS CODE IS TO RECOVER THE DISTANCE AND THE CORRELATION BETWEEN NEURONS
%% this is work in progress and adapted to Percy's data

brainRegion=cfg.brainRegion;

%% STEP 1: LOAD THE xyz data

for xx=1:2;

if xx==1;
    data=ctrlFish;
elseif xx==2;
    data=mutFish;
end

for j=1:size(data,1);

for k=1:4;

clear mat_dist mat_dist mat_corr mat_corr
%% calculate distance between neurons from centroids data------------------
mat_dist=triu(squareform(pdist(data{j, k+1}.xyz(:,:))),1);

% will only select the upper triangle using logical
mat=ones(size(mat_dist,1),size(mat_dist,2));
mat=logical(triu(mat,1)); %only keep the upper triangle
mat=mat(:);

mat_dist=mat_dist(:);
mat_dist=mat_dist(mat);
% figure, imagesc(mat_dist) % make sure the data is good
% figure, histogram(mat_dist)

%% to check whether the distance is actually correct on the raw data-------
% cell1=1
% cell2=1000
% figure, scatter3(xyz(:,1),xyz(:,2),xyz(:,3),'.'), hold on
% scatter3(xyz(cell1,1),xyz(cell1,2),xyz(cell1,3),'filled','r'), hold on
% scatter3(xyz(cell2,1),xyz(cell2,2),xyz(cell2,3),'filled','g')
% title (['r cell' cell1 ' and g cell' cell2])
% mat_dist(cell1,cell2)

%% calculate correlation matrix for the DFF data----------------------------
mat_corr = corrcoef(data{j, k+1}.DFF.');
mat_corr = mat_corr(:);
% select only the upper triangle with the mat from above
mat_corr=mat_corr(mat);
% figure, imagesc(mat_corr) % make sure that the data is coorect
% figure, histogram(mat_corr()) % plot the histogram of the data

%% plot a scatter of distance versus correlation---------------------------


% %%
% figure, scatter(mat_dist(:),mat_corr(:),'.')
% xlabel('distance in um')
% ylabel('correlation')


%% bin the data, choose the numbers of bins
width= cfg.binSize;
bins=[0:width:400];
%% calculate the mean and std for the bins
clear meancorrUP meancorrDOWN
clear stdcorrUP stdcorrDOWN
for i=1:size(bins,2)-1
meancorrUP(i)=mean((mat_corr(mat_dist>=bins(i) & mat_dist<bins(i+1) & mat_corr>0)));
stdcorrUP(i)=std((mat_corr(mat_dist>=bins(i) & mat_dist<bins(i+1) & mat_corr>0)));
meancorrDOWN(i)=mean((mat_corr(mat_dist>=bins(i) & mat_dist<bins(i+1) & mat_corr<0)));
stdcorrDOWN(i)=std((mat_corr(mat_dist>=bins(i) & mat_dist<bins(i+1) & mat_corr<0)));

end
%% plot the scatter together with the binned data--------------------------
% figure, 
% scatter(mat_dist(:),(mat_corr(:)),'.')
% hold on
% e=errorbar(bins(2:end)-width/2,meancorrUP,stdcorrUP);
% xlabel('distance in um')
% ylabel('correlation')
% e.MarkerSize = 10;
% e.Color = 'k';
% e.CapSize = 15;
% e.LineWidth=2;
% f=errorbar(bins(2:end)-width/2,meancorrDOWN,stdcorrDOWN);
% xlabel('distance in um')
% ylabel('correlation')
% f.MarkerSize = 10;
% f.Color = 'r';
% f.CapSize = 15;
% f.LineWidth=2;
    

%% plot the scatter together with the mean, split positive from negative correlations
if xx==1;
figure (10+j), hold on
elseif xx==2;
figure (30+j), hold on   
end
subplot(2,2,k)
h = binscatter(mat_dist(:),(mat_corr(:)),[50 100]); hold on
%  h.ShowEmptyBins = 'on';
ax = gca;
ax.ColorScale = 'log';
colormap(gca,flipud(hot)), hold on
plot(bins(2:end)-width/2,meancorrUP,'m', 'LineWidth',3);
plot(bins(2:end)-width/2,meancorrDOWN,'c', 'LineWidth',3);
title(brainRegion(k,:))
ylim([-0.3 0.8])
suptitle(num2str(data{j, 1}.metadata.fishNb  ))

%%
if xx==1;
    ctrlCorrUP(j,k,:)=meancorrUP;
    ctrlCorrDOWN(j,k,:)=meancorrDOWN;
elseif xx==2;
    mutCorrUP(j,k,:)=meancorrUP;
    mutCorrDOWN(j,k,:)=meancorrDOWN;
end

clear meancorrUP meancorrDOWN 

end
saveas(gcf, [cfg.path_data 'Analysed' filesep num2str(data{j, 1}.metadata.fishNb) 'CorrVSdistance_scatter.png'])

end

end
 


%% plot all data
% figure, hold on
% for k=1:4
%     subplot(2,2,k)
% plot(bins(2:end)-width/2,squeeze(ctrlCorrDOWN(:,k,:)).','k'), hold on
% plot(bins(2:end)-width/2,squeeze(ctrlCorrUP(:,k,:)).','k'), 
% plot(bins(2:end)-width/2,squeeze(mutCorrDOWN(:,k,:)).',cfg.Mutcolor), 
% plot(bins(2:end)-width/2,squeeze(mutCorrUP(:,k,:)).',cfg.Mutcolor), 
% yline(0,'--k')
% xlabel('distance um')
% ylabel('mean correlation')
% title(brainRegion(k,:))
% end

%% FIGURE, plot correlation versus distance as shaddederrorbars. SEM
figure (98), hold on
for k=1:4
    subplot(2,2,k)
shadedErrorBar(bins(2:end)-width/2,squeeze(nanmean(ctrlCorrDOWN(:,k,:),1)),squeeze(nanstd(ctrlCorrDOWN(:,k,:),1)/sqrt(size(ctrlCorrDOWN,1))),'lineProps', 'k'), hold on
shadedErrorBar(bins(2:end)-width/2,squeeze(nanmean(ctrlCorrUP(:,k,:),1)),squeeze(nanstd(ctrlCorrUP(:,k,:),1)/sqrt(size(ctrlCorrUP,1))),'lineProps','k'), 
shadedErrorBar(bins(2:end)-width/2,squeeze(nanmean(mutCorrDOWN(:,k,:),1)),squeeze(nanstd(mutCorrDOWN(:,k,:),1)/sqrt(size(mutCorrDOWN,1))),'lineProps',cfg.Mutcolor), 
shadedErrorBar(bins(2:end)-width/2,squeeze(nanmean(mutCorrUP(:,k,:),1)),squeeze(nanstd(mutCorrUP(:,k,:),1)/sqrt(size(mutCorrUP,1))),'lineProps',cfg.Mutcolor), 
yline(0,'--k')
xline(60,'--k')
xlabel('distance um')
ylabel('mean correlation')
title(brainRegion(k,:))
end

% calculate the number of cells above or below thresholds valueA and valueB
% for controls
%% FIGURE, plot mean correlation for the first few bins
bin=3;
for k=1:4
ctrlUP(k,:)=squeeze(nanmean(ctrlCorrUP(:,k,1:bin),3));
ctrlDOWN(k,:)=squeeze(nanmean(ctrlCorrDOWN(:,k,1:bin),3));
mutUP(k,:)=squeeze(nanmean(mutCorrUP(:,k,1:bin),3));
mutDOWN(k,:)=squeeze(nanmean(mutCorrDOWN(:,k,1:bin),3));

% plot a scatter of ctrl and mut %cells above/below thresholds
figure (99), hold on
subplot(2,4,2*k-1) 
swarmchart(ones(size(ctrlUP,2),1),ctrlUP(k,:),'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([0.6 1.4], repmat(mean(ctrlUP(k,:)),1,2),'Color','k')
errorbar(1,mean(ctrlUP(k,:)), std(ctrlUP(k,:)),'Color','k')
swarmchart(2*ones(size(mutUP,2),1),mutUP(k,:),cfg.Mutcolor,'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([1.6 2.4], repmat(mean(mutUP(k,:)),1,2),'Color',cfg.Mutcolor)
errorbar(2,mean(mutUP(k,:)), std(mutUP(k,:)),'Color',cfg.Mutcolor)
xticks([1 2])
xticklabels({'ctrl','mut'})
title(brainRegion(k,:))
xlim([0 3]), ylim([0 inf])
ylabel(['mean corr UP distance <' num2str(bin*width)])
text(0,0.01, num2str(ranksum(ctrlUP(k,:),mutUP(k,:)),'%.3f'));
subplot(2,4,2*k) 
swarmchart(ones(size(ctrlDOWN,2),1),ctrlDOWN(k,:),'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([0.6 1.4], repmat(mean(ctrlDOWN(k,:)),1,2),'Color','k')
errorbar(1,mean(ctrlDOWN(k,:)), std(ctrlDOWN(k,:)),'Color','k')
swarmchart(2*ones(size(mutDOWN,2),1),mutDOWN(k,:),cfg.Mutcolor,'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([1.6 2.4], repmat(mean(mutDOWN(k,:)),1,2),'Color',cfg.Mutcolor)
errorbar(2,mean(mutDOWN(k,:)), std(mutDOWN(k,:)),'Color',cfg.Mutcolor)
xticks([1 2])
xticklabels({'ctrl','mut'})
title(brainRegion(k,:))
xlim([0 3]), ylim([-inf 0])
ylabel(['mean corr DOWN distance <' num2str(bin*width)])
text(0,-0.01, num2str(ranksum(ctrlDOWN(k,:),mutDOWN(k,:)),'%.4f'));

end

saveas(figure(99), [cfg.path_data 'Analysed' filesep 'CorrVSdistance_scatter.fig'])
saveas(figure(98), [cfg.path_data 'Analysed' filesep 'CorrVSdistance_plot.fig'])

