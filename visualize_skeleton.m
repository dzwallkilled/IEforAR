function visualize_skeleton(skeleton_input)
[~,~,frame,body_num] = size(skeleton_input);
index = get_chain_index;
figure;
for f=1:frame
      for b=1:body_num
          figure(b);
          for l = 1:18
              points = skeleton_input(index(l,:)',:,f,b);
              plot3(points(:,1),points(:,2),points(:,3));
              hold on
          end
      end
%    hold off
   pause(0.1);
end

end


function index = get_chain_index
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