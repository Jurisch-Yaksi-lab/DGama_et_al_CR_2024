This text file describe the procedure for the analysis of 2photon neuronal dataset

# Data acquisition and samples
Data were acquired on a scientifica 2photon microscope with the following parameters, using a 16x water immersion objection (Nikon, NA 0.8)
image size 700x1536 pixel
number of stacks: 8
pixel size 0.4557 micron
time step: 0.2489 sec

Subject: 4 days old Tg(GFAP:gal4);Tg(UAS:GCamp6s) in smh background, paralyzed with bungarotoxin

Stimulus Train: the animals were exposed to 5 stimuli of 1 min of light after 10min baseline

Following image acquisition, cerebral blood flow was investigated in the zebrafish larvae. Animals without blood flow were excluded.

# Data analysis

All analysis were done using matlab.

# STEP1 Image alignment
Data were aligned using alignment tools described in Reiten et al, Current Biology, 2017, https://doi.org/10.1016/j.cub.2016.11.036

Unstable recordings were discarded. One control recording was removed due to unexpected high activity, which was consider an outlier using the isoutlier test in matlab. One recording was removed due to lower fluorescence than average
In total 11 control datasets and 12 mutant datasets were included in the analysis.

# STEP2 Identification of region of interest (ROI)
ROI were segmented and assigned to brain regions using tools described in Bartoszek et al, Current Biology, 2021, https://doi.org/10.1016/j.cub.2021.08.021
Large ROI were drawn along the ventricle lining in each brain region. Each ROI consisted of multiple cells.

All datasets are available on NIRD at doi indicated in the manuscript
 - Data for panel 

Analysis pipelines are as indicated below:

# STEP3 Calculate DFF

Step 3.1: Calculate DFF
Master files: "GLIA_analysis_perfish_v2", using function "plot_response_v4.m"
This code does:
	- Input light onsets/offsets
	- Calculate DFF for each stimulus using as baseline the 5s before each stimulus, and the average response per ROI.
	- Calculate DFF for the entire recording (start at circa 2min /frame 460 to avoid artefacts due to laser turning on) according to Romano et al, Plos computational biology, 2017 https://doi.org/10.1371/journal.pcbi.1005526 (based on 8% percentile). Use a Decay of F0cfg.tauDecay=2;
	- This code averages the ROI from the same brain regions and then all the ROIs


Step 3.2: compile datasets for all fish
Responses across animals were calculated and plotted using code
Fig4_GLIA_ANALYSIS.mlx

UPDATE BELOW
===========================================
Necessary codes to run the analysis:




Necessary codes to run the analysis
"LoadF0resample.m",
"computationF0-LL.m",
"clustering_LL_NJ2.m",
"plot_clusteringSPONT_NJ.m",
"nj_ClusterPerBrainRegion_Allfish.m",
"nj_plotCellsThreshold.m",
"nj_correlationVSdistance_v2.m",
"binscatter.m"



