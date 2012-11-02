%% Loading in image
FILE  = ['..' filesep 'data' filesep 'nemo1.jpg'];
IMAGE = imread( FILE, 'jpg' );
IMAGE = im2double( IMAGE );

%% RGB to rgb conversion
red   = IMAGE(:, :, 1);
green = IMAGE(:, :, 2);
blue  = IMAGE(:, :, 3);

red_prime   = red   ./ (red + green + blue);
green_prime = green ./ (red + green + blue);
blue_prime  = blue  ./ (red + green + blue);

IMAGE_rgb = cat( 3, red_prime .* logical(red + green + blue), green_prime .* logical(red + green + blue), blue_prime .* logical(red + green + blue) );
IMAGE_rgb( isnan( IMAGE_rgb ) ) = 0;
imshow( IMAGE_rgb )
%% RGB to oponent colour space



%% RGB to HSV

IMAGE_hsv = rgb2hsv( IMAGE );
imshow( IMAGE_hsv )

%% 2D Histogram
bins    = 100;
bin_size = 1 / bins;
divider = bin_size + 0.01;
histogram = zeros( bins, bins );
image = reshape( IMAGE, size( IMAGE, 1 ) * size( IMAGE, 2 ), 3);

for i = 1: size( image, 1 )
    histogram( 1 + floor(double(image(i,1))/divider), 1 + floor(double(image(i,2)) / divider) ) = ...
    histogram( 1 + floor(double(image(i,1))/divider), 1 + floor(double(image(i,2)) / divider) ) + 1;
end


%% 3D Histogram
bins    = 100;
bin_size = 1 / bins;
divider = bin_size + 0.01;
histogram = zeros( bins, bins, bins );
image = reshape( IMAGE, size( IMAGE, 1 ) * size( IMAGE, 2 ), 3);

for i = 1: size( image, 1 )
    histogram( 1 + floor(double(image(i,1))/divider), 1 + floor(double(image(i,2)) / divider), 1 + floor(double(image(i,3)) / divider) ) = ...
    histogram( 1 + floor(double(image(i,1))/divider), 1 + floor(double(image(i,2)) / divider), 1 + floor(double(image(i,3)) / divider) ) + 1;
end