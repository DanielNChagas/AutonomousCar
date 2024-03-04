function inside_index = inside_stop_sign_box(x, y, stop_signs)
%INSIDE_STOP_SIGN_BOX Summary of this function goes here
%   Returns 0 if not inside any

inside_index = 0;
%check if it's inside a stop_sign
for i=1:length(stop_signs)
    inside_box = x >= stop_signs(i).box(1) && x <= stop_signs(i).box(3) && y >= stop_signs(i).box(2) && y <= stop_signs(i).box(4);
    if inside_box
        inside_index = i;
        break;
    end
end

end

