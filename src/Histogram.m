function output = Histogram( image, bins, dim )
% Histogram creates a histogram of the image
% image: a image.
% bins: a scalar of bins.
% dim: vector of dimensions
    % Initialize histogram.
    output = zeros( ones(1,size(dim,2)) * bins );
    % Reshape image for for loop
    image = double(reshape( image, size( image, 1 ) * size( image, 2 ), 3));

    % Create 2D histogram
    if size(dim, 2) == 2
        for i = 1: size( image, 1 )
            output( min( bins, floor( image(i,dim(1)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(2)) * bins ) + 1) ) = ...
            output( min( bins, floor( image(i,dim(1)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(2)) * bins ) + 1) ) + 1;
        end
    % Create 3D histogram
    elseif size(dim, 2) == 3
        for i = 1: size( image, 1 )
            output( min( bins, floor( image(i,dim(1)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(2)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(3)) * bins ) + 1)) = ...
            output( min( bins, floor( image(i,dim(1)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(2)) * bins ) + 1), ...
                    min( bins, floor( image(i,dim(3)) * bins ) + 1) ) + 1;
        end
    end
    
    return;
end

