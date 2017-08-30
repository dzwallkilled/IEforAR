function [skeleton_output, body_num] = preprocess_skeleton_data2(skeleton_input)


frame = length(skeleton_input);

joints = zeros(25,3,frame,3);
for f = 1:frame
    body_num = length(skeleton_input(f).bodies);
    for b = 1:body_num 
        for j = 1:25
            joints(j,:,f,b) = [skeleton_input(f).bodies(b).joints(j).x ...\
                skeleton_input(f).bodies(b).joints(j).y ...\
                skeleton_input(f).bodies(b).joints(j).z];
        end
        
    end
end


chains = joints(21,:,:,:) - joints(1,:,:,:);
skeleton_output = 100 * joints./repmat(sum(sum(chains.^2,2).^(0.5),1),25,3);


end


