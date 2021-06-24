I = imread("images\face\1.png");

subplot(2,4,1);
imshow(uint8(I));
title("Original");

[~,hogVisualization] = extractHOGFeatures(I);
subplot(2,4,3);
imshow(I); 
hold on;
plot(hogVisualization);
hold off;
title("HOG");

% vertical edges
mask1 = [-1 0 1; -1 0 1; -1 0 1]; 
% horizontal edges
mask2 = [-1 -1 -1; 0 0 0; 1 1 1];
Ihor = conv2(I, mask1);
Iver = conv2(I, mask2);
edge = sqrt(Iver.^2+Ihor.^2); 

subplot(2,4,5); 
imshow(uint8(Ihor));
title("Horizontal edges");

subplot(2,4,6); 
imshow(uint8(Iver));
title("Vertical edges");

subplot(2,4,7); 
imshow(uint8(edge));
title("Edges");

edge = edge(2:size(edge,1)-1,2:size(edge,2)-1);
for i=1:size(edge,1)
    for j=1:size(edge,2)
        if edge(i,j) > 150
            I(i,j) = 255;
        end
    end
end
subplot(2,4,8); 
imshow(uint8(I));
title("Edge extraction");

