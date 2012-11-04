%% Loading in image
FILE  = ['..' filesep 'data' filesep 'nemo1.jpg'];
IMAGE = imread( FILE, 'jpg' );
test = RGBtorgb( IMAGE );