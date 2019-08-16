% % Ejercicio 2
% Limpia memoria, consola y pantalla
% clc; clear; close all;
% Conjuntos difusos a usar
uT = [0 0.3 0.7 0.8 0.9 1];
uS = [0 0.2 0.4 0.6 0.8 1];
% Conjunto universo
x = 0:length(uT) - 1;
% Operador OR difuso
uT_or_uS =  max([uT; uS]);
% Operador AND difuso
uT_and_uS =  min([uT; uS]);
% Complemento difuso X'(x) = 1 - X(x)
uT_= (ones(length(uT),1) - uT')';
uS_= (ones(length(uS),1) - uS')';
% Ley de morgan: ~(uT AND uS) = max[~uT, ~uS]
ley_morgan = max([uT_; uS_]);
% % Ploteando resultados
% Conjunto uT
subplot(2,2,1);
plot(x, uT, 'or', 'LineWidth', 2);
title('Conjunto difuso \muT');
xlabel('x'); ylabel('X(x)'); grid;
% Conjunto uS
subplot(2,2,2);
plot(x, uS, '*b', 'LineWidth', 2);
title('Conjunto difuso \muS');
xlabel('x'); ylabel('X(x)'); grid;
% Conjunto uT OR uS
subplot(2,2,3);
plot(x, uT_or_uS, 'ob', 'LineWidth', 2);
title('Conjunto difuso \muT OR \muS');
xlabel('x'); ylabel('X(x)'); grid;
% Conjunto uT AND uS
subplot(2,2,4);
plot(x, uT_and_uS, '*r', 'LineWidth', 2);
title('Conjunto difuso \muT AND \muS');
xlabel('x'); ylabel('X(x)'); grid;

% % Segundo ploteo
figure;
% Conjunto uT
subplot(2,2,1);
plot(x, uT_, 'or', 'LineWidth', 2);
title('Conjunto difuso ~\muT');
xlabel('x'); ylabel('X(x)'); grid;
% Conjunto uS
subplot(2,2,2);
plot(x, uS_, '*b', 'LineWidth', 2);
title('Conjunto difuso ~\muS');
xlabel('x'); ylabel('X(x)'); grid;
% Conjunto uT OR uS
subplot(2,2,[3, 4]);
plot(x, ley_morgan, 'ob', 'LineWidth', 2);
title('Ley de Morgan ~\muT OR ~\muS');
xlabel('x'); ylabel('X(x)'); grid;