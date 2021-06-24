function images = cropping(image, window_height, window_width)
    dimensions = size(image);
    height = dimensions(1);
    width = dimensions(2);
    images = zeros(height, width, (height-window_height)*(width-window_width));
    item = 1;
    
    for i = 1:height-window_height
        for j = 1:width-window_width
            cropped = image(i:i+window_height,j:j+window_width);
            cropped = pad(cropped, height, width);
            images(:,:,item) = cropped;
            item = item + 1;
        end 
    end
end