fds_saliencyMap = fileDatastore('/Users/ehzawad/Dropbox/Final/saliently_processed_image_sets/model_1/random_center_surround_saliency/*.png', 'ReadFcn', @importdata);
% fds_saliencyMap = fileDatastore('/Users/ehzawad/Dropbox/Final/saliently_processed_image_sets/model_2/CovSal/*.png', 'ReadFcn', @importdata);
% fds_saliencyMap = fileDatastore('/Users/ehzawad/Dropbox/Final/saliently_processed_image_sets/model_3/Self_resemblance_by_LARK/*.png', 'ReadFcn', @importdata);
  % fds_saliencyMap = fileDatastore('/Users/ehzawad/Dropbox/Final/saliently_processed_image_sets/model_4/UMH/*.png', 'ReadFcn', @importdata);

fds_TD_FixMaps = fileDatastore('/Users/ehzawad/Dropbox/Final/TD_FixMaps/*.png', 'ReadFcn', @importdata);
 fds_ASD_FixMaps = fileDatastore('/Users/ehzawad/Dropbox/Final/ASD_FixMaps/*.png', 'ReadFcn', @importdata);

fullFileNames_smap = fds_saliencyMap.Files;
fullFileNames_truthmap = fds_TD_FixMaps.Files;
fullFileNames_ASD_fixmaps = fds_ASD_FixMaps.Files;

numFiles_smap = length(fullFileNames_smap);
numFiles_truthmap = length(fullFileNames_truthmap);
numFiles_ASD_fixmaps = length(fullFileNames_ASD_fixmaps);


TD_FixMaps_allvalues = 1;


for k = 1 : numFiles_smap
    s = imread(fullFileNames_smap{k});
   s = imresize(s, 0.10, 'nearest');

    g = imread(fullFileNames_truthmap{k});
    g = imresize(g, 0.10, 'nearest');


    a = imread(fullFileNames_ASD_fixmaps{k});
    a = imresize(a, 0.10, 'nearest');


    score_TD = InfoGain(s, a, g);

    TD_result = score_TD;

    TD_result = abs(TD_result);

 

    TD_FixMaps_allvalues = TD_FixMaps_allvalues + TD_result;
    disp(TD_FixMaps_allvalues)
end


disp(TD_FixMaps_allvalues);
mean_TD = TD_FixMaps_allvalues./numFiles_truthmap;

disp(mean_TD);