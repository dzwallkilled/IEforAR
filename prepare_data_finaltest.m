clc
clear
close all
tic

branch = 'ComT05';

global cb
cb = get_colorbar(256);
image_folder = ['./Images/' branch '/test/'];
mkdir(image_folder);
data_folder = './AllSkeletonFiles_remove_nan_nolabel/';

list = dir(data_folder);
list = list(3:end);
len_list = length(list);
disp([branch ' processing'])
h = waitbar(0,'1','name',branch,'CreateCancelBtn','close(h)');
set(h,'CloseRequestFcn','closereq');
for i = 1:len_list
   skeleton_data = read_skeleton_file([data_folder list(i).name]);
    [skeleton_data, ~] = preprocess_skeleton_data(skeleton_data); 
    features = extract_feature_com(skeleton_data);
    [image] = transform_method5(features,[256 256]);
    
    imwrite(image,[image_folder list(i).name(1:6) '.jpg']);
    
    waitbar(i/len_list,h,['Processed: ' num2str(i) '/' num2str(len_list) ' Time (s): ' num2str(toc)]);
    
    
    
end

close(h)
disp([branch ' finished']);










