function [amplitude]=calculate_responses(results, path, light)

% you need to input 
% - the length of Baseline in second cfg.LengthBaseline
% - the length of the windo to plot cfg.LengthWindow
% - the 
% - number of trials, eg cfg.n_trials = 5; 
% - with light ==1; it measures the ON responding cells
%   with light ==2; it measures the OFF responding cells
results.cfg.TimeVector.ON=[2314 3471 4628 5784 6941];
results.cfg.TimeVector.OFF=[2546 3703 4859 6016 7172];

results.cfg.LengthBaseline=5; %this needs to be in seconds. eg 30 s baseline duration ... 
%this can be adapted to the length of your choosing and will be what is "before" the onset
results.cfg.LengthWindow=10; %this needs to be in seconds. eg 30 s  duration ... 
%this can be adapted to the length of your choosing and will be the window
% you choose for your calculation of responding cells
results.cfg.PlotWindow=120; %this needs to be in seconds. eg 30 s  duration ... 
%this is the threshold used to identify responding cells
results.cfg.thresholdSD=2;

%% STEP0 gets some important variables for the analysis====================
% gets the values out of the results variable
traces = results.DV_DFF_XYZINDEXPLANE_rawtraces; %raw traces of you data
xyz=traces(:,[1:3]); %this is the x,y,z position of the neuron
traces = traces(:,6:end); %raw traces of you data
cellID=results.redoneIndex;
xyzb=cat(2,xyz,cellID); %this is the x,y,z position and brain ID of the neuron
cfg=results.cfg;
path_save=path.save;

% input the length of baseline, duration to calculate and plot
DurationBaseline = floor(cfg.LengthBaseline * cfg.fps); 
LengthWindow = floor(cfg.LengthWindow * cfg.fps); 
PlotWindow = floor(cfg.PlotWindow * cfg.fps); 

% gives a different time vector for lightON or lightOFF using the same code
if light==1;
stim_triggers = cfg.TimeVector.ON; % these are the onsets for each of the stimuli in FRAMES
elseif light==2;
stim_triggers = cfg.TimeVector.OFF; % these are the onsets for each of the stimuli in FRAMES
end

%% STEP1 calculate the dff per stimulus and average========================
%% STEP1.1 important to identify the responding cells (use LengthWindow)
% make a cell array with dimension 1 is the cell and dimension 2 is the stimulus number
% DFF_per_stimulus is a cell array where in each cell dimension 1 is the cell id, dimension 2 is the stimulus number
% calculate the baseline and DFF for each stimulus separetely. Only
% calculate for the length of the Window (eg 10sec).
DFF_per_stimulus=cell(size(traces,1),2);
for i=1: size(traces,1) % i is cell index
for j=1:cfg.n_trials % j is number of trial
    baseline=repmat(mean(traces(i,[floor(stim_triggers(j)-DurationBaseline):floor(stim_triggers(j))])),1,length(traces(i,[floor(stim_triggers(j)-LengthWindow):floor(stim_triggers(j))])));
    DFF_per_stimulus{i,1}(j,:)=(((traces(i,[floor(stim_triggers(j)-LengthWindow):floor(stim_triggers(j))])-baseline)./baseline)*100);
    DFF_per_stimulus{i,2}(j,:)=(((traces(i,[floor(stim_triggers(j))+1:floor(stim_triggers(j)+LengthWindow+1)])-baseline)./baseline)*100);
    baseline=[];
end
end
%% STEP1.2 important to plot a longer time of interest (use PlotWindow)
DFF=cell(size(traces,1),2);
for i=1: size(traces,1) % i is cell index
for j=1:cfg.n_trials % j is number of trial
    baseline=repmat(mean(traces(i,[floor(stim_triggers(j)-DurationBaseline):floor(stim_triggers(j))])),1,length(traces(i,[floor(stim_triggers(j)-PlotWindow):floor(stim_triggers(j))])));
    DFF{i,1}(j,:)=(((traces(i,[floor(stim_triggers(j)-PlotWindow):floor(stim_triggers(j))])-baseline)./baseline)*100);
    DFF{i,2}(j,:)=(((traces(i,[floor(stim_triggers(j))+1:floor(stim_triggers(j)+PlotWindow+1)])-baseline)./baseline)*100);
    baseline=[];
end
end
%% STEP1.3 make the average of all 5 stimulus for each cell before and after
% stimulus
[MeanDFF_per_stimulus]=cellfun(@mean,DFF_per_stimulus,'UniformOutput',false);
[MeanDFF]=cellfun(@mean,DFF,'UniformOutput',false);
MeanDFFm=cell2mat(MeanDFF);
%% STEP1.4 plot response of all cells
figure, 
set(gcf,  'Position',[50 50 800 600])

