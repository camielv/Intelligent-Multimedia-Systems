function output = RGBtorgb( RGB_image )
% RGBtorgb normalizes a RGB image
    % Perform the normalization R / (R+G+B), G / (R+G+B) and B / (R+G+B)
    output = double( RGB_image ) ./ repmat( sum( double( RGB_image ), 3 ), [1,1,3] );
    % Map all NaN's to 0
    output( isnan( output ) ) = 0;
    
	return;
end

