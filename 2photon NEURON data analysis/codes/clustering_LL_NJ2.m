function [idx, cfg] = clustering_LL_NJ2(traces, cfg)

cfg.originalfps=cfg.fps; %added NJY 22.02.2022

%% Epoch selection
if not(isempty(cfg.epoch))
    disp('epochs provided')
    epoch=[cfg.epoch]*cfg.originalfps*60; % frames
    traces=traces(:,round(epoch(1)):round(epoch(2)));
end

%% Smoothing
if cfg.smoothing
    disp('smoothing occurs')
    smoothedTraces=zeros(size(traces, 1), size(traces, 2));
    for i=1:size(traces, 1) % loop for al neurons
    smoothedTraces(i, :) = smooth(traces(i, :), cfg.winSize);
    end
    traces=smoothedTraces;
end

%% Resampling 
if cfg.resampling
    disp('resampling occurs')
    freqRatio=cfg.resampledfps/cfg.originalfps;
    [p, q]=rat(freqRatio); % final fps / original fps
    traces = resample(traces,p, q)';
end

%% Filtering
if cfg.filtering
    disp('filtering occurs')
    [b,a] = butter(6,cfg.freqCutOff/(cfg.originalfps/2));
    for i = 1:size(traces,1)
        traces(i,:) = filter(b,a,traces(i,:));
    end
end

%% Z-scoring
if cfg.Zscore
    disp('Zscore occurs')
    temp = zscore(traces'); % z-scores are computed using the mean and standard deviation along each column of X.
    traces=temp';
end

%% PCA before clustering / for no PCA, assign data=traces for clustering
if cfg.PCA
    epoch=[cfg.epoch]*cfg.originalfps*60; % frames
    disp('Each neuron is defined by its activity on each time frame. The PCA is used to reduce the timeframe dimension.')
    [coeff, score, latent] = pca(traces(:,epoch(1):epoch(2)), 'NumComponents', cfg.numComponents);
    data = score;
    variance_explained = (cumsum(latent)/sum(latent));
    disp(['The first ' num2str(cfg.numComponents) ' principal components explain ' num2str(variance_explained(cfg.numComponents)) ' of the variance'])
    %     figure;
    % subplot(2, 1, 1)
    % imagesc(traces(:,epoch(1):epoch(2)), [-5 15])
    % subplot(2, 1, 2)
    % imagesc(coeff')
else
    data=traces;
end

%% Optimal K for clustering
if strcmp(cfg.optimalK, 'gap')
    disp(['Computation of the optimal K number for ' cfg.clusteringAlgo ' with the ' cfg.optimalK ' algorithm'])
    eval = evalclusters(data, cfg.clusteringAlgo, cfg.optimalK, 'KList',1:12, 'Distance', cfg.clusteringDistance);
    K=eval.OptimalK;
    cfg.K=K; % save in config structure
elseif strcmp(cfg.optimalK, 'silhouette')
    disp(['Computation of the optimal K number for ' cfg.clusteringAlgo ' with the ' cfg.optimalK ' algorithm'])
    eval = evalclusters(data, cfg.clusteringAlgo, cfg.optimalK, 'KList',1:12, 'Distance', cfg.clusteringDistance);
    K=eval.OptimalK;
    cfg.K=K; % save in config structure
elseif strcmp(cfg.optimalK, 'CalinskiHarabasz')
    disp(['Computation of the optimal K number for ' cfg.clusteringAlgo ' with the ' cfg.optimalK ' algorithm'])
    eval = evalclusters(data, cfg.clusteringAlgo, cfg.optimalK, 'KList',1:12);
    K=eval.OptimalK;
    cfg.K=K; % save in config structure
elseif strcmp(cfg.optimalK, 'DaviesBouldin')
    disp(['Computation of the optimal K number for ' cfg.clusteringAlgo ' with the ' cfg.optimalK ' algorithm'])
    eval = evalclusters(data, cfg.clusteringAlgo, cfg.optimalK, 'KList',1:12);
    K=eval.OptimalK;
    cfg.K=K; % save in config structure
elseif strcmp(cfg.optimalK, 'manual')
    K=cfg.K;
else
    error('no method selected for the computation of K')
end


%% Clustering
if strcmp(cfg.clusteringAlgo, 'kmeans')
    idx = kmeans(data, K, 'Distance', cfg.clusteringDistance, 'Replicates', 50);
elseif strcmp(cfg.clusteringAlgo, 'gmdistribution')
    gm = fitgmdist(data, K);
    P = posterior(gm,data);
    indexes = cluster(gm,data);
    idx={P; indexes};
else
    error('Incorrect clustering algorithm')
end



end