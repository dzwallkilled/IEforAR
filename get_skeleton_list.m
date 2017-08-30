function skeleton_file_list = get_skeleton_list(data_folder)

list = ls(data_folder);
skeleton_file_list = list(3:end,:);

missing_list_file = './samples_with_missing_skeletons.txt';
fid = fopen(missing_list_file);
if fid < 0
    disp(' Samples with missing skeletons txt file read failed.')
    return
else    
    while ~feof(fid)
        line = fgets(fid); %# read line by line
        for i = 1:length(skeleton_file_list) %delete the file in the list which has missing skeletons
            if strcmp(skeleton_file_list(i,1:20),line(1:20))
                skeleton_file_list(i,:)=[];
                break;
            end            
        end
    end
end
