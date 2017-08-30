% function [X_JJd, X_JLd, X_LLa] = calculate_PCA_matrix(Features)
% clear
% clc
% close
% 
% load JLd.mat

% X = [];
% n = 1;
% for s = 1000:5000
%     if ~isempty(JLd(s))
%         frame = size(JLd(s).JLd,2);
%         X(:,n:n+frame-1) = JLd(s).JLd(:,:,1);
%         n = n + frame;
%     end
% end

[PC,~,VP,~] = wpca(X(:,1:60000)');
sumVP = cumsum(VP)./sum(VP);
index = find(sumVP > 0.99);
TranMatrix_JLd = PC(:,1:max(256,index(1)));

Avg_JLd = mean(X(:,1:60000),2);

save('PCA_Param_JLd.mat','Avg_JLd','TranMatrix_JLd','-v7.3');

disp('Feature Matrix created.')



