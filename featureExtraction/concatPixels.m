function out = concatPixels(image, height, width)
    out = reshape(image, [1,height*width]);
end