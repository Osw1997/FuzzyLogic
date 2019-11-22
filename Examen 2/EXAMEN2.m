clear all; close all; clc;

%Leer la imagen
color = imread('pic2.png');

%para ver la imagen
figure
imshow(color); 

%esacala de grises
gris = rgb2gray(color);
figure
% imshow(gris);

% %Reducir el tama�o
 imagen = imresize(gris,[240,320]);
 imshow(imagen)
% %Pasarla a Double
% imagenPro = double(imagen);

%Desprescieando el fondo blanco
[x y] = find(imagen<180);
x = x'; 
y = y';
c = 3;
% %
ejeX = 0:3:240;
ejeY = 0:3:320;
% %
alpha = 01.25;
beta = 0.25;
delta = 0;
k = 1;

% %
for i = 1:length(ejeX)
    for j = 1:length(ejeY)
        for h = 1:length(x)
            D = sqrt( (ejeX(i)-x(h))^2 + (ejeY(j)-y(h))^2);
            aux(h) = exp(-alpha*D);
        end
        M(j,i) = sum(aux);
    end
end
M;
% [X,Y] = meshgrid(ejeX,ejeY);
% mesh(X,Y,M)
% pause
disp('Ya paso por aqui')

% %
M1(k) = max(max(M));

while (delta < 1) || (k < 5)
    for i = 1:length(ejeX)
        for j = 1:length(ejeY)
            if M(j,i) == M1(k)
                X1(k) = i;
                Y1(k) = j;
            end
        end
    end
    k
    M(Y1(k),X1(k))
    %plot3(ejeX(X1),ejeY(Y1),ejeZ(Z1),'k*','linewidth',2)
    EX=ejeX(X1);
    EY=ejeY(Y1);
    for i = 1:length(ejeX)
        for j = 1:length(ejeY)
            for n = 1:k
                D = sqrt( ( ejeX(i)-ejeX(X1(n)) )^2 + ( ejeY(j)- ejeY(Y1(n)) )^2 );
                aux(n) = exp(-beta*D);
            end
            aux2 = M(j,i) - M1(k)*sum(aux);
            M(j,i) = aux2;
            M(j,i) = max(M(j,i),0);
        end
    end
    k = k + 1;
    M1(k) = max(max(M(:,:)));
    delta = M1(1)/M1(k);
end

% %

hold on
plot(EY,EX,'r*','linewidth',2)
title('Algoritmo de monta�a')
xlabel(' X')
ylabel(' Y')

figure
[X,Y] = meshgrid(ejeX,ejeY); 
% mat_scala = zeros(size(M));
[tam_x tam_y] = size(M);
% mat_scala = [repmat(1,26,tam_y); repmat(0.8,26,tam_y); repmat(0.6,26,tam_y); repmat(0.4,29,tam_y)];
% M = M .* mat_scala;
mesh(X,Y,M)

% %
%Empieza kmeans
% Determinaci�n de n�mero de clusters
X= [x,y];

[no_clust, datos] = size(X);
no_clust = 4
U = zeros(no_clust, datos);
U(1,1:4:end) = 1;
U(2,2:4:end-1) = 1;
U(3,3:4:end-2) = 1;
U(4,4:4:end-3) = 1;
% Determinaci�n de n�mero de clusters

[filas_cumulos,  datos_cum] = size(U);
% Se itera con base a un par�metro epsilon
epocas = 1e3;
%V = [EX;EY];
for m = 1:epocas
    % Centroides
    %V = zeros(no_clust, filas_cumulos);
    
    if m==1
        V = [EX;EY];
    else
        for i=1:no_clust
           for j=1:2
               V(i,j) = sum(U(i,:).*X(:,j)')/sum(U(i,:));
            end
        end
    end
    V;
    
%     for n = 1:no_clust
%         V(n,:) = calc_centroide(X, U(n,:));
%     end
    %%V = V';
%     X11=X1/10;
%     Y11=Y1/10;
%     V=[X11;Y11];
    %V=V';
    % Distancias entre centroides a datos
    dist = zeros(filas_cumulos, datos_cum);
    for n = 1:filas_cumulos
        dist(n,:) = sqrt(sum((X - repmat(V(:,n),1,datos_cum)).^2));
    end
    dist;
    % Se actualiza U
    for n = 1:filas_cumulos
%         U(n,:) = dist(n,:) == min(dist);
        U(n,:) = ((dist(n,1:end) ./ dist(1,1:end)).^2 + (dist(n,1:end) ./  dist(2, 1:end)).^2 + (dist(n,1:end) ./  dist(3, 1:end)).^2).^-1;
    end
%     Se plotea el resultado
    %r = plot3(V(1,:), V(2,:), V(3,:), '*k', 'LineWidth', 5); hold on
    V;
%     pause(0.5);
%     if m ~= epocas
%       %  set(r, 'visible', 'off')
%     end
%     U 
end
figure()
% imshow(gris);
imshow(imagen)
hold on
plot(V(2,:), V(1,:), '*r', 'LineWidth', 2);
title('Algoritmo de monta�a con IRIS.')
xlabel(' X')
ylabel(' Y')

%Finaliza K-means

