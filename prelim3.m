
% a)
% Read the image
img = imread('SirHenry.png');
% Display the original image
figure;
imshow(img);
title('Sir Henry');

%fuck it, GRAYSCALE THIS SHIT!!!!!
grayimg = rgb2gray(img);
figure;
imshow(grayimg);
title('Grayscale Image of Henry');

% double precision it
imgX = double(grayimg);
imwrite(uint8(imgX), 'SirHenryGray.png'); 

avg_intensity = mean(imgX(:)); %me when i vectorize 
fprintf('The average pixel value of the image X is: %.2f\n', avg_intensity); % me when i format it 

%b) ------------
% Create a 2D Gaussian filter
hgauss = fspecial('gaussian', [10 10], 1.0);
% Plot the 2D filter
figure;
surf(hgauss);
title('2D Gaussian Filter');
xlabel('X');
ylabel('Y');
zlabel('Amplitude');

% filter image using guassian filter we made
YGauss = filter2(hgauss, imgX, 'same');

% Display the filtered (blurred) image
figure;
imshow(YGauss / 255); % Normalize to display properly
title('Blurred Image (YGauss)');

% Find the average intensity of the blurred image
avg_intensity_YGauss = mean(YGauss(:));
fprintf('The average pixel value of the blurred image YGauss is: %.2f\n', avg_intensity_YGauss);

% Save the blurred image after normalizing it
imwrite(YGauss / 255, 'SirHenryGaussBlur.png');


% c) Create the simple lowpass filter
Hlow = (1/5) * [0 1 0; 1 1 1; 0 1 0];

% Apply the simple lowpass filter
YLow = filter2(Hlow, imgX, 'same');

% Save the simple blurred image
imwrite(YLow / 255, 'SirHenrySimpleBlur.png');

% d) Take the difference between Gaussian and simple blur
diff_image = YGauss - YLow;

% Find max and min differences
max_diff = max(diff_image(:));
min_diff = min(diff_image(:));
fprintf('Maximum difference: %.2f\nMinimum difference: %.2f\n', max_diff, min_diff);

% Display the difference image
figure;
imshow(diff_image, [min_diff max_diff]);
title('Difference between Gaussian and Simple Blur');

% Rescale difference image to [0,1] and save
diff_scaled = (diff_image - min_diff) / (max_diff - min_diff);
imwrite(diff_scaled, 'SirHenrySimpleBlurDiff.png');

% e) Create and apply highpass filter
Hhigh = (1/5) * [0 1 0; 1 1 1; 0 1 0] - Hlow;
YHigh = filter2(Hhigh, YGauss, 'same');

% Find and display max and min values of YHigh
max_YHigh = max(YHigh(:));
min_YHigh = min(YHigh(:));
fprintf('YHigh maximum value: %.2f\n', max_YHigh);
fprintf('YHigh minimum value: %.2f\n', min_YHigh);

% Display highpass filtered image
figure;
imshow(YHigh, [min_YHigh max_YHigh]);
title('Highpass Filtered Image');

% Rescale and save highpass image
YHigh_scaled = (YHigh - min_YHigh) / (max_YHigh - min_YHigh);
imwrite(YHigh_scaled, 'SirHenryGaussHigh.png');

% f) Generate sharpened images for different alpha values
alpha_values = [1 2 5 10 20];

for alpha = alpha_values
    YSharp = YGauss + alpha * YHigh;
    
    % Ensure values are in proper range by scaling
    YSharp = YSharp - min(YSharp(:));  % Shift minimum to 0
    YSharp = YSharp / max(YSharp(:));  % Scale maximum to 1
    
    % Display sharpened image
    figure;
    imshow(YSharp);
    title(sprintf('Sharpened Image (alpha = %.1f)', alpha));
    
    % Save sharpened image
    filename = sprintf('SirHenrySharp_alpha%.1f.png', alpha);
    imwrite(YSharp, filename);
end