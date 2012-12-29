function error = RMSE(dataset1, dataset2)
    error = sqrt(mean((dataset1 - dataset2).^2));
end

