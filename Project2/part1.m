image = imread("Project2/WeeksHallSmall.jpg");
% imshow(image);
image = rgb2gray(image);
% imshow(image);
image = double(image);

% %part A
% avg_pixel_value = mean2(image);
% disp(['average pixel value: ', num2str(avg_pixel_value)]);
% 
% %part B
% [rows, cols] = size(image);
% b_filtered_img = zeros(rows, cols);
% 
% m = [2, 4, 8, 16, 32];
% for M = 1:5
%     for row = 1:rows
%     b_filtered_img(row, :) = filter(ones(1, m(M)), m(M), image(row, :));
%     end
%     % figure;
%     % imshow(uint8(b_filtered_img));
%     % title(sprintf('Row-Blurred Image, M = %d', m(M))); 
% end
% 
% b_filtered_img = zeros(rows, cols);
% 
% for M = 1:5
%     for col = 1:cols
%     b_filtered_img(:, col) = filter(ones(1, m(M)), m(M), image(:, col));
%     end
%     figure;
%     imshow(uint8(b_filtered_img));
%     title(sprintf('Column-Blurred Image, M = %d', m(M))); 
% end

% figure;
% imshow(uint8(b_filtered_img));
% title('Row-Blurred Image with Moving Average Filter');

%part C

% 
% % Create a stem plot of the middle row
% figure;
% stem(image(230, :));
% title('Stem Plot of Row 230');
% xlabel('Column Index');
% ylabel('Pixel Intensity');
% 
% %that row filtered
% b = [1, -1];
% a = 1; 
% 
% [~, cols] = size(image);
% c_filtered_row = zeros(1, cols);
% 
% c_filtered_row(1, :) = filter(b, a, image(230, :));
% 
% figure;
% stem(c_filtered_row);
% xlabel('Column Index');
% ylabel('Pixel Difference');
% title('Filtered Row 230 with Difference Filter');

%the entire image filtered by row
[rows, cols] = size(image);
% c_filtered_img = zeros(rows, cols);
% tau = 15;
% 
% for row = 1:rows
%     c_filtered_img(row, :) = filter(b, a, image(row, :));
%     for col = 1:cols
%         if c_filtered_img(row, col) > tau
%             c_filtered_img(row, col) = 1;
%         else
%             c_filtered_img(row, col) = 0;
%         end
%     end
% end
% 
% figure;
% imagesc(uint8(c_filtered_img));
% title('Edge Detection by Row with Tau = 10');
% 
% %the entire image filtered by cols
% for col = 1:cols
%     c_filtered_img(:, col) = filter(b, a, image(:, col));
%     for row = 1:rows
%         if c_filtered_img(row, col) > tau
%             c_filtered_img(row, col) = 1;
%         else
%             c_filtered_img(row, col) = 0;
%         end
%     end
% end
% 
% figure;
% imagesc(uint8(c_filtered_img));
% title('Edge Detection by Column with Tau = 10');

%part D
% dur = [0 0 -1; 0 1 0; 0 0 0];
% dul = [-1 0 0; 0 1 0; 0 0 0];
% tau = 10;
% newPic = conv2(dul, image);
% for row = 1:rows
%     for col = 1:cols
%          if newPic(row, col) > tau
%             newPic(row, col) = 1;
%         else
%             newPic(row, col) = 0;
%         end
%     end
% end
% imshow(newPic);
% title('Edge Detection by Dul with Tau = 10');

% %part E
tau = 30;
fiveByfive = [0 0 0 0 0;
               0 0 0 0 0;
               0 0 -1 0 0;
               0 1 0 0 -1;
               0 0 0 1 0];
newPic = conv2(fiveByfive, image);
for row = 1:rows
    for col = 1:cols
         if newPic(row, col) > tau
            newPic(row, col) = 1;
        else
            newPic(row, col) = 0;
        end
    end
end
figure;
imshow(newPic);
title('Slope Detection');