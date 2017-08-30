%method following 'On Geometric Features for Skeleton-Based Action Recognition using Multilayer
%LSTM Networks'
%including traslating and rotation
function skeleton_output = translate_skeleton(skeleton_input)

[~,~,frame,body_num] = size(skeleton_input);
skeleton_output = zeros(25,3,frame,body_num);

for f = 1:frame
    for b = 1:body_num
        u = skeleton_input(5,:,f,b) - skeleton_input(9,:,f,b);%x
        u = u'/norm(u);
        v = skeleton_input(21,:,f,b) - skeleton_input(1,:,f,b);%y
        v = v'/norm(v);
        w = cross(u,v);%z
        w = w/norm(w);
        u = cross(v,w);%orthogonal for xyz
        skeleton_output(:,:,f,b) = (skeleton_input(:,:,f,b) - repmat(skeleton_input(1,:,f,b),25,1)) * [u v w];    
    end
end
end
