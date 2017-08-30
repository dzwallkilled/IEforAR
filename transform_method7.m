
%temporal information included
function image_output = transform_method7(features)
[dim,frame,~] = size(features);
image = zeros(dim,frame,3);

feature_main = features(:,:,1);
min_value = min(feature_main,[],2);
range = max(feature_main,[],2) - min_value;
image(:,:,1) = ((feature_main - min_value)./range);

velocity = feature_main(:,2:end) - feature_main(:,1:end-1);
temp2 = abs(velocity);
min_value = min(temp2,[],2);
range = max(temp2,[],2) - min_value;
image(:,:,2) = [zeros(dim,1) ((temp2 - min_value)./range).^(1/2)];
% 
acceleration = velocity(:,2:end,1) - velocity(:,1:end-1,1);
temp3 = abs(acceleration);
min_value = min(temp3,[],2);
range = max(temp3,[],2) - min_value;
image(:,:,3) = [zeros(dim,2) ((temp3 - min_value)./range).^(1/2)];

% if body_num > 1 %more than one body
%     feature_second = features(:,:,1);
%     min_value = min(feature_second,[],2);
%     range = max(feature_second,[],2) - min_value;
%     image(:,:,1) = (0.9*image(:,:,1) + 0.1*((feature_second - min_value)./range));
% end

image_output = image;

end
