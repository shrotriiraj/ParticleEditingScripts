% Ask the user to select an input image
[filename, pathname] = uigetfile('*.*', 'Select image file');
ogIm = imread(fullfile(pathname, filename));
imshow(ogIm)

% Create the folder to save the final test images if it doesn't exist
folderName = 'final test images';
if ~exist(folderName, 'dir')
    mkdir(folderName);
end

im_height = size(ogIm, 1);
im_width = size(ogIm, 2);

temp = zeros(im_height, im_width, 3); % Initialize temporary image

x = []; % This will store screw sizes
while true
    loop = input('Continue? (1/0): '); % 1 to continue, 0 to break loop
    if loop == 1        
        [filename, pathname] = uigetfile('*.*', 'Select image file');
        spliceIm = imread(fullfile(pathname, filename));
        imshow(spliceIm)

        % Draw a rectangle to define the region of interest
        h = drawrectangle;
        position = h.Position;
        
        x0 = round(position(1));
        y0 = round(position(2));
        xf = round(position(1) + position(3));
        yf = round(position(2) + position(4));
        
        temp(y0:yf, x0:xf, :) = spliceIm(y0:yf, x0:xf, :);
        
        imshow(temp)
    else
        break
    end
end

% Save the final image
[~, name, ext] = fileparts(filename);
finalFilename = fullfile(folderName, [name '_final' ext]);
imwrite(temp, finalFilename);
        
disp(['Finished image ' name '_final' ext ' saved. Thank you!']);
        
