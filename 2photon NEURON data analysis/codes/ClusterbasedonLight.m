%%Set path to where your codes are
addpath(genpath('X:\Nathalie\data\code\2p data Percy'))
%% STEP1: IMPORT DATA=================================
% load the result file data by dragging in the command window
% you can also enter the path where the data is
path='W:\percy\2022_04_08\20220408_11_52_04_20220408volsmhctrlF01\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path)

% this will make a matrix containing the raw values and called traces
traces=results.DV_DFF_XYZINDEXPLANE_rawtraces(:,6:end);
neuronsLabels=results.neuronLabels;

% MAKE A TIME VECTOR
% it makes a time vector of the length of the traces vector where each datapoint correspond to one frame
results.time=[0:size(traces,2)-1]*results.metadata.timeStep;
results.time=single(results.time);

%% STEP2: CALCULATE DFF BY REMOVING THE AVERAGE OF THE ENTIRE TRACE AND PLOT THE DATA===========================
% this will remove the average of the entire trace to calculate DFF

baseline_all=(repmat(mean(traces,2),1,size(traces,2)));
DFF= (((traces-baseline_all)./baseline_all)*100);
results.DV_DFFaveragetime=DFF

 % This will  plot the non sorted results
 figure, imagesc(results.DV_DFFaveragetime);
 caxis([0 50])
 colorbar
 colormap(flipud(hot))
 

%% STEP3: CLUSTERING AND SORTING OF THE DATA =================================

% Main script for clustering from LL
% uses
% - clustering.m
% - plot_Traces.m
% - plot_clustersROI.m

% ENTER PARAMETERS MANUALLY IN CONFIG STRUCTURE --------------------------
% logical(0) means false, logical(1) means true

cfg.F0method='substraction average';
cfg.clusteringAlgo='kmeans'; % 'Kmeans' or 'gmdistribution'(Mixture of gaussians)
cfg.PCA=logical(0); % 'false' or 'true'. For a dimesionality-reduction PCA BEFORE the clustering. 
cfg.numComponents=10; % ATTENTION, if cfg.PCA='true', cfg.clusteringDistance must be 'sqeuclidean' !!
cfg.clusteringDistance='correlation'; % 'sqeuclidean' or 'correlation'
cfg.optimalK='manual'; % 'manual', 'gap', 'silhouette', '' or ''
cfg.K=5; %  if chosen 'manual', enter the number you want
cfg.Zscore=logical(0);
cfg.filtering=logical(0);
cfg.freqCutOff=0.5;
cfg.resampling=logical(0); 
cfg.smoothing=logical(0);  
cfg.condition='';

cfg.fishNb=results.metadata.name;
cfg.fps=1/results.metadata.timeStep; % frame rate of the 2 photon

% THE PARAMETERS BELOW WILL DRAW LINE ON THE PLOT ------------------------
% Can be adapted based on the stimulus train
cfg.stimuliPlotAxes=[10 11 15 16 20 21 25 26 30 31]; % in minutes, will plot the event on the graph
% enter time vector (manually detected by Nathalie in frames)
cfg.TimeVector.ON=[2314 3471 4628 5784 6941]
cfg.TimeVector.OFF=[2546 3703 4859 6016 7172]

% ENTER THE TIME YOU WISH THE CLUSTERING TO BE MADE FROM
cfg.epoch=[10 31]; % enter epoch used for clustering in minutes
% the time frame indicated here makes teh clustering for the data with the
% light stimuli

% THE CODE BELOW WILL DO THE CLUSTERING ---------------------------------
[idx, cfg] = clustering_LL_NJ2(results.DV_DFFaveragetime, cfg);
results.idx=single(idx); % idx is the index of the cell
results.cfg=cfg; % save the configuration cfg in the results array

% delete the variables that are not useful
results=rmfield(results, {'DV_rawtraces', 'traces' ,'positions_nodoubles', 'perplane', ...
    'neuronLabels_nodoubles', 'traces', 'neuronLabels', 'planePresent'})

%% SAVE THE DATA AND CLUSTERING

save([path filesep results.metadata.name 'Results_CLUSTERING.mat'] , 'results','-v7.3');



