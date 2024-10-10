This text file describe the procedure for the analysis of 2photon neuronal dataset

# Data acquisition and samples
Data were acquired on a scientifica 2photon microscope with the following parameters, using a 16x water immersion objection (Nikon, NA 0.8)
image size 700x1536 pixel
number of stacks: 8
pixel size 0.4557 micron
time step: 0.2489 sec

Subject: 4 days old Tg(elavl3:H2B-HuCGCamp6s) in smh background, paralyzed with bungarotoxin

Stimulus Train: the animals were exposed to 5 stimuli of 1 min of light after 10min baseline

Following image acquisition, cerebral blood flow was investigated in the zebrafish larvae. Animals without blood flow were excluded.

# Data analysis

All analysis were done using matlab.

# STEP1 Image alignment
Data were aligned using alignment tools described in Reiten et al, Current Biology, 2017, https://doi.org/10.1016/j.cub.2016.11.036

Unstable recordings were discarded. One control recording was removed due to unexpected high activity, which was consider an outlier using the isoutlier test in matlab. 
In total 8 control datasets and 14 mutant datasets were included in the analysis.

# STEP2 Cell segmentation
Cells were segmented and assigned to brain regions using tools described in Bartoszek et al, Current Biology, 2021, https://doi.org/10.1016/j.cub.2021.08.021

The light responses and spontaneous brain activity were analyzed differently.

All datasets are available on NIRD at doi indicated in the manuscript
 - Data for panel A: 20220408volsmhctrlF01Results_CLUSTERING.mat contain traces and cell location for the representative example
 - Data for panel B-C: data_spontaneous.mat contain all data of all fishes
 - Data for panel D-E: 2 files per sample, 1 containing ON responding cells and the other OFF responding cells, e.g. 
		- 20220403volsmhctrlF02_Amplitude_OFFResponding_v2.mat 
		- 20220403volsmhctrlF02_Amplitude_ONResponding_v2.mat

Analysis pipelines are as indicated below:

# STEP3 Analysis light responses

Master files: "Fig3_RespondingCells_SMH.mlx",
"SupplementaryF_activity_allsamples.mlx",
These files were used to generate figure 3A, D, E, F

Step 3.1: calculate DFF and identify responding cells per fish
Light onsets/offsets were input manually
DFF was calculated for each stimuli by subtracting the baseline (5s), and averaging per cell.
Responding cells (either activated or inhibited) were determined as cells with a change in DFF of minimum 2*std during the 10s following the light onset or offset as compared to their baseline. 
See code "Identify responses to light.m" which calls "calculate_responses.m" code

Step 3.2: compile datasets for all fish
Responses across animals were calculated and plotted using code
Fig3_RespondingCells_SMH.mlx
All datasets can be plotted using the code "SupplementaryF_activity_allsamples.mlx", which also describes how the data were analyzed and clustered prior to plotting.

Necessary codes to run the analysis:
"ClusterbasedonLight.m"
"Identify responses to light.m", 
"calculate_responses.m", 
"clustering_LL_NJ2.m",
"nj_load2pdata_v3.m",

# STEP4 spontaneous activity

Master file: "Fig3_AnalysisSpontaneousActivity_SMH.mlx"
This file was used to generate figure s¤

Step 4.1: calculate baseline per sample
Use code "LoadF0resample.m", which does 
 - Select baseline period. Selected frames 460-2304 (corresponding to circa min 2 to before the first light stimulus, this allows to eliminate possible artefact due to the laser turning on)
 - DFF calculation according to Romano et al, Plos computational biology, 2017 https://doi.org/10.1371/journal.pcbi.1005526 (based on 8% percentile). Use a Decay of F0cfg.tauDecay=2;
 - Perform clustering on the spontaneous activity for better visualization (can be omitted and has not been used in the manuscript), use the "clustering_LL_NJ2.m" and "plot_clusteringSPONT_NJ.m" codes to do the clustering and plotting the data if needed
 - Resample the data to 1fps, using MATLAB resample function. This is better than smooth.

Step 4.2: combine all samples
Combine the output of all the fishes from the same experiment into single matrix. Code used is "nj_ClusterPerBrainRegion_Allfish.m"

Step 4.3: detect active cells and calculate their correlation
1. Identified the active periods of a cell by using a threshold of 4*8th percentile on the resampled DFF. Based on optimization steps, this was the most accurate threshold to use. Calculate the total time spent above this threshold. Refer to "nj_plotCellsThreshold.m" code for more details.
2. Calculate the correlation between cells in individual regions and relate it to their distance. Brain hemispheres were not split, hence distance above 100micron may refer to cells located in the different hemisphere. Refer to "nj_correlationVSdistance_v2.m" for more details. This codes also plot all individual sample.


Necessary codes to run the analysis
"LoadF0resample.m",
"computationF0-LL.m",
"clustering_LL_NJ2.m",
"plot_clusteringSPONT_NJ.m",
"nj_ClusterPerBrainRegion_Allfish.m",
"nj_plotCellsThreshold.m",
"nj_correlationVSdistance_v2.m",
"binscatter.m"



