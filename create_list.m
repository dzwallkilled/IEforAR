% train and test list for two evaluations
% cross subject and cross view
function [cross_sub_V2Tr1Te0_index, cross_view_V2Tr1Te0_index] = create_list(skeleton_file_list, target_folder)
mkdir(target_folder);
labels = str2num(skeleton_file_list(:,18:20));

%% cross subject training and test list
performer_list = str2num(skeleton_file_list(:,10:12));

training_subjects = [1 2 4 5 8 9 13 14 15 16 17 18 19 25 27 28 31 34 35 38]';
train_index = zeros(length(performer_list),1);
for i = 1:length(training_subjects)
    train_index = train_index | (performer_list == training_subjects(i));
end

val_subjects = [2 4 9 14 17 19 25 28 34 38]';
val_index = zeros(length(performer_list),1);
for i = 1:length(val_subjects)
    val_index = val_index | (performer_list == val_subjects(i));
end

index = train_index + val_index; % 2 for val, 1 for train, 0 for test
print_list(skeleton_file_list, labels, index, [target_folder 'cross_subject/']);

cross_sub_V2Tr1Te0_index = index;
%% cross view training and test list
camera_list = str2num(skeleton_file_list(:,6:8));

training_cameras = [2 3]';
train_index = zeros(length(camera_list),1);
for i = 1:length(training_cameras)
    train_index = train_index | (camera_list == training_cameras(i));
end

train_index_list = find(train_index == 1);
val_index = zeros(length(train_index),1);
temp = randperm(length(train_index_list));
val_index(train_index_list(temp(1:length(train_index_list)/2))) = 1;
index = train_index + val_index;

print_list(skeleton_file_list,labels, index, [target_folder 'cross_view/']);

cross_view_V2Tr1Te0_index = index;
%%

disp('Cross_subject & Cross_view lists created.')
end



function print_list(skeleton_file_list, labels, index, target_folder)

mkdir(target_folder);
train_fid = fopen([target_folder 'train.txt'],'w');
val_fid = fopen([target_folder 'val.txt'],'w');
test_fid = fopen([target_folder 'test.txt'],'w');

for i = 1:length(skeleton_file_list)
    if index(i) ~= 0
        %train 1
        fprintf(train_fid, [skeleton_file_list(i,17:20) '/' skeleton_file_list(i,1:20) '.jpg']);
        fprintf(train_fid, ' %d\n', labels(i)-1);
        if index(i) == 2% val 2
            fprintf(val_fid, [skeleton_file_list(i,17:20) '/' skeleton_file_list(i,1:20) '.jpg']);
            fprintf(val_fid, ' %d\n', labels(i)-1);
        end
    else %test 0
        fprintf(test_fid, [skeleton_file_list(i,17:20) '/' skeleton_file_list(i,1:20) '.jpg']);
        fprintf(test_fid, ' %d\n', labels(i)-1);        
    end
end


fclose(train_fid);
fclose(val_fid);
fclose(test_fid);
end