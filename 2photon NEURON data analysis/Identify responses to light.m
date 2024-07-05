% DETECT THE LIGHT RESPONSES FOR ALL CELLS IN THE BRAIN AND BRAIN
% REGIONS

%-------------------------------------------------------------------------
%   VERSION 09.02.2023, WRITTEN BY NATHALIE JURISCH-YAKSI FOR THE DATA OF
%   PERCY
%   CHANGES INCLUDE SORTING CELLS AND OUTPUTING THE RESPONSES OF ALL CELLS

%% Set path to where your codes are =======================================
addpath(genpath('X:\Nathalie\data\code'))

% ======================================================================
% enter where to save the data
path.save='X:\Percival\2photon data\Analysis\gbt\'


%% STEP1: IMPORT DATA======================================================

% Enter the path where the data is
path.data='X:\Percival\2photon data\gbt0031 2p data\2022_09_01\20220901_20_13_49_20220109gbt0031mutF01\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)

path.data='X:\Percival\2photon data\gbt0031 2p data\2022_09_01\20220901_20_56_06_20220109gbt0031mutF02\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)

path.data='X:\Percival\2photon data\gbt0031 2p data\2022_09_05\20220905_19_34_18_20220509gbt0031ctrlF03\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)

path.data='X:\Percival\2photon data\gbt0031 2p data\2022_09_05\20220905_21_34_43_20220509gbt0031mutF02\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)

path.data='X:\Percival\2photon data\gbt0031 2p data\2022_09_05\20220905_23_07_31_20220509gbt0031mutF04\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)

path.data='X:\Percival\2photon data\gbt0031 2p data\2022_09_09\20220909_21_49_34_20220909gbt0031ctrlF02\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)

path.data='X:\Percival\2photon data\gbt0031 2p data\2022_09_05\20220905_19_34_18_20220509gbt0031ctrlF03\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)

path.data='X:\Percival\2photon data\gbt0031 2p data\2022_09_09\20220909_16_16_21_20220909gbt0031mutF01\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)

path.data='X:\Percival\2photon data\gbt0031 2p data\2022_12_30\20221230_12_54_47_20221230gbt0031ctrl2\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)

path.data='X:\Percival\2photon data\gbt0031 2p data\2022_09_05\20220905_19_34_18_20220509gbt0031ctrlF03\Aligned\celldetection_celldetectionpercy2detectiontimepoint\'
cd(path.data)
loadResponses(path)




%% STEP2: GET THE AVERAGE RESPONSE TO LIGHT, THE ID OF RESPONSIVE CELLS, THEIR AMPLITUDE AND THE % OF RESPONDING CELLS IN EACH BRAIN AREA

function loadResponses(path)
load('Results_BrainRegions.mat')

% MAKE A TIME VECTOR AND ENTER SOME PARAMETERS IN THE CFG FILE
% it makes a time vector of the length of the traces vector where each datapoint correspond to one frame
traces=results.DV_DFF_XYZINDEXPLANE_rawtraces(:,6:end);
results.time=[0:size(traces,2)-1]*results.metadata.timeStep;
results.time=single(results.time);
clear traces

% ENTER SOME PARAMETERS IN THE CFG FILE
results.cfg.fishNb=results.metadata.name;
results.cfg.fps=1/results.metadata.timeStep; % frame rate of the 2 photon
% enter time vector (manually detected by Nathalie in frames)
results.cfg.TimeVector.ON=[2314 3471 4628 5784 6941];
results.cfg.TimeVector.OFF=[2546 3703 4859 6016 7172];
%input some data for calculating the responding cells
results.cfg.n_trials=5;
results.cfg.LengthBaseline=5; %this needs to be in seconds. eg 30 s baseline duration ... 
%this can be adapted to the length of your choosing and will be what is "before" the onset
results.cfg.LengthWindow=10; %this needs to be in seconds. eg 30 s  duration ... 
%this can be adapted to the length of your choosing and will be the window
% you choose for your calculation of responding cells
results.cfg.PlotWindow=120; %this needs to be in seconds. eg 30 s  duration ... 
%this is the threshold used to identify responding cells
results.cfg.thresholdSD=2;

% IDENTIFY RESPONSES TO ON ANS OFF STIMULI
% - with 1; it measures the ON responding cells
[amplitudeON]=calculate_responses (results,  path, 1)
%   with 2; it measures the OFF responding cells
[amplitudeOFF]=calculate_responses (results,  path, 2)
end
