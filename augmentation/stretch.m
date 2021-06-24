function images = stretch(image, distance, interval, vertical)
    dimensions = size(image);
    target_height = dimensions(1);
    target_width = dimensions(2);
    
    if vertical
        smallest = target_height - distance;
        largest = target_height + distance;
    else
        smallest = target_width - distance;
        largest = target_width + distance;
    end
    
    images = zeros(target_height, target_width, (largest-smallest)/interval -2);
    item = 1;
    
    for i = smallest:interval:largest
        if i ~= target_width
                       
            if vertical  
                stretched = imresize(image, [i target_width]);
            else
                stretched = imresize(image, [target_height i]);
            end
            
            if (vertical && i < target_height) || (~vertical && i < target_width)
                stretched = pad(stretched, target_height, target_width);
            else
                stretched = crop(stretched, target_height, target_width);
            end
            
            images(:,:,item) = stretched;
            item = item + 1;
        end 
    end
end