%% code to plot the data of Percy on ventricular measurement
% data were pulled out of the excel sheet
load('X:\Nathalie\data\github\DGama_et_al_CR_2024\quantifications\Figure 1 quantifications\data_ventricleSize.mat')
cfg.Mutcolor='m'; %enter the color you want for your mutant display, 'm'= magenta, 'c'=cyan
index=[2:size(data,2)];
mat=table2array(data(:,index));
idx=table2array(data(:,1));
%%
for i=1:size(mat,2)
    figure
    set(gcf,  'Position',[100 100 250 150])
toplotC=mat(idx==1,i);
toplotM=mat(idx==2,i);
swarmchart(ones(length(toplotC),1), mean(toplotC,2,'omitnan'),80,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([0.8 1.2], repmat(mean(mean(toplotC,2,'omitnan'),'omitnan'),1,2),'Color','k')
errorbar(1,mean(mean(toplotC,2,'omitnan'),'omitnan'), std(mean(toplotC,2,'omitnan'),'omitnan'),'Color','k')
swarmchart(1.5*ones(length(toplotM),1), mean(toplotM,2,'omitnan'),80,cfg.Mutcolor,'filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([1.3 1.7], repmat(mean(mean(toplotM,2,'omitnan'),'omitnan'),1,2),'Color','k')
errorbar(1.5,mean(mean(toplotM,2,'omitnan'),'omitnan'), std(mean(toplotM,2,'omitnan'),'omitnan'),'Color','k')
xlim([0.7 1.8]), ylim([0.9*min(cat(1,toplotC,toplotM)) 1.1*max(cat(1,toplotC,toplotM))])
ylim([0 Inf])
text(0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
    num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
xticks([1 1.5])
xticklabels({'ctrl','mut'})
clear toplotC toplotM
hold off
title(data.Properties.VariableNames(index(i)))
end