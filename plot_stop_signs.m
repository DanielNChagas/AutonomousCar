function plot_stop_signs(stop_signs,speed_limit_signs, plot)
for i=1:length(stop_signs)+length(speed_limit_signs)
    if i<=length(stop_signs)
        box = stop_signs(i).box;
        patch([box(1), box(1), box(3), box(3)], [box(2), box(4), box(4), box(2)], 'g', 'FaceAlpha', 0.3, 'Parent', plot);
    else
        box = speed_limit_signs(i-length(stop_signs)).box;
        patch([box(1), box(1), box(3), box(3)], [box(2), box(4), box(4), box(2)], 'b', 'FaceAlpha', 0.3, 'Parent', plot);
    end
end

