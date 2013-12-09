function [F, G, H] = costFcn(Z,X,Y,lambda,t)
% Compute the cost function F(Z)
%
% INPUTS: 
%   Z: Parameter values
% OUTPUTS
%   F: Function value
%   G: Gradient value
%   H: Hessian value
%
% @ 2011 Kiho Kwak -- kkwak@andrew.cmu.edu

G = zeros(size(Z));
H = zeros(length(Z));

tinv = 1/t;
% W : [204 1]
% x : [204 trials]
% y : [1 trials]
D = ((W'*X)+C).*Y+xi-1; % den : 
F = sum(xi) + lambda*W'*W - sum(log(D))/t-sum(log(xi))/t;
G = [   (2*lambda*Z(1:204)-X*(Y./D)'/t);
        -sum(Y./D)/t;
        (-sum(1./D)+sum(1./xi))/t];
H = 5;
end