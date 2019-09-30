clc; clear all; clc;
% Reading picture
color_ = imread('ardilla.jpg');
subplot(2,2,[1,3]);
imshow(color_);
% Resize image
color = imresize(color_,[240, 320]);
% Grey scale
grey = rgb2gray(color);
% figure;
subplot(2,2,[2,4]);
imshow(grey);
% Values less than 120
bin1 = grey < 120;
figure;
subplot(2,2,[1,3]);
imshow(bin1);
% Values greater than 120
bin2 = grey > 120;
subplot(2,2,[2,4]);
imshow(bin2);
% Histograma de la escala de grises
figure;
histogram(grey);