% % Método de la montaña
% Puntos a analizar
puntos = [0.36 0.65 0.62 0.50 0.35 0.90 1.0 0.99 0.83 0.88;
          0.85 0.89 0.55 0.75 1.00 0.35 0.24 0.55 0.36 0.43];
      
size_puntos = length(puntos);
plot(puntos(1,:), puntos(2,:), 'or');
% axis([min(puntos(1,:)) max(puntos(1,:)) min(puntos(2,:)) max(puntos(2,:))]); 
% Cuadrícula
paso = 1 / 5;
cuadricula = 0:paso:1;
p_cluster = repmat(cuadricula, length(cuadricula), 1);
% Centros de cada cluster
centroide = paso / 2;
multi = 1:length(cuadricula);
centros =  centroide:paso:1-centroide;
centros_c = repmat(centros, length(cuadricula) - 1, 1);
% Ploteo
hold on;
plot(cuadricula, p_cluster, 'k', 'LineWidth', 2);
plot(p_cluster, cuadricula, 'k', 'LineWidth', 2);
plot(centros, centros_c, '*g', 'LineWidth', 2);
grid on;
size_cuadricula = length(cuadricula);
size_centros = length(centros);



centro_vec = zeros(2, size_centros * size_centros);
size_vect = length(centro_vec);
counter = 1;
for m = 1:size_centros
    for n = 1:size_centros
        centro_vec(:,counter) = [centros(m), centros(n)];
        counter = counter + 1;
    end
end
% plot(centro_vec(1,:), centro_vec(2,:), 'r*')


mat_dist = zeros(size_cuadricula, size_centros);
for m = 1:size_vect
    for n = 1:size_puntos
        mat_dist(m,n) = sqrt((centro_vec(1, m) - puntos(1, n))^2 + (centro_vec(2, m) - puntos(2, n))^2);
    end
end
% Alfa
a = -15;
[i, k] = size(mat_dist)
a_mat = zeros(i, k);
a_mat(a_mat == 0) = a;

arg_exp = a_mat .* mat_dist;

M_Ni = zeros(1, i);
for n = 1:i
    M_Ni(n) = sum(exp(arg_exp(n,:)));
end

M_Ni = reshape(M_Ni, size(centros_c))

surf(M_Ni, centros_c)
% Máximo matriz
val_max = max(M_Ni(:));
[f,c] = find(M_Ni == val_max);

% % Entra al While
while (1)
    nueva_montana = M_Ni - val_max * 
end


