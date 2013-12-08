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
    index5 = 1:100;
    index5(20*(n-1)+1:20*n) = [];
    Xtrain = [X(1,index5) X(2,index5)];
    Y = [Y(1,index5) Y(2,index5)];
    for n=1:length(lambdas)
        lambda = lambdas(n);
        
        % Solve for each lambda
        % init_Z = [W, C,  zeta];
        while (t <= Tmax)
            
            [optSolution, err] = solveOptProb_NM(@costFcn,init_Z,tol);
            
        end
        % use solution classifier on test set
        E(set,n) = err;
    end
end
E = mean(E); % average the errors
optLambda = lambdas(E==min(E));
end
