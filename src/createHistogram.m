function histogram = createHistogram(image, bins, grid, y, n, kernel, ...
                                     dim_x, dim_y)
    % Initialize histogram
    histogram = zeros(bins, bins, bins);
    
    % Every position in the image contains binnumber
    bin = min(bins, floor(image .* bins) + 1);
    
    % Compute absolute position
    abs_x = y(1) + grid(1,:);
    abs_y = y(2) + grid(2,:);
    
    for i = 1:n
        % Find image positions
        pos_x = abs_x(1, i);
        pos_y = abs_y(1, i);
        
        % Check if position is still in the image
        if pos_x > 0 && pos_x < dim_x && ...
                pos_y > 0 && pos_y < dim_y
            
            % Find correct index and add kernel
            histogram(bin(pos_y, pos_x, 1), bin(pos_y, pos_x, 2), bin(pos_y, pos_x, 3)) = ...
                histogram(bin(pos_y, pos_x, 1), bin(pos_y, pos_x, 2), bin(pos_y, pos_x, 3))  + kernel(i);
        end
    end
    
    % Normalize the histogram
    histogram = histogram ./ sum(kernel);
end