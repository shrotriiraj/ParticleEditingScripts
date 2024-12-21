color_imgs = dir('Color Img\*.png');
binary_imgs = 'Binary Img v2';

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
    
        % Reads in color image
        RGBimg = imread(filename);      
    
        % Convert the image to grayscale
        grayimg = rgb2gray(RGBimg);

        % Apply adaptive histogram equalization
        particles_contrast = adapthisteq(grayimg);
        
        % Filter out noise using a median filter
        particles_filtered = medfilt2(particles_contrast,[3 3]);
        
        % Makes it a binary images For Level 
        level = graythresh(particles_filtered);
        %level = 0.35;
        particles_binarized = imbinarize(particles_filtered, level);      
        
        % Saves it to the correct output folder 
        imwrite(particles_binarized,save_name);     
    end
end