% CODES USED FOR PLOTTING RNAseq data

%% pull out the data from the imported table 
% this is the data from Konika's normalization including counts, counts are
% log transformed
load('Z:\Manuscripts\Dgama etal 2024 smh\Cell reports\Revision\RNAseq\240418_RNASeqData_smh_rev.mat')

data=table2array(RNAseq(:,[1,4:17]));
%padj is column 6 of data and FC is column 2
data=sortrows(data,6,'ascend');

%% make a volcano plot with log2FC and log10(pvalueAdj)
thres_p=0.1; % we only selected a threshold og p<0.1
% thres_FC=0.8;

figure, hold on
idx=find(data(:,6)>thres_p);
scatter(data(:,2),-log10(data(:,6)),40,'k','filled')
idx=[];
idx=find(data(:,6)<=thres_p);
scatter(data(idx,2),-log10(data(idx,6)),40,'r','filled')
yline(-log10(thres_p),'--k')
xline(0,'--k')
xlim([-8 8])

xlabel('log2FC')
ylabel('-log10(p-valueAdj)')
title('volcano plot smh')

% %% make a volcano plot with log2FC and log10(pvalue)
% thres_p=0.01; % we only selected a threshold og p<0.05
% % thres_FC=0.8;
% 
% figure, hold on
% idx=find(data(:,4)>thres_p);
% scatter(data(:,1),-log10(data(:,4)),10,'k','filled')
% idx=[];
% idx=find(data(:,4)<=thres_p);
% scatter(data(idx,1),-log10(data(idx,4)),10,'r','filled')
% yline(-log10(thres_p),'--k')
% xline(0,'--k')
% 
% xlabel('log2FC')
% ylabel('-log10(p-value)')
% title('volcano plot elipsa')

% %% find data with p_value adj below threshold
% 
% data=sortrows(data,2,'descend');
% idx=(data(:,6)<=thres_p); % find gene number for DEG

%% pull out the data from the imported table 
% counts and FC/p-values are not on the same table, use the gene number of
% DEG to identify them
counts=data(:,[8:15]);
DEGcounts=data(idx,[8:15]);

% plot  a heatmap of the data sorted, here is zscore
cmap = redbluecmap(9);
figure, imagesc(zscore(DEGcounts,[],2)), colormap(cmap)

% plot  a heatmap of the data sorted, not z score
figure, imagesc(DEGcounts), colormap(hot)

% plot  a heatmap of the data sorted, not z score
figure, imagesc(power(2,DEGcounts)), caxis([0 1000])


%% make a clustergram of the z score of the DEG
cmap = redbluecmap(9);
% clustergram(zscore(data(idx,4:11),[],2),'Colormap',cmap) z score and
% standardization does the same
cg=clustergram(DEGcounts,'Standardize','row','Colormap',cmap); %, 'RowLabels',nameidx)
%cg=clustergram(mat,'Standardize','row','Colormap',cmap, 'RowLabels',nameidx)
cgAxes =plot(cg); % Use the plot function to plot to a separate figure and output the axes
set(cgAxes, 'Clim', [-2 2]) % Set colour limit or other axes properties.


%% make PCA plots

% Calculate the variance for each gene
geneVariance = var(counts, 0, 2);

% Select the top 1000 most variable genes
[~, sortedIndices] = sort(geneVariance, 'descend');
topN = 2000;
topIndices = sortedIndices(1:topN);

numericData = counts(topIndices,:);
numericData = normalize(numericData,2,'center');

%
% Perform PCA
[coeff, score, ~, ~, explained] = pca(numericData');

% Plot the PCA results with one dot per sample
figure
scatter(score(1:4,1), score(1:4,2),'k','filled');hold on % Scatter plot of the first two principal components
scatter(score(5:8,1), score(5:8,2),'r','filled'); % Scatter plot of the first two principal components


xlabel(['PC1 (Explained variance of ' num2str(explained(1)) '%)']);
ylabel(['PC2 (Explained variance of ' num2str(explained(2)) '%)']);
title('PCA Plot for RNA-seq Data SMH');

% Optional: Add labels to the dots if you have sample labels
for i=1:4
text(score(i,1), score(i,2)-2, ['ctrl ', num2str(i)], 'FontSize', 12);
end
for i=1:4
text(score(i+4,1), score(i+4,2)-2, ['mut ',  num2str(i)], 'FontSize', 12);
end

xlim([-60 60])
ylim([-50 50])
axis square


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

