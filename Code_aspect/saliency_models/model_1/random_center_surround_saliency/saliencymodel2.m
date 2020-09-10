clc;
clear all;
close all;

myFolder = '/Users/ehzawad/Dropbox/Final/original_images/';
filePattern = fullfile(myFolder, '*.png');
theFiles = dir(filePattern);

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    img = imread(fullFileName);
    
    gfrgb = imfilter(img, fspecial('gaussian', 3, 3),'symmetric','conv');
    cform = makecform('srgb2lab');
    lab = applycform(gfrgb,cform);
  
    l = double(lab(:,:,1));
    a = double(lab(:,:,2));
    b = double(lab(:,:,3));
    
    [r,c] = size(l);
    Map_L(1:r,1:c) = 0.0;
    Map_a(1:r,1:c) = 0.0;
    Map_b(1:r,1:c) = 0.0;
    Map_Points(1:r,1:c) = 0.0;
    
    n = 1000;
    
    for i=1:n    
        x1 = floor(rand()*(r-1))+1;
        y1 = floor(rand()*(c-1))+1;       
        x2 = floor(rand()*(r-1))+1;
        y2 = floor(rand()*(c-1))+1;
        
        if(x2 <r && y2 < c && x1 > 0 && y1 > 0)
            l1 = x1;
            u1 = y1;           
            l2 = x2;
            u2 = y2;
            
            if(x1>x2)
                l1 = x2;
                l2 = x1;
            end
            
            if(y1>y2)
                u1 = y2;
                u2 = y1;
            end
            
            ml = mean2(l(l1:l2,u1:u2));
            Map_L(l1:l2,u1:u2) = Map_L(l1:l2,u1:u2) + abs((l(l1:l2,u1:u2) - ml));
            ma = mean2(a(l1:l2,u1:u2));
            Map_a(l1:l2,u1:u2) = Map_a(l1:l2,u1:u2) + abs((a(l1:l2,u1:u2) - ma)); 
            mb = mean2(b(l1:l2,u1:u2));
            Map_b(l1:l2,u1:u2) = Map_b(l1:l2,u1:u2) + abs((b(l1:l2,u1:u2) - mb));
        end       
    end

    sm1 = ((Map_L).^(2) + (Map_a).^(2) + (Map_b).^(2)).^(1/2);
    sm1 = medfilt2(sm1,[11 11]);
    SM = uint8(((sm1 - min(sm1(:)))/(max(sm1(:))))*255);
    %figure; imshow(SM);
    %drawnow; % Force display to update immediately.
    foldername = '/Users/ehzawad/Dropbox/Final/saliently_processed_image_sets/model_1/random_center_surround_saliency/';
    %baseFileName2 = strcat(fullFileName,'');
    fullFileName2 = fullfile(foldername, baseFileName);
    imwrite(SM, fullFileName2);
end