function showBoxes(I, boxes, cutout_width, cutout_height, show_scores)
    imshow(I);
    hold on;

    for i=1:size(boxes,1)
        box = boxes(i,:);
        if box ~= [0,0,0]
            rectangle('Position',[box(1), box(2), cutout_width, cutout_height],'Edgecolor', 'g');
            if show_scores
                text(box(1), box(2)+5, num2str(box(3)), 'FontSize', 8, 'Color', 'r');
            end
        end
    end
    
    hold off;
end