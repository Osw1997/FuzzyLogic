% % % % Caracterización de una variable difusa
% % % Peso de un niño para un columpio hecho para niños.

% % Peso normal 
% Intervalos
paso = 1;
a = 20;
b = 30;
c = 40;
fin_grafica = 60;
normal = zeros(1, fin_grafica * paso);
indx = 1;
for x = 0:paso:fin_grafica
    if x <= a ||  x > c
        normal(indx) = 0;
    elseif x > a && x <= b
        normal(indx) = (x - a) / (b - a);
    elseif x > b && x <= c
        normal(indx) = (c - x) / (c - b);
    end
    indx = indx + 1;
end
% % Peso Ligero
% Intervalos
b = 0;
c = 20;
d = 25;
ligero = zeros(1, fin_grafica * paso);
indx = 1;
for x = 0:paso:fin_grafica
    if x >= b && x <= c
        ligero(indx) = 1;
    elseif x > c && x <= d
        ligero(indx) = (d - x) / (d - c);
    else
        ligero(indx) = 0;
    end
    indx = indx + 1;
end
% % Peso Pesado
% Intervalos
a = 35;
b = 40;
c = fin_grafica;
pesado = zeros(1, fin_grafica * paso);
indx = 1;
for x = 0:paso:fin_grafica
    if x > a && x <= b
        pesado(indx) = (x - a) / (b - a);
    elseif x >= b && x <= c
        pesado(indx) = 1;
    else
        pesado(indx) = 0;
    end
    indx = indx + 1;
end
% Universo
x = 0:paso:fin_grafica;
% % Ploteo
plot(x, ligero, 'LineWidth', 2); hold on;
plot(x, normal, 'LineWidth', 2); hold on;
plot(x, pesado, 'LineWidth', 2); hold on;
axis([0 fin_grafica 0 1.1]);
legend('Ligero', 'Normal', 'Pesado');
title('Peso de un niño para un columpio hecho para niños');
xlabel('x'); ylabel('X(x)');
grid;
