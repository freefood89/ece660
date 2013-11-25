function [optSolution, err] = solveOptProb_NM(costFcn,init_Z,tol)
% Compute the optimal solution using Newton method
%
% INPUTS:
%   costFcn: Function handle of F(Z)
%   init_Z: Initial value of Z
%   tol: Tolerance
%
% OUTPUTS:
%   optSolution: Optimal soultion
%   err: Errorr
%
% @ 2011 Kiho Kwak -- kkwak@andrew.cmu.edu


Z = init_Z;
err = 1;

% Set the error 2*tol to make sure the loop runs at least once
while (err/2) > tol

    
% Execute the cost function at the current iteration
% F : function value, G : gradient, H, hessian
[F, G, H] = feval(costFcn,Z);

   
    
end



