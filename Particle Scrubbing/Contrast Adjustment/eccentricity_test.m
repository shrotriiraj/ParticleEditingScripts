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

% Define the eccentricity thresholds and threshold sensitivities
eccentricityThresholds = [0.5, 0.7, 0.9];
thresholdSensitivities = [0.7, 0.8, 0.9];

% Create a figure to display the images
figure;

% Loop through the combinations of thresholds and eccentricities
for i = 1:numel(eccentricityThresholds)
    for j = 1:numel(thresholdSensitivities)
        % Set the parameters for adaptive thresholding
        eccentricityThreshold = eccentricityThresholds(i);
        thresholdSensitivity = thresholdSensitivities(j);
        
        % Compute the global threshold using graythresh
        globalThreshold = graythresh(I);
        
        % Apply adaptive thresholding
        threshold = globalThreshold * thresholdSensitivity;
        BW = imbinarize(I, threshold);
        
        % Define the minimum and maximum particle areas to include
        minParticleArea = 50; % Adjust as needed
        maxParticleArea = Inf; % Adjust as needed
        
        % Perform connected component analysis using regionprops
        cc = bwconncomp(BW);
        props = regionprops(cc, 'Area', 'BoundingBox', 'Eccentricity');
        
        % Refine the binarization based on region properties
        for k = 1:numel(props)
            % Retrieve the properties of the current particle
            area = props(k).Area;
            boundingBox = props(k).BoundingBox;
            eccentricity = props(k).Eccentricity;
            
            % Check if the particle meets the area and eccentricity criteria
            if area >= minParticleArea && area <= maxParticleArea && eccentricity <= eccentricityThreshold
                % Include the particle in the final binary image
                particleMask = false(size(BW));
                particleMask(cc.PixelIdxList{k}) = true;
                BW = BW | particleMask;
            end
        end
        
        % Remove small specks or noise using morphological operations
        se = strel('disk', 3); % Adjust the size of the structuring element as needed
        BW = imopen(BW, se);
        
        % Create a subplot for the current threshold and eccentricity combination
        subplot(numel(eccentricityThresholds), numel(thresholdSensitivities), (i-1)*numel(thresholdSensitivities) + j);
        
        % Display the binary image
        imshow(BW);
        
        % Add a title with the threshold and eccentricity values
        title(sprintf('Threshold: %.1f, Eccentricity: %.1f', thresholdSensitivity, eccentricityThreshold));
    end
end
