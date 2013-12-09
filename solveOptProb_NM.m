function [optSolution, err] = solveOptProb_NM(costFcn,X,Y,lambda)
% Compute the optimal solution using Newton method
%

% Some constants
Tmax=1e6;
tol =1e-6;
err = 1;
beta = 15;

% Initialize log barrier constant
t=1;

% Initialize Z
W0 = ones(204,1);
C0 = 1;
xi0 = 1-Y.*(W0'*X+C0);
xi0(xi0<=0)=0.001;
Z = [W0; C0; xi0];

% Set the error 2*tol to make sure the loop runs at least once
while (err/2) > tol
    
    
    % Execute the cost function at the current iteration
    % F : function value, G : gradient, H, hessian
    [F, G, H] = feval(costFcn,Z,X,Y,lambda,t);
    
    % Compute the Newton step
    delZ = -H\G;
    err = -G'*delZ;
    
    % Compute Line Search step size
    s=1;
    Zk=Z+s*Z;
    crit1 = Zk(1:204)'*X*Y+Zk(205)*Y+Zk(206:end)-1;
    crit2 = Zk(206:end);
    while(sum(crit1>0)~=0 || sum(crit2>0)~=0)
        s=s/2
        Zk=Z+s*Z;
        crit1 = Z(1:204)'*X*Y+Z(205)*Y+Z(206:end)-1;
        crit2 = Zk(206:end);
    end
    Z = Zk;
    t=t*beta
    if(t>=Tmax)
       break 
    end
end
end



