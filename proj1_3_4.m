set(groot, 'defaultAxesFontName','Helvetica');
set(groot, 'defaultAxesFontSize',16);
set(groot, 'defaultAxesYLimitMethod','padded');
set(groot, 'defaultAxesTitleFontSizeMultiplier', 1.2);
set(groot, 'defaultLineLineWidth', 2);
set(groot, 'defaultStemLineWidth', 2);
set(groot, 'defaultStemMarkerSize', 8);

fsim = 1e5;
t = 0:1/fsim:2;
noise1_var1 = sqrt(1)*randn(1, length(t));  % sigma^2 = 1
noise2_var1 = sqrt(1)*randn(1, length(t));  % sigma^2 = 1
noise1_var100 = sqrt(150)*randn(1, length(t));  % sigma^2 = 150
noise2_var100 = sqrt(150)*randn(1, length(t));  % sigma^2 = 150

A = 2.5;
B = 200;
L = 120;

u = @(t) double(t >= 0);
sig = @(t) 100 * cos(10000 * pi * t) .* (u(t) - u(t - 1));

[y1sig, y2sig] = lab1sim(A, B, L, sig); %gets the two responses - y1 and y2

% z1a = y1sig(t) + noise1_var1; %adds noise
% z2a = y2sig(t) + noise2_var1;
% 
% %call lab1est which outputs estimated angle and L
% [~, lHat1] = lab1est(A, B, z1a, z2a);
% fprintf('%.10f\n', lHat1);
% display(["True_L: ", L, "Est_L: " lHat1, "difference: ", abs(L-lHat1) "variance: ", 1]); %every time i run i get the same thing:(
% 
% z1b = y1sig(t) + noise1_var100; %do it for the other varriance
% z2b = y2sig(t) + noise2_var100;
% % figure;
% % plot(t, z1b, 'b');
% % hold on;
% % % plot(t, noise1_var1, 'green');
% % plot(t, z1a, 'r');
% % hold off;
% 
% % 
% %call lab1est which outputs estimated angle and L
% [~, lHat2] = lab1est(A, B, z1b, z2b);
% fprintf('%.10f\n', lHat2);
% display(["True_L: ", L, "Est_L: " lHat2, "difference: ", abs(L-lHat2) "variance: ", 150]);

M = 12;
N = 100;
% estimates = zeros(N, M); 
% for alpha = 10:10:120 %for each alpha (it's really the sqrt of alpha right?)
% 
%    for n = 1:N
%         z1 = y1sig(t) + sqrt(alpha)*randn(1, length(t));
%         z2 = y2sig(t)+ sqrt(alpha)*randn(1, length(t)); 
%        [~, estimates(n, alpha/10)] = lab1est(A, B, z1, z2); %get the estimated L for each set of noisy responses
%     end
% end
% 
% save('estimates.mat', 'estimates'); %save it
data = load('estimates.mat'); %get it
estimates = data.estimates;

mse_for_relization = zeros(N, M);
mse_for_alpha = zeros(M, 1); 
for alpha = 10:10:120 
    mse_for_relization(:, alpha/10) = ((estimates(:, alpha/10)) - L).^2; % am i supposed to multiple by sigma squared?
    mse_for_alpha(alpha/10, 1) = (1/N)*sum(mse_for_relization(:, alpha/10));
end

figure;
plot(10:10:120, mse_for_alpha); 
xlabel('$\sigma^2$', 'Interpreter', 'latex');
ylabel('MSE of $\sigma^2$', 'Interpreter', 'latex');
title('MSE of $\sigma^2$ vs $\sigma^2$', 'Interpreter', 'latex');
xlim([10, 120]);
grid on;


standard_dev_per_alpha = zeros(M,1);

% standard_dev_per_alpha = std(mse_for_relization, 0, 1);

for alpha = 10:10:120 
    summation = 0;
    for n = 1:N
        summation = summation + (mse_for_relization(n, alpha/10)-mse_for_alpha(alpha/10, 1))^2;
    end
    standard_dev_per_alpha(alpha/10, 1) = sqrt((1/N)*summation);
end

alpha = 10:10:120;
figure;
errorbar(alpha, mse_for_alpha, standard_dev_per_alpha, 'LineWidth', 2) 
xlabel('$\sigma^2$', 'Interpreter', 'latex');
ylabel('MSE of $\sigma^2$', 'Interpreter', 'latex');
title('MSE of $\sigma^2$ with Error Bars', 'Interpreter', 'latex');
xlim([10 120]);
grid on;
