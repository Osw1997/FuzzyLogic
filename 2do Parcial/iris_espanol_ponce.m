
close all; clear all; clc;
% Datos = importdata('IrisDataBase.dat')
% % Adquisición de datos
dat = fopen('IrisDataBase.dat');
IrisDataBase = textscan(dat, '%f %f %f %f %s');
fclose(dat);
Datos(:,1) = IrisDataBase{2};
Datos(:,2) = IrisDataBase{3};
Datos(:,3) = IrisDataBase{4};
% figure(1)
% plot3(Datos(:,1),Datos(:,2),Datos(:,3),'.')
grid on;
DatosS=Datos(1:50,:);%Datos Iris-setosa
DatosVS=Datos(51:100,:); %Datos Iris-versicolour
DatosV=Datos(101:150,:);%Datos Iris-virginica
% figure(2)
hold on;
plot3(DatosS(:,1),DatosS(:,2),DatosS(:,3),'.r')
plot3(DatosVS(:,1),DatosVS(:,2),DatosVS(:,3),'.g')
plot3(DatosV(:,1),DatosV(:,2),DatosV(:,3),'.b')
grid on;
X = Datos';

% % % Clusters nítidos
% Determinación de número de clusters
[no_clust, datos] = size(X);
% Matriz inicial para 2 cluster
U = zeros(no_clust, datos);
U(1,1:3:end) = 1;
U(2,2:3:end-1) = 1;
U(3,3:3:end-2) = 1;
[filas_cumulos,  datos_cum] = size(U);
% Se itera con base a un parámetro epsilon
epocas = 10;
for m = 1:epocas
    % Centroides
    V = zeros(no_clust, filas_cumulos);
    for n = 1:no_clust
        V(n,:) = calc_centroide(X, U(n,:));
%         pause;
    end
%     pause;
    V = V';
    % Distancias entre centroides a datos
    dist = zeros(filas_cumulos, datos_cum);
    for n = 1:filas_cumulos
        dist(n,:) = sqrt(sum((X - repmat(V(:,n),1,datos_cum)).^2));
    end
%     dist
    % Se actualiza U
    for n = 1:filas_cumulos
        U(n,:) = dist(n,:) == min(dist);
    end
%     Se plotea el resultado
    r = plot3(V(1,:), V(2,:), V(3,:), 'ob', 'LineWidth', 5); hold on
%     V
    pause(2);
    if m ~= epocas
        set(r, 'visible', 'off')
    end
%     U 
end
