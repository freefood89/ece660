function [F, G, H] = costFcn(Z,X,y,lambda,t)
% Compute the cost function F(Z)
%
% INPUTS:
%   Z: Parameter values
% OUTPUTS
%   F: Function value
%   G: Gradient value
%   H: Hessian value

G = zeros(size(Z));
H = zeros(length(Z));
tinv = 1/t;

W = Z(1:204); % W : [204 1]
C = Z(205);
xi = Z(206:end)'; % xi: [1 trials]
N = size(X,2);

D = ((W'*X)+C).*y+xi-1; % den :
invD2 = D.^-2;
F = sum(xi) + lambda*W'*W - sum(log(D))/t - sum(log(xi))/t;
G =[2*lambda*W-(X*(y./D)'/t);
    -sum(y./D)/t;
    1 - (1./D + 1./xi)'/t];

% The Hessian matrix is solved for in 9 partitions divided as shown below: 
% AA AB AC
% BA BB BC
% CA CB CC


% AC
H(1:204,206:end) = X*(ones(N,1)*(y.*invD2))/t;
% BC
H(205,206:end) = y.*invD2/t;
% CA and CB
H(206:end,1:205) = H(1:205,206:end)';

% AB
H(1:204,205) = X*invD2'/t;
% BA
H(205,1:204) = H(1:204,205)';

% AA
WW = 2*lambda*eye(204);
for i=1:N
    WW = WW + X(:,i)*X(:,i)'*invD2(i)/t;
end
H(1:204,1:204) = WW;
% BB
H(205,205) = sum(invD2)/t;
% CC
H(206:end,206:end) = diag((invD2+xi.^-2)/t);


% for i=1:N
%     WW = WW + X(:,i)*X(:,i)'*invD2(i);
%     H(:,205+i) = C(:,i)*invD2(i); %region C
%     H(1:204,205) = H(1:204,205)+H(1:204,205+i);
%     H(1:204,205+i) = H(1:204,205+i)*Y(i);
% end
% H(1:204,1:204) = WW;
% H(205,205) = sum(invD2)/t;
% H(206:end,206:end) = H(206:end,206:end) + diag((xi.^-2)/t);
% H(205:end,1:205)=H(1:205,205:end)';
end