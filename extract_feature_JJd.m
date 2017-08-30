function features = extract_feature_JJd(skeleton_input)

% index = get_JJd_index01;
% index = get_JJd_index02;
% index = get_JJd_index03;
index = get_JJd_index04;

joints = skeleton_input;
vec = joints(index(:,2),:,:,:) - joints(index(:,1),:,:,:);

features = squeeze(sum(vec.^2,2).^(1/2));
end


function index = get_JJd_index01
%
index = zeros(300,2);
n = 0;
for i = 1:24
    for j = i+1:25
        n = n + 1;
        index(n,:) = [i j];
    end
end

end


function index = get_JJd_index02
%
index = zeros(300,2);
n = 0;
for i = 1:24
    for j = i+1:25
        n = n + 1;
        index(n,:) = [i j];
    end
end

connected = [
    %remove directly connected
    1 2;
    1 13;
    1 17;
    2 21;
    3 4;
    3 21;
    5 6;
    5 21;
    6 7;
    7 8;
    8 22;
    8 23;
    9 10;
    9 21;
    10 11;
    11 12;
    12 24;
    12 25;
    13 14;
    14 15;
    15 16;
    17 18;
    18 19;
    19 20
    ];
con_index = zeros(length(connected),1);
for i = 1:length(connected)
    idx = index == connected(i,:);
    con_index(i) = find(idx(:,1) ==1 &idx(:,2)==1);
end
index(con_index,:) = [];

end


%16 joints
function index = get_JJd_index03

joint_num = [1 4 6 7 8 10 11 12 14 15 18 19 22 23 24 25];
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

%16 joints
function index = get_JJd_index04

joint_num = [1 4 5 7 8 9 11 12 14 15 16 18 19 20 24 25];
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

%12 joints
function index = get_JJd_index05

joint_num = [2 4 5 7 9 11 13 15 17 19 22 24];
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

%11 joints
function index = get_JJd_index06

joint_num = [1 4 6 8 10 12 14 16 18 20 21];
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

