% % % Clusters difusos
% Puntos a clasificar
X = [1 4 4 5.5;
     1 1 2 1];
% Matriz inicial para 2 cluster
U = [0 0 1 1;
     1 1 0 0];
% Se plotean los datos 
plot(X(1,:), X(2,:), 'ro', 'Linewidth', 3)
axis([0 6 0 2]); grid on; hold on;
% pause;
% Determinación de número de clusters
[no_clust, datos] = size(X);
[filas_cumulos,  datos_cum] = size(U);
% Se itera con base a un parámetro epsilon
epocas = 10
for m = 1:epocas
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
    % Se actualiza U difuso
    for n = 1:filas_cumulos
%         U(n,:) = dist(n,:) == min(dist);
        U(n,:) = ((dist(n,1:end) ./ dist(1,1:end)).^2 + (dist(n,1:end) ./  dist(2, 1:end)).^2).^-1;
    end
    U
%     Se plotea el resultado
    r = plot(V(1,:), V(2,:), 'ob', 'LineWidth', 5); hold on
    V
%     pause(2);
    pause;
    if m ~= epocas 
        set(r, 'visible', 'off')
    end
%     U 
end