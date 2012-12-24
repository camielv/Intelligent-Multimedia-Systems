function target = meanshift(next_frame, q, target, bins, dim )
    % Initialization
    target_x = target(1);
    target_y = target(2);
    target_width = target(3);
    target_height = target(4);
    upperleft = [target_x; target_y];
    bottomright = [target_x + target_width; target_y + target_height];  
    midWidth = floor( ( bottomright(1) - upperleft(1) ) / 2 );
    midHeight = floor( ( bottomright(2) - upperleft(2) ) / 2 );
    
    y0 = round( [ target_x + midWidth ; target_y + midHeight ] );
    y1 = [0,0];
    
    % Create candidate histogram
    p = weightedHistogram( next_frame, bins, dim ); %candidate_hist
    rho0 = bhattacharyyaDistance( q, p );
    
    image_size = size( next_frame );
    weights = zeros( 1, image_size );
    stepsize = 10;
    % region of width x height pixels centred on the candidate position
    window       = [ target_x - target_width, target_y - target_height, ...
        target_x + 2 * target_width, target_y + 2 * target_height];


    % Checking if window size is valid
    if window(1) < 1
        window(1) = 1;
    end
    if window(2) < 1
        window(2) = 1;
    end
    if window(3) > image_size(2) - target_width
        window(3) = image_size(2) - target_width;
    end
    if window(4) > image_size(1) - target_height
        window(4) = image_size(1) - target_height;
    end
    
    bin = min( bins, floor( next_frame * bins ) + 1 );
    % Loop over candidate frames.
    for i = window(1) : stepsize : window(3)
        for j = window(2) : stepsize : window(4)
            % Crop candidate frame
            candidate_pos = imcrop( next_frame, [i, j, target_width, target_height] );
            
            % Create histograms
            p  = weightedHistogram( candidate_pos, bins, dim );

            weights(i) = sqrt( q( bin(i,j,1), bin(i,j,2), bin(i,j,3) ) / ...
                p( bin(i,j,1), bin(i,j,2), bin(i,j,3) ));
                      
            % Update y1
            y1 = y1 + weights(i) * [i;j];
            
        end
    end
    
    p = weightedHistogram( image, bins, dim );
    rho1 = bhattacharyyaDistance( q, p );

    while rho1 < rho0
         % Find new position
         real_y1 = ( (y0 + real_y1) / 2 );
         y1 = round( real_y1 );
         
         %TODO check midwidth bla
         candidate_pos = imcrop( next_frame, [y1(1), y1(2), target_width, target_height] );
         
         % Calculate new p
         p = weightedHistogram( candidate_pos, bins, dim );
         
         % Calculate new battacharyya distance
         rho1 = bhattacharyyaDistance( q, p );
    end
    
    target = imcrop( next_frame, [y1(1), y1(2), target_width, target_height] );
end