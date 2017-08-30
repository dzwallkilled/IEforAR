clear
close all
clc

tic

load skeleton_file_list.mat 

h = waitbar(0,'1','name','Creating images','CreateCancelBtn','close(h)');
set(h,'CloseRequestFcn','closereq');
waitbar(0,h,'Start creating images');

mkdir('./Images/JJd/TranMed1_hsv_300x200/'); 
mkdir('./Images/JJd/TranMed2_hsv_300x256/'); 
mkdir('./Images/JJd/TranMed3_hsv_256x256/'); 

mkdir('./Images/JLd/TranMed1_hsv_897x200/'); 
mkdir('./Images/JLd/TranMed2_hsv_897x256/'); 
mkdir('./Images/JLd/TranMed3_hsv_256x256/'); 

mkdir('./Images/LLa/TranMed1_hsv_741x200/'); 
mkdir('./Images/LLa/TranMed2_hsv_741x256/'); 
mkdir('./Images/LLa/TranMed3_hsv_256x256/'); 


len = length(skeleton_file_list);

for i = 1:len
%% JJd
    image = imread(['./Images/JJd/TranMed1_rgb_300x200/' skeleton_file_list(i,1:20) '.jpg']); 
    image = hsv2rgb(single(image)/256.0);%treated as coding in hsv, instead of rgb space
    imwrite(image, ['./Images/JJd/TranMed1_hsv_300x200/' skeleton_file_list(i,1:20) '.jpg']);

    image = imread(['./Images/JJd/TranMed2_rgb_300x256/' skeleton_file_list(i,1:20) '.jpg']); 
    image = hsv2rgb(single(image)/256.0);%treated as coding in hsv, instead of rgb space
    imwrite(image, ['./Images/JJd/TranMed2_hsv_300x256/' skeleton_file_list(i,1:20) '.jpg']);

    image = imread(['./Images/JJd/TranMed3_rgb_256x256/' skeleton_file_list(i,1:20) '.jpg']); 
    image = hsv2rgb(single(image)/256.0);%treated as coding in hsv, instead of rgb space
    imwrite(image, ['./Images/JJd/TranMed3_hsv_256x256/' skeleton_file_list(i,1:20) '.jpg']);

%% JLd
    image = imread(['./Images/JLd/TranMed1_rgb_897x200/' skeleton_file_list(i,1:20) '.jpg']); 
    image = hsv2rgb(single(image)/256.0);%treated as coding in hsv, instead of rgb space
    imwrite(image, ['./Images/JLd/TranMed1_hsv_897x200/' skeleton_file_list(i,1:20) '.jpg']);

    image = imread(['./Images/JLd/TranMed2_rgb_897x256/' skeleton_file_list(i,1:20) '.jpg']); 
    image = hsv2rgb(single(image)/256.0);%treated as coding in hsv, instead of rgb space
    imwrite(image, ['./Images/JLd/TranMed2_hsv_897x256/' skeleton_file_list(i,1:20) '.jpg']);

    image = imread(['./Images/JLd/TranMed3_rgb_256x256/' skeleton_file_list(i,1:20) '.jpg']); 
    image = hsv2rgb(single(image)/256.0);%treated as coding in hsv, instead of rgb space
    imwrite(image, ['./Images/JLd/TranMed3_hsv_256x256/' skeleton_file_list(i,1:20) '.jpg']);

%% LLa
    image = imread(['./Images/LLa/TranMed1_rgb_741x200/' skeleton_file_list(i,1:20) '.jpg']); 
    image = hsv2rgb(single(image)/256.0);%treated as coding in hsv, instead of rgb space
    imwrite(image, ['./Images/LLa/TranMed1_hsv_741x200/' skeleton_file_list(i,1:20) '.jpg']);

    image = imread(['./Images/LLa/TranMed2_rgb_741x256/' skeleton_file_list(i,1:20) '.jpg']); 
    image = hsv2rgb(single(image)/256.0);%treated as coding in hsv, instead of rgb space
    imwrite(image, ['./Images/LLa/TranMed2_hsv_741x256/' skeleton_file_list(i,1:20) '.jpg']);

    image = imread(['./Images/LLa/TranMed3_rgb_256x256/' skeleton_file_list(i,1:20) '.jpg']); 
    image = hsv2rgb(single(image)/256.0);%treated as coding in hsv, instead of rgb space
    imwrite(image, ['./Images/LLa/TranMed3_hsv_256x256/' skeleton_file_list(i,1:20) '.jpg']);
    
    
    waitbar(i/56575.0,h,['Processed: ' num2str(i) '/56575   Time (s): ' num2str(toc)]);
end

disp('All finished');