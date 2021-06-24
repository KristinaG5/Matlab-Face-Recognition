function score=scoreBoxes(boxes, boxes_weighting)
    scores = [];
    num_boxes = 0;
    for i=1:size(boxes,1)
        box = boxes(i,:);
        if box ~= [0,0,0]
            scores = [scores, box(3)];
            num_boxes = num_boxes + 1;
        end
    end
    score = mean(scores) * (num_boxes * boxes_weighting);
end