clc
clear
close all
tic

%Open multi matlab apps to parallel run the preprocessing
% Thread = 1, 2, 3, 4, 5, 6
% each thread processes 10,000 samples in parallel
Thread = 6; 
image_folder = './Images/ComT05/'; % the folder to store result images
global cb % colorbar
cb = get_colorbar(256); 


data_folder = './nturgb+d_skeletons/'; % the folder of skeleton data
% for convenience, the skeleton_file_list has been saved into mat
% and is loaded when using
load skeleton_file_list.mat 
len = length(skeleton_file_list);

% for storage stablility consideration, the folder is divided into 60
% subfolders corresponding with number of classes
% 
% ./nturgb+d_skeletons/
%    A001/ S001C001P001R001A001.skeleton ...
%    A002/ S001C001P001R001A002.skeleton ...
%    ...
%    A060/ *
   
for i = 1:60
   sub_img_folder = ['A0' num2str(floor(i/10)) num2str(mod(i,10)) '/']; 
   mkdir([image_folder sub_img_folder]);
end


%% setup the display messages
% for each thread, there is a message displayed
num1 = [];
for t = 1:5
    num1(t).n = (t-1)*10000+1:t*10000;
end
num1(6).n = 50001:len; 
msg1 = ['00001:10000';'10001:20000';'20001:30000';'30001:40000';'40001:50000';['50001:' num2str(len)]];
msg2 = ['/10000';'/20000';'/30000';'/40000';'/50000';['/' num2str(len)]];
disp([msg1(Thread,:) ' processing'])
h = waitbar(0,'1','name',['Thread' num2str(Thread) ' ' msg1(Thread,:)],'CreateCancelBtn','close(h)');
set(h,'CloseRequestFcn','closereq');

%% do the image encoding
for i = num1(Thread).n
    %read the skeleton data using the provided code along with the dataset
    skeleton_data = read_skeleton_file([data_folder skeleton_file_list(i,17:20) '/' skeleton_file_list(i,:)]);
    % do some preprocessing to the skeleton data
    % including normalization and dimension tranpose
    [skeleton_data, ~] = preprocess_skeleton_data(skeleton_data); 
    % extract the features
    features = extract_feature_com(skeleton_data);
    % encode the features into color images
    [image] = transform_method5(features,[256 256]);
    % save the images
    imwrite(image,[image_folder skeleton_file_list(i,17:20) '/' skeleton_file_list(i,1:20) '.jpg']);
    
    waitbar((i-num1(Thread).n(1)+1)/length(num1(Thread).n),h,['Processed: ' num2str(i) msg2(Thread,:)  '  Time (s): ' num2str(toc)]);
end

close(h)
disp([msg1(Thread,:) ' finished']);








