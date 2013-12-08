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

    % Solve for optimum solution for each lambda
    for n=1:length(lambdas)
        lambda = lambdas(n);
        % init_Z = [W, C,  zeta];
        while (t <= Tmax)
            [optSolution, err] = solveOptProb_NM(@costFcn,init_Z,Xtrain,tol);
        end
    end
    
end
E = mean(E); % average the errors across sets
optLambda = lambdas(E==min(E)); % return lambda with lowest mean error
end
