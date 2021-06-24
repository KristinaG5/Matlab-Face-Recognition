function images = rotate(image, degree_range, interval)
    dimensions = size(image);
    target_height = dimensions(1);
    target_width = dimensions(2);
    images = zeros(target_height, target_width, degree_range/interval);
    item = 1;
    
    for i = 1:interval:degree_range
        if i ~= 0
            rotated = imrotate(image,i);
            rotated = crop(rotated, target_height, target_width);
            images(:,:,item) = rotated;
            item = item + 1;
        end 
    end
end