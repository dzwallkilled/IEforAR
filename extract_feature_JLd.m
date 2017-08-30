function [features] = extract_feature_JLd(skeleton_input)

index = get_JLd_index01;
% index = get_JLd_index02;
% index = get_JLd_index03;
pts1 = skeleton_input(index(:,1),:,:,:);
pts2 = skeleton_input(index(:,2),:,:,:);
pts3 = skeleton_input(index(:,3),:,:,:);
features = squeeze((sum(cross(pts2-pts1,pts3-pts1,2).^2,2).^(1/2))./(sum((pts3-pts2).^2,2).^(1/2)));

end

function index = get_JLd_index01
line_index = get_line_index01;
len_line = length(line_index);
index = zeros(897,3); %[J, (J1,J2)]
cnt = 0;
for i = 1:25
    for j = 1:len_line
        if i ~= line_index(j,1) && i ~= line_index(j,2)
            cnt = cnt + 1;
            index(cnt,:) = [i line_index(j,:)];
        end
    end
end

end

function index = get_JLd_index02
line_index = get_line_index01;
neib_index = get_neighbour_index;
len_line = length(line_index);
index = [];
cnt = 0;
for i = 1:len_line
    neib_joints = [neib_index(line_index(i,1)).neib neib_index(line_index(i,2)).neib];
    neib_joints = unique(neib_joints);
    neib_joints(neib_joints== line_index(i,1) | neib_joints== line_index(i,2)) = [];
    for j = neib_joints
        cnt = cnt + 1;
        index(cnt,:) = [j line_index(i,:)];        
    end
end
end

function index = get_JLd_index03
joints = [3 4 5 6 7 8 9 10 11 12 13 14 15 17 18 19];
nb_index = get_neighbour_index;

line_index_temp = [];
for j = joints
   nb_joints = [nb_index(j).neib]';
   line_temp = [repmat(j,length(nb_joints),1) nb_joints];
   line_index_temp = [line_index_temp;line_temp];    
end
line_index(:,1) = min(line_index_temp,[],2);
line_index(:,2) = max(line_index_temp,[],2);
[~,I] = sort(line_index(:,1));
line_index = line_index(I,:);
line_index = unique(line_index,'rows');

len_line = length(line_index);
index=[];
cnt = 1;
for i = 1:len_line
    nb_joints = [nb_index(line_index(i,1)).neib nb_index(line_index(i,2)).neib]';
    nb_joints = unique(nb_joints);
    nb_joints(nb_joints== line_index(i,1) | nb_joints== line_index(i,2)) = [];

    len = length(nb_joints);
    index(cnt:cnt+len-1,:) = [nb_joints repmat(line_index(i,:),len,1)];
    cnt = cnt+len;
end
end

function index = get_line_index01
%case 1: directly adjacent (calculated from 1 to 25, deep first)
index = [1 2;
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
    19 20;
    %case 2: J1 at end, J2 two steps away (End:4,8,12,15,19)
    4 21;
    8 5;
    12 9;
    15 13;
    19 17;
    %case 3: J1 and J2 are at end (End:4,8,12,15,19)
    4 8;
    4 12;
    4 15;
    4 19;
    8 12;
    8 15;
    8 19;
    12 15;
    12 19;
    15 19];
end

function index = get_line_index02
%case 1: directly adjacent (calculated from 1 to 25, deep first)
index = [1 2;
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
    19 20;
    %case 2: J1 at end, J2 two steps away (End:4,8,12,15,19)
    4 21;
    8 5;
    12 9;
    15 13;
    19 17;
    %case 3: J1 and J2 are at end (End:4,8,12,15,19)
    4 8;
    4 12;
    4 15;
    4 19;
    8 12;
    8 15;
    8 19;
    12 15;
    12 19;
    15 19
    %case 4: two steps away at four body ends
    5 7;
    6 8;
    9 11;
    10 12;
    13 16;
    17 20
    ];
end


function index = get_neighbour_index
index = [];
index(1).neib =  [2 13 14 17 18 21];
index(2).neib =  [1 3 5 9 13 17 21];
index(3).neib =  [2 4 5 9 21];
index(4).neib =  [3 21];
index(5).neib =  [2 3 6 7 9 21];
index(6).neib =  [5 7 8 21];
index(7).neib =  [5 6 8 22 23];
index(8).neib =  [6 7 22 23];
index(9).neib =  [2 3 5 10 11 21];
index(10).neib =  [9 11 12 21];
index(11).neib =  [9 10 12 24 25];
index(12).neib =  [10 11 24 25];
index(13).neib =  [1 2 14 15 17];
index(14).neib =  [1 13 15 16];
index(15).neib =  [13 14 16];
index(16).neib =  [14 15];
index(17).neib =  [1 2 13 18 19];
index(18).neib =  [1 17 19 20];
index(19).neib =  [17 18 20];
index(20).neib =  [18 19];
index(21).neib =  [1 2 3 4 5 6 9 10];
index(22).neib =  [7 8 23];
index(23).neib =  [7 8 22];
index(24).neib =  [11 12 25];
index(25).neib =  [11 12 24];


end
