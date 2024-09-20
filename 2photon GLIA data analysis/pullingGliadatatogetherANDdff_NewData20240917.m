%% run the DFF and averaging accross brain regions for all fishes

path='X:\Nathalie\other\manuscript\in preparation\DGama_brainphysiology_smh\2p_glia\data_newROI\'

% % ctrls (11)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20221027_15_56_48_20221027GFAPgal4UASsmhctrlF02\Aligned\celldetection_manual\20221027GFAPgal4UASsmhctrlF02_Results_DV_nodoubles.mat')
brainRegion=[3,3,2,2,3,3,2,2,1,1,2,2,3,3,3,3,1,1,2,2,3,3,2,2,1,1,1,1,2,2,2,2,1,1,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20221128_14_15_08_20221128GFAPgal4UASsmhctrlF02\Aligned\celldetection_manual\20221128GFAPgal4UASsmhctrlF02_Results_DV_nodoubles.mat')
brainRegion=[3,3,3,3,2,2,2,2,3,3,1,1,3,3,2,2,3,3,1,1,3,3,2,2,1,1,1,1,2,2,3,3,3,3,2,2,1,1,1,1,2,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\2023_04_26\20230426_14_02_42_20230426GFAPgal4UASsmhctrlF04\Aligned\celldetection_manual\20230426GFAPgal4UASsmhctrlF04_Results_DV_nodoubles.mat')
brainRegion=[3,2,3,2,2,2,3,2,1,1,3,2,1,1,1,1,3,2,1,1,1,1,2,1,1,1,1,1,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20230718_21_39_56_20230718GFAPgal4UASsmctrlF05\Aligned\celldetection_manual\20230718GFAPgal4UASsmctrlF05_Results_DV_nodoubles.mat')
brainRegion=[3,3,3,2,2,2,2,3,3,2,2,3,3,3,3,1,1,2,2,2,2,1,1,2,2,1,1,2,2,1,1,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20230718_22_35_51_20230718GFAPgal4UASsmctrlF06\Aligned\celldetection_manual\20230718GFAPgal4UASsmctrlF06_Results_DV_nodoubles.mat')
brainRegion=[3,3,2,2,2,2,3,3,2,2,3,3,1,1,2,2,3,3,2,2,3,3,1,1,3,3,2,2,1,1,2,2,1,1,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20230718_09_25_40_20230718GFAPgal4UASsmhctrlF01\Aligned\celldetection_manual\20230718GFAPgal4UASsmhctrlF01_Results_DV_nodoubles.mat')
brainRegion=[3,3,2,2,2,2,2,2,3,3,2,2,3,3,2,2,2,2,3,3,2,2,2,3,3,2,2,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20230718_17_23_29_20230718GFAPgal4UASsmhctrlF03\Aligned\celldetection_manual\20230718GFAPgal4UASsmhctrlF03_Results_DV_nodoubles.mat')
brainRegion=[3,3,3,2,2,3,3,3,2,2,2,2,2,2,2,3,3,2,1,2,2,2,3,3,3,3,2,2,1,1,2,2,2,2,1,1,2,2,1,1,2,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20230718_18_29_44_20230718GFAPgal4UASsmhctrlF04\Aligned\celldetection_manual\20230718GFAPgal4UASsmhctrlF04_Results_DV_nodoubles.mat')
brainRegion=[3,3,2,2,2,2,2,2,3,3,2,2,2,3,3,1,1,2,2,2,1,1,2,2,1,1,2,2,2,2,1,1,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20240719_16_46_29_20240719GFAPgal4UASsmhctrlF03\Aligned\celldetection_manual\20240719GFAPgal4UASsmhctrlF03_Results_DV_nodoubles.mat')
brainRegion=[3,3,2,2,2,2,2,3,3,1,1,2,2,3,3,3,3,2,2,1,1,3,3,3,3,2,2,1,1,1,1,2,2,3,3,3,3,2,2,1,1,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20240729_11_45_09_20240729GFAPgal4UASsmhctrlF01\Aligned\celldetection_manual\20240729GFAPgal4UASsmhctrlF01_Results_DV_nodoubles.mat')
brainRegion=[2,2,2,2,1,1,3,3,2,2,2,2,3,3,1,1,2,2,3,3,2,2,1,1,3,3,2,2,1,1,3,3,1,1,2,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20240729_13_16_13_20240729GFAPgal4UASsmhctrlF02\Aligned\celldetection_manual\20240729GFAPgal4UASsmhctrlF02_Results_DV_nodoubles.mat')
brainRegion=[2,2,2,2,2,2,3,3,1,1,2,2,2,2,3,3,1,1,2,2,3,3,1,1,2,2,1,1,2,2,3,3,1,1,2,2,3,3,2];
[amplitude]=plot_response_v4 (results,path)

% %mutants (11)
% load('X:\Percival\2photon data\glia 2p\smh\2022_12_13\20221213_15_06_27_20221213GFAPgal4UASelipsamutF01\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20221218_11_45_16_20221218GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\20221218GFAPgal4UASsmhmutF01_Results_DV_nodoubles.mat')
brainRegion=[3,3,2,2,2,3,3,2,2,2,2,2,3,3,3,3,2,2,2,2,1,1,2,2,2,2,2,2,3,3,3,2,2,2,2,1,1,2,2,1,1,2,2,2,2,1,2,2,1,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20221218_12_50_09_20221218GFAPgal4UASsmhmutF02\Aligned\celldetection_manual\20221218GFAPgal4UASsmhmutF02_Results_DV_nodoubles.mat')
brainRegion=[3,3,3,3,2,2,3,3,2,2,3,3,3,3,2,2,2,2,2,2,3,3,3,3,2,2,2,1,1,2,2,2,2,1,1,2,2,1,1,2,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\2023_04_20\20230420_18_10_23_20230420GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\20230420GFAPgal4UASsmhmutF01_Results_DV_nodoubles.mat')
brainRegion=[2,2,2 1,1,1,1,3,3,2,1,1,1,1,2,1,1,1,1,1,2,1,1,1,3,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\2023_04_26\20230426_13_08_57_20230426GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\20230426GFAPgal4UASsmhmutF01_Results_DV_nodoubles.mat')
brainRegion=[2,2,2,2,1,1,3,1,1,2,3,3,1,1,1,1,2,2,1,1,1,3,3,2,1,1,1,1,1,1,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\2023_04_26\20230426_18_24_20_20230426GFAPgal4UASsmhmutF04\Aligned\celldetection_manual\20230426GFAPgal4UASsmhmutF04_Results_DV_nodoubles.mat')
brainRegion=[2,3,3,1,1,1,1,2,1,1,1,1,3,2,3,1,1,2,1,3,2,1,1,1,3,2,1,1,1,3,1,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20230718_12_22_42_20230718GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\20230718GFAPgal4UASsmhmutF01_Results_DV_nodoubles.mat')
brainRegion=[3,3,3,3,2,2,3,3,3,3,2,2,2,2,3,3,3,3,2,2,3,3,2,2,1,1,2,2,1,1,2,2,2,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20230718_19_40_43_20230718GFAPgal4UASsmhmutF04\Aligned\celldetection_manual\20230718GFAPgal4UASsmhmutF04_Results_DV_nodoubles.mat')
brainRegion=[1,1,2,2,1,1,2,2,3,3,2,2,1,1,3,3,2,2,1,1,3,3,2,2,1,1,3,3,2,2,1,1,3,3,2,2,1,1,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20230718_20_40_49_20230718GFAPgal4UASsmhmutF05\Aligned\celldetection_manual\20230718GFAPgal4UASsmhmutF05_Results_DV_nodoubles.mat')
brainRegion=[2,2,3,3,1,1,2,2,2,2,2,1,1,2,3,3,2,2,3,3,1,1,3,3,2,2,1,1,3,3,2,2,1,1,2,2,1,1,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20230718_16_18_32_20230718GFAPgal4UASsmhmutlF03\Aligned\celldetection_manual\20230718GFAPgal4UASsmhmutlF03_Results_DV_nodoubles.mat')
brainRegion=[3,3,3,3,2,2,3,3,2,2,3,3,2,2,1,1,2,2,3,3,1,1,2,2,3,3,1,1,2,2,1,1,2,2,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20240719_11_47_41_20240719GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\20240719GFAPgal4UASsmhmutF01_Results_DV_nodoubles.mat')
brainRegion=[2,2,1,1,2,2,3,3,2,2,2,2,1,1,2,2,1,1,3,3,2,2,1,1,2,2,1,1,2,2,1,1,2];
[amplitude]=plot_response_v4 (results,path)
load('X:\Percival\2photon data\glia 2p\smh\Glia 2p ROIs redone\20240729_10_36_01_20240729GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\20240729GFAPgal4UASsmhmutF01_Results_DV_nodoubles.mat')
brainRegion=[1,1,2,2,2,2,2,2,1,1,1,1,2,2,1,1,2,2,1,1,2,2,1,1,2,2,3,3,3,3,2,2,1,1,2];
[amplitude]=plot_response_v4 (results,path)