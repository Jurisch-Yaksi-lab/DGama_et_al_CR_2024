function nj_plotCellsThreshold(ctrlFish,mutFish, cfg)

% written by Nathalie Jurisch-Yaksi December 2022
% this code does
% 1. calculate active cells based on a threshold defined under cfg
% 2. plot the activity of cells based on the time they spend above 4*the 8th percentile
% 3. output 2 figures, one histogram and one scatter with ranksum statistics

threshold=cfg.threshold;
percentile=cfg.percentile; 
binSize=cfg.binSize;
valueA=cfg.valueA; 
valueB=cfg.valueB;
brainRegion=cfg.brainRegion;


% FIGURES: PLOT the % of time a cell is above a threshold of x*percentile============

close all
clear Nctrl Nmut edges

% below will plot the data for each fish (i) and each brain region (k)
for k=1:4;
figure (1), hold on

% plot ctrl fish
for i=1:size(ctrlFish,1)
figure (1),
subplot(2,2,k),
matrix=ctrlFish{i, k+1}.resampled_DFF(1:end,:);
mat=matrix>threshold*prctile(matrix,percentile,2);
[Nctrl(i,:),edges(i,:)]=histcounts(100*sum(double(mat),2)/size(matrix,2), [0:binSize:100],'Normalization', cfg.type); 
plot(edges(i,1:end-1)+binSize/2, (Nctrl(i,:)),'k','LineWidth',0.5), hold on
clear mat matrix
end

% plot mut fish on top of same figure
for i=1:size(mutFish,1)
figure (1), 
subplot(2,2,k),
matrix=mutFish{i, k+1}.resampled_DFF(1:end,:);
mat=matrix>threshold*prctile(matrix,percentile,2);
[Nmut(i,:),edges(i,:)]=histcounts(100*sum(double(mat),2)/size(matrix,2), [0:binSize:100],'Normalization', cfg.type); 
plot(edges(i,1:end-1)+binSize/2, (Nmut(i,:)),cfg.Mutcolor,'LineWidth',0.5), hold on
clear mat matrix
end

% plot the average of ctrl and mut on top in bold
figure (1), 
subplot(2,2,k),
plot(edges(i,1:end-1)+binSize/2, (mean(Nctrl,1)),'k','LineWidth',3), hold on
plot(edges(i,1:end-1)+binSize/2, (mean(Nmut,1)),cfg.Mutcolor,'LineWidth',3), hold on
title (brainRegion(k,:))
xlabel('% time above threshold')
ylabel('% cells')
xlim([0 100])
ylim([0 Inf])


% plot a shadded Error Bar with the average/SEM of ctrl and mut 
figure (10), 
subplot(2,2,k),
shadedErrorBar(edges(1,1:end-1)+binSize/2, 100*(mean(Nctrl,1)), 100*(std((Nctrl),[],1)/sqrt(size(Nctrl,1))),'lineprops', 'k'), hold on
shadedErrorBar(edges(1,1:end-1)+binSize/2, 100*(mean(Nmut,1)), 100*(std((Nmut),[],1)/sqrt(size(Nmut,1))),'lineprops', cfg.Mutcolor), 
title ([brainRegion(k,:) ', SEM'])
xlabel(['% time above ' num2str(threshold) '*' num2str(percentile) 'th percentile'])
ylabel('% cells')
xlim([0 100])
ylim([0 Inf])

% this needs to be done only with probability histograms and not cdf
% histograms
if contains(cfg.type, 'probability');
% calculate the number of cells above or below thresholds valueA and valueB
% for controls
aboveC(:,k)=sum(Nctrl(:,edges(1,1:end-1)>=valueA),2);
belowC(:,k)=sum(Nctrl(:,edges(1,1:end-1)<valueB),2);
% for mutants
aboveM(:,k)=sum(Nmut(:,edges(1,1:end-1)>=valueA),2);
belowM(:,k)=sum(Nmut(:,edges(1,1:end-1)<valueB),2);

