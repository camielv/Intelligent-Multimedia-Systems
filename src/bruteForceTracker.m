function path = bruteForceTracker()
    % Read movie
    %frames     = mmreader(movie);
    %num_frames = frames.numberOfFrames;
    %path       = zeros(2, num_frames);
    %current    = im2double(read(frames, 1));
    bins       = 16;
    dim        = [1,2,3]
    
    % Temporary
    video       = load('FRAMES.mat');
    video_cells = struct2cell(video.FRAMES);
    frames      = video_cells(1, :);
    num_frames  = size(frames, 2);
    current     = im2double(frames{1});
    
    % Datastructure to safe positions 
    path = zeros(2, num_frames);
        
    % Select target using imrect
    figure(1);
    imshow(current);
    title('Select target and double click the rectangle when finished');
    h = imrect;
    target = round(wait(h));
    
    % Draw selection
    hold on;
    rectangle('Position', target, 'LineWidth',2, 'EdgeColor','b');
    hold off;
    
    % Determine corners (top left and bottom right)
    tl = [target(1); target(2)];
    br = [target(1) + target(3); target(2) + target(4)];
    
    % Determine middle of selection
    half_width  = floor((br(1) - tl(1)) / 2);
    half_height = floor((br(2) - tl(2)) / 2);
    
    % Initial position
    y0 = round([br(1) - half_width; br(2) - half_height]);
    
    % Save path
    path(:, 1) = y0;
    
    q_frame = imcrop(current, target);
    q       = Histogram(q_frame, bins, [1,2,3]);
    
    for i = 2:num_frames
        % Read next frame
        current = im2double(frames{i});
        
        % Compute new position using bruteforce
        target = bruteForce(current, q, target, bins, dim, 5);
        
        % Show the next frame
        imshow(current);
        
        % Draw Rectangle
        hold on;
        rectangle('Position', target, 'LineWidth',2, 'EdgeColor','b');
        hold off;
        drawnow;
        
        % Determine middle Save path
        br = [target(1) + target(3); target(2) + target(4)];
        y1 = round([br(1) - half_width; br(2) - half_height]);

        path(:, i) = y1;
    end
    close all;
end