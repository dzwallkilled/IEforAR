
function [features] = extract_feature_LLa(skeleton_input)
index = get_LLa_index01;
lines1 = skeleton_input(index(:,2),:,:,:) - skeleton_input(index(:,1),:,:,:);
lines2 = skeleton_input(index(:,4),:,:,:) - skeleton_input(index(:,3),:,:,:);
features = squeeze(acos(dot(lines1,lines2,2) ...\
            ./(sum(lines1.^2,2).^(1/2)) ...\
            ./(sum(lines2.^2,2).^(1/2))));%use matrix calculation for efficiency

end


function index_out = get_LLa_index01
index = get_line_index01;
index_out = zeros(741,4);
n = 0;
for i = 1:38
    for j = i+1:39
        n = n + 1;
        index_out(n,:) = [index(i,1) index(i,2) index(j,1) index(j,2)];
    end
end

end


function index = get_line_index01
%case 1: directly adjacent (calculated from 1 to 25, deep first)
index = [1 2;
    1 17;
    1 13;
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
    %case 2: J1 at end, J2 two steps away (End:4,7,11,15,19)
    4 21;
    7 5;
    11 9;
    15 13;
    19 17;
    %case 3: J1 and J2 are at end (End:4,7,11,15,19)
    4 7;
    4 11;
    4 15;
    4 19;
    7 11;
    7 15;
    7 19;
    11 15;
    11 19;
    15 19];
end
