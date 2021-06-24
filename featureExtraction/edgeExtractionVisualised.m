I = imread("images\face\1.png");

mask1 = [-1 0 1; -1 0 1; -1 0 1]; 
mask2 = [-1 -1 -1; 0 0 0; 1 1 1];

Iver = conv2(I, mask1);
subplot(1,4,1);
imshow(uint8(Iver));
title("Horizontal");

Ihor = conv2(I, mask2);
subplot(1,4,2);
imshow(uint8(Ihor));
title("Vertical");
    
edge = edgeExtraction(I);
edge = edge(2:size(edge,1)-1,2:size(edge,2)-1);

subplot(1,4,3); 
imshow(uint8(edge));
title("Edges");

for i=1:size(edge,1)
    for j=1:size(edge,2)
        if edge(i,j) > 150
            I(i,j) = 255;
        end
    end
end
subplot(1,4,4); 
imshow(uint8(I));
title("Overlaid");