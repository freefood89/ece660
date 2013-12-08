close all;
clear all;

load feaSubEImg.mat;

class1 = cell2mat(class(:,1));
class2 = cell2mat(class(:,2));

figure, show_chanWeights(class1(:,1));

Ac = zeros(1,6);     
% 6-fold cross validation to report accuracy
for n=1:6
    

    Ac(n) = err;
end

% run final classification
