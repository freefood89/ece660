clear all;
close all;

K = 8;
A = dctmtx_ren(K);
image = imgRead('fishing_boat.bmp');
blocks = imblock_ren(image,K);

%%
S = 21;
for blk=1:size(blocks,2)
    ind=sort(randperm(K^2,S)); % indexes of working set
    m = floor(S/6); % number of elements in test set
    lambdas = 10:10:S;
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
    if(lambda~=10)
%         figure, plot(lambdas,Error);
    end
end
%%
figure;
subplot(131), imgShow(imassemble_ren(cSensed,size(image,1),size(image,2)));
title('Compressed Sensing');
subplot(132), imgShow(medfilt2(imassemble_ren(cSensed,size(image,1),size(image,2)),[3 3]));
title('Median Filtered');
subplot(133), imgShow(image);
title('Original');
