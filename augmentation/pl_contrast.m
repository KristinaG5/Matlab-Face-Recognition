function images = pl_contrast(image, smallest, largest, interval)
    dimensions = size(image);
    height = dimensions(1);
    width = dimensions(2);
    images = zeros(height, width, largest-smallest-2);
    item = 1;
    
    for i = smallest:interval:largest
        if i ~= 1
            pl = (double(image) .^ double(i)) / double(255 ^ (i-1));
            pl = uint8(pl);
            images(:,:,item) = pl;
            item = item + 1;
        end 
    end
end