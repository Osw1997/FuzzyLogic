% % Ejercicio 3
inicio = 0;
fin = 10;
dx = 0.1; 
x = inicio:dx:fin;
% 1era función de membresía
uA = x ./ (x + 2);
% Normalizando la función
uA = uA / max(uA);
% plot(x, uA);

% 2da función de membresía
uB = 2 .^ - x;
% Normalizando la función
uB = uB / max(uB);
% plot(x, uB);

% 3ra función de membresía
uC = 1  ./ (1 + 10 * (x - 2) .^ 2);
% Normalizando la función
uC = uC / max(uC);
% plot(x, uC);

% % 1)
uA_ = (ones(length(uA), 1) - uA')';
uB_ = (ones(length(uB), 1) - uB')';
uC_ = (ones(length(uC), 1) - uC')';

subplot(3,1,1);
plot(x, uA_, 'LineWidth', 2); hold on;
plot(x, uA, 'LineWidth', 2); 
legend('~\muA', '\muA');
title('~\muA vs \muA');
xlabel('x'); ylabel('X(x)'); grid;
% 
subplot(3,1,2);
plot(x, uB_, 'LineWidth', 2); hold on;
plot(x, uB, 'LineWidth', 2);
legend('~\muB', '\muB');
title('~\muB vs \muB');
xlabel('x'); ylabel('X(x)'); grid;
% 
subplot(3,1,3);
plot(x, uC_, 'LineWidth', 2); hold on;
plot(x, uC, 'LineWidth', 2);
legend('~\muC', '\muC');
title('~\muC vs \muC');
xlabel('x'); ylabel('X(x)'); grid;

% % 2)
AuB = max([uA; uB]);
AuC = max([uA; uC]);
BuC = max([uB; uC]);
figure;
% 
subplot(3,1,1);
plot(x, AuB, 'g', 'LineWidth', 5); hold on;
plot(x, uA, 'b', 'LineWidth', 0.1); hold on;
plot(x, uB, 'm', 'LineWidth', 0.1); hold on;
legend('AuB', '\muA', '\muB');
title('A u B');
xlabel('x'); ylabel('X(x)'); grid;
axis([0 fin 0 1]);
% 
subplot(3,1,2);
plot(x, AuC, 'g', 'LineWidth', 2); hold on;
plot(x, uA, 'b', 'LineWidth', 0.1); hold on;
plot(x, uC, 'm', 'LineWidth', 0.1); hold on;
legend('AuC', '\muA', '\muC');
title('A u C');
xlabel('x'); ylabel('X(x)'); grid;
axis([0 fin 0 1]);
% 
subplot(3,1,3);
plot(x, BuC, 'g', 'LineWidth', 2); hold on;
plot(x, uB, 'b', 'LineWidth', 0.1); hold on;
plot(x, uC, 'm', 'LineWidth', 0.1); hold on;
legend('AuC', '\muB', '\muC');
title('B u C');
xlabel('x'); ylabel('X(x)'); grid;
axis([0 fin 0 1]);

% % 3)
AnB = min([uA; uB]);
AnC = min([uA; uC]);
BnC = min([uB; uC]);
figure;
% 
subplot(3,1,1);
plot(x, AnB, 'g', 'LineWidth', 5); hold on;
plot(x, uA, 'b', 'LineWidth', 0.1); hold on;
plot(x, uB, 'm', 'LineWidth', 0.1); hold on;
legend('AnB', '\muA', '\muB');
title('A n B');
xlabel('x'); ylabel('X(x)'); grid;
axis([0 fin 0 1]);
% 
subplot(3,1,2);
plot(x, AnC, 'g', 'LineWidth', 2); hold on;
plot(x, uA, 'b', 'LineWidth', 0.1); hold on;
plot(x, uC, 'm', 'LineWidth', 0.1); hold on;
legend('AnC', '\muA', '\muC');
title('A n C');
xlabel('x'); ylabel('X(x)'); grid;
axis([0 fin 0 1]);
% 
subplot(3,1,3);
plot(x, BnC, 'g', 'LineWidth', 2); hold on;
plot(x, uB, 'b', 'LineWidth', 0.1); hold on;
plot(x, uC, 'm', 'LineWidth', 0.1); hold on;
legend('AnC', '\muB', '\muC');
title('B n C');
xlabel('x'); ylabel('X(x)'); grid;
axis([0 fin 0 1]);

% % 4)
AnC_ = max([uA_; uC_]);
BnC_ = max([uB_; uC_]);
AuC_ = min([uA_; uC_]);
figure;
% 
subplot(3,1,1);
plot(x, AnC_, 'g', 'LineWidth', 5); hold on;
plot(x, AnC, 'b', 'LineWidth', 0.1); hold on;
legend('~(AnC)', '\muA n \muC');
title('~(A n B)');
xlabel('x'); ylabel('X(x)'); grid;
axis([0 fin 0 1]);
% 
subplot(3,1,2);
plot(x, BnC_, 'g', 'LineWidth', 2); hold on;
plot(x, BnC, 'b', 'LineWidth', 0.1); hold on;
legend('~(BnC)', '\muB n \muC');
title('~(B n C)');
xlabel('x'); ylabel('X(x)'); grid;
axis([0 fin 0 1]);
% 
subplot(3,1,3);
plot(x, AuC_, 'g', 'LineWidth', 2); hold on;
plot(x, AuC, 'b', 'LineWidth', 0.1); hold on;
legend('~(AuC)', '\muA u \muC');
title('~(A u C)');
xlabel('x'); ylabel('X(x)'); grid;
axis([0 fin 0 1]);

