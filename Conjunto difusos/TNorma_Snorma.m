% % % Ejecicio 4
% % T - Norma , S - Norma
% Conjutnos
uT = [0 0.3 0.7 0.8 0.9 1];
uS = [0 0.2 0.4 0.6 0.8 1];

% T_min
Tmin = min([uT; uS]);
% T_ap
Tap = uT .* uS;
% T_bp
T_bp = max([zeros(1, length(uT)); uT + uS - ones(1, length(uT))])
% T_dp
    