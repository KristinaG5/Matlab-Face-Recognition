function images = translation(image, max_vertical, max_horizontal)
    max_vertical = int8(max_vertical);
    max_horizontal = int8(max_horizontal);
    dimensions = size(image);
    height = dimensions(1);
    width = dimensions(2);
    images = zeros(height, width, (max_vertical * max_horizontal * 2) -1);
    item = 1;
    
    for i = -max_vertical:max_vertical
        for j = -max_horizontal:max_horizontal
            if i ~= 0 && j ~= 0
                translated = imtranslate(image,[j, i]);
                images(:,:,item) = translated;
                item = item + 1;
            end
        end
    end
end