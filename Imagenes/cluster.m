% % % Clusters nítidos
% Puntos a clasificar
X = [1 4 4 5.5;
     1 1 2 1];
% Matriz inicial para 2 cluster
U = [0 0 1 1;
     1 1 0 0];
% Determinación de número de clustes
[no_clust, datos] = size(X);
% Centroides
V = zeros(no_clust, datos);
for m = 1:no_clust
    V(m,:) = calc_centroide(X, U(m,:));
end



function v = calc_centroide(x, u)
    [fila, col] = size(x);
    v = zeros(1, fila);
    sum_u = sum(u);
    for n = 1:fila
        v(n) = sum(x(fila) .* u) / sum_u;
    end
end