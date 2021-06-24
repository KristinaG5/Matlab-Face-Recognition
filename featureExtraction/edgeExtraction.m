function out = edgeExtraction(image)
    % vertical edges
    mask1 = [-1 0 1; -1 0 1; -1 0 1]; 
    % horizontal edges
    mask2 = [-1 -1 -1; 0 0 0; 1 1 1];

    Ihor = conv2(image, mask1);
    Iver = conv2(image, mask2);
    
    out = Iver.^2+Ihor.^2;
    out = sqrt(out); 
end

