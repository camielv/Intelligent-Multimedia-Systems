function output = kernel(target)

    [height, width] = size(target);

    % Initialise the kernel
    kernel = zeros(height,width);
    
    % Calculate the middle of the image
    midHeight = 0.5 * height;
    midWidth  = 0.5 * width;
    
    % Each kernel entry is the distance to the middle
    for i=1:height
        for j=1:width
             kernel(i,j) = i-midHeight^2 + j-midWidth^2;
        end
    end
    
    % Normalise the kernel
    normalisedKernel = kernel/max(kernel(:));

    % Use Epanechiknov
    d = 2;
    c_d = pi;
    output = 0.5 / c_d * (d + 2) * (1 - normalisedKernel);

end

