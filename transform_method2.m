
%linear transform (modified from method1 which has some problems)
function image_output = transform_method2(features,img_size)
features = imresize(features,img_size);

[dim,frame,body_num] = size(features);
image_output = zeros(dim,frame,3);

min_value = min(features,[],2);
range = max(features,[],2) - min_value;

image_output(:,:,1) = (features(:,:,1)- repmat(min_value(:,1),1,frame))./repmat(range(:,1),1,frame);

if body_num == 1
    image_output(:,:,2) = 1-image_output(:,:,1);%one body
else
    image_output(:,:,2) = (features(:,:,2)-repmat(min_value(:,2),1,frame))./repmat(range(:,2),1,frame);%two bodies
end

image_output(:,:,3) = 4*image_output(:,:,2) .* image_output(:,:,1);


end