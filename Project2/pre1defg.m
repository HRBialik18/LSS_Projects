%partD
% Define poles and zeros
c1 = 2;
c2 = 5/4;
poles = [c2 + 0i, 0 + 0i];
zeros = [-1/c1 + 0i];

% Plot poles and zeros
figure;
plot(real(poles), imag(poles), 'x', 'MarkerSize', 10, 'LineWidth', 2); % Poles
hold on;
plot(real(zeros), imag(zeros), 'o', 'MarkerSize', 10, 'LineWidth', 2); % Zeros

% Add the unit circle
theta = linspace(0, 2*pi, 100);
x_unit = cos(theta);
y_unit = sin(theta);
plot(x_unit, y_unit, 'r--'); % Dashed red unit circle

% Show the ROC as the region outside the pole at |5/4|
r_outer = abs(c2); % Radius of the pole defining the ROC boundary
theta_fill = linspace(0, 2*pi, 100);

% Create a large circular region that fills most of the visible area
r_max = 6; % Define an outer limit for the visible region
x_fill_outer = r_max * cos(theta_fill); %chana should the zp include ROC?
y_fill_outer = r_max * sin(theta_fill);

% Define the inner boundary of the ROC at |5/4|
x_fill_inner = r_outer * cos(theta_fill);
y_fill_inner = r_outer * sin(theta_fill);

% Fill the ROC as the area outside the pole's radius
fill([x_fill_outer, fliplr(x_fill_inner)], [y_fill_outer, fliplr(y_fill_inner)], ...
    [0.8 0.8 1], 'FaceAlpha', 0.2, 'EdgeColor', 'none');

% Formatting the plot
axis equal;
xlabel('Real Part');
ylabel('Imaginary Part');
xlim([-3,3]);
ylim([-3,3]);
title('Pole-Zero Diagram with ROC');
legend('Poles', 'Zeros', 'Unit Circle', 'ROC');
grid on;
hold off;

%partE
transfer_funct = filt([0,c1,1], [1,-c2,0]);
figure;
pzplot(transfer_funct); %chana should the zp include ROC?
axis equal;
a = findobj(gca,'type','line');
for i = 1:length(a)
set(a(i),'markersize',12); % change marker size
set(a(i), 'linewidth',2) % change linewidth
end

%partF
c1 = 1;
c2 = 0.9;

transfer_funct = filt([0,c1,1], [1,-c2,0]);
figure;
pzplot(transfer_funct);
axis equal;
a = findobj(gca,'type','line');
for i = 1:length(a)
set(a(i),'markersize',12); % change marker size
set(a(i), 'linewidth',2) % change linewidth
end

n = 128; % Number of frequency points
omega = linspace(-pi, pi, n); % Frequency range from -pi to pi
[h, w] = freqz([0,c1,1], [1,-c2,0], omega); % Compute frequency response

% Plot the Frequency Response |H(e^{jω})|
figure;
plot(w, abs(h));
title('Magnitude of Frequency Response |H(e^{jω})|');
xlabel('Frequency (rad/sample)');
ylabel('|H(e^{jω})|');
grid on;

%partG
largestMag = max(abs(h));
display(["Max mag: ", largestMag]);

closestTo1 = [inf,inf];
for i = 1:n
    if abs(abs(h(i)) - 1) < closestTo1(1)
        closestTo1 = [abs(abs(h(i)) - 1), w(i)];
    end
end
display(["Freq when mag closest to 1: ", closestTo1(2)]);