
function image_output = transform_method9(features,img_size)
global cb;%claimed in main file
features = imresize(features,img_size,'bilinear');
[dim,frame,~] = size(features);

color_index = ones(dim,frame);
for f = 1:frame
    min_value = min(features(:,1:f,1),[],2);
    range = max(features(:,1:f,1)-min_value,[],2);
    color_index(:,f) = ceil(256*(features(:,f,1)-min_value)./range);
    
end

color_index(color_index < 1 ) = 1;
color_index(color_index > 256) = 256;        
color_index(isnan(color_index) ) = 1;

temp = cb(color_index,:);
image = reshape(temp,dim,frame,3);

image_output = image;

end
