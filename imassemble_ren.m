function image = imassemble_ren(blocks,M,N)
[blockSize,numblocks]=size(blocks);
side = sqrt(blockSize);
image = zeros(M*8,N*8);

n=1;
for i=1:side:M*side
    for j=1:side:N*side
        image(i:i+side-1,j:j+side-1) = reshape(blocks(:,n),side,side);
        n=n+1;
    end
end
end