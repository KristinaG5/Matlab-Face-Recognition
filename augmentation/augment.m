function images = augment(I)
    I = uint8(I);
    height = 27;
    width = 18;
    half_width = uint8(width/2);
    half_height = uint8(height/2);

    % params
    degrees = 30;
    degree_interval = 15;
    widen_distance = half_width;
    stretch_distance = half_height;
    stretch_interval = 15;
    brightness = 100;
    brightness_interval = 100;
    pl_low = 0.5;
    pl_high = 1.5;
    pl_interval = 0.5; 
    
    % move
    rotated_images = rotate(I, degrees, degree_interval);
    widened_images = stretch(I, widen_distance, stretch_interval, false);
    stretched_images = stretch(I, stretch_distance, stretch_interval, true);
    all_moved_images = cat(3, I, rotated_images, widened_images, stretched_images);
    total_moved_images = size(all_moved_images, 3);
    
    % contrast/brighten
    total_brightened_images = 2*(brightness/brightness_interval) * total_moved_images;
    total_contrasted_images = uint8((pl_high - pl_low)/pl_interval) * total_moved_images;
    all_coloured_images = zeros(height, width, total_brightened_images + total_moved_images + total_contrasted_images);
    all_coloured_images(:,:,1:total_moved_images) = all_moved_images;
    counter = total_moved_images+1;
    for i=1:total_moved_images
        image = all_moved_images(:,:,i);
        brightened_images = brighten(image, brightness, brightness_interval);
        num_brightnened_images = size(brightened_images, 3);
        all_coloured_images(:,:,counter:counter+num_brightnened_images-1) = brightened_images;
        counter = counter + num_brightnened_images;
        
        contrasted_images = pl_contrast(image, pl_low, pl_high, pl_interval);
        num_contrasted_images = size(contrasted_images, 3);
        all_coloured_images(:,:,counter:counter+num_contrasted_images-1) = contrasted_images;
        counter = counter + num_contrasted_images;
    end
    
    % flip
    total_coloured_images = size(all_coloured_images,3);
    images = zeros(height, width, total_coloured_images * 2);
    images(:,:,1:total_coloured_images) = all_coloured_images;
    
    for i=1:total_coloured_images
        image = all_coloured_images(:,:,i);
        images(:,:,i+total_coloured_images) = flip(image,2);
    end
    
    % montage(uint8(images));
end
