function [amplitude]=plot_response_v4 (results,path)

%==================================
% code by Nathalie done on 30.11.2022 to recover the response of glia cells
% obtained from large ROI drawn by Percy

% you need to input 
% - the length of Baseline and window to analyse in second cfg.LengthBaseline
% - number of trials, eg cfg.n_trials = 5; 

% gets the values out of the results variable
cfg=results.cfg;
traces = results.DV_DFF_XYZINDEXPLANE_rawtraces; %raw traces of you data

% sort the traces depending on the regionID (tel=1, etc)
traces = sortrows([cfg.regionID traces], 1);
sortedID=traces(:,1);
traces = traces(:,7:end); %raw traces of you data
for i=1:size(traces,1)
traces(i,:)=smooth(traces(i,:),3);
end

% input some numbers for the baseline calculation using sumbre code
F0cfg=[]; 
F0cfg.F0method='sumbre'; % 'sumbre' or 'trad' (in small letters)
F0cfg.tauDecay=2; % seconds, for GCamp6s
F0cfg.start=460; % frame where to start the DFF calculation, this is equivalent to around 2min
F0cfg.stop=9250; % frame where to stop the calculation, 2304 is slightly before LIGHTonset
F0cfg.fps=cfg.originalfps;

% traces is the raw traces from start to stop of baseline
% Calculate the baseline
F0 = computationF0_LL(traces(:,F0cfg.start:F0cfg.stop), F0cfg);
% compute DFF
DFF = ((traces(:,F0cfg.start:F0cfg.stop)-F0)./F0)*100 ;


% convert the length of baseline, duration to calculate and plot in FRAMES 
DurationBaseline = floor(cfg.LengthBaseline * cfg.originalfps); 
LengthWindow = floor(cfg.LengthWindow * cfg.originalfps); 

% identify the onsets for each of the stimuli in FRAMES FOR RESAMPLED
stim_triggers = floor(cfg.TimeVector.ON); 

%% CALCULATE THE DFF FOR EACH STIMULI AND ROI

% make a cell array with dimension 1 is the ROI and dimension 2 is the stimulus number
% DFF_per_stimulus is a cell array where in each cell dimension 1 is the cell id, dimension 2 is the stimulus number
% calculate the baseline and DFF for each stimulus separetely
% DFF_per_stimulus{i,1}is the response for n stimulus for each ROI
DFF_per_stimulus=cell(size(traces,1),1);
for i=1: size(traces,1) % i is cell index
for j=1:cfg.n_trials % j is number of trial
    baseline=repmat(mean(traces(i,[floor(stim_triggers(j)-DurationBaseline):floor(stim_triggers(j))])),1,length(traces(i,[floor(stim_triggers(j)-LengthWindow):floor(stim_triggers(j)+LengthWindow+1)])));
    DFF_per_stimulus{i,1}(j,:)=(((traces(i,[floor(stim_triggers(j)-LengthWindow):floor(stim_triggers(j)+LengthWindow+1)])-baseline)./baseline)*100);
    baseline=[];
end
end

% make the average of all 5 stimulus for each ROI before and after
% stimulus
[MeanDFF_per_stimulus]=cellfun(@mean,DFF_per_stimulus,'UniformOutput',false);

%make a matrix with dimension 1 is the ROI and dimension 2 is time
MeanResponse=[]; %empty the data to avoid overwriting it
for i=1:size(traces,1)
    MeanResponse(i,:)=MeanDFF_per_stimulus{i,1};
end

% calculate average response per region
DFF1=[];
DFF1(1,:)=mean(MeanResponse(sortedID==1,:),1);
DFF1(2,:)=mean(MeanResponse(sortedID==2,:),1);
DFF1(3,:)=mean(MeanResponse(sortedID==3,:),1);
DFF1(4,:)=mean(MeanResponse(sortedID==4,:),1);

%% CALCULATE AVERAGE DFF PER BRAIN REGION FOR ENTIRE RECORDING

% for this to work, tel needs to be region 1, midbrain region 2 
% hindbrain region 3, thalamus region 4
DFF2=[];
DFF2(1,:)=mean(DFF(sortedID==1,:),1);
DFF2(2,:)=mean(DFF(sortedID==2,:),1);
DFF2(3,:)=mean(DFF(sortedID==3,:),1);
DFF2(4,:)=mean(DFF(sortedID==4,:),1);

%% PLOTTING

% time for plotting
plotTime=results.time(1:size(MeanResponse,2))-results.cfg.PlotWindow;
% color for plotting
col=char('k','b','r','g');

% set the figure
figure, 
set(gcf,  'Position',[50 50 600 600])
str= {['Glia responses ' results.metadata.name 'with baseline '...
    num2str(cfg.LengthBaseline) 'sec']}
annotation('textbox',[0.05 0.95 0.9 0.05],'String',str, 'FontSize',14, 'FontWeight', 'bold', 'LineStyle', 'none');

% subplot 1 plot the average response for the 5 stimuli per brain region
subplot('Position',[0.05 0.55 0.9 0.35]), 
line ([0 0], [0 20], 'Color',[0.8, 0.8, 0.8]), hold on
line ([60 60], [0 20],'Color',[0.8, 0.8, 0.8])
for i=1:4
shadedErrorBar(plotTime,mean(MeanResponse(sortedID==i,:),1),std(MeanResponse(sortedID==i,:),[],1)/sqrt(size(MeanResponse(sortedID==i,:),1)),'lineProps',col(i) )
end
title (['average of glial ROI (average stimuli)'])
xlabel('time in sec')
ylabel('DFF')
xlim([-60 120])
ylim([-2 20])
legend ('tel=black', 'mid=blue', 'hind=red', 'thal=green')

% subplot showing average response per brain region
subplot('Position',[0.5 0.55 0.4 0.35]),imagesc(DFF1), colormap(flipud(hot)), caxis([-10 30]), colorbar
title (['DFF of glial ROI (average regions, average stimuli)'])
xlabel('time in frames')
ylabel('brain region number')

% subplot showing average response per sorted ROI
subplot('Position',[0.50 0.1 0.4 0.35]),imagesc(MeanResponse), colormap(flipud(hot)), caxis([-10 30]), colorbar
title (['DFF of glial ROI (individual ROI, sorted, average stimuli)'])
xlabel('time in frames')
ylabel('ROI number, sorted by brain region')

% subplot showing the average DFF per brain region for the entire duration
% of the recording
subplot('Position',[0.05 0.1 0.9 0.35]), 
plot(results.time/60,100*cfg.stimulus, 'Color', [0.8, 0.8, 0.8]), hold on
plot(results.time/60,DFF2) 
legend ('light', 'tel','mid', 'hind','thal')
xlabel('time in min')
ylabel('DFF')
title('glia activity not normalized')

legend ('light', 'tel','mid', 'hind','thal')
xlabel('time in min')
ylabel('DFF')
title('glia activity not normalized')
%% save figure as png
saveas(gcf, [path, results.metadata.name,'_GliaAverage.png'])

%%
% save the data in a file
amplitude.DFFstim_sorted=MeanResponse;
amplitude.regionID_sorted=sortedID;
amplitude.timestim=plotTime;
amplitude.time=results.time(F0cfg.start:F0cfg.stop);
amplitude.DFFstim_meanRegion=DFF1;
amplitude.DFF_meanRegion=DFF2;
amplitude.metadata=results.metadata;
amplitude.cfg=results.cfg;
save([path filesep results.metadata.name '_Amplitude_glia.mat'] , 'amplitude','-v7.3');

