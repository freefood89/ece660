function imgOut = imgRecover(imgIn,blkSize,numSample)

S = numSample;
K = blkSize;
blocks = imblock_ren(imgIn,K);
cSensed = zeros(size(blocks));
A = dctmtx_ren(K);
for blk=1:size(blocks,2)
    ind=sort(randperm(K^2,S)); % indexes of working set
    m = floor(S/6); % number of elements in test set
    lambdas = 5:5:20;
    Error = zeros(1,length(lambdas));
    for L=1:length(lambdas)
        for iter=1:min(lambdas(L),20)
            iTest = randperm(length(ind),m);
            iTrain = ind;
            iTrain(iTest) = []; % remove testing set from training set
            iTest = ind(sort(iTest)); % indexes of test Set
            
            trainSet = blocks(iTrain,blk);
            alpha = OMP_ren(trainSet,A(iTrain,:),K,lambdas(L));
            eps = A(iTest,:)*alpha -  blocks(iTest,blk);
            Error(L) = Error(L) + sum(eps.^2)/(K^2)/length(iTest);
        end
    end
    lambda = lambdas(Error==min(Error));
    alpha = OMP_ren(blocks(ind,blk),A(ind,:),K,lambda);
    cSensed(:,blk) = A*alpha;
    [blk, lambda]
end
imgOut = imassemble_ren(cSensed,size(imgIn,1),size(imgIn,2));
end