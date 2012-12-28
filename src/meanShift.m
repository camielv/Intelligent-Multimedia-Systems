function y1 = meanShift(image, bins, grid, y0, n, q, kernel, dim_x, dim_y)
    y1 = [0; 0];
    
    % Compute rho by bhattacharyya coefficient
    y0   = round(y0);
    p    = createHistogram(image, bins, grid, y0, n, kernel, dim_x, dim_y);
    rho0 = sum(sqrt(p(:) .* q(:)));
    
    % Initialize weights
    weights = zeros(1, n);
    
    % Find for each pixel the correct bin
    bin = min(bins, floor(image * bins) + 1);
    
    % Absolute position
    abs_x = y0(1) + grid(1, :);
    abs_y = y0(2) + grid(2, :);
    
    for i = 1:n
        % Find image positions
        pos_x = abs_x(1, i);
        pos_y = abs_y(1, i);
        
        % Check if its inside image and histogram not zero
        if pos_x > 0 && pos_x < dim_x && pos_y > 0 && pos_y < dim_y && ...
                p(bin(pos_y, pos_x, 1), bin(pos_y, pos_x, 2), bin(pos_y, pos_x, 3)) ~= 0
            
            weights(i) = q(bin(pos_y, pos_x, 1), bin(pos_y, pos_x, 2), bin(pos_y, pos_x, 3)) / ...
                p(bin(pos_y, pos_x, 1), bin(pos_y, pos_x, 2), bin(pos_y, pos_x, 3));
        end
        
        % Update y1
        y1 = y1 + weights(i) * [pos_x; pos_y];
    end
    
    % Normalize y1
    real_y1 = y1 / sum(weights);
    y1 = round(real_y1);
    
    % Compute new histogram and bhattacharyya
    p    = createHistogram(image, bins, grid, y1, n, kernel, dim_x, dim_y);
    rho1 = sum(sqrt(p(:) .* q(:)));
    
    % While rho1 is smaller than rho0 find better histograms.
    while rho1 < rho0
        real_y1 = (y0 + real_y1) / 2;
        y1 = round(real_y1);
        
        % Compute new histogram and new bhattacharyya
        p    = createHistogram(image, bins, grid, y1, n, kernel, dim_x, dim_y);
        rho1 = sum(sqrt(p(:) .* q(:)));
    end
end