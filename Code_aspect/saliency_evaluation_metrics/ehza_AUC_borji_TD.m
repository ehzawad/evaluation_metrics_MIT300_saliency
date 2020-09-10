fds_saliencyMap = fileDatastore('/Users/ehzawad/Desktop/SM1dataset2/*.png', 'ReadFcn', @importdata);


fds_TD_FixMaps = fileDatastore('/Users/ehzawad/Dropbox/TrainingData/TD_FixMaps/*.png', 'ReadFcn', @importdata);
fds_ASD_FixMaps = fileDatastore('/Users/ehzawad/Dropbox/TrainingData/ASD_FixMaps/*.png', 'ReadFcn', @importdata);

fullFileNames_smap = fds_saliencyMap.Files;
fullFileNames_truthmap = fds_TD_FixMaps.Files;
fullFileNames_ASD_fixmaps = fds_ASD_FixMaps.Files;

numFiles_smap = length(fullFileNames_smap);
numFiles_truthmap = length(fullFileNames_truthmap);
numFiles_ASD_fixmaps = length(fullFileNames_ASD_fixmaps);

TD_FixMaps_allvalues = 0.0;
ASD_FixMaps_allvalues = 0.0;

i = 0;
for k = 1 : numFiles_smap

    s = imread(fullFileNames_smap{k});
    g = imread(fullFileNames_truthmap{k});
    a = imread(fullFileNames_ASD_fixmaps{k});
    
    %disp(s)
    %disp(g)
    %disp(a)
    
    i = i + 1;
    
    disp(i);

    [score] = AUC_shuffled(s, g, a);
    % [score] = AUC_shuffled(saliencyMap, groundtruthMap, othersaliencyMap);
    TD_result = score;
    disp(TD_result);
    TD_FixMaps_allvalues = TD_FixMaps_allvalues + TD_result;
%     
%     [score,~,~,~] = AUC_Judd(s, a, 0, 0);
%     ASD_result = score;
%     disp(ASD_result);
%     ASD_FixMaps_allvalues = ASD_FixMaps_allvalues + ASD_result;
    
    

%    disp(TD_result)
%    disp(ASD_result)
   % disp(TD_FixMaps_allvalues);

end



disp(TD_FixMaps_allvalues);
% disp(ASD_FixMaps_allvalues);

mean_TD = TD_FixMaps_allvalues./numFiles_truthmap;
% mean_ASD = ASD_FixMaps_allvalues./numFiles_ASD_fixmaps;

disp(mean_TD);
% disp(mean_ASD);