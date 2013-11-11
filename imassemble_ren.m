function image = imassemble_ren(blocks,M,N)
[blocklen,numblocks] = size(blocks);
side = sqrt(blocklen);
image = zeros(M,N);

n=1;
for i=1:side:M
    for j=1:side:N
        image(i:i+side-1,j:j+side-1) = reshape(blocks(:,n),side,side);
        n=n+1;
    end
end
end