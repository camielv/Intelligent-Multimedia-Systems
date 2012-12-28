function path = meanShiftTracker(movie)
    % Read movie
    frames     = VideoReader(movie);
    num_frames = frames.numberOfFrames;
    current    = RGBtorgb(read(frames, 1));
    bins       = 16;
        
    % Datastructure to safe positions 
    path = zeros(num_frames, 2);
    
    % Dimensions
    dim_x = frames.Width;
    dim_y = frames.Height;
    
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
    
    % Meshgrid to save possible locations efficiently
    [X,Y] = meshgrid( -half_width  : half_width  - 1, ...
                      -half_height : half_height - 1);
    X = reshape(X, 1, size(X, 2) * size(X, 1));
    Y = reshape(Y, 1, size(Y, 2) * size(Y, 1));
    grid = [X;Y];
    length = size(grid, 2);
    
    % Create kernel
    kernel = createKernel(grid, 3.14159265359, 2);
    
    % Initial position
    y0 = round([br(1) - half_width; br(2) - half_height]);
    
    % Save path
    path(1, :) = y0;
    
    q = createHistogram(current, bins, grid, y0, length, kernel, dim_x, dim_y);
    
    for i = 2:num_frames
        % Read next frame
        current = RGBtorgb(read(frames, 1));
        
        % Compute new position using meanshift
        y1 = meanShift(current, bins, grid, y0, length, q, kernel, dim_x, dim_y);
        while norm(y1 - y0) > 0.1
           y0 = y1;
           y1 = meanShift(current, bins, grid, y0, length, q, kernel, dim_x, dim_y);
        end
        
        % Show the next frame
        imshow(current);
        
        % Draw Rectangle
        target = [y1(1) - half_width, y1(2) - half_height, 2 * half_width, 2 * half_height];
        hold on;
        rectangle('Position', target, 'LineWidth',2, 'EdgeColor','b');
        hold off;
        drawnow;
        
        % Save path
        path(i, :) = y1;
    end
    
    close all
end

