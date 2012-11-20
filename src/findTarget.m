function target = findTarget( current, next_frame, target, bins )
    target_frame = imcrop( current, target );
    window       = [ target(1) - target(3), target(2) - target(4), target(1) + 2 * target(3), target(2) + 2 * target(4)];
    image_size   = size( current );
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
    
    smallest = inf;
    parameters = zeros(2, 1);
    
    for i = window(1):10:window(3)
        for j = window(2):10:window(4)
            candidate_frame = imcrop( next_frame, [i, j, target(3), target(4)]);
            
            target_hist     = Histogram( target_frame, bins, [1,2,3] );
            candidate_hist  = Histogram( candidate_frame, bins, [1,2,3] );
            
            E_distance = sqrt( sum( sum( sum( (target_hist - candidate_hist).^2 ) ) ) );
            
            if E_distance < smallest
                smallest    = E_distance;
                parameters = [i;j];
            end
        end
    end
    target = [parameters(1), parameters(2), target(3), target(4)];
end