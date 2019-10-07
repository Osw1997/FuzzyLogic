% % % Clusters n�tidos
% Puntos a clasificar
X = [1 4 4 5.5;
     1 1 2 1];
% Matriz inicial para 2 cluster
U = [0 0 1 1;
     1 1 0 0];
% Se plotean los datos 
plot(X(1,:), X(2,:), 'ro', 'Linewidth', 3)
axis([0 6 0 2]); grid on; hold on;
pause;
% Determinaci�n de n�mero de clusters
[no_clust, datos] = size(X);
[filas_cumulos,  datos_cum] = size(U);
% Se itera con base a un par�metro epsilon
for m = 1:2
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
    % Se actualiza U
    for n = 1:filas_cumulos
        U(n,:) = dist(n,:) == min(dist);
    end
%     Se plotea el resultado
    r = plot(V(1,:), V(2,:), 'ob', 'LineWidth', 5); hold on
    V
    pause(2);
    if m ~= 2
        set(r, 'visible', 'off')
    end
%     U 
end

