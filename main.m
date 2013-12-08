close all;
clear all;

load feaSubEImg.mat;

class1 = cell2mat(class(:,1));
class2 = cell2mat(class(:,2));
numTrial = size(class1,1);
figure, show_chanWeights(class1(:,1));
%%
Ac = zeros(1,6);
Ytrain = [ones(1,100) -ones(1,100)];
Ytest = [ones(1,20) -ones(1,20)];
for n=1:6
    % Define training set
    index6 = 1:numTrial;
    index6((n-1)*20+1:n*20) = []; % remove testing data from training pool
    Xtrain = [class1(:,index6) class2(:,numTrial+index6)]; % training data
    
    % Find best lambda for training set
    lambda = getOptLambda(Xtrain,Ytrain,params); 
   
    % Re-solve entire training set using best lambda
    [sol, err] = solveOptProb_NM(@costFcn,lambda,Xtrain);
    
    % Classify testing set
    Xtest = [class1(:,(n-1)*20+1:n*20) class2(:,numTrial+(n-1)*20+1:n*20)];
    res = 2*(sol(1:204)'*Xtest+sol(205)>=0)-1;
    
    % Store classification error
    Ac(n) = sum(result==Ytest);
end
