clc
clear all
close all
%% Loading an Image
[filename,pathname]=uigetfile('*.*','Pick a MATLAB code File');
filename=strcat(pathname,filename);
b=imread(filename);
a=rgb2gray(b);
figure;
imshow(a);
title('Original Image');
%% Thresholding / Binarization
level=graythresh(a);
BW=imbinarize(a,level); % you can change the value of level
figure;
subplot(2,2,1);
imshowpair(a,BW,'montage')
title('Binarized Image');
%% For Level 0.40
level=graythresh(a);
BW=imbinarize(a,0.40); % you can change the value of level
subplot(2,2,2);
imshowpair(a,BW,'montage')
title('Binarized Image for level 0.40');
%% For level 0.60
level=graythresh(a);
BW=imbinarize(a,0.60); % you can change the value of level
subplot(2,2,3);
imshowpair(a,BW,'montage')
title('Binarized Image for level 0.60 ');
%% For level 0.80
level=graythresh(a);
BW=imbinarize(a,0.80); % you can change the value of level
subplot(2,2,4);
imshowpair(a,BW,'montage')
title('Binarized Image for level 0.80');