% plot a scatter of ctrl and mut %cells above/below thresholds
figure (20)
subplot(2,4,2*k-1) 
swarmchart(ones(size(belowC,1),1),100*belowC(:,k),50,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([0.6 1.4], repmat(mean(100*belowC(:,k)),1,2),'Color','k')
errorbar(1,mean(100*belowC(:,k)), std(100*belowC(:,k)),'Color','k')
swarmchart (2*ones(size(belowM,1),1),100*belowM(:,k),50,cfg.Mutcolor,'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3);
line([1.6 2.4], repmat(mean(100*belowM(:,k)),1,2),'Color',cfg.Mutcolor)
errorbar(2,mean(100*belowM(:,k)), std(100*belowM(:,k)),'Color',cfg.Mutcolor)
xticks([1 2])
xticklabels({'ctrl','mut'})
title(brainRegion(k,:))
xlim([0 3]), ylim([0 inf])
ylabel(['% inactive cells <' num2str(valueB) '%'])
text(0,5, num2str(ranksum(belowC(:,k),belowM(:,k)),'%.3f'));
subplot(2,4,2*k) 
swarmchart(ones(size(aboveC,1),1),100*aboveC(:,k),50,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([0.6 1.4], repmat(mean(100*aboveC(:,k)),1,2),'Color','k')
errorbar(1,mean(100*aboveC(:,k)), std(100*aboveC(:,k)),'Color','k')
swarmchart (2*ones(size(aboveM,1),1),100*aboveM(:,k),50,cfg.Mutcolor,'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3);
line([1.6 2.4], repmat(mean(100*aboveM(:,k)),1,2),'Color',cfg.Mutcolor)
errorbar(2,mean(100*aboveM(:,k)), std(100*aboveM(:,k)),'Color',cfg.Mutcolor)
xticks([1 2])
xticklabels({'ctrl','mut'})
title(brainRegion(k,:))
xlim([0 3]), ylim([0 inf])
ylabel(['% active cells >' num2str(valueA) '%'])
text(0,5, num2str(ranksum(aboveC(:,k),aboveM(:,k)),'%.4f'));

else
    display ('no plot generated')
end
end



saveas(figure(10), [cfg.path_data 'Analysed' filesep '_RespCells_histogram.fig'])
saveas(figure(20), [cfg.path_data 'Analysed' filesep '_RespCells_scatter.fig'])

%% BELOW IS FOR SANITY CHECK TO SHOW THAT EVERYTHING WORKS WELL========================
% 
% %% FIGURES 5B: PLOT the % of time a cell is above a threshold of x*percentile============
% % this code plot a lot of subgraphs that can be useful to double check that
% % everything is right
% 
% close all
% for i=8%:size(ctrlFish,1)
%     for k=1:4
% matrix=mutFish{i, k+1}.resampled_DFF(1:end,:);
% mat=matrix>threshold*prctile(matrix,percentile,2);
% figure, 
% subplot(3,2,1:2), imagesc(mat), title(['above ' num2str(threshold) '* 10th percentile']), colorbar
% subplot(3,2,3:4),  imagesc(matrix), caxis([0 50]), title('raw data'), colorbar
% subplot(3,2,5),  imagesc(std(matrix,[],2)), caxis([0 50]), title([num2str(threshold) '* 10th percentile']), colorbar
% subplot(3,2,6),  imagesc(100*sum(double(mat),2)/size(matrix,2)), caxis([0 100]), title(['% above ' num2str(threshold) '* 10th percentile']), colorbar
%    clear mat matrix
%     end
% end
% 
% %% FIGURES 5C: PLOT the time a cell is above a threshold of x*percentile============
% % this code is good to acertain that he threshold is acurate
% 
% close all
% for i=8%:size(ctrlFish,1)
%     for k=4%:4
% matrix=mutFish{i, k+1}.resampled_DFF(1:150,:); %put around 150 cells to be able to see something
% mat=matrix>threshold*prctile(matrix,percentile,2);
% figure, 
% subplot(3,2,1:2), imagesc(mat), title(['above ' num2str(threshold) '* 10th percentile']), colorbar
% subplot(3,2,3:4),  imagesc(matrix), caxis([0 50]), title('raw data'), colorbar
% subplot(3,2,5),  imagesc(std(matrix,[],2)), caxis([0 50]), title([num2str(threshold) '* 10th percentile']), colorbar
% subplot(3,2,6),  imagesc(100*sum(double(mat),2)/size(matrix,2)), caxis([0 100]), title(['% above ' num2str(threshold) '* 10th percentile']), colorbar
% 
% figure, 
% for j=1:size(matrix,1)
% plot(10*j+3*mat(j,:),cfg.Mutcolor), hold on, plot(10*j+2*zscore(matrix(j,:)),'k'),
% end

% clear mat matrix
%     end
% end



