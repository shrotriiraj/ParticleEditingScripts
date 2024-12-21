% Read the image
[filename, pathname] = uigetfile('*.*', 'Select image file');
originalImage = imread(fullfile(pathname, filename));

% Display the image
figure(1);
imshow(originalImage);
title('Original Image');

% Initialize modified image as the original image
modifiedImage = originalImage;

% While loop to black out multiple areas
continueFlag = true;
while continueFlag
    % Use drawrectangle to define the region of interest
    h = drawrectangle;
    roiPosition = round(h.Position);

    % Extract coordinates of the rectangle
    x0 = roiPosition(1);
    y0 = roiPosition(2);
    width = roiPosition(3);
    height = roiPosition(4);

    % Create a black area inside the rectangle
    modifiedImage(y0:y0+height, x0:x0+width, :) = 0;

    % Prompt the user if they want to continue blacking out areas
    continueInput = input('Continue blacking out areas? (y/n): ', 's');
    if strcmpi(continueInput, 'n')
        continueFlag = false;
    end
end

% Save the modified image with the same name in the same folder
[~, name, ext] = fileparts(filename);
modifiedFilename = fullfile(pathname, [name '_modified' ext]);
imwrite(modifiedImage, modifiedFilename);

disp(['Modified image saved as: ' [name '_modified' ext]]);
close all;