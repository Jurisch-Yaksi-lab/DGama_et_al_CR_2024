% VERSION 2 PART1 WITH THE DETECTED GLIA REGIONS

%% Set path to where your codes are ==========================
addpath(genpath('X:\Percival\Matlab codes\New 2p codes for analysis'))
addpath(genpath('X:\Nathalie\other\manuscript\in preparation\DGama_brainphysiology_smh\2p_glia'))
%% STEP1: IMPORT DATA=================================
% load the result file data "Results_BrainRegions.mat" by dragging in the command window
% you can also enter the path where the data is
path='X:\Nathalie\other\manuscript\in preparation\DGama_brainphysiology_smh\2p_glia\data\'
% cd(path)

%% STEP2: CALCULATE DFF AND AVERAGE ACTIVITY FOR THE ROI FROM SAME BRAIN REGION===========================

% ENTER SOME VALUES===============
% THESE VALUE DO NOT NEED TO BE CHANGED FOR EACH RECORDINGS  ==============
% ENTER values related to the light stimulus
cfg.TimeVector.ON=[2314 3471 4628 5784 6941]
cfg.TimeVector.OFF=[2546 3703 4859 6016 7172]
cfg.stimulus=zeros(1,length(results.traces));
cfg.stimulus(cfg.TimeVector.ON)=1;
cfg.stimulus(cfg.TimeVector.OFF)=1;
% ENTER values related to brain regions
cfg.regionID=results.redoneIndex;
% MAKE A TIME VECTOR
% it makes a time vector of the length of the traces vector where each datapoint correspond to one frame
results.time=[0:length(results.traces)-1]*results.metadata.timeStep;
results.time=single(results.time);
cfg.originalfps=1/results.metadata.timeStep; 
% ENTER values  to calculate average responses to all stimuli
cfg.n_trials=5;
cfg.LengthBaseline=10; %this needs to be in seconds. eg 30 s baseline duration ... 
%this can be adapted to the length of your choosing and will be what is "before" the onset
cfg.LengthWindow=120; %this needs to be in seconds. eg 120 s  duration ... 
%this is the length of the window to plot before and after the stimulus
%onset
cfg.PlotWindow=120; %this needs to be in seconds. eg 120 s  duration ... 
%this is the length of the window to plot before and after the stimulus
%onset

results.cfg=cfg;

% THIS CODE WILL PLOT AND SAVE EVERYTHING
[amplitude]=plot_response_v3 (results,path)