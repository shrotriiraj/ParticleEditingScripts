color_imgs = dir('Color Img\*.png');
binary_imgs = 'Extra Low Contrast';

% In case there is no folder or you delete it
if ~isfolder(binary_imgs)
    disp('No Extra Low Contrast Folder, making one')
    mkdir(binary_imgs)
end

% Iterate through the images and make a binary image, then save it to
% the proper folder with the proper name
for i = 1:numel(color_imgs)
    filename = fullfile(color_imgs(i).folder, color_imgs(i).name);
    save_name = fullfile(binary_imgs, color_imgs(i).name);

    RGBimg = imread(filename);             % Read in color image
    particles_gray = rgb2gray(RGBimg);     % Convert the image to grayscale
    BW = imbinarize(particles_gray, 0.80);          % you can change the value of level

    %noise = adapthisteq(particles_gray);   % Apply adaptive histogram equalization
    %I = medfilt2(noise, [3 3]);             % Filter out noise using a median filter
    % Set the parameters for adaptive thresholding
    %thresholdSensitivity = 0.70;            % Adjust as needed
    %globalThreshold = graythresh(I);        % Compute the global threshold using graythresh
    % Apply adaptive thresholding
    %threshold = globalThreshold * thresholdSensitivity;
    %BW = imbinarize(I, threshold);
    

    % Define the minimum and maximum particle areas to include
    minParticleArea = 50;                    % Adjust as needed
    maxParticleArea = Inf;                   % Adjust as needed
    % Define the eccentricity threshold
    eccentricityThreshold = 0.90;            % Adjust as needed

    % Get the connected components in the binary image
    cc = bwconncomp(BW);

    % Get the region properties of the connected components
    props = regionprops(cc, 'Area', 'BoundingBox', 'Eccentricity');

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
    se = strel('disk', 4);    % Adjust the size of the structuring element as needed
    BW = imopen(BW, se);

    imwrite(BW, save_name);    % Save the binary image to the correct output folder
    
    disp(['Finished image ' color_imgs(i).name ' saved.']);
end
