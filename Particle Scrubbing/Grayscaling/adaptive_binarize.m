% Ask the user to select an input image
[filename, pathname] = uigetfile('*.*', 'Select image file');
inputImage = imread(fullfile(pathname, filename));

% Convert the input image to grayscale
grayImage = rgb2gray(inputImage);

% Ask user for sensitivity and neighborhood size
sensitivity = input('Enter sensitivity (0 to 1): ');
neighborhood = input('Enter neighborhood size (odd number): ');

% Apply adaptive thresholding
binaryImage = imbinarize(grayImage, 'adaptive', 'Sensitivity', sensitivity, 'ForegroundPolarity', 'bright', 'NeighborhoodSize', neighborhood);

% Display the original and final images side by side
figure;
subplot(1, 2, 1);
imshow(inputImage);
title('Original Image');
subplot(1, 2, 2);
imshow(binaryImage);
title('Binary Image');
