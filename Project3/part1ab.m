set(groot, 'defaultAxesFontName','Helvetica');
set(groot, 'defaultAxesFontSize',16);
set(groot, 'defaultAxesYLimitMethod','padded');
set(groot, 'defaultAxesTitleFontSizeMultiplier', 1.2);
set(groot, 'defaultLineLineWidth', 2);
set(groot, 'defaultStemLineWidth', 2);
set(groot, 'defaultStemMarkerSize', 8);

[audioData, fs] = audioread('oddity.wav');

m = audioData(:, 1);
m = m.'; %chana should I need to do this?

disp(["f_s", num2str(fs)]);

t = (0:length(m)-1) / fs;
figure;
plot(t, m);
xlabel('Time (s)');
ylabel('m(t)');
title('m(t) vs Time');
grid on;

% soundsc(m, fs);
energy1 = sum((abs(m)).^2);

disp(["energy of m(t)", num2str(energy1)]);


fh = 1e7;
fc = 1310*1000;
Gc = 10;
MessageSignalRF = resample(m, fh, fs);
t = 0:1/fh:(1/fh)*(length(MessageSignalRF)-1); %chana two of the same thing
% t = (0:length(MessageSignalRF)-1) / fh;
c = Gc * cos(2 * pi * fc * t);
st = c.* MessageSignalRF;

figure;
plot(t, MessageSignalRF);
xlabel('Time (s)');
ylabel('Upsampled m(t)');
title('Upsampled m(t) vs Time');
grid on;
energy2 = sum((abs(MessageSignalRF)).^2);
disp(["energy of Upsampled m(t)", num2str(energy2)]);

figure;
plot(t, st);
xlabel('Time (s)');
ylabel('s(t)');
title('s(t) vs Time');
grid on;
energy3 = sum((abs(st)).^2);
disp(["energy of s(t)", num2str(energy3)]);

% st = upconvert(m, Gc, fs, fc, fh);