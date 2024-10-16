function [theta_est, L_est] = lab1est(A, B, y1, y2)
    % Constants
    c_s = 343; % Speed of sound in m/s

    % Cross-correlation to find the relative delay
    [C, lags] = xcorr(y1, y2);
    [~, idx] = max(C);
    lag = lags(idx); % Get the lag corresponding to the peak

    % Convert lag to time
    relative_time_shift = lag / 1e6; % Convert from samples to seconds

    % Calculate the delays τ1 and τ2
    tau1 = sqrt(B^2 + (100 - A)^2) / c_s; % Assuming L = 100 for the first call
    tau2 = sqrt(B^2 + (100 - 2 * A)^2) / c_s; % Assuming L = 100 for the second call

    % Calculate relative delay
    relative_delay = min(abs(tau1 - tau2) * c_s / A, 1);

    % Estimate theta
    theta_est = asin(relative_delay);

    % Estimate L
    L_est = B * tan(theta_est);
end