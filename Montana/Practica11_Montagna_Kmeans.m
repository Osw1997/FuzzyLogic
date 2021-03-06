close all;
clear all;
clc;
% % Adquisici�n de datos
dat = fopen('IrisDataBase.dat');
IrisDataBase = textscan(dat, '%f %f %f %f %s');
fclose(dat);
Datos(:,1)=IrisDataBase{2};
Datos(:,2)=IrisDataBase{3};
Datos(:,3)=IrisDataBase{4};
DatosS=Datos(1:50,:);%Datos Iris-setosa
DatosVS=Datos(51:100,:); %Datos Iris-versicolour
DatosV=Datos(101:150,:);%Datos Iris-virginica
figure()
hold on;
plot3(DatosS(:,1),DatosS(:,2),DatosS(:,3),'*g')
plot3(DatosVS(:,1),DatosVS(:,2),DatosVS(:,3),'*b')
plot3(DatosV(:,1),DatosV(:,2),DatosV(:,3),'*r')
grid on;
% % Logaritmo
% % Se definen los parametros iniciales.
% m -> puede tener valores de 1 o 2 comunmente.
m =2;
% c -> numero de cluster.
c = 3;
% ej -> Umbral de paro del algoritmo
ej = 0.0001;
% Se define los tres vectores.
x = [DatosS(:,1)' DatosVS(:,1)' DatosV(:,1)'];
y = [DatosS(:,2)' DatosVS(:,2)' DatosV(:,2)'];
z = [DatosS(:,3)' DatosVS(:,3)' DatosV(:,3)'];
% %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
ejeX = 0:0.1:4.5;
ejeY = 0:0.1:7;
ejeZ = 0:0.1:3;
% %
alpha = 4.5;
beta = 4.5;
delta = 0;
k = 1;
% %
for i = 1:length(ejeX)
for j = 1:length(ejeY)
for m = 1:length(ejeZ)
for h = 1:length(x)
D = sqrt( (ejeX(i)-x(h))^2 + (ejeY(j)-y(h))^2 +(ejeZ(m)-z(h))^2);
aux(h) = exp(-alpha*D);
end
M(j,i,m) = sum(aux);
end
end
end
% %
M1(k) = max(max(max(M(:,:,:))));
while delta < 2
for i = 1:length(ejeX)
for j = 1:length(ejeY)
for m = 1:length(ejeZ)
if M(j,i,m) == M1(k)
X1(k) = i;
Y1(k) = j;
Z1(k) = m;
end
end
end
end
M(Y1(k),X1(k),Z1(k))
plot3(ejeX(X1),ejeY(Y1),ejeZ(Z1),'k*','linewidth',2)
for i = 1:length(ejeX)
for j = 1:length(ejeY)
for m = 1:length(ejeZ)
for n = 1:k
D = sqrt( ( ejeX(i)-ejeX(X1(n)) )^2 + ( ejeY(j)- ejeY(Y1(n)) )^2 + ( ejeZ(m)-ejeZ(Z1(n)) )^2 );
aux(n) = exp(-beta*D);
end
aux2 = M(j,i,m) - M1(k)*sum(aux);
M(j,i,m) = aux2;
M(j,i,m) = max(M(j,i,m),0);
end
end
end
k = k + 1;
M1(k) = max(max(max(M(:,:,:))));
delta(k-1) = M1(1)/M1(k);
end
title('Algoritmo de monta�a con IRIS.')
xlabel(' X')
ylabel(' Y')
zlabel(' Z')
legend('Setosa','Versicolour','Virginica','Centros obtenidos')


%%Empieza kmeans
%close all; clear all; clc;
% Datos = importdata('IrisDataBase.dat')
% % Adquisici�n de datos
dat = fopen('IrisDataBase.dat');
IrisDataBase = textscan(dat, '%f %f %f %f %s');
fclose(dat);
Datos(:,1)=IrisDataBase{2};
Datos(:,2)=IrisDataBase{3};
Datos(:,3)=IrisDataBase{4};
figure(1)
plot3(Datos(:,1),Datos(:,2),Datos(:,3),'.')
grid on;
DatosS=Datos(1:50,:);%Datos Iris-setosa
DatosVS=Datos(51:100,:); %Datos Iris-versicolour
DatosV=Datos(101:150,:);%Datos Iris-virginica
figure(2)
hold on;
plot3(DatosS(:,1),DatosS(:,2),DatosS(:,3),'*g')
plot3(DatosVS(:,1),DatosVS(:,2),DatosVS(:,3),'*b')
plot3(DatosV(:,1),DatosV(:,2),DatosV(:,3),'*r')
grid on;
hold on;
% Determinaci�n de n�mero de clusters
X= Datos';
[no_clust, datos] = size(X);
U = zeros(no_clust, datos);
U(1,1:3:end) = 1;
U(2,2:3:end-1) = 1;
U(3,3:3:end-2) = 1;
% Determinaci�n de n�mero de clusters

[filas_cumulos,  datos_cum] = size(U);
% Se itera con base a un par�metro epsilon
epocas = 40;
for m = 1:epocas
    % Centroides
    V = zeros(no_clust, filas_cumulos);
    for n = 1:no_clust
        V(n,:) = calc_centroide(X, U(n,:));
    end
    %%V = V';
    X11=X1/10;
    Y11=Y1/10;
    Z11=Z1/10;
    V=[X11;Y11;Z11];
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
    r = plot3(V(1,:), V(2,:), V(3,:), 'ok', 'LineWidth', 5); hold on
    V;
    pause(0.5);
    if m ~= epocas
        set(r, 'visible', 'off')
    end
%     U 
end
%Finaliza K-means