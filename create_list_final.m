
load skeleton_file_list.mat
labels = str2num(skeleton_file_list(:,18:20));
target_folder = './lists3/';
mkdir(target_folder);

train_fid = fopen([target_folder 'train.txt'],'w');
for i = 1:length(skeleton_file_list)
   fprintf(train_fid, [skeleton_file_list(i,17:20) '/' skeleton_file_list(i,1:20) '.jpg']);
   fprintf(train_fid, ' %d\n', labels(i)-1); 
end
fclose(train_fid);


val_fid = fopen([target_folder 'val.txt'],'w');
idx = randperm(length(skeleton_file_list));
for i = idx(1:length(skeleton_file_list)/5)
   fprintf(val_fid, [skeleton_file_list(i,17:20) '/' skeleton_file_list(i,1:20) '.jpg']);
            fprintf(val_fid, ' %d\n', labels(i)-1);
end
fclose(val_fid);


test_fid = fopen([target_folder 'test.txt'],'w');
test_list = dir('./AllSkeletonFiles_remove_nan_nolabel/');
test_list = test_list(3:end,:);
for i = 1:length(test_list)
   fprintf(test_fid, ['test/' test_list(i).name(1:6) '.jpg']);
   fprintf(test_fid, ' %d\n', 0);
end
fclose(test_fid);
