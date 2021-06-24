function images = brighten(image, max_value, interval)
    dimensions = size(image);
    height = dimensions(1);
    width = dimensions(2);
    images = zeros(height, width, 2*(max_value/interval)-1);
    item = 1;
    
    for i = -max_value:interval:max_value+1
        if i ~= 0
            brightened = image + i;
            images(:,:,item) = brightened;
            item = item + 1;
        end 
    end
end