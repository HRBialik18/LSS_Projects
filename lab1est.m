function [theta_est, L_est] = lab1est(A, B, y1, y2)
    % Constants
    c_s = 343; % Speed of sound in m/s

    % Cross-correlation to find the relative delay
    [C, lags] = xcorr(y1, y2);
    [~, idx] = max(C);
    lag = lags(idx); % Get the lag corresponding to the peak

    % Convert lag to time
    relative_time_shift = lag / 1e5; % Convert from samples to seconds

    % Calculate relative delay
    relative_delay = min(abs(relative_time_shift) * c_s / A, 1);

    % Estimate theta
    theta_est = asin(relative_delay);

    % Estimate L
    L_est = B * tan(theta_est)+A; %I added the +A because the angle thing gives us L-A
end