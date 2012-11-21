function distance = bhattacharyyaDistance( hist1, hist2 )
    hist1 = hist1(:) / sum(hist1(:));
    hist2 = hist2(:) / sum(hist2(:));
    b_coefficient = sum( sqrt( hist1 .* hist2 ) );
    distance = sqrt( 1 - b_coefficient );
    return;
end