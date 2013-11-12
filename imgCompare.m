function error = imgCompare(A,B)

error = 0;
E = A-B;
for n=1:size(A,2)
    error = error + norm(E(:,n));
end
end