subplot('Position',[0.1 0.1 0.4 0.8]), 
imagesc(sortrows([mean(MeanDFFm(:,PlotWindow+1:PlotWindow+LengthWindow),2) MeanDFFm],1,'descend')), caxis([-20 50]), colormap(parula), colorbar, hold on
xline(size(MeanDFFm,2)/2,'--k', 'LineWidth', 2)
xlabel('frames')
ylabel('neurons')
title('all brain')

subplot('Position',[0.6 0.1 0.3 0.8]), 
xline(0,'-y', 'LineWidth', 1)
shadedErrorBar(results.time(1:size(MeanDFFm,2))-results.cfg.PlotWindow,mean(MeanDFFm,1),std(MeanDFFm,[],1)/sqrt(size(MeanDFFm,1)))
title (['average of ' num2str(size(MeanDFFm,1)) ' cells'])
xlabel('time in sec')
ylabel('[DFF %]')
xlim([-120 120])

if light==1;
str= {['ON Response sorted ' results.metadata.name]}
annotation('textbox',[0.05 0.95 0.9 0.05],'String',str, 'FontSize',14, 'FontWeight', 'bold', 'LineStyle', 'none');
saveas(gcf, [path_save, results.metadata.name,'_ONResponse.png'])
elseif light==2;
str= {['OFF Response sorted ' results.metadata.name]}
annotation('textbox',[0.05 0.95 0.9 0.05],'String',str, 'FontSize',14, 'FontWeight', 'bold', 'LineStyle', 'none');
saveas(gcf, [path_save, results.metadata.name,'_OFFResponse.png'])
end

% % UNCOMMENT IF YOU WANT TO PLOT THE RESPONSES FOR ALL CELLS IN THE BRAIN
% REGIONS
% % plot response of all cells in individual brain regions
% for ii=1:4
% figure, 
% set(gcf,  'Position',[50 50 800 600])
% 
% subplot('Position',[0.1 0.1 0.4 0.8]), 
% imagesc(sortrows([mean(MeanDFFm(cellID==ii,PlotWindow+1:PlotWindow+LengthWindow),2) MeanDFFm(cellID==ii,:)],1,'descend')), caxis([-20 50]), colormap(parula), colorbar, hold on
% xline(size(MeanDFFm,2)/2,'--k', 'LineWidth', 2)
% xlabel('frames')
% ylabel('neurons')
% title(['Brain Region = ' num2str(ii)])
% 
% subplot('Position',[0.6 0.1 0.3 0.8]), 
% xline(0,'-y', 'LineWidth', 1)
% shadedErrorBar(results.time(1:size(MeanDFFm,2))-results.cfg.PlotWindow,mean(MeanDFFm(cellID==ii,:),1),std(MeanDFFm(cellID==ii,:),[],1)/sqrt(size(MeanDFFm(cellID==ii,:),1)))
% title (['average of ' num2str(size(MeanDFFm(cellID==ii,:),1)) ' cells'])
% xlabel('time in sec')
% ylabel('[DFF %]')
% xlim([-120 120])
% end
%%=========================================================================

%% STEP2 CALCULATE RESPONDING CELLS========================================
%% STEP2.1 calculate activity before and after the stimulus
%make a matrix with dimension 1 is the cell and dimension 2 is time
% MeanResponse is the array with the mean activity before and after the
% stimulus
MeanResponse=[]; %empty the data to avoid overwriting it
for i=1:size(traces,1)
    MeanResponse.before(i,:)=MeanDFF_per_stimulus{i,1};
    MeanResponse.after(i,:)=MeanDFF_per_stimulus{i,2};
end

SD_baseline=std(MeanResponse.before,0,2);
Mean_After=mean(MeanResponse.after,2);

%% STEP2.2 identify cells that show increased or decreased activity using a threshold
% threshold is 2*SD (results.cfg.thresholdSD*SD_baseline)
% calculate  cells going UP and DOWN
respondingcells.up.id=Mean_After>results.cfg.thresholdSD*SD_baseline;
respondingcells.down.id=Mean_After<-results.cfg.thresholdSD*SD_baseline;

cellidUP=find(respondingcells.up.id);
cellidDOWN=find(respondingcells.down.id);

matUP=MeanDFFm(cellidUP,:);
matDOWN=MeanDFFm(cellidDOWN,:);

%% STEP2.3 Plot the cells above or below threshold
cmap=jet; % colormap to plot

figure, 
set(gcf,  'Position',[50 50 1200 600])

subplot('Position',[0.05 0.5 0.2 0.35]), shadedErrorBar(results.time(1:size(matUP,2))-results.cfg.PlotWindow,mean(matUP,1),std(matUP,[],1)/sqrt(size(matUP,1)))
title (['average of ' num2str(length(cellidUP)) '=' num2str(length(cellidUP)/length(xyzb)*100)  '%, activated cells'])
xlabel('time in sec')
ylabel('DFF')

