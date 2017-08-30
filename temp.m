
data_folder = './nturgb+d_skeletons/';
load skeleton_file_list.mat %for convenience, the skeleton_file_list is saved and loaded when using
len = length(skeleton_file_list);

for i = 1:60
   sub_folders = ['A0' num2str(floor(i/10)) num2str(mod(i,10)) '/']; 
   mkdir([data_folder sub_folders]);
end

for i =1:len
    i
   movefile([data_folder skeleton_file_list(i,:)],[data_folder skeleton_file_list(i,17:20) '/']);
    
end


