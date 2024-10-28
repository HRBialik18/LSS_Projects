set(groot, 'defaultAxesFontName','Helvetica');
set(groot, 'defaultAxesFontSize',16);
set(groot, 'defaultAxesYLimitMethod','padded');
set(groot, 'defaultAxesTitleFontSizeMultiplier', 1.2);
set(groot, 'defaultLineLineWidth', 2);
set(groot, 'defaultStemLineWidth', 2);
set(groot, 'defaultStemMarkerSize', 8);

%a
t = linspace(0, 0.001, 1000);  % 1000 points between 0 and 1 ms

% Define unit step function
u = @(t) double(t >= 0);

sig = @(t) 100 * cos(10000 * pi * t) .* (u(t) - u(t - 1));
s = sig(t);

% Plot the signal
figure;
plot(t * 1000, s);  % Convert time to ms for the x-axis
xlabel('Time (ms)');
ylabel('Amplitude');
title('Signal s(t) = 100cos(10000\pi t)(u(t) - u(t - 1))');
grid on;

%c
B = 200;
L =100;
A = 0.025;
c = 343;
tau1 = (sqrt((B^2)+(L-A)^2))/c;
tau2 = (sqrt((B^2)+(L-2*A)^2))/c;
tauMin = min(tau1, tau2);
tauMax = max(tau1, tau2);

y1 = @(t) sig(t-tau1);
y2 = @(t) sig(t-tau2);

fsim = 1e6;
t = tauMin-(0.5e-3):(1/fsim):tauMax+(0.5e-3);
figure;
subplot(2, 1, 1); 
plot(t, y1(t));
grid on;
title('Signal from Microphone 1: s(t-tau1)');
xlabel('Time (s)'); ylabel('Amplitude');
xlim([tauMin-(0.5e-3), tauMax+(0.5e-3)]);

subplot(2, 1, 2);
plot(t, y2(t));
title('Signal from Microphone 2: s(t-tau2)');
grid on;
xlabel('Time (s)'); ylabel('Amplitude');
xlim([tauMin-(0.5e-3), tauMax+(0.5e-3)]);

%e test
% [y1sig, y2sig] = lab1sim(A, B, L, sig);
% tauMin = min(tau1, tau2);
% tauMax = max(tau1, tau2);

% t = tauMin-(0.5e-3):(1/fsim):tauMax+(0.5e-3);
% figure;
% subplot(2, 1, 1); 
% plot(t, y1sig(t));
% title('s(t-tau1)');
% xlabel('time (s)'); ylabel('amplitude');

% subplot(2, 1, 2);
% plot(t, y2sig(t));
% title('s(t-tau2)');
% xlabel('time (s)'); ylabel('amplitude');

%lab1est test
% [theta_est, L_est] = lab1est(A, B, y1(t), y2(t))