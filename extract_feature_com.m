function features = extract_feature_com(skeleton_input)

feature_JJd = extract_feature_JJd(skeleton_input);
feature_JLd = extract_feature_JLd(skeleton_input);
feature_LLa = extract_feature_LLa(skeleton_input);

features = zeros(256,256,3);

features(:,:,1) = imresize(feature_JJd(:,:,1),[256 256],'bilinear');
features(:,:,2) = imresize(feature_JLd(:,:,1),[256 256],'bilinear');
features(:,:,3) = imresize(feature_LLa(:,:,1),[256 256],'bilinear');



end