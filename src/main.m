%% Loading in image
FILE  = ['..' filesep 'data' filesep 'nemo1.jpg'];
IMAGE = imread( FILE, 'jpg' );
test = RGBtoOpponent( IMAGE );
imshow( test );
%% Assignment 2
DIRECTORY = ['..' filesep 'data' filesep 'video'];
IMAGE = [DIRECTORY filesep 'frame0085.png'];
current = im2double( imread( IMAGE ) );

% Show image in figure
figure, imshow( current );
% Give imrect tool
h = imrect;

% Wait till user double clicked
target = wait(h);

% Draw rectangle at target location
hold on;
rectangle('Position', target, 'LineWidth',2, 'EdgeColor','b');
hold off;

all_frames = [getframe(gca)];

for next_frame_nr = 86:285
    next_frame_name = [DIRECTORY filesep 'frame' num2str(next_frame_nr,'%04d') '.png'];
	next_frame = im2double(imread(next_frame_name));
    
    [target, distance] = findTarget( current, next_frame, target, 20 );
    current = next_frame;
    % *your tracking-code here*
    imshow( next_frame );
    
    % Draw rectangle at location
    hold on;
    rectangle('Position', target, 'LineWidth',2, 'EdgeColor','b');
    hold off;
    %all_frames = [all_frames getframe(gca)];
    drawnow
end

%save_movie(all_frames, 'your_movie.avi', 15, 100);

close all;
%}