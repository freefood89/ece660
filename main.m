close all;
clear all;

load feaSubEImg.mat;

class1 = cell2mat(class(:,1));
class2 = cell2mat(class(:,2));

figure, show_chanWeights(class1(:,1));
Ac = zeros(1,6);
% 6-fold cross validation to report results
Y = [ones(1,100); -ones(1,100)];
for n=1:6
    index6 = 1:120;
    index6((n-1)*20+1:n*20) = []; % remove testing data from training pool
    X = [class1(:,index6); class2(:,index6)]; % training data
    lambda = getOptLambda(X,Y,params); % best lambda for training set
   
    % solve, classify, store error
    [sol, err] = solveOptProb_NM(@costFcn,lambda,testset);
    Ac(n) = err;
end
