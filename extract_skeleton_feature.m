%the codes have been optimised for speed
function features = extract_skeleton_feature(skeleton_input, flags)

%Joint Joint Distances (JJd)
if flags(1) == 1
    features.JJd = calculate_JJd(skeleton_input);
end

%Joint Line Distances (JLd)
if flags(2) == 1
    features.JLd = calculate_JLd(skeleton_input);
end

%Line Line Angle (LLa)
if flags(3) == 1
    features.LLa = calculate_LLa(skeleton_input);
end

end



