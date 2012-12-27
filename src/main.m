%% Tracker
DIRECTORY = ['..' filesep 'data' filesep 'video'];
IMAGE = [DIRECTORY filesep 'Frame0085.png'];
current = im2double(imread(IMAGE));

bins = 10;
dim = [1,2,3];

% Show image in figure
figure, imshow(current);

% Selector tool
title('Select a target, and double click the rectangle when ready!');
h = imrect;

% Wait till user double clicked
target = wait(h);

% Draw rectangle at target location
hold on;
rectangle('Position', target, 'LineWidth',2, 'EdgeColor','b');
hold off;

% Crop it and create histogram
target_frame = imcrop(current, target);
q = weightedHistogram(target_frame, bins, dim);

% all_frames = [getframe(gca)];
for next_frame_nr = 86:285
    next_frame_name = [DIRECTORY filesep 'Frame' num2str(next_frame_nr,'%04d') '.png'];
	next_frame = im2double(imread(next_frame_name));
    
    % *your tracking-code here*
    % target = findTarget( target_hist, next_frame, target, bins );
    target = meanshift(next_frame, q, target, bins, dim);
    current = next_frame;
    imshow(next_frame);
    
    % Draw rectangle at location
    hold on;
    rectangle('Position', target, 'LineWidth',2, 'EdgeColor','b');
    hold off;
    %all_frames = [all_frames getframe(gca)];
    drawnow
end

%save_movie(all_frames, 'your_movie.avi', 15, 100);

close all;