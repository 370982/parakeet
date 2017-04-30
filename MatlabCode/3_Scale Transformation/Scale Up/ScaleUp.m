%Using the Gaussian pyramid method to scale up
clc;clear;close all;
im0 = imread('pop.tif');
im0=double(im0);
figure(1);imshow(im0,[0,8500]);title('Original Image');


%Gaussian template
Sigma1=0.3;
f= fspecial('gaussian',[3,3],Sigma1);
im1 = imfilter(im0,f,'conv','replicate');

%N1,N2,N3 is the coefficient of down-sampling
N1=2;
D1 = dsample(im1,N1);
figure(2);
imshow(D1,[0,8500]);
title('Octave 1');
imwrite(uint16(D1),'Down2km.tif','Tiff');

N2=4;
D2 = dsample(im1,N2);
figure(3);
imshow(D2,[0,8500]);
title('Octave 2');
imwrite(uint16(D2),'Down4km.tif','Tiff');

N3=8;
D3 = dsample(im1,N3);
figure(4);
imshow(D3,[0,8500]);
title('Octave 3');
imwrite(uint16(D3),'Down8km.tif','Tiff');