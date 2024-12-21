 % Ask the user to select an input image
[filename, pathname] = uigetfile('*.*', 'Select image file');
particles = imread(fullfile(pathname, filename));

% Compute the mean intensity of the particles
mean_intensity = mean(particles_data(:));

% Compute the standard deviation of the particle intensities
std_intensity = std(double(particles_data(:)));

% Compute the total area of the particles
particles_area = sum(particles_data(:) > 0);

% Compute the average particle size
particle_size = particles_area / numel(particles_data);

% Display the results
fprintf('Mean Intensity: %f\n', mean_intensity);
fprintf('Standard Deviation of Intensities: %f\n', std_intensity);
fprintf('Total Area of Particles: %d\n', particles_area);
fprintf('Average Particle Size: %f\n', particle_size);
