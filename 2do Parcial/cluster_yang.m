% % % Clusters difusos
% Puntos a clasificar
X = [1 4 4 5.5;
     1 1 2 1];
% Matriz inicial para 2 cluster
U = [0 1 0 1;
     1 0 1 0];
% Se plotean los datos 
plot(X(1,:), X(2,:), 'ro', 'Linewidth', 3)
axis([0 6 0 2]); grid on; hold on;
pause;
% Determinación de número de clusters
[no_clust, datos] = size(X);
[filas_cumulos,  datos_cum] = size(U);
% OTro parámtero de detención (ejemplo)
cont = 0;
% % Parámetros de parada
% Valor de detención
J_parada = 2.4;
% Valor actual de la iteración actual
J = Inf;
V = [randperm(4,2); randperm(4,2)];
% % Se itera con base a un parámetro epsilon
while (J_parada < J)
%     Se plotea el resultado
    r = plot(V(1,:), V(2,:), 'ob', 'LineWidth', 5); hold on
    % Centroides
    V = zeros(no_clust, filas_cumulos);
    for n = 1:no_clust
        V(n,:) = calc_centroide(X, U(n,:));
    end 
    V = V';
    % Distancias entre centroides a datos
    dist = zeros(filas_cumulos, datos_cum);
    for n = 1:filas_cumulos
        dist(n,:) = sqrt(sum((X - repmat(V(:,n),1,datos_cum)).^2));
    end
    dist
%     Función de costo
    J = sum(sum((dist .* U)'))
    % Se actualiza U
    for n = 1:filas_cumulos
        U(n,:) = dist(n,:) == min(dist); 
    end
%     Se plotea el resultado
%     r = plot(V(1,:), V(2,:), 'ob', 'LineWidth', 5); hold on
    V
    pause(2);
    if J_parada < J
        set(r, 'visible', 'off')
    end
    if cont > 2
        break;
    end
    cont = cont + 1;
%     U 
end

