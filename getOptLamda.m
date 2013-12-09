function optLamda = getOptLamda(X, Y, setPara)
% Get the optimal lamda
%
% INPUTS:
%   X(MxN) : trData(i,j) is the i-th feature from the j-th trial
%   Y(Nx1): trData(j) is the label of the j-th trial (1 or -1)
%   setPara : Initialized parameters
%            setPara.t
%            setPara.beta
%            setPara.Tmax
%            setPara.tol
%            setPara.W
%            setPara.C
%
% OUTPUTS:
%   optLamda: Optimal lamda value
%
% @ 2011 Kiho Kwak -- kkwak@andrew.cmu.edu

lambdas = [.01 1 100 1000];
E = zeros(5,length(lambdas));
for set=1:5
    % Define training set
    index5 = 1:100;
    index5(20*(set-1)+1:20*set) = [];
    Xtrain = [X(:,index5) X(:,100+index5)];
    Ytrain = [Y(:,index5) Y(:,100+index5)];
    for n=1:length(lambdas)
        lambda = lambdas(n);
        % init_Z = [W, C,  zeta];
        % Solve for optimum solution for each lambda
        while (t <= Tmax)
            [optSolution, err] = solveOptProb_NM(@costFcn,init_Z,Xtrain,Ytrain,lambda);
        end
        
        % Test each classifier for each lambda
        Xtest = [X(:,20*(set-1)+1:20*set) X(:,100+20*(set-1)+1:20*set)];
        Ytest = [Y(:,20*(set-1)+1:20*set) Y(:,100+20*(set-1)+1:20*set)];
        res = 2*(sol(1:204)'*Xtest+sol(205)>=0)-1;
        
        % Store classification error for each lambda
        E(n,set) = sum(res==Ytest);
    end
    
end
% Average errors across sets
E = mean(E); 
optLambda = lambdas(E==min(E)); % return lambda with lowest mean error
end
