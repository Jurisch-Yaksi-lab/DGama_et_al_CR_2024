function [ctrlFish,mutFish]=nj_ClusterPerBrainRegion_Allfish(path_data)

% written by Nathalie Jurisch-Yaksi December 2022
% this code does
% 1. load all the control and mutant data into one cell array for ctrl and one for mutant
% 2. cluster the data by brain region and plot them
% 3. save two variable ctrlFish and mutFish



% give a name to the brain region, this was chosen by Percy ================
brainRegion=char('telencephalon','TeO/thalamus','Hindbrain', 'Habenula');

% pull out all control and mutant from the path_data files ================

for j=1:2;
if j==1,    stk_files_ctrl1 = dir(fullfile(path_data, '*ctrl*' ));
elseif j==2, stk_files_ctrl1 = dir(fullfile(path_data, '*mut*' ));
end
counter=1;

% load each data
for i=1:size(stk_files_ctrl1,1)   
    tic
display(stk_files_ctrl1(i).name)
load([path_data stk_files_ctrl1(i).name]);

 % Then I ran the STEP3: CLUSTERING AND SORTING OF THE DATA for each brain
 % region
 
% ENTER PARAMETERS MANUALLY IN CONFIG STRUCTURE==============================
% logical(0) means false, logical(1) means true
CLUSTERcfg.fishNb=spontaneous.fishNb;
CLUSTERcfg.fps=spontaneous.fps; % frame rate of the 2 photon
CLUSTERcfg.F0method='substraction average';
CLUSTERcfg.clusteringAlgo='kmeans'; % 'Kmeans' or 'gmdistribution'(Mixture of gaussians)
CLUSTERcfg.PCA=logical(0); % 'false' or 'true'. For a dimesionality-reduction PCA BEFORE the clustering. 
CLUSTERcfg.numComponents=10; % ATTENTION, if cfg.PCA='true', cfg.clusteringDistance must be 'sqeuclidean' !!
CLUSTERcfg.clusteringDistance='correlation'; % 'sqeuclidean' or 'correlation'
CLUSTERcfg.optimalK='manual'; % 'manual', 'gap', 'silhouette', '' or ''
CLUSTERcfg.K=5; %  if chosen 'manual', enter the number you want
CLUSTERcfg.Zscore=logical(0);
CLUSTERcfg.filtering=logical(0);
CLUSTERcfg.freqCutOff=0.5;
CLUSTERcfg.resampling=logical(0); 
CLUSTERcfg.smoothing=logical(0);  
CLUSTERcfg.condition='';
% THE PARAMETERS BELOW WILL DRAW LINE ON THE PLOT ------------------------
% Can be adapted based on the stimulus train
CLUSTERcfg.stimuliPlotAxes=[]; % in minutes, will plot the event on the graph
% ENTER THE TIME YOU WISH THE CLUSTERING TO BE MADE FROM
CLUSTERcfg.epoch=[0.1 7.5]; % enter epoch used for clustering in minutes
% there is no light stimuli in that period

Fish{counter,1}.metadata=CLUSTERcfg;

 for k=1:4; %4 brain region
     % ENTER FEW 
DFF=spontaneous.DFF(spontaneous.brainRegion==k,:);

% THE CODE BELOW WILL DO THE CLUSTERING ---------------------------------
[idx, CLUSTERcfg] = clustering_LL_NJ2(DFF, CLUSTERcfg);
% RECOVER PARAMETERS IN ONE ARRAY
data{k,1}.CLUSTERidx=idx; % idx is the index of the cell
data{k,1}.CLUSTERcfg=CLUSTERcfg; % save the configuration cfg in the results array
data{k,1}.resampled_DFF=spontaneous.resampled_DFF(spontaneous.brainRegion==k,:);
data{k,1}.DFF=DFF;
data{k,1}.xyz=spontaneous.xyz(spontaneous.brainRegion==k,:);
data{k,1}.fishNb=CLUSTERcfg.fishNb;
data{k,1}.time=spontaneous.time;
data{k,1}.brainRegion=k;

% PLOT THE AVERAGE CLUSTER ACTIVITY AND THEIR LOCATION

plot_clusteringSPONT_NJ_v2 ([path_data 'Analysed' filesep], data{k,1}) 

Fish{counter,1+k}.CLUSTERidx=data{k,1}.CLUSTERidx;
Fish{counter,1+k}.xyz=spontaneous.xyz(spontaneous.brainRegion==k,:);
Fish{counter,1+k}.brainregion=brainRegion(k,:);
Fish{counter,1+k}.resampled_DFF=spontaneous.resampled_DFF(spontaneous.brainRegion==k,:);
Fish{counter,1+k}.DFF=DFF;
Fish{counter,1+k}.AUC=trapz(spontaneous.resampled_DFF(spontaneous.brainRegion==k,:),2);

clear DFF
 end
 counter=counter+1;
 clear spontaneous
 close all
 toc
end
if j==1
    ctrlFish=Fish;
    clear Fish
elseif j==2
    mutFish=Fish;
    clear Fish
end
end

save([path_data 'Analysed' filesep '_AllFishCtrl.mat'] , 'ctrlFish','-v7.3');
save([path_data 'Analysed' filesep '_AllFishMut.mat'] , 'mutFish','-v7.3');
disp('clustering, combining and saving data is finished')

