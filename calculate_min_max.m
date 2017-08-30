% clear
% clc
% close
% 
% 
% data_folder = './nturgb+d_skeletons/';
% load skeleton_file_list.mat %for convenience, the skeleton_file_list is saved and loaded when using
% 
% 
% min_value = [];
% max_value = [];
% flags = [1; 0; 0];
% for i = 1:1200 %200, 35809, 2097, 45181]
%     skeleton_data = read_skeleton_file([data_folder skeleton_file_list(i,:)]); 
%     [skeleton_data, ~] = preprocess_skeleton_data(skeleton_data); 
% %     visualize_skeleton(skeleton_data);
%     features = extract_feature_JJd(skeleton_data);
%     min_value(:,i) = min(features(:,:,1),[],2);
%     max_value(:,i) = max(features(:,:,1),[],2);
% end


% avg_min = mean(min_value,2);
% avg_max = mean(max_value,2);
% min_value = min(min_value,[],2);
% max_value = max(max_value,[],2);
% JJd.avg_min = avg_min;
% JJd.max = max_value;
% JJd.min = min_value;
% JJd.avg_max = avg_max;

JJd.avg_min = imresize(JJd.avg_min,[256 1],'bilinear');
JJd.avg_max = imresize(JJd.avg_max,[256 1],'bilinear');
JJd.min = imresize(JJd.min,[256 1],'bilinear');
JJd.max = imresize(JJd.max,[256 1],'bilinear');

save('Colormap_Params.mat','JJd','-v7.3');