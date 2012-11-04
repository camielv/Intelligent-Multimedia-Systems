function output = RGBtoHSV( RGB_image )
% RGBtoHSV converts the image to the HSV colourspace
    % Initialize image
    output = zeros( size( RGB_image ) );
    
    % Convert to HSV
    for i = 1:size( RGB_image, 1 )
        for j = 1:size( RGB_image, 2 )
            R = RGB_image(i,j,1);
            G = RGB_image(i,j,2);
            B = RGB_image(i,j,3);
            minimum = min( [R G B] );
            maximum = max( [R G B] );

            % Find the Hue
            if (minimum == maximum)
                output(i,j,1) = 0;
            else
                switch (maximum)
                    case R
                        output(i,j,1) = (0 + ((G-B) / (maximum - minimum))) * 60;
                    case G
                        output(i,j,1) = (2 + ((B-R) / (maximum - minimum))) * 60;
                    case B
                        output(i,j,1) = (4 + ((R-G) / (maximum - minimum))) * 60;
                end
            end

            % Calculate Saturation and Value
            output(i,j,2) = (maximum - minimum) / maximum;
            output(i,j,3) = maximum;            
        end
    end
    
    % Normalize
    output(:,:,1) = mod( output(:,:,1), 360 ) / 360;
    output( isnan( output ) ) = 0;
	return;
end

