 % Ask the user to select an input image
[filename, pathname] = uigetfile('*.*', 'Select image file');
particles = imread(fullfile(pathname, filename));

% Convert the image to grayscale
particles_gray = rgb2gray(particles);

% Apply edge detection using the Canny method
particles_edges = edge(particles_gray,'Canny');

% Display the edge map
figure;
imshow(particles_edges);
title('Edge Map');

% Find connected components in the edge map
particles_cc = bwconncomp(particles_edges);

% Get the bounding boxes of the connected components
particles_props = regionprops(particles_cc, 'BoundingBox');

% Display the original image with bounding boxes around regions of interest
figure;
imshow(particles);
hold on;

for i = 1:length(particles_props)
    rectangle('Position', particles_props(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
end

title('Original Image with Bounding Boxes');
