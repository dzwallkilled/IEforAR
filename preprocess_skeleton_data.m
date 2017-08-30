function [skeleton_output, body_num] = preprocess_skeleton_data(skeleton_input)

%align the skeleton data according to body_ID
%meanwhile normalizing the joint xyz corrdinates based on chain distances
[skeleton_output, body_cnt] = enhance_skeleton(skeleton_input);
% visualize_skeleton(skeleton_output);
%translate (actually there is no need for JLd, JJd and LLa, which are relative features)
% skeleton_output = translate_skeleton(skeleton_output);

%select a main body
[skeleton_output,body_num] = select_main_body(skeleton_output,body_cnt);

end


% if spread X /spread Y is larger than 0.8, then dismissed
% method from 'NTU RGB+D: A Large Scale Dataset for 3D Human Activity Analysis'
function [skeleton_output,body_num] = select_main_body(skeleton_input,body_cnt)
body_num = size(skeleton_input,4);

if body_num > 1
    skeleton_tran = translate_skeleton(skeleton_input);
    spread = max(skeleton_tran,[],1)-min(skeleton_tran,[],1);
    ratio = squeeze(spread(1,1,:,:)./spread(1,2,:,:));
    ratio(isnan(ratio)) = 0;
    avg_ratio1 = sum(ratio)./body_cnt';
    spread = max(skeleton_input,[],1)-min(skeleton_input,[],1);
    ratio = squeeze(spread(1,1,:,:)./spread(1,2,:,:));
    ratio(isnan(ratio)) = 0;
    avg_ratio2 = sum(ratio)./body_cnt';
    avg_ratio = (avg_ratio1+avg_ratio2)/2;
    if min(avg_ratio) < 0.8
        skeleton_output = skeleton_input(:,:,:,avg_ratio <= 0.8);
        body_cnt(avg_ratio > 0.8) = [];
        skeleton_tran(:,:,:,avg_ratio > 0.8) = [];
    else
       skeleton_output = skeleton_input(:,:,:,avg_ratio == min(avg_ratio)); 
       body_cnt(avg_ratio ~= min(avg_ratio)) = [];
       skeleton_tran(:,:,:,avg_ratio ~= min(avg_ratio)) = [];
    end
    
    if size(skeleton_output,4) > 1
        if max(body_cnt) == min(body_cnt)
            variation = squeeze(sum(sum(var(skeleton_tran,0,3),2),1));
            [~,I] = sort(variation,'descend');
        else
            [~,I] = sort(body_cnt,'descend');            
        end
        skeleton_output = skeleton_output(:,:,:,I);
    end
else
    skeleton_output = skeleton_input;
end

end


function [skeleton_output, body_cnt] = enhance_skeleton(skeleton_input)
frame = length(skeleton_input);

max_body_num = 0;
body_ID = int64(0);

body_index = zeros(7,frame);
for f = 1:frame
    body_num = length(skeleton_input(f).bodies);    
    for b = 1:body_num
        body_id = skeleton_input(f).bodies(b).bodyID;
        if isempty(find(body_id == body_ID, 1))
            max_body_num = max_body_num + 1;
            body_ID(max_body_num) = body_id;
        end
        idx = find(body_id == body_ID, 1);
        body_index(idx,f) = 1;
    end
end

joints = zeros(25,3,frame,max_body_num);
for f = 1:frame
    body_num = length(skeleton_input(f).bodies);
    for b = 1:body_num
        idx = find(skeleton_input(f).bodies(b).bodyID == body_ID, 1);
        for j = 1:25
            joints(j,:,f,idx) = [skeleton_input(f).bodies(b).joints(j).x ...\
                skeleton_input(f).bodies(b).joints(j).y ...\
                skeleton_input(f).bodies(b).joints(j).z];
        end
    end
end

%normalization
%method from 'On Geometric Features for Skeleton-Based Action Recognition
%          using Multilayer LSTM Networks'
index = get_chain_index; %the index that defines chains according to joint numbers
chains = joints(index(:,2),:,:,:) - joints(index(:,1),:,:,:);
skeleton_output = 100 * joints./repmat(sum(sum(chains.^2,2).^(0.5),1),25,3);
% skeleton_output = joints;

body_index(max_body_num+1:end,:) = [];
body_cnt = sum(body_index,2);
body_index(body_cnt < max(body_cnt)/2,:) = 0;
skeleton_output(:,:,sum(body_index,1) == 0,:) = [];
skeleton_output(:,:,:,body_cnt<max(body_cnt)/2) = [];
body_cnt(body_cnt<max(body_cnt)/2) = [];
end



function index = get_chain_index
% % spine based to spine
% index = [1 21];

% all connected chains
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
    9 10;
    9 21;
    10 11;
    11 12;
    13 14;
    14 15;
    17 18;
    18 19];
end

