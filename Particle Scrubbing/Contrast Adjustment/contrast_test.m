 % Ask the user to select an input image
[filename, pathname] = uigetfile('*.*', 'Select image file');
particles = imread(fullfile(pathname, filename));

% Adjust the contrast
% particles_contrast = imadjust(particles,[0.2 0.8],[]);

% Grayscale
particles_gray = rgb2gray(particles);

% Filter out noise using a median filter
particles_filtered = medfilt2(particles_gray,[3 3]);

particles_imadjust = imadjust(particles_filtered);
particles_histeq = histeq(particles_filtered);
particles_adapthisteq = adapthisteq(particles_filtered);

% Makes it a binary images For Level 
level = graythresh(particles_filtered);
% level = 0.35;
particles_binarized = imbinarize(particles_filtered, level);

particles_imadjust_b = imbinarize(particles_imadjust, level);
particles_histeq_b = imbinarize(particles_histeq, level);
particles_adapthisteq_b = imbinarize(particles_adapthisteq, level);

montage({particles,particles_imadjust_b,particles_histeq_b,particles_adapthisteq_b},"Size",[1 4])
title("Original Image and Binarized Images using imadjust, histeq, and adapthisteq")

