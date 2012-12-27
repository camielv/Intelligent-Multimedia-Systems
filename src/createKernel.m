function kernel = createKernel(grid, c, d)
    distance = sqrt(sum(abs(grid).^2, 1));
    kernel   = 0.5 / c * (d + 2) * (1 - (distance / max(distance(:))));
end