
fsim = 1e6;
noise1 = sqrt(1)*randn(1, 5*fsim);  % sigma^2 = 1
noise2 = sqrt(100)*randn(1, 5);  % sigma^2 = 100

A = 0.025;
B = 200;
L = 150;
sig = @(t) 100 * cos(10000 * pi * t) .* (u(t) - u(t - 1));

[y1sig, y2sig] = lab1sim(A, B, L, sig);

z1 = @(t) y1sig + noise1;
z2 = @(t) y2sig + noise2;



