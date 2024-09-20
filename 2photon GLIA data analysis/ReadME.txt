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

All analysis were done using matlab (matlab version 2023 works, or earlier).

# STEP1 Image alignment
Data were aligned using alignment tools described in Reiten et al, Current Biology, 2017, https://doi.org/10.1016/j.cub.2016.11.036

Unstable recordings were discarded. One control recording was removed due to unexpected high activity, which was consider an outlier using the isoutlier test in matlab. One recording was removed due to lower fluorescence than average
In total 10 control datasets and 11 mutant datasets were included in the analysis.

# STEP2 Identification of region of interest (ROI)
Large ROI were drawn along the ventricle lining in each brain region. 
Each ROI consisted of multiple cells.

All datasets are available on NIRD at doi indicated in the manuscript
 - Data for panel 

Analysis pipelines are as indicated below:

# STEP3 Calculate DFF

Step 3.1: Calculate DFF
Master files: "GLIA_analysis_perfish_v2", using function "plot_response_v4.m"
This code does:
	- Load the ROI data and traces
	- Assign each ROI to a brain region, the assignement to brain regions was manually. 3 brain regions were chosen: forebrain (anterior to habenula), forebrain-midbrain (poster to and including habenula), hindbrain
	- Input light onsets/offsets
	- Calculate DFF for each stimulus using as baseline the 5s before each stimulus, and the average response per ROI.
	- Calculate DFF for the entire recording according to Romano et al, Plos computational biology, 2017 https://doi.org/10.1371/journal.pcbi.1005526 (based on 8% percentile). Use a Decay of F0cfg.tauDecay=2;
	- This code averages the ROI from the same brain regions and then all the ROIs

F0cfg.start=460; % frame where to start the DFF calculation, this is equivalent to around 2min
F0cfg.stop=9250; % frame where to stop the calculation, 2304 is slightly before LIGHTonset


Step 3.2: compile datasets for all fish
Responses across animals were calculated and plotted using code
Fig4_GLIA_ANALYSIS_v2.mlx, functions are nested in the live editor file


===========================================
Necessary codes to run the analysis
"GLIA_analysis_perfish_v2.m"
"plot_response_v4.m",
"computationF0_LL.m",
"nj_load2pGliadata_v2.m"




