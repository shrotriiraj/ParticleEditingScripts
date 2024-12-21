color_imgs = dir('Test Image Set 1\*.png');
binary_imgs = 'Final Set 1';

% In case there is no folder or you delete it 
if ~isfolder(binary_imgs)
    disp('No Final Set 1, making one')
    mkdir(binary_imgs)
end

% Itteraties through the images and makes a binary image and saves it to
% the proper folder with the proper name 
for i=1:height(color_imgs)

    filename = horzcat(color_imgs(i).folder,'\',color_imgs(i).name);
    save_name = horzcat(binary_imgs,'\',color_imgs(i).name);

    RGBimg = imread(filename);      % Reads in color image
    particles_gray = rgb2gray(a);    % Convert the image to grayscale
    noise = adapthisteq(particles_gray);    % Apply adaptive histogram equalization
    I = medfilt2(noise, [3 3]);     % Filter out noise using a median filter

     % Set the parameters for adaptive thresholding
    thresholdSensitivity = 0.75;        % Adjust as needed       
    globalThreshold = graythresh(I);        % Compute the global threshold using graythresh
    % Apply adaptive thresholding
    threshold = globalThreshold * thresholdSensitivity;
    BW = imbinarize(I, threshold);
    % Define the minimum and maximum particle areas to include
    minParticleArea = 50; % Adjust as needed
    maxParticleArea = Inf; % Adjust as needed 
    % Define the eccentricity threshold
    eccentricityThreshold = 0.5; % Adjust as needed
    
    % Refine the binarization based on region properties
    for j = 1:numel(props)
        % Retrieve the properties of the current particle
        area = props(j).Area;
        boundingBox = props(j).BoundingBox;
        eccentricity = props(j).Eccentricity;
        
        % Check if the particle meets the area and eccentricity criteria
        if area >= minParticleArea && area <= maxParticleArea && eccentricity <= eccentricityThreshold
            % Include the particle in the final binary image
            particleMask = false(size(BW));
            particleMask(cc.PixelIdxList{j}) = true;
            BW = BW | particleMask;
        end
    end
    
    % Remove small specks or noise using morphological operations
    se = strel('disk', 4); % Adjust the size of the structuring element as needed
    BW = imopen(BW, se);

    imwrite(BW,save_name);        % Saves it to the correct output folder 
end