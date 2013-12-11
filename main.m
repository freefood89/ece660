close all;
% clear all;

load feaSubEImg.mat;

class1 = cell2mat(class(:,1));
class2 = cell2mat(class(:,2));
numTrial = size(class1,2);
% figure, show_chanWeights(class1(:,1));
%%
Ac = zeros(1,6);
Ytrain = [ones(1,100) -ones(1,100)];
Ytest = [ones(1,20) -ones(1,20)];
for n=1:length(Ac)
    % Define training set
    display([num2str(n) '/6 folds']);
    index6 = 1:numTrial;
    index6((n-1)*20+1:n*20) = []; % remove testing data from training pool
    Xtrain = [class1(:,index6) class2(:,index6)]; % training data
    
    % Find best lambda for training set
    lambda = getOptLambda(Xtrain,Ytrain); 
   
    % Re-solve entire training set using best lambda
    W0 = zeros(204,1);
    C0 = 0;
    xi0 = (1-Ytrain.*(W0'*Xtrain+C0));
    xi0(xi0<=0)=0;
    xi0 = xi0+.001;
    initZ = [W0; C0; xi0'];
    t=1;
    Tmax = 1e6;
    beta=15;
    while (t <= Tmax)
        sol = solveOptProb_NM(@costFcn,initZ,Xtrain,Ytrain,lambda,t);
        t= t*beta;
        initZ = sol;
    end
    sol = solveOptProb_NM(@costFcn,initZ,Xtrain,Ytrain,lambda,t);
    W = sol(1:204);
    C = sol(205);
    % Classify testing set
    Xtest = [class1(:,(n-1)*20+1:n*20) class2(:,(n-1)*20+1:n*20)];
    res = 2*(W'*Xtest+C>=0)-1;
    
    % Store classification accuracy
    Ac(n) = sum(res==Ytest);
end
%%
mean(Ac)
std(Ac)
