function cutouts=getCutouts(I, cutout_height, cutout_width)
    [height, width] = size(I);
    columns = width-cutout_width;
    rows = height-cutout_height;
    total_cutouts = uint16(columns * rows);
    cutouts = uint8(zeros(cutout_height, cutout_width, total_cutouts));
    counter = 1;

    for i=1:rows
        for j=1:columns
            cutout = I(i:i+cutout_height-1,j:j+cutout_width-1);
            cutouts(:,:,counter) = cutout;
            counter = counter + 1;
        end
    end
end