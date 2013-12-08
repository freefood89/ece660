function [F, G, H] = costFcn(Z,x,y)
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
% y : [trials 1]
den = (W'*x)*y+C*y+xi-1; % den : 
F = sum(xi) + lambda*W'*W - tinv*sum(log(den))-tinv*sum(log(xi));
G = 
H = 
end