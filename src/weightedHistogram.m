function output = weightedHistogram( image, bins, dim )
% weightedHistogram creates a weighted histogram of the image
% image: a image.
% bins: a scalar of bins.
% dim: vector of dimensions

    % Initialize histogram.
    output = zeros( ones(1,size(dim,2)) * bins );
    
    % Make kernel
    tmpWeightedKernel = kernel(image);
    
    % Reshape image and kernel for for loop
    image = double(reshape( image, size( image, 1 ) * size( image, 2 ), 3));
    [r, c] = size(tmpWeightedKernel);
    weightedKernel = double(reshape( tmpWeightedKernel, r * c, 1));

    
    % Create 2D histogram
    if size(dim, 2) == 2
        for i = 1: size( image, 1 )
            output( min( bins, floor( image(i,dim(1)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(2)) * bins ) + 1)) = ...
            output( min( bins, floor( image(i,dim(1)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(2)) * bins ) + 1) ) + weightedKernel(i);
        end
    % Create 3D histogram
    elseif size(dim, 2) == 3
        for i = 1: size( image, 1 )
            output( min( bins, floor( image(i,dim(1)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(2)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(3)) * bins ) + 1)) = ...
            output( min( bins, floor( image(i,dim(1)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(2)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(3)) * bins ) + 1) ) + weightedKernel(i);
        end
    end
    return;
end