function augmented = augment_folder(images)
    num_originals = length(images);
    
    counter = 1;
    for i=1:num_originals
        augmented_images = uint8(augment(images(:,:,i)));
        
        if i == 1
            augmentation_size = size(augmented_images, 3);
            augmented = uint8(zeros(27, 18, num_originals * augmentation_size));
        end
        
        for j=1:augmentation_size
            augmented(:,:, counter) = augmented_images(:,:,j);
            counter = counter + 1;
        end
    end
end