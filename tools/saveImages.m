function saveImages(directory, prefix, images)
    dimensions = size(images);
    length = dimensions(3);
    
    fprintf("%s %i\n", "Saving images: ", length);

    for i=1:length
        name = append(directory, prefix, string(i), ".png");
        imwrite(uint8(images(:,:,i)),name);
    end
end