subplot('Position',[0.3 0.5 0.3 0.35]),imagesc(sortrows([mean(matUP(:,PlotWindow+1:PlotWindow+LengthWindow),2) matUP],1,'descend')), colormap(flipud(hot)), caxis([-20 50]), colorbar
title (['DFF of ' num2str(length(cellidUP)) ' activated cells'])

subplot('Position',[0.65 0.5 0.3 0.35]), scatter(xyzb(cellidUP,1),xyzb(cellidUP,2),[], cmap(1+xyzb(cellidUP,4)*50,:),'filled')
title (['xy position of ' num2str(length(cellidUP)) ' activated cells'])
% calculate % responding cells
for k=1:4;
    numcellUP(k)=length(find(xyzb(cellidUP,4)==k))/length(find(xyzb(:,4)==k))*100;
end
text(10,10, [ num2str(numcellUP(1)) '% Telencephalon  ' num2str(numcellUP(2)) '% Tectum/Thalamus'])
text(10,30, [  num2str(numcellUP(3)) '% Hindbrain  ' num2str(numcellUP(4)) '% Habenula'])


subplot('Position',[0.05 0.05 0.2 0.35]), shadedErrorBar(results.time(1:size(matDOWN,2))-results.cfg.PlotWindow,mean(matDOWN,1),std(matDOWN,[],1)/sqrt(size(matDOWN,1)))
title (['average of ' num2str(length(cellidDOWN)) '=' num2str(length(cellidDOWN)/length(xyzb)*100)  '%, inhibited cells'])
xlabel('time in sec')
ylabel('DFF')

subplot('Position',[0.3 0.05 0.3 0.35]),imagesc(sortrows([mean(matDOWN(:,PlotWindow+1:PlotWindow+LengthWindow),2) matDOWN],1,'descend')), colormap(flipud(hot)), caxis([-20 50]), colorbar
title (['DFF of ' num2str(length(cellidDOWN)) ' inhibited cells'])

subplot('Position',[0.65 0.05 0.3 0.35]), scatter(xyzb(cellidDOWN,1),xyzb(cellidDOWN,2),[], cmap(1+xyzb(cellidDOWN,4)*50,:),'filled')
title (['xy position of ' num2str(length(cellidDOWN)) ' inhibited cells'])
% calculate % responding cells
for k=1:4;
    numcellDOWN(k)=length(find(xyzb(cellidDOWN,4)==k))/length(find(xyzb(:,4)==k))*100;
end
text(10,10, [ num2str(numcellDOWN(1)) '% Telencephalon  ' num2str(numcellDOWN(2)) '% Tectum/Thalamus'])
text(10,30, [  num2str(numcellDOWN(3)) '%Hindbrain  ' num2str(numcellDOWN(4)) '%Habenula'])


%% INCLUDE TITLE AND SAVE THE DATA
if light==1;
str= {['ON Responding cells above SD threshold ' results.metadata.name 'with baseline '...
    num2str(cfg.LengthBaseline) 'sec and window ' num2str(cfg.LengthWindow) 'sec']}
annotation('textbox',[0.05 0.95 0.9 0.05],'String',str, 'FontSize',14, 'FontWeight', 'bold', 'LineStyle', 'none');
saveas(gcf, [path_save, results.metadata.name,'_ONRespondingAverage.png'])
amplitude.ON.UP.DFF=matUP;
amplitude.ON.UP.cellIDxyzb=xyzb(cellidUP,:);
amplitude.ON.DOWN.DFF=matDOWN;
amplitude.ON.DOWN.cellIDxyzb=xyzb(cellidDOWN,:);
amplitude.metadata=results.metadata;
amplitude.cfg=results.cfg;
amplitude.all.traces=MeanDFFm;
amplitude.all.xyzb=xyzb;
save([path_save filesep results.metadata.name '_Amplitude_ONResponding_v2.mat'] , 'amplitude','-v7.3');


elseif light==2;
str= {['OFF Responding cells above SD threshold ' results.metadata.name 'with baseline '...
    num2str(cfg.LengthBaseline) 'sec and window ' num2str(cfg.LengthWindow) 'sec']}
annotation('textbox',[0.05 0.95 0.9 0.05],'String',str, 'FontSize',14, 'FontWeight', 'bold', 'LineStyle', 'none');
saveas(gcf, [path_save, results.metadata.name,'_OFFRespondingAverage.png'])
amplitude.OFF.UP.DFF=matUP;
amplitude.OFF.UP.cellIDxyzb=xyzb(cellidUP,:);
amplitude.OFF.DOWN.DFF=matDOWN;
amplitude.OFF.DOWN.cellIDxyzb=xyzb(cellidDOWN,:);
amplitude.metadata=results.metadata;
amplitude.cfg=results.cfg;
amplitude.all.traces=MeanDFFm;
amplitude.all.xyzb=xyzb;
save([path_save filesep results.metadata.name '_Amplitude_OFFResponding_v2.mat'] , 'amplitude','-v7.3');

end
