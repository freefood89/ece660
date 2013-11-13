function alpha = OMP_ren(B,C,K,lambda)

normC=C;
% norms = zeros(1,K^2);
% means = mean(normC);
% for n=1:size(normC,2)
%     norms(n) = norm(normC(:,n));
%     normC(:,n) = normC(:,n)-means(n);
%     normC(:,n) = normC(:,n)/norm(normC(:,n));
% end

prod=0;
alpha=zeros(K^2,1);
F = B;
omega = [];
a = zeros(1,K^2); % Convenient for debug
for p=1:lambda
    % Find Ai with largest inner product
    index = 1;
    prod = 0;
    for n=1:K^2 % optimize later (dont iterate if it's been picked)
        a(n) = abs(F'*normC(:,n));
        if(a(n)>prod && (sum(omega==n)==0))
            prod=a(n);
            index=n;
        end
    end
    omega = [omega index];
    
    % solve for alpha using residuals
    alpha(omega) = C(:,omega)\B;
    % Calculating residue with Ai & ai
    F = B - C*alpha;
end
end