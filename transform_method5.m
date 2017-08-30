
%3 channels for JJd, JLd, LLa
%part of the method is implemented in the begin of this file, i.e. in
% the file-name function
function image_output = transform_method5(features,img_size)

features = imresize(features, img_size,'bilinear');

min_value = min(features,[],2);
range = max(features,[],2) - min_value;
image_output = (features - min_value)./range;

end
