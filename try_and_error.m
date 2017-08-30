clc
clear
close all

data_folder = './nturgb+d_skeletons/';
load skeleton_file_list.mat %for convenience, the skeleton_file_list is saved and loaded when using

global cb
cb = get_colorbar(256);

tic
%% read list
% skeleton_file_list = get_skeleton_list(data_folder);

%%%for convenience, the skeleton_file_list is saved and loaded when using
% save skeleton_file_list.mat skeleton_file_list

%% try and error
disp('try and error processing')
len = length(skeleton_file_list);
mkdir('./Images/try_and_error/');
for i = 1:120 %200, 35809, 2097, 45181]
    skeleton_data = read_skeleton_file([data_folder skeleton_file_list(i,17:20) '/' skeleton_file_list(i,:)]);
    [skeleton_data, body_num] = preprocess_skeleton_data(skeleton_data); 
%     visualize_skeleton(skeleton_data);

    features = extract_feature_JLd01(skeleton_data);    
    [image] = transform_method6(features,[256 256]);
    imwrite(image, ['./Images/try_and_error/' skeleton_file_list(i,1:20) '.jpg']);
end

disp('try and error finished');

%% create train and test lists
% % Last time run at 3:20PM 22/03/2017
% target_folder = './lists2/';
% [cross_sub_V2Tr1Te0_index, cross_view_V2Tr1Te0_index] = create_list(skeleton_file_list,target_folder);
% save index.mat cross_sub_V2Tr1Te0_index cross_view_V2Tr1Te0_index

%%






