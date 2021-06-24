function image = pad(original_image, target_height, target_width)
    dimensions = size(original_image);
    original_height = dimensions(1);
    original_width = dimensions(2);
    half_target_height = uint8(target_height/2);
    half_target_width = uint8(target_width/2);
    
    top = uint8(original_height/2)-1;
    bottom = top;
    left = uint8(original_width/2)-1;
    right = left;
    if right*2 < original_width-1
        right = right + 1;
    end
    if bottom*2 < original_height-1
        bottom = bottom + 1;
    end
    
    image = zeros(target_height, target_width);
    image(half_target_height-top:half_target_height+bottom, half_target_width-left:half_target_width+right) = original_image;
end