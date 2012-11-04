function output = RGBtoOpponent( RGB_image )
% RGBtoOpponent converts a RGB image to the Opponent colour space
    % Initialize image
    output = zeros( size(RGB_image) );
    
    % Calculate luminance
    output(:,:,1) = 0.2126 * RGB_image(:,:,1) + ...
                    0.7152 * RGB_image(:,:,2) + ...
                    0.0722 * RGB_image(:,:,3);
                
    % Calculate R-G
    output(:,:,2) = RGB_image(:,:,2) - ...
                    RGB_image(:,:,1);
                
    % Calculate B-Y = B - (R+G)
    output(:,:,3) = RGB_image(:,:,3) - ...
                    ( RGB_image(:,:,1) + ...
                    RGB_image(:,:,2) );

	return;
end

