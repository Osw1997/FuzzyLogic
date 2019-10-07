function v = calc_centroide(x, u)
    [fila, col] = size(x);
    v = zeros(1, fila);
    sum_u = sum(u);
    for n = 1:fila
        v(n) = sum(x(n,:) .* u) / sum_u;
    end
    v = v';
end