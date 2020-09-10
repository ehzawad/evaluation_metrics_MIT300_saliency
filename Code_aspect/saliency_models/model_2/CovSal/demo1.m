clc;
clear all;
close all;

% options for saliency estiomation
options.size = 512;                     % size of rescaled image
options.quantile = 1/10;                % parameter specifying the most similar regions in the neighborhood
options.centerBias = 1;                 % 1 for center bias and 0 for no center bias
options.modeltype = 'CovariancesOnly';  % 'CovariancesOnly' and 'SigmaPoints'
% to denote whether first-order statistics
% will be incorporated or not

srcFiles = dir('/Users/ehzawad/Dropbox/Final/original_images/*.png');
for i = 1 : 2
    filename = fullfile(srcFiles(i).folder,srcFiles(i).name);
    I= imread(filename);
    
    disp(filename);
    
    salmap1 = saliencymap(I, options);
    
    % figure;
    helu = imagesc(salmap1);
    
    % colormap(gray);% axis image off;
    title('Covariances only');

    n = strcat('/Users/ehzawad/Desktop/',srcFiles(i).name);
    
    finalOutput = mat2gray(helu);
    imshow((finalOutput));
    imwrite(finalOutput, n);
end
