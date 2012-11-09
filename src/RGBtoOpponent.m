function output = RGBtoOpponent( RGB_image )
% RGBtoOpponent converts a RGB image to the Opponent colour space
    %{
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
	%}
	
	%
	% Initialize image
    output = zeros( size(RGB_image) );
    
    % Calculate O1 = (R-G)/sqrt(2)
    output(:,:,1) = ( RGB_image(:,:,1) - RGB_image(:,:,2) ) / sqrt(2);
                
    % Calculate O2 (R+G-2B)/sqrt(6)
    output(:,:,2) = ( RGB_image(:,:,1) + RGB_image(:,:,2) - 2*RGB_image(:,:,3) ) / sqrt(6);
                    
    % Calculate O3 = (R+G+B)/sqrt(3)
    output(:,:,3) = ( RGB_image(:,:,1) + RGB_image(:,:,2) + RGB_image(:,:,3) ) / sqrt(3);

	return;
	%
end

