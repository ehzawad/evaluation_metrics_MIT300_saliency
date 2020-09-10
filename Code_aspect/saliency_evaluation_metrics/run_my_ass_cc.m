fds_saliencyMap = fileDatastore('/Users/ehzawad/Desktop/SM1dataset2/*.png', 'ReadFcn', @importdata);
% fds_TD_FixMaps = fileDatastore('/Users/ehzawad/Dropbox/TrainingData/TD_FixMaps/*.png', 'ReadFcn', @importdata);
fds_ASD_FixMaps = fileDatastore('/Users/ehzawad/Dropbox/TrainingData/ASD_FixMaps/*.png', 'ReadFcn', @importdata);
 
fullFileNames_smap = fds_saliencyMap.Files;
% fullFileNames_truthmap = fds_TD_FixMaps.Files;
fullFileNames_ASD_fixmaps = fds_ASD_FixMaps.Files;
 
 
numFiles_smap = length(fullFileNames_smap);
% numFiles_truthmap = length(fullFileNames_truthmap);
numFiles_ASD_fixmaps = length(fullFileNames_ASD_fixmaps);
 
 
% TD_FixMaps_allvalues = 0.0;
ASD_FixMaps_allvalues = 0.0;
 
i = 0;
for k = 1 : numFiles_smap
 
    s = imread(fullFileNames_smap{k});
   %  g = imread(fullFileNames_truthmap{k});
    a = imread(fullFileNames_ASD_fixmaps{k});
   
%     disp(a);
%     disp(s);
     
    i = i + 1;
   
    disp(i);
   
    ss = real(s);
    aa = real(a);
   
   
    [score] = CC(ss, aa);

   result = score;
   
   % disp(result);

end