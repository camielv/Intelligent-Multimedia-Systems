%% Dataset creator
video       = load('FRAMES.mat');
video_cells = struct2cell(video.FRAMES);
frames      = video_cells(1, :);
num_frames  = size(frames, 2);
annotation  = zeros(num_frames, 2);

for i = 1:num_frames
    frame = im2double(frames{i});
    imshow(frame);
    drawnow;
    annotation(i,:) = ginput(1);
end

%% Draw annotation
annotation = struct2cell(load( 'PLAYER2.mat' ));
annotation = annotation{1};

results = struct2cell(load( 'results_player2.mat' ));
rgb_bf  = results{1};
rgb_ms  = results{2};
RGB_ms  = results{3};
RGB_bf  = results{4};

for i = 1:num_frames
    frame = im2double(frames{i});
    imshow(frame);
    hold on;
    scatter(rgb_bf(i, 1), rgb_bf(i,2), 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'g');
    scatter(rgb_ms(i, 1), rgb_ms(i,2), 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'g');
    scatter(RGB_ms(i, 1), RGB_ms(i,2), 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'None');
    scatter(RGB_bf(i, 1), RGB_bf(i,2), 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'None');
    scatter(annotation(i, 1), annotation(i,2), 'MarkerFaceColor','g', 'MarkerEdgeColor', 'g');
    hold off;
    drawnow;
end

%% Save video
%frames = mmreader('../data/video.mpg');
path = ['..' filesep 'data' filesep 'video4'];
num_frames = 1820;
%# figure
figure, set(gcf, 'Color','white')

%# create AVI object
vidObj = VideoWriter('video4.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 15;
open(vidObj);

%# create movie
for i=1200:1500
    frame_name = [path filesep 'frame' num2str(i,'%05d') '.jpg'];
	imshow(im2double(imread(frame_name)));
    drawnow;
    writeVideo(vidObj, getframe(gca));
end

close(gcf)
%# save as AVI file, and open it using system video player
close(vidObj);
winopen('video4.avi')
