% % Práctica 1 - Superficie
% % % % Práctica 1
% clc
% % Paso
dx = 01;
% % Contjuntos universos
x = 0:dx:43;
y = 0:dx:55;
z = -10:dx:10;
% % Conjuntos difusos
% Entrada 1
f11 = gbellmf(x,  [21.5 2.5 0]);
f12 = gbellmf(x,  [21.5 2.5 43]); f12(end - 5: end) = 1;
fuzzy_ent1 = [f11; f12];
% plot(x, fuzzy_ent1);
% xlabel('x'); ylabel('\mu(x)');
% title('Entrada 1'); axis([0 x(end) 0 1]);

% Entrada 2
f21 = gbellmf(y,  [27.5 2.5 0]);
f22 = gbellmf(y,  [27.5 2.5 55]); f12(end - 10: end) = 1;
fuzzy_ent2 = [f21; f22];
% figure;
% plot(y, fuzzy_ent2);
% xlabel('y'); ylabel('\mu(y)');
% title('Entrada 2'); axis([0 y(end) 0 1]);

% Salida
fz1 = gbellmf(z, [10 2.5 -10]);
fz2 = gbellmf(z, [10 2.5 10]);
fuzzy_sal = [fz1; fz2];
% figure;
% plot(z, fuzzy_sal);
% xlabel('z'); ylabel('\mu(z)');
% title('Salida'); axis([z(1) z(end) 0 1]);

% Matriz XY que tendrá correspondencia a Z por cada punto
size_x = length(x); size_y = length(y);
XY = zeros(size_x, size_y);
for xe = 1:size_x
    for ye = 1:size_y
        % Valor fijo dado por los FORs
        % Obteniendo valores asociados al vector univeso de cada entrada
%         uni_x = find(x == xe);
        uni_x = xe;
%         uni_y = find(y == ye); 
        uni_y = ye;
        % Extrayendo el grado de pertenencia asociado a dichos valores
        pert_x = [fuzzy_ent1(1, uni_x); fuzzy_ent1(2, uni_x)];
        pert_y = [fuzzy_ent2(1, uni_y); fuzzy_ent2(2, uni_y)];
        % Reglas de inferencia
        % pert_x = [0.8 0.001]'; % pert_x = [1 3]';
        % pert_y = [0.1 0.3]'; % pert_y = [2 4]';
        reglas = min(combvec(pert_y', pert_x'));
        % % Cortes en C1
        % Vector de índices asociados a C1
        R_C1 = [1, 3, 4]; 
        C_C1 = max(reglas(R_C1));
        % Vector de índices asociados a C1
        R_C2 = [2]; 
        C_C2 = max(reglas(R_C2));

        % % Obteniendo cortes de cada variable difusa de salida
        % Corte para C1
        temp_fz1 = fz1;
        temp_fz1(temp_fz1 > C_C1) = C_C1;
        % Corte para C2
        temp_fz2 = fz2;
        temp_fz2(temp_fz2 > C_C2) = C_C2;

        % Curva final 
        curva = max([temp_fz1; temp_fz2]);
        % Centro de gravedad 
        CG = sum(z .* curva) / sum(curva);
        XY(xe, ye) = CG;
    end     
end
[X,Y] = meshgrid(y,x);
figure;
plot3(X,Y,XY);
xlabel('x'); ylabel('y'); zlabel('\mu(x,y)');
title('Salida'); axis([y(1) y(end) x(1) x(end) -6 6]);
grid on;