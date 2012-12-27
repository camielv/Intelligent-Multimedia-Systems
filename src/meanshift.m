function target = meanshift(next_frame, q, target, bins, dim )
    % Initialization
    upperleft   = [target(1); target(2)];
    bottomright = [target(1) + target(3); target(2) + target(4)];  
    midWidth    = floor((bottomright(1) - upperleft(1)) / 2);
    midHeight   = floor((bottomright(2) - upperleft(2)) / 2);
    
    y0 = round([target(1) + midWidth ; target(2) + midHeight]);
    y1 = [0,0];
    
    % Create candidate histogram
    p = weightedHistogram(next_frame, bins, dim);
    % Calculate bhattacharyya distance
    rho0 = bhattacharyyaDistance(q, p);
    
    image_size = size(next_frame);
    weights    = zeros(1, image_size);
    stepsize   = 10;
    % Region of Interest  2*width x 2*height pixels centred on the candidate position
    window     = [target(1) - target(3), target(2) - target(4), ...
                  target(1) + 2 * target(3), target(2) + 2 * target(4)];

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
    
    bin = min(bins, floor( next_frame * bins ) + 1);
    
    % Loop over candidate frames.
    for i = window(1):stepsize:window(3)
        for j = window(2):stepsize:window(4)
            % Crop candidate frame
            candidate_pos = imcrop( next_frame, [i, j, target(3), target(4)] );
            
            % Create histograms
            p = weightedHistogram(candidate_pos, bins, dim);
            weights(i) = sqrt(q(bin(i,j,1), bin(i,j,2), bin(i,j,3))/...
                p( bin(i,j,1), bin(i,j,2), bin(i,j,3)));
                      
            % Update y1
            y1 = y1 + weights(i) * [i,j];
            
        end
    end
    
    p = weightedHistogram(image, bins, dim);
    rho1 = bhattacharyyaDistance(q, p);

    while rho1 < rho0
         % Find new position
         real_y1 = ( (y0 + real_y1) / 2 );
         y1 = round( real_y1 );
         
         %TODO check midwidth bla
         candidate_pos = imcrop( next_frame, [y1(1), y1(2), target_width, target_height] );
         
         % Calculate new p
         p = weightedHistogram(candidate_pos, bins, dim);
         
         % Calculate new battacharyya distance
         rho1 = bhattacharyyaDistance(q, p);
    end
    
    target = [y1(1), y1(2), target(3), target(4)];
end