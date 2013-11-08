function blocks = imsegment_ren(image,block_width)
    [M,N] = size(image);
    
    numblocks = ceil(M/block_width)+ceil(N/block_width);
    blocks = zeros(block_width^2,numblocks);
    
    n=1;
    for i=1:block_width:M
        for j=1:block_width:N
            patch = image(i:i+block_width-1,j:j+block_width-1);
            blocks(:,n) = patch(:);
            n=n+1;
        end
    end
end