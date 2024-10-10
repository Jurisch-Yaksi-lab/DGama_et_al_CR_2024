%% load and pull out the data from the imported table 
% this is the data after normalization. The matrix also include the GOterms
load('RNAseqData.mat')

data=table2array(RNAseq(:,[1,4:8]));
%padj is column 6 of data and FC is column 2
[data,index]=sortrows(data,6,'ascend');

%% make a volcano plot with log2FC and log10(pvalueAdj)
thres_p=0.1; % we only selected a threshold og p<0.1
% thres_FC=0.8;
% add the gene name for a selected set of genes

figure, hold on
idx=find(data(:,6)>thres_p);
scatter(data(:,2),-log10(data(:,6)),40,'k','filled')
idx=[];
idx=find(data(:,6)<=thres_p);
scatter(data(idx,2),-log10(data(idx,6)),40,'r','filled')
for i=[2, 23, 35, 36, 38, 41]
    text(data(i,2)+0.3,-log10(data(i,6))+0.1,num2str(table2array(RNAseq(i,3))));
    line([data(i,2) data(i,2)+0.3], [-log10(data(i,6)) -log10(data(i,6))+0.1], 'Color', 'k', 'LineWidth', 1)
end
yline(-log10(thres_p),'--k')
xline(0,'--k')
xlim([-6 6])

xlabel('log2FC')
ylabel('-log10(p-valueAdj)')
title('volcano plot smh')

%% find data with p_value adj below threshold

data=sortrows(data,2,'descend');
idx=data(find(data(:,6)<=thres_p),1); % find gene number for DEG

%% pull out the data from the imported table 
% counts and FC/p-values are not on the same table, use the gene number of
% DEG to identify them
count=table2array(counts(:,[1,4:11]));
mat=nan(length(idx),9);
for i=1:length(idx)
idx2=find(count(:,1)==idx(i));
mat(i,1)=idx(i);
mat(i,2:9)=count(idx2,2:9);
nameidx(i)=table2array(RNAseq(find(table2array(RNAseq(:,1))==idx(i)),3));
end

% plot  a heatmap of the data sorted, here is zscore
cmap = redbluecmap(9);
figure, imagesc(zscore(mat(:,2:9),[],2)), colormap(cmap)

%% make a clustergram of the z score of the DEG
cmap = redbluecmap(9);
% clustergram(zscore(data(idx,4:11),[],2),'Colormap',cmap) z score and
% standardization does the same
cg=clustergram(mat(:,2:9),'Standardize','row','Colormap',cmap, 'RowLabels',nameidx)
cgAxes =plot(cg); % Use the plot function to plot to a separate figure and output the axes
set(cgAxes, 'Clim', [-2 2]) % Set colour limit or other axes properties.



%% PLOT DATA FROM DAVID GO ANALYSIS
% DATA WAS UPLOADED ON DAVID USING THE ENTREZ_GENE_ID. IT WAS NOT POSSIBLE TO GENE THE GENE NAMES
% https://david.ncifcrf.gov/tools.jsp
% done on 11th April 2024
% data were downloaed and saved as excel files
% data were imported in matlab

%% plot BP data
bp=DavidBP;
sorted_data = sortrows(bp, 7,'ascend');
sorted_data = sortrows(sorted_data,6,'descend')
data=table2array(sorted_data(:,[3,6,7]));
names=table2array(sorted_data(:,2));

figure, scatter(data(:,2),[1:size(data,1)], 50*data(:,1), -log10(data(:,3)), 'filled'); 
hold on
scatter([1,1],[1,2],50*[1,5],[0,0,0],'filled')
colormap(cool); % Purple to red
colorbar
set(gca, 'YTick', 1:length(names), 'YTickLabel', names);
set(gca, 'YDir', 'reverse');
xlabel('Fold Enrichement')
xlim([0 Inf])
ylim([0 Inf])
title('BP')

%sorted_data = sortrows(bp, 9,'ascend');
mat=table2array(sorted_data(: ,(8:end)));
mat2=table();

for i=1:size(mat,1)
    for j=1:size(mat,2)
    if ~isnan(mat(i,j))
        mat2(i,j)= table2array(RNAseq(find(table2array(RNAseq(:,1))== mat(i,j)),3));
    end
    end
end
bp_gene=cat(2,sorted_data(:,1:7),mat2);
for i=1: size(bp_gene,2)-7
bp_gene.Properties.VariableNames{i+7}=['gene' num2str(i)];
end

%
writetable(bp_gene, 'bp_gene.csv');

%%
Rawdata=DavidCC;
sorted_data = sortrows(Rawdata, 7,'ascend');
sorted_data = sortrows(sorted_data,6,'descend')
data=table2array(sorted_data(:,[3,6,7]));
names=table2array(sorted_data(:,2));

figure, scatter(data(:,2),[1:size(data,1)], 50*data(:,1), -log10(data(:,3)), 'filled'); 
hold on
scatter([1,1],[1,2],50*[1,5],[0,0,0],'filled')
colormap(cool); % Purple to red
colorbar
set(gca, 'YTick', 1:length(names), 'YTickLabel', names);
set(gca, 'YDir', 'reverse');
xlabel('Fold Enrichement')
xlim([0 Inf])
ylim([0 Inf])
title('CC')

%sorted_data = sortrows(mat, 9,'ascend');
mat=table2array(sorted_data(: ,(8:end)));
mat2=table();

for i=1:size(mat,1)
    for j=1:size(mat,2)
    if ~isnan(mat(i,j))
        mat2(i,j)= table2array(RNAseq(find(table2array(RNAseq(:,1))== mat(i,j)),3));
    end
    end
end
cc_gene=cat(2,sorted_data(:,1:7),mat2);
for i=1: size(cc_gene,2)-7
cc_gene.Properties.VariableNames{i+7}=['gene' num2str(i)];
end

%
writetable(cc_gene, 'cc_gene.csv');
%%
clear mat mat2
Rawdata=DavidMF;
sorted_data = sortrows(Rawdata, 7,'ascend');
sorted_data = sortrows(sorted_data,6,'descend')
data=table2array(sorted_data(:,[3,6,7]));
names=table2array(sorted_data(:,2));

figure, scatter(data(:,2),[1:size(data,1)], 50*data(:,1), -log10(data(:,3)), 'filled'); 
hold on
scatter([1,1],[1,2],50*[1,5],[0,0,0],'filled')
colormap(cool); % Purple to red
colorbar
set(gca, 'YTick', 1:length(names), 'YTickLabel', names);
set(gca, 'YDir', 'reverse');
xlabel('Fold Enrichement')
xlim([0 Inf])
ylim([0 Inf])
title('MF')

%sorted_data = sortrows(mf, 9,'ascend');
mat=table2array(sorted_data(: ,(8:end)));
mat2=table();

for i=1:size(mat,1)
    for j=1:size(mat,2)
    if ~isnan(mat(i,j))
        mat2(i,j)= table2array(RNAseq(find(table2array(RNAseq(:,1))== mat(i,j)),3));
    end
    end
end
mf_gene=cat(2,sorted_data(:,1:7),mat2);
for i=1: size(mf_gene,2)-7
mf_gene.Properties.VariableNames{i+7}=['gene' num2str(i)];
end

%
writetable(mf_gene, 'mf_gene.csv');

%%

