function overlap = calculateOverlap(box_a, box_b, width, height)
    min_right = min(box_a(1), box_b(1)) + width;
    max_left = max(box_a(1), box_b(1));
    min_bottom = min(box_a(2), box_b(2)) + height;
    max_top = max(box_a(2), box_b(2));

    x_overlap = max(0, min_right-max_left);
    y_overlap = max(0, min_bottom-max_top);
    overlap = x_overlap * y_overlap;
end