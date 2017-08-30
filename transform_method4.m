
function image_output = transform_method4(features)
global cb;%claimed in main file

[dim,frame,body_num] = size(features);

new_features = zeros(2*dim,frame);
new_features(1:2:end,:) = features(:,:,1);
if body_num == 1
    new_features(2:2:end,:) = features(:,:,1);
else
    new_features(2:2:end,:) = features(:,:,2);
end

min_value = min(new_features,[],2)/1;
range = max(new_features,[],2) - min_value;
color_index = ceil(256*(new_features - min_value)./range);
color_index(color_index == 0 ) = 1;
color_index(isnan(color_index) ) = 1;

temp = cb(color_index,:);
image_output = reshape(temp,2*dim,frame,3);

end
