clc; close all; clear all;
% % Posición del generador
% Conjunto universo
x = 0:0.1:360;
% Conjuntos difusos
NEg = trapmf(x, [-90 -22.5 22.5 90]);
Eg = trapmf(x, [0 67.5 112.5 180]);
Sg = trapmf(x, [90 157.5 202.5 270]);
Og = trapmf(x, [180 247.5 292.5 360]);
NOg = trapmf(x, [270 337.5 382.5 450]);
pos_gen = [NEg; Eg; Sg; Og; NOg];
% Figura 1
figure;
subplot(2,1,1);
title('Posision Generador')
ylabel('Grado de pertenecia'); xlabel('Grados');
hold on; 
plot(x, pos_gen, 'LineWidth', 3); 
grid; axis([x(1) x(end) 0 1]);
% % Posición de la veleta
% Conjunto universo
x = 0:0.1:360;
% Conjuntos Difusos
NEv = trapmf(x, [-90 -22.5 22.5 90]);
Ev = trapmf(x, [0 67.5 112.5 180]);
Sv = trapmf(x, [90 157.5 202.5 270]);
Ov = trapmf(x, [180 247.5 292.5 360]);
NOv = trapmf(x, [270 337.5 382.5 450]);
pos_vel = [NEv; Ev; Sv; Ov; NOv];
% Figura 2
% figure;
subplot(2,1,2);
title('Posision Veleta')
ylabel('Grado de pertenencia'); xlabel('Grados');
hold on;
plot(x, pos_vel, 'LineWidth', 3);
grid; axis([x(1) x(end) 0 1]);
% % Velocidad del viento
% Conjunto universo
x = 0:0.1:100;
% Conjuntos difusos
Lenta = trapmf(x, [-45 -5 5 45]);
Media = trapmf(x, [5 45 55 95]);
Rapida = trapmf(x, [55 95 105 145]);
fuzzy_set = [Lenta; Media; Rapida];
% Figura 3
figure;
subplot(2,1,1);
title('Velocidad');
ylabel('Grado de pertenencia'); xlabel('RPM');
hold on;
plot(x, fuzzy_set, 'LineWidth', 3);
grid; axis([x(1) x(end) 0 1]);
% % Direccion del generador
% Conjunto universo
x = 0:0.01:3;
% Conjuntos difusos
Antihorario = trapmf(x, [-1.35 -0.15 1 2]);
NoMover = trapmf(x, [1 1.35 1.65 2]);
Horario = trapmf(x, [1 2 3.15 4.35]);
movimiento = [Antihorario; NoMover; Horario];
% Figura 4
% figure;
subplot(2,1,2);
title('Dirección')
ylabel('Grado de pertenencia'); xlabel('Direccion');
hold on;
plot(x, movimiento, 'LineWidth', 3);
grid; axis([x(1) x(end) 0 1]);