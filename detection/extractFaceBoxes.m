function boxes = extractFaceBoxes(predictions, columns, min_confidence, max_overlap, width, height)
    boxes = [];

    for i=1:length(predictions)
        score = predictions(i);
        % check confidence
        if score >= min_confidence
            row = floor(i / columns);
            column = rem(i, columns);
            box = [column, row, score];
            total_boxes = size(boxes, 1);
            add_to_list = true;
            % check overlap
            if total_boxes > 0
                for j=1:total_boxes
                    other_box = boxes(j,:,:);
                    overlap = calculateOverlap(box, other_box, width, height);
                    if overlap > max_overlap
                        if other_box(3) >= score
                            add_to_list = false;
                            break;
                        else
                            boxes(j, :, :) = [0,0,0];
                        end
                    end
                end
            end
            if add_to_list 
                boxes = [boxes; box];
            end
        end
    end
end