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
f12 = gbellmf(x,  [21.5 2.5 43]); % f12(end - 5: end) = 1;
fuzzy_ent1 = [f11; f12];
% plot(x,fuzzy_ent1)
% plot(x, fuzzy_ent1);
% xlabel('x'); ylabel('\mu(x)');
% title('Entrada 1'); axis([0 x(end) 0 1]);

% Entrada 2
f21 = gbellmf(y,  [27.5 2.5 0]);
f22 = gbellmf(y,  [27.5 2.5 55]); % f12(end - 10: end) = 1;
fuzzy_ent2 = [f21; f22];
% plot(y,fuzzy_ent2)
% figure;
% plot(y, fuzzy_ent2);
% xlabel('y'); ylabel('\mu(y)');
% title('Entrada 2'); axis([0 y(end) 0 1]);

% Salida
a1 = 10; b1 = 2.5; c1 = -10;
fz1 = gbellmf(z, [a1 b1 c1]);
a2 = 10; b2 = 2.5; c2 = 10;
fz2 = gbellmf(z, [a2 b2 c2]);
fuzzy_sal = [fz1; fz2];
plot(z, fuzzy_sal);
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
        W1 = reglas(R_C1);
        % Vector de índices asociados a C2
        R_C2 = [2]; 
        W2 = reglas(R_C2);
        
%         Valor del conjunto universo asociado a W1
%         posiciones = fz1 == W1(:);
%         posiciones = round(fz1, 5) == round(W1(:), 5);
        Z1 = zeros(1,length(W1));
%         Z1 = c1 + a1 * ((1 - R_C1(:)) / R_C1(:)) ^ (1 / (2 * b1));
        for n = 1:length(W1)
%             Z1(n) = z(posiciones(n,:));
            Z1(n) = c1 + a1 * ((1 - W1(n)) / W1(n))^(1 / (2 * b1));
        end
%         Valor del conjunto universo asociado a W2
%         posiciones = fz2 == W2(:);
%         posiciones = round(fz2, 5) == round(W2(:), 5);
        Z2 = zeros(1,length(W1));
        for n = 1:length(W2)
%             Z2(n) = z(posiciones(n,:));
            Z2(n) = c2 + a2 * ((1 - W2(n)) / W2(n))^(1 / (2 * b2));
        end

        Z0 = (sum(Z1 .* W1) + sum(Z2 .* W2)) / sum([W1 W2]);
        XY(xe, ye) = Z0;
    end     
end
[X,Y] = meshgrid(y,x);
figure;
plot3(X,Y,XY);
xlabel('x'); ylabel('y'); zlabel('\mu(x,y)');
title('Salida'); axis([y(1) y(end) x(1) x(end) -15 15]);
grid on;