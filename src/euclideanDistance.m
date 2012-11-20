function distance = euclideanDistance( hist1, hist2 )
    distance = sum( sum( sum( sqrt((hist1 - hist2).^2) ) ) );
    return;
end

