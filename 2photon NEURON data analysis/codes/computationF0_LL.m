
function F0 = computationF0_LL(traces, cfg)


if strcmp(cfg.F0method, 'trad')
    
    meanBaseline = mean(traces(:,cfg.F0_start:cfg.F0_end),2);
    F0= repmat(meanBaseline,1,size(traces,2));
    
    
elseif strcmp(cfg.F0method, 'sumbre')
    
    traces=traces'; % traces in format time x cells
    cfg.tauDecay=2; % for GCAMP6slow
    MovingWdw=max(15, 40*cfg.tauDecay); %(40* This is the standard but should be adapted when you have very slow oscillations)
    
    twdw=MovingWdw;
    wdw=round(cfg.fps*twdw);
    numCells=size(traces,2);
    numFrames=size(traces,1); % 50356
    smoothBaseline=zeros(size(traces));
    disp('Calculating fluorescence baseline of ROIs')
    
    %%
    if numFrames > 2*wdw
        parfor j=1:numCells;
            dataSlice=traces(:,j); % trace of neuron j
            temp=zeros(numFrames-2*wdw,1); % 50356 - 2976 = removing 2 windows. Will contain percentile for all the trace.
            for i=wdw+1:numFrames-wdw; % sliding wdw. Start at i = wdw+1 and compute before.
                temp(i-wdw)=prctile(dataSlice(i-wdw:i+wdw),8); % for i = wdw+1, take frames from 1:2977 and compute 8 percentile
            end
            smoothBaseline(:,j)=[temp(1)*ones(wdw,1) ; temp; temp(end)*ones(wdw,1)]; % fill up the gap left by removing the 2 windows, with first and last elements
            smoothBaseline(:,j)=runline(smoothBaseline(:,j),wdw,1); % linear regression to smooth what we added ?
        end
        
    else
        parfor j=1:numCells;
            smoothBaseline(:,j)=[ones(numFrames,1)*prctile(traces(:,j),8)];
        end
    end
    
    
    F0=smoothBaseline';
    
else
    error('Incorrect method for F0 computation')
end
