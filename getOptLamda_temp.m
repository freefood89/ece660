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
%   optiLamda: Optimal lamda value 
%
% @ 2011 Kiho Kwak -- kkwak@andrew.cmu.edu


:
:

% init_Z = [W, C, zeta];
while (t <= Tmax)
    :
    [optSolution, err] = solveOptProb_NM(@costFcn, init_Z,tol);
    :
end
:
: