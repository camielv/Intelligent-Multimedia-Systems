function target = findTarget( current, next_frame, target, bins )
    % Initialization
    smallest = inf;
    parameters = zeros(2, 1);
    stepsize = 10;
    window       = [ target(1) - target(3), target(2) - target(4), target(1) + 2 * target(3), target(2) + 2 * target(4)];
    image_size   = size( current );

    % Crop the target frame
    target_frame = imcrop( current, target );
    
    % Checking if window size is valid
    if window(1) < 1
        window(1) = 1;
    end
    if window(2) < 1
        window(2) = 1;
    end
    if window(3) > image_size(2)
        window(3) = image_size(2);
    end
    if window(4) > image_size(1)
        window(3) = image_size(1);
    end

    % Histogram of the target
    target_hist = Histogram( target_frame, bins, [1,2,3] );
    % Loop over candidate frames.
    for i = window(1) : stepsize : window(3)
        for j = window(2):10:window(4)
            % Crop candidate frame
            candidate_frame = imcrop( next_frame, [i, j, target(3), target(4)]);
            
            % Create histograms
            candidate_hist  = Histogram( candidate_frame, bins, [1,2,3] );
            
            % Calculate Distance between histogram
            distance = euclideanDistance( target_hist, candidate_hist );
            
            % Check if distance is smaller
            if distance < smallest
                smallest    = distance;
                parameters = [i;j];
            end
        end
    end
    target = [parameters(1), parameters(2), target(3), target(4)];
    
    return;
end