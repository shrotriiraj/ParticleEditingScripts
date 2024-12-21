% Read in image
[filename, pathname] = uigetfile('*.*', 'Select image file');
img = imread(fullfile(pathname, filename));

% Display image
imshow(img);
title('Draw regions to be filled with white. Press enter when finished.');

% Initialize binary image
bw = false(size(img,1), size(img,2));

% Draw multiple regions and fill them with white
while true
    % Draw a region
    h = imfreehand();

    % Get the binary mask for the drawn region
    mask = h.createMask();

    % Add the mask to the binary image
    bw = bw | mask;

    % Ask if the user wants to draw another region
    cont = input('Draw another region? (y/n): ', 's');
    if strcmpi(cont, 'n')
        break;
    end
end

% Fill the drawn regions with white
img(bw) = 255;

% Display the final image
imshow(img);
title('Result');

