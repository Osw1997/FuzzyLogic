clear all; close all; clc;

%Leer la imagen
color = imread('pic2_.jpeg');

%para ver la imagen
figure
imshow(color); 

%esacala de grises
gris = rgb2gray(color);
figure
% imshow(gris);

% %Reducir el tamaño
 imagen = imresize(gris,[240,320]);
 imshow(imagen)
% %Pasarla a Double
% imagenPro = double(imagen);

%Desprescieando el fondo blanco
[x y] = find(imagen<180);
x = x'; 
y = y';
c = 4;
% %
ejeX = 0:3:240;
ejeY = 0:3:320;
% %
alpha = 01;
beta = 0.1;
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

while (delta < 1) || (k < 4)
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
title('Algoritmo de montaña')
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
% Determinación de número de clusters

[y x] = find(imagen<180);
P = [x y];
datos = length(x);
no_clust = 4;
A = 4;
B = 2;
C = [EX; EY]'
U = inicial(no_clust,datos);
int = 0;

fig = [];
nf = 1;
li = 1;
for i=2:length(x)
    dif = x(i)-x(i-1);
    if dif > 3
        fig(nf,:) = [li,i-1];
        li = i;
        nf = nf + 1;
    end
end
fig(nf,:)= [li,length(x)];

% Se itera con base a un parámetro epsilon
epocas = 20;
for ciclo=1:3
    P = [x(fig(ciclo,1):fig(ciclo,2)) y(fig(ciclo,1):fig(ciclo,2))];
    datos = length(P);
    no_clust = 1;
    A = 1;
    B = 2;
    C = [EX(ciclo); EY(ciclo)]'
    U = inicial(no_clust,datos);
    int = 0;
while 1
    %============= Calculo de Distancias ==============
    int = int+1;
    D = [];
    Ji = 0;
    for i=1:no_clust
        for j=1:datos
            d = 0;
            for k=1:B
                d = d+(P(j,k)-C(i,k))^2;
            end
            D(i,j) = sqrt(d);
        end
        Ji = [Ji sum(D(i,:))]; %Suma las distancias de los datos a un clouster
    end
    D;
    %============= Calculo de la U ==============
    for i=1:A
        k = strfind(D(:,i)',min(D(:,i)));
        U(:,i) = 0;
        U(k,i) = 1;
    end
    %================= Calculo de J ==========
    J = sum(Ji); %suma todas las distancias hacia todos los clouster
    %============== Actualizacion de Clouster =====================
    for i=1:no_clust
        for j=1:B
            C(i,j) = sum(U(i,:).*P(:,j)')/sum(U(i,:));
        end
    end
    C;
    %pause();
    %=============================
    if int==epocas
        break;
    end
    
    
end
    CF(ciclo,:) = C;
end

C=CF;

figure()
imshow(imagen);
hold on
plot(C(:,1), C(:,2), '*r', 'LineWidth', 2);
title('Algoritmo de montaña con Kmeans.')
xlabel(' X')
ylabel(' Y')

%Finaliza K-means

% %
%Seleccionar un cluster

promt = 'Seleccione el cluster que quiere mostrar: ';
clus =  input(promt);

while 1
    promt = 'Seleccione el cluster que quiere mostrar: ';
    clus =  input(promt);
    figure()
    imshow(imagen);
    hold on
    plot(x(fig(clus,1):fig(clus,2)), y(fig(clus,1):fig(clus,2)),'*')
end





function U = inicial(Ncloster,Ndatos)

h=rand(Ncloster,Ndatos);

for i=1:Ndatos
    %k=max(h(:,i))
    k=strfind(h(:,i)',max(h(:,i)));
    h(:,i)=0;
    h(k,i)=1;
end
U = h;
end
