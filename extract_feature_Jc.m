function [features] = extract_feature_Jc(skeleton_input)
[~,~,frame,body_num] = size(skeleton_input);
features = zeros(300,frame);


points = reshape(permute(skeleton_input,[2 1 3 4]),75,frame,body_num);
trans_skeleton = translate_skeleton(skeleton_input);
trans_points = reshape(permute(trans_skeleton,[2 1 3 4]),75,frame,body_num);

features(1:75,:) = points(:,:,1);
features(76:150,:) = trans_points(:,:,1);

if body_num > 1
    features(151:225,:) = points(:,:,2);
    features(226:300,:) = trans_points(:,:,2);   
else
    features(151:225,:) = points(:,:,1);
    features(226:300,:) = trans_points(:,:,1); 
end

end