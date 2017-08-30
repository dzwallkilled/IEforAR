%specifically for Features like JLd and LLa which have many dimensions,
%which could be mapped into three channels of RGB
function image_output = transform_method3(features,img_size)
dim = size(features,1);
features = imresize(features,[dim img_size(2)],'bilinear');
main_feature = features(:,:,1);
min_value = min(main_feature,[],2);
range = max(main_feature - min_value,[],2);
main_feature = (main_feature - min_value)./range;

image = reshape(main_feature,dim/3,3,img_size(2));
image = permute(image,[1 3 2]);

image_output = imresize(image,img_size,'bilinear');

end
