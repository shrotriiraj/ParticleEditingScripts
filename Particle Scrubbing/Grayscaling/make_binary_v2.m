color_imgs = dir('Color Img\*.png');
binary_imgs = 'Binary Img';

% In case there is no folder or you delete it 
if ~isfolder(binary_imgs)
    disp('No binary folder, making one')
    mkdir(binary_imgs)
end

% Read in the image
[filename, pathname] = uigetfile('*.*', 'Select image file');
img = imread(fullfile(pathname, filename));

% Create a figure with two subplots for the original and binary images
figure('Position',[100,100,1000,500])
subplot(1,2,1), imshow(img), title('Original Image')
subplot(1,2,2), imshow(imbinarize(rgb2gray(img))), title('Binary Image')

% Create a slider for adjusting the threshold
slider = uicontrol('style','slider','position',[100 10 300 20],...
    'min',0,'max',1,'value',0.5);

% Create a function to update the binary image based on the slider value
update_binary = @(src,event) set(subplot(1,2,2),'CData',imbinarize(rgb2gray(img),src.Value));

% Attach the slider to the update function
addlistener(slider,'Value','PostSet',update_binary);

% Itteraties through the images and makes a binary image and saves it to
% the proper folder with the proper name 
for i=1:height(color_imgs)

    filename = horzcat(color_imgs(i).folder,'\',color_imgs(i).name);
    save_name = horzcat(binary_imgs,'\',color_imgs(i).name);

    RGBimg = imread(filename);      % Reads in color image
    grayIm = rgb2gray(RGBimg);      % Makes it a grayscale image (make changes?)
    biIm = imbinarize(grayIm);      % Makes it a binary images (make changes)
    imwrite(biIm,save_name);        % Saves it to the correct output folder 
end
