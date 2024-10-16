
fsim = 1e6;
t = 0:1/fsim:5;
noise1_var1 = sqrt(1)*randn(1, length(t));  % sigma^2 = 1
noise2_var1 = sqrt(1)*randn(1, length(t));  % sigma^2 = 1
noise1_var100 = sqrt(100)*randn(1, length(t));  % sigma^2 = 100
noise2_var100 = sqrt(100)*randn(1, length(t));  % sigma^2 = 100

A = 0.025;
B = 200;
L = 150;

u = @(t) double(t >= 0);
sig = @(t) 100 * cos(10000 * pi * t) .* (u(t) - u(t - 1));

[y1sig, y2sig] = lab1sim(A, B, L, sig); %gets the two responses - y1 and y2

z1 = y1sig(t) + noise1_var1; %adds noise
z2 = y2sig(t) + noise2_var1;

%call lab1est which outputs estimated angle and L
[~, lHat1] = lab1est(A, B, z1, z2);

display(["True_L: ", L, "Est_L: " lHat1, "difference: ", abs(L-lHat1) "variance: ", 1]); %every time i run i get the same thing:(

z1 = y1sig(t) + noise1_var100; %do it for the other varriance
z2 = y2sig(t) + noise2_var100;

%call lab1est which outputs estimated angle and L
[~, lHat2] = lab1est(A, B, z1, z2);

display(["True_L: ", L, "Est_L: " lHat2, "difference: ", abs(L-lHat2) "variance: ", 100]);

M = 2; %should be 25
N = 2; %should be 50
estimates = zeros(N, M); %alpha goes from 0 to M while N goes from 1 to M so how does that work with the sizing? chana
for alpha = 0:M %for each alpha (it's really the sqrt of alpha right?)
   
    z1 = y1sig(t) + alpha*randn(N, length(t)); %create 50 noises for z1 and add them to y1
    z2 = y2sig(t)+ alpha*randn(N, length(t)); %create 50 noises for z2 and add them to y2
    for n = 1:N
       [~, estimates(n, alpha + 1)] = lab1est(A, B, z1(n, :), z2(n, :)); %get the estimated L for each set of noisy responses
    end
end

%we only have to save the first 20? chana
save('estimates.mat', 'estimates'); %save it
data = load('estimates.mat'); %get it
estimates = data.estimates;

mse_for_relization = zeros(N, M);
mse_for_alpha = zeros(M+1, 1); %says M+1 because it starts from zero... chana
for alpha = 0:M 
    mse_for_relization(:, alpha+1) = (estimates(:, alpha+1).*alpha - L).^2;
    mse_for_alpha(alpha+1, 1) = (1/N)*sum(mse_for_relization(:, alpha+1));
end

alpha_squared = (0:M).^2; %plot of alpha squared vs mse
figure;
plot(alpha_squared, mse_for_alpha);
xlabel('Alpha Squared');
ylabel('MSE of Alpha');
title('MSE of Alpha vs Alpha Squared');
grid on;

standard_dev_per_alpha = zeros(M+1,1);

for alpha = 0:M 
    mse_for_alpha(alpha+1, 1) = sqrt((1/N)*sum((mse_for_relization(:, alpha+1)-mse_for_alpha(alpha+1, 1))));
end
figure;
errorbar(alpha, mse_for_alpha, standard_dev_per_alpha) %why not working chana
xlabel('Alpha');
ylabel('MSE of Alpha');
title('MSE vs Alpha with Error Bars');
grid on;
