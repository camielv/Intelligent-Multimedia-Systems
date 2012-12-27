function target = bruteForce(image, q, target, bins, dim, stepsize)
    % Initialization
    smallest   = inf;
    parameters = zeros(2, 1);
    window     = [target(1) - target(3), target(2) - target(4), target(1) + 2 * target(3), target(2) + 2 * target(4)];
    image_size = size(image);
    
    % Checking if window size is valid
    if window(1) < 1
        window(1) = 1;
    end
    if window(2) < 1
        window(2) = 1;
    end
    if window(3) > image_size(2) - target(3)
        window(3) = image_size(2) - target(3);
    end
    if window(4) > image_size(1) - target(4)
        window(4) = image_size(1) - target(4);
    end
    
    window = round(window);
    
    % Loop over candidate frames.
    for i = window(1):stepsize:window(3)
        for j = window(2):stepsize:window(4)
            % Crop candidate frame
            candidate_frame = imcrop(image, [i, j, target(3), target(4)]);
            
            % Create histograms
            p  = Histogram(candidate_frame, bins, dim);
            
            % Calculate Distance between histogram
            distance = bhattacharyyaDistance(q, p);
            
            % Check if distance is bigger
            if distance < smallest
                smallest   = distance;
                parameters = [i;j];
            end
        end
    end
    target = [parameters(1), parameters(2), target(3), target(4)];
end