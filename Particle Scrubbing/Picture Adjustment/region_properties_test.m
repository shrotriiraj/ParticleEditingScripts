 % Ask the user to select an input image
[filename, pathname] = uigetfile('*.*', 'Select image file');
particles = imread(fullfile(pathname, filename));

% Display the original image
figure;
imshow(particles);
title('Original Image');

%Calculate centroids for connected components in the image using regionprops.
%The regionprops function returns the centroids in a structure array.
s = regionprops(particles,'centroid');

%Store the x- and y-coordinates of the centroids into a two-column matrix.
centroids = cat(1,s.Centroid);

%Display the binary image with the centroid locations superimposed.
imshow(particles)
hold on
plot(centroids(:,1),centroids(:,2),'b*')
hold off

%Calculate properties of regions in the image and return the data in a table.
stats = regionprops("table",particles,"Centroid", "MajorAxisLength","MinorAxisLength")

%Get centers and radii of the circles.
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;

%Plot the circles.
hold on
viscircles(centers,radii)
hold off
