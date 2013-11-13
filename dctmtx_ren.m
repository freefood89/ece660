function A = dctmtx_ren(n)
c = sqrt(2/n);
u = 1:n;
v = 1:n;
% A = zeros(n^2);
for y=1:n
    for x=1:n

        U=c.*cos(pi*(2*x-1)*(u-1)/(2*n));
        V=c.*cos(pi*(2*y-1)*(v-1)/(2*n));
        U(1) = U(1)/sqrt(2);
        V(1) = V(1)/sqrt(2);
        A(x+n*(y-1),:)=reshape(U'*V,1,n^2);
    end
end
end