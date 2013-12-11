function sol = solveOptProb_NM(costFcn,initZ,X,Y,lambda,t)
% Compute the optimal solution using Newton method
%

% Some constants
tol =1e-6;
err = 3*tol;
beta = 15;
N = size(X,2);
Z = initZ;
while (err/2) > tol
    
    
    % Execute the cost function at the current iteration
    % F : function value, G : gradient, H, hessian
%     display('Evaluating Cost Function');
    [F, G, H] = feval(costFcn,Z,X,Y,lambda,t);
    
    % Compute the Newton step
    delZ = -(inv(H)*G);
    err = -G'*delZ;
    if(err/2 < tol)
       break 
    end
    % Compute step size by backtracking
%     display('Performing Line Search');
    s=1;
    Zk=Z+s*delZ;
    crit1 = sum(Zk(1:204)'*X.*Y+Zk(205)*Y+Zk(206:end)'-1>0);
    crit2 = sum(Zk(206:end)>0);
    while(crit1<N || crit2<N)
        s=s/2;
        Zk=Z+s*delZ;
        crit1 = sum(Zk(1:204)'*X.*Y+Zk(205)*Y+Zk(206:end)'-1>0);
        crit2 = sum(Zk(206:end)>0);
    end
    Z = Zk;
end
sol = Z;
end



