function image = crop(original_image, target_height, target_width)
    dimensions = size(original_image);
    half_height = uint8(dimensions(1)/2);
    half_width = uint8(dimensions(2)/2);
    
    top = uint8(target_height/2)-1;
    bottom = top;
    left = uint8(target_width/2)-1;
    right = left;
    if right*2 < target_width-1
        right = right + 1;
    end
    if bottom*2 < target_height-1
        bottom = bottom + 1;
    end
    
    image = original_image(half_height-top:half_height+bottom,half_width-left:half_width+right);
end