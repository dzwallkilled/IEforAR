function image_output = transform_method6(features,img_size)
global cb;%claimed in main file
features = imresize(features,img_size,'bilinear');
[dim,frame,~] = size(features);
main_feature = features(:,:,1);
main_feature = (main_feature - min(main_feature,[],2));
color_index = ceil(256*main_feature./max(main_feature,[],2));
color_index(color_index < 1 ) = 1;
color_index(color_index > 256) = 256;
color_index(isnan(color_index) ) = 1;

temp = cb(color_index,:);
image = reshape(temp,dim,frame,3);

image_output = image;

end
