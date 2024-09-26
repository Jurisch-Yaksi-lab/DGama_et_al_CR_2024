%% code to plot the data of Percy on pineal data
addpath(genpath('X:\Nathalie\data\github\DGama_et_al_CR_2024'))
%% pineal data
% data were pulled out of the excel sheet
load('X:\Nathalie\data\github\DGama_et_al_CR_2024\quantifications\Figure 1 quantifications\data_brainMeasurements.mat')
cfg.Mutcolor='m'; %enter the color you want for your mutant display, 'm'= magenta, 'c'=cyan
index=[2:2:28];
mat=table2array(data(:,index));
idx=table2array(data(:,1));
%% plot all the individual dataset
for i=1:size(mat,2)
figure
set(gcf,  'Position',[100 100 150 150])
toplotC=mat(idx==1,i);
toplotM=mat(idx==2,i);
swarmchart(ones(length(toplotC),1), mean(toplotC,2,'omitnan'),80,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([0.8 1.2], repmat(mean(mean(toplotC,2,'omitnan'),'omitnan'),1,2),'Color','k')
errorbar(1,mean(mean(toplotC,2,'omitnan'),'omitnan'), std(mean(toplotC,2,'omitnan'),'omitnan'),'Color','k')
swarmchart(1.5*ones(length(toplotM),1), mean(toplotM,2,'omitnan'),80,'m','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([1.3 1.7], repmat(mean(mean(toplotM,2,'omitnan'),'omitnan'),1,2),'Color','k')
errorbar(1.5,mean(mean(toplotM,2,'omitnan'),'omitnan'), std(mean(toplotM,2,'omitnan'),'omitnan'),'Color','k')
xlim([0.7 1.8]), ylim([0.9*min(cat(1,toplotC,toplotM)) 1.1*max(cat(1,toplotC,toplotM))])
%ylabel('um')
text(0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
    num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
xticks([1 1.5])
%ylim([0 70])
xticklabels({'ctrl','mut'})
clear toplotC toplotM
hold off
title(data.Properties.VariableNames(index(i)))
end

%%
%% plot the tel data only
    figure, hold on
    set(gcf,  'Position',[100 100 150 200])
    marker=['o';'o';'o';'o'];
    %marker=['s';'>';'o';'<'];
for i=1:3
    toplotC=mat(idx==1,i);
    toplotM=mat(idx==2,i);
    s1 = swarmchart((i-1)+ones(length(toplotC),1), mean(toplotC,2,'omitnan'),80,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s1.Marker = marker(i);
    line((i-1)+[0.8 1.2], repmat(mean(mean(toplotC,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1,mean(mean(toplotC,2,'omitnan'),'omitnan'), std(mean(toplotC,2,'omitnan'),'omitnan'),'Color','k')
    s2 = swarmchart((i-1)+1.5*ones(length(toplotM),1), mean(toplotM,2,'omitnan'),80,'m','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s2.Marker = marker(i);    line((i-1)+[1.3 1.7], repmat(mean(mean(toplotM,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1.5,mean(mean(toplotM,2,'omitnan'),'omitnan'), std(mean(toplotM,2,'omitnan'),'omitnan'),'Color','k')
    text((i-1)+0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
        num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
    xticks([1 1.5 2 2.5 3 3.5])
    xticklabels({'ctrl','mut','ctrl','mut','ctrl','mut'})
    clear toplotC toplotM
    text (i,250,data.Properties.VariableNames(index(i)))
    xlim([0.5 4])
    ylabel('um')
end

%% plot the OT data only
    figure, hold on
    set(gcf,  'Position',[100 100 150 200])
    marker=['o';'o';'o';'o'];
    %marker=['s';'>';'o';'<'];
for i=1:3
    k=i+3;
    toplotC=mat(idx==1,k);
    toplotM=mat(idx==2,k);
    s1 = swarmchart((i-1)+ones(length(toplotC),1), mean(toplotC,2,'omitnan'),80,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s1.Marker = marker(i);
    line((i-1)+[0.8 1.2], repmat(mean(mean(toplotC,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1,mean(mean(toplotC,2,'omitnan'),'omitnan'), std(mean(toplotC,2,'omitnan'),'omitnan'),'Color','k')
    s2 = swarmchart((i-1)+1.5*ones(length(toplotM),1), mean(toplotM,2,'omitnan'),80,'m','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s2.Marker = marker(i);
    line((i-1)+[1.3 1.7], repmat(mean(mean(toplotM,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1.5,mean(mean(toplotM,2,'omitnan'),'omitnan'), std(mean(toplotM,2,'omitnan'),'omitnan'),'Color','k')
    text((i-1)+0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
        num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
    xticks([1 1.5 2 2.5 3 3.5])
    xticklabels({'ctrl','mut','ctrl','mut','ctrl','mut'})
    clear toplotC toplotM
    text (i,100,data.Properties.VariableNames(index(k)))
    xlim([0.5 4])
    ylabel('um')
end

%% plot the HB data only
    figure, hold on
    set(gcf,  'Position',[100 100 150 200])
    column=[7 9 10];
    marker=['o';'o';'o';'o'];
    %marker=['s';'>';'o';'<'];
for i=1:3
    k=column(i);
    toplotC=mat(idx==1,k);
    toplotM=mat(idx==2,k);
    s1 = swarmchart((i-1)+ones(length(toplotC),1), mean(toplotC,2,'omitnan'),80,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s1.Marker = marker(i);
    line((i-1)+[0.8 1.2], repmat(mean(mean(toplotC,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1,mean(mean(toplotC,2,'omitnan'),'omitnan'), std(mean(toplotC,2,'omitnan'),'omitnan'),'Color','k')
    s2 = swarmchart((i-1)+1.5*ones(length(toplotM),1), mean(toplotM,2,'omitnan'),80,'m','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s2.Marker = marker(i);    line((i-1)+[1.3 1.7], repmat(mean(mean(toplotM,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1.5,mean(mean(toplotM,2,'omitnan'),'omitnan'), std(mean(toplotM,2,'omitnan'),'omitnan'),'Color','k')
    text((i-1)+0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
        num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
    xticks([1 1.5 2 2.5 3 3.5])
    xticklabels({'ctrl','mut','ctrl','mut','ctrl','mut'})
    clear toplotC toplotM
    text (i,200,data.Properties.VariableNames(index(k)))
    xlim([0.5 4])
    ylabel('um')
end

%% plot the pH3 data only
    figure, hold on
    set(gcf,  'Position',[100 100 350 250])
    column=[11:14];
    marker=['o';'o';'o';'o'];
    %marker=['s';'>';'o';'<'];
for i=1:4
    k=column(i);
    toplotC=mat(idx==1,k);
    toplotM=mat(idx==2,k);
    s1 = swarmchart((i-1)+ones(length(toplotC),1), mean(toplotC,2,'omitnan'),80,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s1.Marker = marker(i);
    line((i-1)+[0.8 1.2], repmat(mean(mean(toplotC,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1,mean(mean(toplotC,2,'omitnan'),'omitnan'), std(mean(toplotC,2,'omitnan'),'omitnan'),'Color','k')
    s2 = swarmchart((i-1)+1.5*ones(length(toplotM),1), mean(toplotM,2,'omitnan'),80,'m','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s2.Marker = marker(i);    line((i-1)+[1.3 1.7], repmat(mean(mean(toplotM,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1.5,mean(mean(toplotM,2,'omitnan'),'omitnan'), std(mean(toplotM,2,'omitnan'),'omitnan'),'Color','k')
    text((i-1)+0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
        num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
    xticks([1 1.5 2 2.5 3 3.5 4 4.5])
    xticklabels({'ctrl','mut','ctrl','mut','ctrl','mut','ctrl','mut'})
    clear toplotC toplotM
    text (i,5,data.Properties.VariableNames(index(k)))
    xlim([0.5 5])
    ylabel('number cells')
end

%% for microglia data
% data were pulled out of the excel sheet
load('X:\Nathalie\data\github\DGama_et_al_CR_2024\quantifications\Figure 1 quantifications\microgliaCount.mat')
cfg.Mutcolor='m'; %enter the color you want for your mutant display, 'm'= magenta, 'c'=cyan
index=[2:size(data,2)];
mat=table2array(data(:,index));
idx=table2array(data(:,1));

% plot the data 
    figure, hold on
    set(gcf,  'Position',[100 100 350 250])
    column=[1:4];
    marker=['o';'o';'o';'o'];
    %marker=['s';'>';'o';'<'];
for i=1:4
    k=column(i);
    toplotC=mat(idx==1,k);
    toplotM=mat(idx==2,k);
    s1 = swarmchart((i-1)+ones(length(toplotC),1), mean(toplotC,2,'omitnan'),80,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s1.Marker = marker(i);
    line((i-1)+[0.8 1.2], repmat(mean(mean(toplotC,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1,mean(mean(toplotC,2,'omitnan'),'omitnan'), std(mean(toplotC,2,'omitnan'),'omitnan'),'Color','k')
    s2 = swarmchart((i-1)+1.5*ones(length(toplotM),1), mean(toplotM,2,'omitnan'),80,'m','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s2.Marker = marker(i);    line((i-1)+[1.3 1.7], repmat(mean(mean(toplotM,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1.5,mean(mean(toplotM,2,'omitnan'),'omitnan'), std(mean(toplotM,2,'omitnan'),'omitnan'),'Color','k')
    text((i-1)+0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
        num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
    xticks([1 1.5 2 2.5 3 3.5 4 4.5])
    xticklabels({'ctrl','mut','ctrl','mut','ctrl','mut','ctrl','mut'})
    clear toplotC toplotM
    text (i,5,data.Properties.VariableNames(index(k)))
    xlim([0.5 5])
    ylabel('number cells')
end

%% for brain ventricle data
% data were pulled out of the excel sheet
load('X:\Nathalie\data\github\DGama_et_al_CR_2024\quantifications\Figure 1 quantifications\data_ventricleSize.mat')
cfg.Mutcolor='m'; %enter the color you want for your mutant display, 'm'= magenta, 'c'=cyan
index=[2:size(data,2)];
mat=table2array(data(:,index));
idx=table2array(data(:,1));

% plot the data 
    figure, hold on
    set(gcf,  'Position',[100 100 350 250])
    column=[1,7,11];
    marker=['o';'o';'o';'o'];
    %marker=['s';'>';'o';'<'];
for i=1:3
    k=column(i);
    toplotC=mat(idx==1,k);
    toplotM=mat(idx==2,k);
    s1 = swarmchart((i-1)+ones(length(toplotC),1), mean(toplotC,2,'omitnan'),80,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s1.Marker = marker(i);
    line((i-1)+[0.8 1.2], repmat(mean(mean(toplotC,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1,mean(mean(toplotC,2,'omitnan'),'omitnan'), std(mean(toplotC,2,'omitnan'),'omitnan'),'Color','k')
    s2 = swarmchart((i-1)+1.5*ones(length(toplotM),1), mean(toplotM,2,'omitnan'),80,'m','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
    s2.Marker = marker(i);    line((i-1)+[1.3 1.7], repmat(mean(mean(toplotM,2,'omitnan'),'omitnan'),1,2),'Color','k')
    errorbar((i-1)+1.5,mean(mean(toplotM,2,'omitnan'),'omitnan'), std(mean(toplotM,2,'omitnan'),'omitnan'),'Color','k')
    text((i-1)+0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
        num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
    xticks([1 1.5 2 2.5 3 3.5])
    xticklabels({'ctrl','mut','ctrl','mut','ctrl','mut'})
    clear toplotC toplotM
    text (i,5,data.Properties.VariableNames(index(k)))
    xlim([0.5 4])
    ylabel('area (um3)')
    ax = gca;
    ax.YAxis.Exponent = 3;    
end