function LoadF0resample(path)

% written by Nathalie Jurisch-Yaksi Nov/Dec 2022
% The function below will 
% 1. load the results_brainRegions file, 
% 2. calculate the baseline from minute 2 til the end
% 3. cluster the data
% 4. resample the data to 1fps
% STEP1 LOAD THE RESULTS BRAIN REGIONS ------------------------------------
stk_files = dir(fullfile(path, '*Results_BrainRegions*' ));
load(stk_files.name);
disp('data loaded')
% enter parameters manually into a new  structure array called "spontaneous"
spontaneous.fishNb = results.metadata.name; 
spontaneous.fps = 1/results.metadata.timeStep; % frame rate of the 2 photon
spontaneous.condition= 'spontaneous'; % condition : 'light'/'no light' ?

% STEP2 compute F0 for DFF calculations --------------------------------
%!!!!!!!! USE SUMBRE CODE FOR BASELINE CALCULATION FOR SPONTANEOUS ACTIVITY!!!!!!!!!!
F0cfg=[];
F0cfg.start=460; % frame where to start the DFF calculation, this is equivalent to around 2min
F0cfg.stop=2304; % frame where to stop the calculation, 2304 is slightly before LIGHTonset
F0cfg.fps=spontaneous.fps; 
F0cfg.F0method='sumbre'; % 'sumbre' or 'trad' (in small letters)
F0cfg.tauDecay=2; % seconds, for GCamp6s

% traces is the raw traces from start to stop of baseline
traces=results.DV_DFF_XYZINDEXPLANE_rawtraces(:,6+F0cfg.start:6+F0cfg.stop); 
spontaneous.xyz=results.positions_nodoubles(:,1:3);
spontaneous.brainRegion=results.redoneIndex;
spontaneous.time=[F0cfg.start:F0cfg.stop]*results.metadata.timeStep;
disp('baseline calculation initiated')
% Calculate the baseline
tic
F0 = computationF0_LL(traces, F0cfg);

% compute DFF
DFF = ((traces(:,:)-F0)./F0)*100 ;
toc
disp('DFF calculated')
% STEP3: CLUSTERING AND SORTING OF THE DATA ---------------------------

% Main script for clustering 
% uses
% - clustering.m
% - plot_Traces.m
% - plot_clustersROI.m

% ENTER PARAMETERS MANUALLY IN CONFIG STRUCTURE --------------------------
% logical(0) means false, logical(1) means true

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

CLUSTERcfg.fishNb=results.metadata.name;
CLUSTERcfg.fps=1/results.metadata.timeStep; % frame rate of the 2 photon

% THE PARAMETERS BELOW WILL DRAW LINE ON THE PLOT ------------------------
% Can be adapted based on the stimulus train
CLUSTERcfg.stimuliPlotAxes=[]; % in minutes, will plot the event on the graph

% ENTER THE TIME YOU WISH THE CLUSTERING TO BE MADE FROM
CLUSTERcfg.epoch=[0.1 7.5]; % enter epoch used for clustering in minutes
% the time frame indicated here makes teh clustering for the data with the
% light stimuli. The recordings are now 7.9min long

% THE CODE BELOW WILL DO THE CLUSTERING ---------------------------------
disp('clustering starts')
[idx, CLUSTERcfg] = clustering_LL_NJ2(DFF, CLUSTERcfg);
spontaneous.CLUSTERidx=idx; % idx is the index of the cell
spontaneous.CLUSTERcfg=CLUSTERcfg; % save the configuration cfg in the results array
spontaneous.DFF=DFF;

% s PLOT THE AVERAGE CLUSTER ACTIVITY AND THEIR LOCATION

plot_clusteringSPONT_NJ (path, spontaneous) 

% STEP4 RESAMPLING OF THE DATA TO 1HZ  -----------------------
% It is also doing a better job than averaging
newfps=1; %empirically determined. It removes some of the background
freqRatio=newfps/spontaneous.fps;
[p, q]=rat(freqRatio); % final fps / original fps
resampled_DFF = resample(DFF',p, q)';

spontaneous.F0cfg=F0cfg;
spontaneous.resampled_DFF=resampled_DFF;
spontaneous.resampled_fps=newfps;

% STEP5 SAVE THE DATA AND CLUSTERING

save([path filesep spontaneous.fishNb '_Results_SPONTANEOUSv2.mat'] , 'spontaneous','-v7.3');
disp([num2str(spontaneous.fishNb) ' baseline calculation, clustering, resampling and saving finished'] )
end

