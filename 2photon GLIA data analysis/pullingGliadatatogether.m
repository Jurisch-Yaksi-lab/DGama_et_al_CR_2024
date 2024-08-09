% code to load the data==============================

% ctrls
load('X:\Percival\2photon data\glia 2p\smh\2022_10_27\20221027_15_56_48_20221027GFAPgal4UASsmhctrlF02\Aligned\celldetection_manual\Results_BrainRegions.mat')
brainRegion=[3,2,3,2,3,2,1,1,1,1,3,2,1,1,1,1,2,1,1,1,2,1,1,1,2,2];
load('X:\Percival\2photon data\glia 2p\smh\2022_11_28\20221128_14_15_08_20221128GFAPgal4UASsmhctrlF02\Aligned\celldetection_manual\Results_BrainRegions.mat')
brainRegion=[2,3,3,2,1,1,1,3,2,1,1,1,3,2,1,1,1,2,3,1,1,1,3,2,2,1,1,1,2];
load('X:\Percival\2photon data\glia 2p\smh\2023_04_26\20230426_14_02_42_20230426GFAPgal4UASsmhctrlF04\Aligned\celldetection_manual\Results_BrainRegions.mat')
brainRegion=[3,2,3,2,2,2,3,2,1,1,3,2,1,1,1,1,3,2,1,1,1,1,2,1,1,1,1,1,2];
load('X:\Percival\2photon data\glia 2p\smh\2023_07_18\20230718_21_39_56_20230718GFAPgal4UASsmctrlF05\Aligned\celldetection_manual\Results_BrainRegions.mat')
brainRegion=[2,3,3,2,3,2,1,1,1,1,2,1,1,1,1,2,1,1,1,1,2,1,1,1,2];
load('X:\Percival\2photon data\glia 2p\smh\2023_07_18\20230718_22_35_51_20230718GFAPgal4UASsmctrlF06\Aligned\celldetection_manual\Results_BrainRegions.mat')
brainRegion=[3,3,3,2,3,2,3,2,3,2,3,2,1,1,1,1,2,1,1,1,1,2,2];
load('X:\Percival\2photon data\glia 2p\smh\2023_07_18\20230718_09_25_40_20230718GFAPgal4UASsmhctrlF01\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2023_07_18\20230718_17_23_29_20230718GFAPgal4UASsmhctrlF03\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2023_07_18\20230718_18_29_44_20230718GFAPgal4UASsmhctrlF04\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\new data 2024\2024_07_19\20240719_16_46_29_20240719GFAPgal4UASsmhctrlF03\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\new data 2024\2024_07_29\20240729_11_45_09_20240729GFAPgal4UASsmhctrlF01\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\new data 2024\2024_07_29\20240729_13_16_13_20240729GFAPgal4UASsmhctrlF02\Aligned\celldetection_manual\Results_BrainRegions.mat')

%mutants
load('X:\Percival\2photon data\glia 2p\smh\2022_12_13\20221213_15_06_27_20221213GFAPgal4UASelipsamutF01\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2022_12_18\20221218_11_45_16_20221218GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2022_12_18\20221218_12_50_09_20221218GFAPgal4UASsmhmutF02\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2023_04_20\20230420_18_10_23_20230420GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2023_04_26\20230426_13_08_57_20230426GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2023_04_26\20230426_18_24_20_20230426GFAPgal4UASsmhmutF04\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2023_07_18\20230718_12_22_42_20230718GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2023_07_18\20230718_19_40_43_20230718GFAPgal4UASsmhmutF04\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2023_07_18\20230718_20_40_49_20230718GFAPgal4UASsmhmutF05\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\2023_07_18\20230718_16_18_32_20230718GFAPgal4UASsmhmutlF03\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\new data 2024\2024_07_19\20240719_11_47_41_20240719GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\Results_BrainRegions.mat')
load('X:\Percival\2photon data\glia 2p\smh\new data 2024\2024_07_29\20240729_10_36_01_20240729GFAPgal4UASsmhmutF01\Aligned\celldetection_manual\Results_BrainRegions.mat')

%% code to check that the brain region are well separated
% it plots a subplot for each ROI which is color-coded based ont he brain
% region
clear mat
figure,
for k=1:length(results.redoneIndex)
    mat=squeeze(results.neuronLabels(:,:,:)==k);
    % Find the indices of the slices that are entirely zero
    zero_slices = all(all(mat == 0, 1), 2);
    % Remove the zero slices
    mat(:, :, zero_slices) = [];
    mat=mat*brainRegion(k);
    subplot(1,length(results.redoneIndex),k)
    imagesc(mat), caxis([0 4])
    xlim([0 512])
    ylim([0 1536])
    axis off
    colormap jet
    %colorbar
    clear mat

end
%%
dex2(results.volume)

dex2(results.neuronLabels)
colormap jet
caxis([0 23])

