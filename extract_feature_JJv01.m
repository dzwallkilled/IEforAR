function features = extract_feature_JJv01(skeleton_input)
[joint_num,cor_dim,frame,body_num] = size(skeleton_input);

% index = get_JJo_index01;
index = get_JJo_index02;

joints = zeros(2*joint_num,cor_dim,frame);
joints(1:joint_num,:,:) = skeleton_input(:,:,:,1);
if body_num == 1
    joints(joint_num+1:end,:,:) = skeleton_input(:,:,:,1);
else
    joints(joint_num+1:end,:,:) =  skeleton_input(:,:,:,2);
end
vec = joints(index(:,2),:,:,1) - joints(index(:,1),:,:,1);

features = vec;
features = permute(features,[1 3 2]);
end


%12 joints, two bodies
function index = get_JJo_index01

joint_num = [2 4 5 7 9 11 13 15 17 19 22 24];
joint_num = [joint_num 25+joint_num];
len = length(joint_num);
index = zeros(len*(len-1)/2,2);
n = 0;
for i = 1:len-1
    for j = i+1:len
        n = n + 1;
        index(n,:) = [joint_num(i) joint_num(j)];
    end
end

end

%11 joints, two bodies
function index = get_JJo_index02

joint_num = [1 4 6 8 10 12 14 16 18 20 21];
joint_num = [joint_num 25+joint_num];
len = length(joint_num);
index = zeros(len*(len-1)/2,2);
n = 0;
for i = 1:len-1
    for j = i+1:len
        n = n + 1;
        index(n,:) = [joint_num(i) joint_num(j)];
    end
end

end


