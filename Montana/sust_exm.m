close all; clear all; clc;
% % Adquisición de datos
dat = fopen('IrisDataBase.dat');
IrisDataBase = textscan(dat, '%f %f %f %f %s');
fclose(dat);
Datos(:,1)=IrisDataBase{2};
Datos(:,2)=IrisDataBase{3};
Datos(:,3)=IrisDataBase{4};
DatosS=Datos(1:50,:);%Datos Iris-setosa
DatosVS=Datos(51:100,:); %Datos Iris-versicolour
DatosV=Datos(101:150,:);%Datos Iris-virginica
% figure(2)
hold on;
% plot3(DatosS(:,1),DatosS(:,2),DatosS(:,3),'*r')
% plot3(DatosVS(:,1),DatosVS(:,2),DatosVS(:,3),'*g')
% plot3(DatosV(:,1),DatosV(:,2),DatosV(:,3),'*b')
% grid on;
% % Se definen los parametros iniciales.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% m -> puede tener valores de 1 o 2 comunmente.
m =2;
% c -> numero de cluster.
c = 1;
% ej -> Umbral de paro del algoritmo
ej = 0.0001;
% Se define los tres vectores.
% x = [];
% y = [];
% z = [];
% posicion = 1;
% for a = 1:length(DatosS(:,1)')/3
%      aux2 = round(rand(1)*2);
%  if aux2 == 2
%  x = [x DatosS(posicion,1) DatosVS(posicion+1,1) DatosV(posicion+2,1)];
%  y = [y DatosS(posicion,2) DatosVS(posicion+1,2) DatosV(posicion+2,2)];
%  z = [z DatosS(posicion,3) DatosVS(posicion+1,3) DatosV(posicion+2,3)];
%  elseif aux2 == 1
%  x = [x DatosS(posicion+2,1) DatosVS(posicion,1) DatosV(posicion+1,1)];
%  y = [y DatosS(posicion+2,2) DatosVS(posicion,2) DatosV(posicion+1,2)];
%  z = [z DatosS(posicion+1,3) DatosVS(posicion,3) DatosV(posicion+1,3)];
%  else
%  x = [x DatosS(posicion+1,1) DatosVS(posicion,1) DatosV(posicion,1)];
%  y = [y DatosS(posicion+1,2) DatosVS(posicion,2) DatosV(posicion,2)];
%  z = [z DatosS(posicion+1,3) DatosVS(posicion,3) DatosV(posicion,3)];
%  end
%  posicion = posicion+3;
% end
% 
% 
% for a = posicion:length(DatosS(:,1)')
%  x = [x DatosS(a,1)];
%  y = [y DatosS(a,2)];
%  z = [z DatosS(a,3)];
% end
x = [1 4 4 5.5];
y = [1 1 2 1];
plot(x,y,'or');
% Se defini el numero de puntos
p = length(x);
% % algortitmo *************************************************************
% % variables del algoritmo************************************************
ra = 0.9;
rb = ra*1.9;
k = 1;
E = 10;
alpha = 4/(ra^2);
beta = 4/(rb^2);
D = zeros(length(x),1);
repetir = 0;
% % Ecuacion 1 *************************************************************
for i = 1:length(x)
 for j = 1:length(x)
 D(i) = D(i) + exp(-alpha*( ( x(i)-x(j) )^2 + ( y(i)-y(j) )^2 ));
 end
end
% % Obtener X_i* y Pi* *************************************************
Pi(k) = max(D(:,k));
for i = 1:length(x)
 if Pi(k) == D(i,k)
 Xi(k) = i;
  end
end
while (1)
 if repetir == 0
 % % Aplicacion de la ecuacion 3 ****************************************
 D = [D zeros(length(x),1)];
 for i = 1:length(x)
    D(i,k+1) = D(i,k) - Pi(k)*(exp(-beta*( ( x(i)-x(Xi(k)) )^2 + ( y(i)-y(Xi(k)) )^2 )));
 end
 % % Obtener X_i* y Pi* *************************************************
 k = k + 1;
 repetir = 0;
 end
 Pi(k) = max(D(:,k));
 for i = 1:length(x)
 if Pi(k) == D(i,k)
 Xi(k) = i;
 end
 end
 % % Verificar estado ***************************************************
 if Pi(k) < E*Pi(1)
 break;
 else
 % Obtener el d_min ************************************************
 aux = zeros(1,k-1);
 for i = 1:k-1
 aux(i) = sqrt( ( x(Xi(k))-x(Xi(i)) )^2 + ( y(Xi(k))-y(Xi(i)) )^2 );
 end
 d_min = min(aux);
 if (d_min/ra + Pi(k)/Pi(1)) >= 1
 Xi(k);
 else
 D(Xi(k),k) = 0;
 end
 end
end
% % Graficacion de los puntos **********************************************
centroX = zeros(1,length(Xi));
centroY = zeros(1,length(Xi));
centroZ = zeros(1,length(Xi));
for i = 1:length(Xi)
 centroX(i) = x(Xi(i));
 centroY(i) = y(Xi(i));
%  centroZ(i) = z(Xi(i));
end
plot(centroX,centroY,'+k','linewidth',2)
title('Algoritmo: sustractivo.')
xlabel(' X')
ylabel(' Y')
grid on;
% zlabel(' Z')