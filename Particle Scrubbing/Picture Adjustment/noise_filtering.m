 % Ask the user to select an input image
[filename, pathname] = uigetfile('*.*', 'Select image file');
particles = imread(fullfile(pathname, filename));

% Display the original image
figure;
imshow(particles);
title('Original Image');

% Adjust the contrast
particles_contrast = imadjust(particles,[0.2 0.8],[]);

% Display the contrast-adjusted image
figure;
imshow(particles_contrast);
title('Contrast-Adjusted Image');

% Filter out noise using a median filter
particles_filtered = medfilt2(particles_contrast,[3 3]);

% Display the filtered image
figure;
imshow(particles_filtered);
title('Filtered Image');
