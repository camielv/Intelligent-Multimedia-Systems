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

for i = 1:num_frames
    frame = im2double(frames{i});
    imshow(frame);
    hold on;
    scatter(annotation(i, 1), annotation(i,2));
    hold off;
    drawnow;
end