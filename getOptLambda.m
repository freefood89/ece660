function output = getOptLambda(X, Y)
% Get the optimal lamda
%
% INPUTS:
%   X(MxN) : trData(i,j) is the i-th feature from the j-th trial
%   Y(Nx1): trData(j) is the label of the j-th trial (1 or -1)
%
% OUTPUTS:
%   optLamda: Optimal lamda value
%
Tmax = 1e6;
beta = 15;
lambdas = [.01 1 100 10000];
E = zeros(5,length(lambdas));
display('Searching Optimum Lambda via 5-fold Cross Validation');
for set=1:5
    % Define training set
    index5 = 1:100;
    sets = 1:5;
    index5(20*(set-1)+1:20*set) = [];
    sets(set) = [];
    display(['Train Set: ' num2str(sets) ', Test Set: ' num2str(set) ]);
    Xtrain = [X(:,index5) X(:,100+index5)];
    Ytrain = [Y(:,index5) Y(:,100+index5)];
    for n=1:length(lambdas)
        lambda = lambdas(n);
        % Solve for optimum solution for each lambda
        t=1;
        
        % Initialize Z
        display(['Fold: ' num2str(set) '/5, lambda: ' num2str(lambda)]);
        W0 = zeros(204,1);
        C0 = 0;
        xi0 = (1-Ytrain.*(W0'*Xtrain+C0));
        xi0(xi0<=0)=0;
        xi0 = xi0+.001;
        initZ = [W0; C0; xi0'];
        while (t <= Tmax)
            sol = solveOptProb_NM(@costFcn,initZ,Xtrain,Ytrain,lambda,t);
            t= t*beta;
            initZ = sol;
        end
        
        % Test each classifier for each lambda
        Xtest = [X(:,20*(set-1)+1:20*set) X(:,100+20*(set-1)+1:100+20*set)];
        Ytest = [Y(:,20*(set-1)+1:20*set) Y(:,100+20*(set-1)+1:100+20*set)];
        res = 2*(sol(1:204)'*Xtest+sol(205)>=0)-1;
        
        % Store classification error for each lambda
        E(set,n) = sum(res~=Ytest);
    end
    
end
% Average errors across sets
E = mean(E)
minL = lambdas(E==min(E));
output = minL(end); % return lambda with lowest mean error
display(['Optimum Lambda = ' num2str(output)]);
end
