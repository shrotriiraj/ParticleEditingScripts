% Read in image
[filename, pathname] = uigetfile('*.*', 'Select image file');
img = imread(fullfile(pathname, filename));

% Display image
imshow(img);
title('Draw regions to be filled with white. Press enter when finished.');

% Initialize binary image
bw = false(size(img,1), size(img,2));

% Draw shapes until user stops
choice = 'Yes';
while strcmp(choice, 'Yes')
    % Open image in figure window and let user draw shape
    imshow(rgbImage);
    h = imfreehand(gca);
    wait(h);
    % Create binary mask of shape
    binaryMask = h.createMask();
    % Fill in any gaps in the shape
    binaryMask = imfill(binaryMask, 'holes');
    % Make the inside of the shape white and the outside the same as the original image
    outputImage = rgbImage;
    outputImage(repmat(binaryMask,[1,1,3])) = 255;
    % Show the output image
    imshow(outputImage);
    % Ask user if they want to draw another shape
    choice = questdlg('Do you want to draw another shape?', 'Draw another?', 'Yes', 'No', 'Yes');
end
