clc;clear all;close all;
im0=imread('NDVI.tif');
im0=double(im0);
figure(1);imshow(im0,[0,0.99]);title('Original Image');
%如果是京津冀的ndvi.tif，nodata设置为255
%设置0.99主要是为了显示

%UpSample by a Factor 2
[height,width,flag]=size(im0);
im1=imresize(im0,[height*2,width*2],'bilinear');
figure(2);imshow(im1);
imwrite(im1,'Up4km.tif','Tiff');

%UpSample by a Factor 4
[height,width,flag]=size(im0);
im2=imresize(im0,[height*4,width*4],'bilinear');
figure(3);imshow(im2);
imwrite(im2,'Up2km.tif','Tiff');

%UpSample by a Factor 8
[height,width,flag]=size(im0);
im3=imresize(im0,[height*8,width*8],'bilinear');
figure(4);imshow(im3);
imwrite(im3,'Up1km.tif','Tiff');

%求均值
X8km=mean(im0(:));
X4km=mean(im1(:));
X2km=mean(im2(:));
X1km=mean(im3(:));
%求方差
S8km=var(im0(:));
S4km=var(im1(:));
S2km=var(im2(:));
S1km=var(im3(:));
%求平均绝对误差
MAE8km=mean(mean(abs(im0-mean(mean(im0)))));
MAE4km=mean(mean(abs(im1-mean(mean(im1)))));
MAE2km=mean(mean(abs(im2-mean(mean(im2)))));
MAE1km=mean(mean(abs(im3-mean(mean(im3)))));

