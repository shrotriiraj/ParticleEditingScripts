 % Ask the user to select an input image
[filename, pathname] = uigetfile('*.*', 'Select image file');
particles = imread(fullfile(pathname, filename));

% Convert the image to grayscale
particles_gray = rgb2gray(particles);

% Apply edge detection using the Canny method
particles_edges = edge(particles_gray,'Canny');

% Dilate the edges to fill gaps
se = strel('disk',2);
particles_dilated = imdilate(particles_edges,se);

% Fill in the regions enclosed by the edges
particles_filled = imfill(particles_dilated,'holes');

% Threshold the image to isolate the regions of interest
particles_threshold = particles_filled > 50;

% Extract the data from the regions of interest
particles_data = particles_gray .* uint8(particles_threshold);

% Display the extracted data
figure;
imshow(particles_data);
title('Extracted Data');
