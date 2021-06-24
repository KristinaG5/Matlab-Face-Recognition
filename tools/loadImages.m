function images = loadImages(directory, augment)
    files = dir(directory);
    images = zeros(27, 18, length(files)-2);
    for i = 3:length(files)
        path = append(directory, files(i).name);
        images(:,:,i-2) = imread(path);
    end
    
    if augment
        images = augment_folder(images);
    end
end