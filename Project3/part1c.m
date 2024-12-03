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



fh = 1e7;
fc = 1310*1000;
Gc = 10;

st = upconvert(m, Gc, fs, fc, fh);

w = rand(1, length(st));
y1 = st + sqrt(0.01)*w; %chana good that I square-rooted the varriance?
y2 = st + sqrt(0.1)*w;
y3 = st + sqrt(1)*w;

t = (0:length(st)-1) / fh;

figure;
plot(t, y1);
xlabel('Time (s)');
ylabel('y(t)');
title('y(t) vs Time, Noise Variance: 0.01');
grid on;

figure;
plot(t, y2);
xlabel('Time (s)');
ylabel('y(t)');
title('y(t) vs Time, Noise Variance: 0.1');
grid on;

figure;
plot(t, y3);
xlabel('Time (s)');
ylabel('y(t)');
title('y(t) vs Time, Noise Variance: 1');
grid on;