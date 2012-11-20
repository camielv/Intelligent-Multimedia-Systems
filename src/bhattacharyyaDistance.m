function distance = bhattacharyyaDistance( hist1, hist2 )
    bins = size( hist1, 1 );
    
    b_coefficient = sum( sum( sum( sqrt( hist1 .* hist2 ) ) ) );
    
    distance = sqrt(1 - b_coefficient);
    return;
end

