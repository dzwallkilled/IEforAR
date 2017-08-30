
%temporal information included
%active function
function image_output = transform_method8(features)
global cb;%claimed in main file

[dim,frame,~] = size(features);
main_feature = features(:,:,1);
min_value = min(main_feature(:));
range = max(main_feature(:)) - min_value;
% f = (main_feature - min_value)./range;
alpha = 50;
f = atan(alpha*(main_feature - min_value)./range - alpha/2)/2/atan(alpha/2) + 1/2;
color_index = ceil(256*f);
color_index(color_index == 0 ) = 1;
color_index(isnan(color_index) ) = 1;

temp = cb(color_index,:);
image = reshape(temp,dim,frame,3);

image_output = image;

end
