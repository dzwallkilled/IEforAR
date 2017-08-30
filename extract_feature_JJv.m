function features = extract_feature_JJv(skeleton_input)

index = get_JJo_index01;

joints = skeleton_input;

features = joints(index(:,2),:,:,1) - joints(index(:,1),:,:,1);
features = permute(features,[1 3 2]);
end

function index = get_JJo_index01
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