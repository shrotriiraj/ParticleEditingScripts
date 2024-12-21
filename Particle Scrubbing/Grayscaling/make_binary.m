%% This should segment the color images and turn them into binary images 
% Not all images will be able to be processed through automation so don't
% be afraid to make manual changes where necessary
% be sure to use imfill(). You can manually draw a boundry and then use
% imfill to fill it in... 


color_imgs = dir('Color Img\*.png');
binary_imgs = 'Binary Img';

% In case there is no folder or you delete it 
if ~isfolder(binary_imgs)
    disp('No binary folder, making one')
    mkdir(binary_imgs)
end

% Itteraties through the images and makes a binary image and saves it to
% the proper folder with the proper name 
for i=1:height(color_imgs)
    for i=1:height(color_imgs)

        filename = horzcat(color_imgs(i).folder,'\',color_imgs(i).name);
        save_name = horzcat(binary_imgs,'\',color_imgs(i).name);
    
        RGBimg = imread(filename);      % Reads in color image
        grayIm = rgb2gray(RGBimg);      % Makes it a grayscale image (make changes?)
        biIm = imbinarize(grayIm);      % Makes it a binary images (make changes)
        % Remove small specks or noise using morphological operations
        se = strel('disk', 3); % Adjust the size of the structuring element as needed
        biIm = imopen(biIm, se);
        
        imwrite(biIm,save_name);        % Saves it to the correct output folder 
    end
end