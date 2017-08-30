%linear transform
%specifically for JJo which has 3 dimensional features
function image_output = transform_method1(features,img_size)

features = imresize(features,img_size,'bilinear');

min_value = min(features,[],2);
range = max(features,[],2) - min_value;

image_output = (features- min_value)./range;


end