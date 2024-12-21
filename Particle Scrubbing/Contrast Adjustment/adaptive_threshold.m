% Loading an Image
[filename, pathname] = uigetfile('*.*', 'Pick an Image File');
filename = strcat(pathname, filename);
a = imread(filename);

% Convert the image to grayscale
particles_gray = rgb2gray(a);

% Apply adaptive histogram equalization
noise = adapthisteq(particles_gray);

% Filter out noise using a median filter
I = medfilt2(noise, [3 3]);
        
% Set the parameters for adaptive thresholding
thresholdSensitivity = 0.70; % Adjust the sensitivity based on your image requirements

% Compute the global threshold using graythresh
globalThreshold = graythresh(I);

% Apply adaptive thresholding
threshold = globalThreshold * thresholdSensitivity;
BW = imbinarize(I, threshold);

% Define the minimum and maximum particle areas to include
minParticleArea = 50; % Adjust as needed
maxParticleArea = Inf; % Adjust as needed

% Define the eccentricity threshold
eccentricityThreshold = 0.90; % Adjust as needed

% Perform connected component analysis using regionprops
cc = bwconncomp(BW);
props = regionprops(cc, 'Area', 'BoundingBox', 'Eccentricity');

% Refine the binarization based on region properties
for i = 1:numel(props)
    % Retrieve the properties of the current particle
    area = props(i).Area;
    boundingBox = props(i).BoundingBox;
    eccentricity = props(i).Eccentricity;
    
    % Check if the particle meets the area and eccentricity criteria
    if area >= minParticleArea && area <= maxParticleArea && eccentricity <= eccentricityThreshold
        % Include the particle in the final binary image
        particleMask = false(size(BW));
        particleMask(cc.PixelIdxList{i}) = true;
        BW = BW | particleMask;
    end
end

% Remove small specks or noise using morphological operations
se = strel('disk', 3); % Adjust the size of the structuring element as needed
BW = imopen(BW, se);

% Display the original image with the binary version side-by-side
figure;
imshowpair(I, BW, 'montage');

% Specify the file name and path for the saved image
%filename = 'grayed.png';

% Use the imwrite function to save the image
%imwrite(I, filename);


