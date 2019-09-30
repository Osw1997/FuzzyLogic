% Reading imageclc; clear all; clc;
% Reading picture
color_ = imread('ardilla.jpg');
color = imresize(color_,[240, 320]);
[x,y,z] = size(color);
% Matriz de patrones
patron_matriz = zeros(z, x * y);
for m = 1:z
    patron_matriz(m,:) = reshape(color(:,:,m), [1, x * y]);
end

plot3(patron_matriz(1,:)', patron_matriz(2,:)', patron_matriz(3,:)', '.');
grid on;