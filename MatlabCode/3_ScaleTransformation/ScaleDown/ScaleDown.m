%高斯金字塔的主要步骤：
%先高斯模糊，后升采样。
clc;clear;close all;
im0 = imread('NDVI.tif'); 
im0 =double(im0); 
figure(1);imshow(im0,[0,0.99]);title('Original Image');
%如果是京津冀的ndvi.tif，nodata设置为255
%设置0.99主要是为了显示

%高斯模板：不同模糊尺度%%%%%%%%%
Sigma1=0.3;
f= fspecial('gaussian',[3,3],Sigma1);
im1 = imfilter(im0,f,'conv','replicate');

%N1，N2，N3为升采样系数%%%%%
N1=2;        
U1 = usample(im1,N1);        
figure(2);
imshow(abs(U1),[]);
title('Octave 1');
imwrite(U1,'Up4km.tif','Tiff');

N2=4;
U2 = usample(im1,N2);        
figure(3);
imshow(abs(U2),[]);
title('Octave 2');
imwrite(U2,'Up2km.tif','Tiff');

N3=8;
U3 = usample(im1,N3);        
figure(4);
imshow(abs(U3),[]);
title('Octave 3');
imwrite(U3,'Up1km.tif','Tiff');

