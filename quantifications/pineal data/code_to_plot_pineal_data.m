%% code to plot the data of Percy on pineal data
addpath(genpath('\\forskning.it.ntnu.no\ntnu\mh\ikom\jurischyaksi\Nathalie\data\github\DGama_et_al_CR_2024\quantifications\pineal data'))
%% pineal data: number of cilia
% data were pulled out of the excel sheet "pineal gland quantifications
% smh.xlsx" and saved into a mat file
load('\\forskning.it.ntnu.no\ntnu\mh\ikom\jurischyaksi\Nathalie\data\github\DGama_et_al_CR_2024\quantifications\pineal data\Pineal_data.mat');
cfg.Mutcolor='m'; %enter the color you want for your mutant display, 'm'= magenta, 'c'=cyan
index=3;
data=pineal_ciliaNum;
mat=table2array(data(:,index));
idx=table2array(data(:,2));
% plot all the individual dataset
for i=1:4
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
ylabel('number cilia')
text(0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
    num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
xticks([1 1.5])
ylim([0 60])
xticklabels({'ctrl','mut'})
clear toplotC toplotM
hold off
title(pineal_ciliaNum.Properties.VariableNames(i))

%% pineal data: area
% data were pulled out of the excel sheet "pineal gland quantifications
% smh.xlsx" and saved into a mat file
load('X:\Nathalie\data\github\DGama_et_al_CR_2024\quantifications\pineal data\Pineal_data.mat');
cfg.Mutcolor='m'; %enter the color you want for your mutant display, 'm'= magenta, 'c'=cyan
index=3;
data=pineal_size;
mat=table2array(data(:,index));
idx=table2array(data(:,2));
% plot all the individual dataset
figure
set(gcf,  'Position',[100 100 150 150])
toplotC=mat(idx==1,1);
toplotM=mat(idx==2,1);
swarmchart(ones(length(toplotC),1), mean(toplotC,2,'omitnan'),80,'k','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([0.8 1.2], repmat(mean(mean(toplotC,2,'omitnan'),'omitnan'),1,2),'Color','k')
errorbar(1,mean(mean(toplotC,2,'omitnan'),'omitnan'), std(mean(toplotC,2,'omitnan'),'omitnan'),'Color','k')
swarmchart(1.5*ones(length(toplotM),1), mean(toplotM,2,'omitnan'),80,'m','filled','MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'XJitterWidth',0.3), hold on
line([1.3 1.7], repmat(mean(mean(toplotM,2,'omitnan'),'omitnan'),1,2),'Color','k')
errorbar(1.5,mean(mean(toplotM,2,'omitnan'),'omitnan'), std(mean(toplotM,2,'omitnan'),'omitnan'),'Color','k')
xlim([0.7 1.8]), ylim([0.9*min(cat(1,toplotC,toplotM)) 1.1*max(cat(1,toplotC,toplotM))])
ylabel('area (um2)')
text(0.7,0.9*min(cat(1,toplotC,toplotM)),['p= '...
    num2str(ranksum(mean(toplotC,2,'omitnan'),mean(toplotM,2,'omitnan')),'%.4f')]);
xticks([1 1.5])
%ylim([0 4000])
xticklabels({'ctrl','mut'})
clear toplotC toplotM
hold off
title(data.Properties.VariableNames(index))


