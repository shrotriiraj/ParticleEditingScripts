% Ask the user to select an original input image
disp('Select original image file :');
[ogfilename, ogpathname] = uigetfile('*.*', 'Select image file');
ogIm = imread(fullfile(ogpathname, ogfilename));

% Save dimensions of image
im_height = size(ogIm, 1);
im_width = size(ogIm, 2);

% Make blank template with same dimensions
temp = zeros(im_height, im_width);

x = []; % This will store screw Sizes
while true
    loop = input('Continue? (1/0) : '); % 1 to continue 0 to break loop
    if loop == 1        
        % Read in Image to extract particle
        disp('Select additive image file :');
        [filename, pathname] = uigetfile('*.*', 'Select image file');
        spliceIm = imread(fullfile(pathname, filename));
        imshow(spliceIm)

        % Draw a rectangle to define the region of interest
        h = drawrectangle;
        position = h.Position;
        
        % Save positions
        x0 = round(position(1));
        y0 = round(position(2));
        xf = round(position(1) + position(3));
        yf = round(position(2) + position(4));

        % Write postions of particle onto template
        % Be careful to not go over the edges of the images
        % or it'll throw an error
        temp(y0:yf, x0:xf) = spliceIm(y0:yf, x0:xf);
        imshow(temp)
    else
        break
    end
end

% Save temp in correct folder
folderName = 'final test images';
if ~exist(folderName, 'dir')
    mkdir(folderName);
end

% Rename temp to original image + "_final" 
[~, firstName, firstExt] = fileparts(ogfilename);
finalFilename = fullfile(folderName, [firstName '_final' firstExt]);
imwrite(temp, finalFilename);
        
% Show completion text
disp(['Finished image ' firstName '_final' firstExt ' saved. Thank you!']);
close all;
