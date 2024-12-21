 % Ask the user to select an input image
[filename, pathname] = uigetfile('*.*', 'Select image file');
particles = imread(fullfile(pathname, filename));

% Adjust the contrast
particles_contrast = adapthisteq(particles_filtered);

% Convert the image to grayscale
particles_gray = rgb2gray(particles_contrast);

% Filter out noise using a median filter
particles_filtered = medfilt2(particles_gray,[3 3]);

% Makes it a binary images For Level 
% level = graythresh(particles_filtered);
level = 0.35;
particles_binarized = imbinarize(particles_filtered, level);      

% Display the results
figure;
subplot(2,2,1), imshow(particles), title('Original Image');
subplot(2,2,2), imshow(particles_contrast), title('Contrast Adjusted Image');
subplot(2,2,3), imshow(particles_filtered), title('Filtered Image');
subplot(2,2,4), imshow(particles_binarized), title('Binarized Image');


% Threshold the image to isolate the regions of interest
particles_threshold = particles_binarized > 50;

% Extract the data from the regions of interest
particles_data = particles_gray .* uint8(particles_threshold);

% Compute the mean intensity of the particles
mean_intensity = mean(particles_data(:));

% Compute the standard deviation of the particle intensities
std_intensity = std(double(particles_data(:)));

% Compute the total area of the particles
particles_area = sum(particles_data(:) > 0);

% Compute the average particle size
particle_size = particles_area / numel(particles_data);

fprintf('Mean Intensity: %f\n', mean_intensity);
fprintf('Standard Deviation of Intensities: %f\n', std_intensity);
fprintf('Total Area of Particles: %d\n', particles_area);
fprintf('Average Particle Size: %f\n', particle_size);
