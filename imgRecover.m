function imgOut = imgRecover(imgIn,blkSize,numSample)

% EXAMPLE:
% blkSize = 8;
% imgIn = imgRead('fishing_boat.bmp');
% numSample=30;

A = dctmtx(blkSize^2);
blocks = imblock_ren(imgIn,blkSize);


for blk=1:size(blocks,2)
    ind=sort(randperm(blkSize^2,numSample));
    B=blocks(ind,blk);
    C = A(ind,:);
    normC=A(ind,:);
    norms = zeros(1,blkSize^2);
    means = mean(normC);
    for n=1:size(normC,2)
        norms(n) = norm(normC(:,n));
        normC(:,n) = normC(:,n)-means(n);
        normC(:,n) = normC(:,n)/norm(normC(:,n));
    end

    prod=0;
    alpha=zeros(blkSize^2,1);
    F = B;
    omega = [];
    a = zeros(1,blkSize^2); % Convenient for debug
    for p=1:numSample
        % Find Ai with largest inner product
        index = 0;
        prod = 0;
        for n=1:blkSize^2 % optimize later (dont iterate if it's been picked)
            a(n) = abs(F'*normC(:,n));
            if(a(n)>prod && (sum(omega==n)==0))
                prod=a(n);
                index=n;
            end
        end
        %     plot(a), title(['A_i, i=' num2str(p)]);
        %     display(index);
        omega = [omega index];
        
        % solve for alpha using residuals
        for n=1:length(omega)
            alpha(omega) = C(:,omega)\B;
        end
        % Calculating residue with Ai & ai
        F = B - C*alpha;
        %     norm(F)
    end
    cSensed(:,blk) = A*alpha;
    blk
end
%%
figure;
subplot(131), imgShow(imassemble_ren(cSensed,size(imgIn,1),size(imgIn,2)));
title('Compressed Sensing');
subplot(132), imgShow(medfilt2(imassemble_ren(cSensed,size(imgIn,1),size(imgIn,2)),[3 3]));
title('Median Filtered');
subplot(133), imgShow(imgIn);
title('Original');
end