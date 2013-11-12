function imOut = imgRecover(imgIn,blkSize,numSample)

% EXAMPLE:
% blkSize = 8;
% imgIn = imgRead('fishing_boat.bmp');
% numSample=30;
A = dctmtx(blkSize^2);
blocks = imblock_ren(imgIn,blkSize);


lambda = floor(linspace(numSample/10,numSample,5));
Error = zeros(size(lambda));
setSize = size(blocks,2)/4; % 4-fold

for L=1:length(lambda)
    for s=1:4
        if(s==1)
            trainSet = blocks(:,(setSize+1):end);
        elseif(s==4)
            trainSet = blocks(:,1:(end-setSize));
        else
            trainSet = blocks(:,[(1:s*(setSize-1)) (s*setSize+1:end)]);
        end
        testSet = blocks(:,((s-1)*setSize+1):(s*setSize));
        
        for blk=1:size(trainSet,2)
            ind=sort(randperm(blkSize^2,lambda(L)));
            B=trainSet(ind,blk);
            C = A(ind,:);
            normC=A(ind,:);
            norms = zeros(1,blkSize^2);
            means = mean(normC);
            for n=1:size(normC,2)
                norms(n) = norm(normC(:,n));
                normC(:,n) = normC(:,n)-means(n);
                normC(:,n) = normC(:,n)/norm(normC(:,n));
            end
            
            % find lambda(L) most orthogonal Ai vectors
            prod=0;
            alpha=zeros(blkSize^2,1);
            F = B;
            omega = [];
            a = zeros(1,blkSize^2); % Convenient for debug
            for p=1:lambda(L)
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
                omega = [omega index];
                
                % solve for alpha using residuals
                alpha(omega) = C(:,omega)\B;
                % Calculating residue with Ai & ai
                F = B - C*alpha;
            end
        end
        % Solve for testSet alpha using omega from training set
        for blk=1:size(testSet,2)
            B=trainSet(ind,blk);
            alpha(omega) = C(:,omega)\B;
            sol(:,blk) = A*alpha;
        end
        Error(L) = Error(L) + imgCompare(testSet,sol)/4;
    end
end
figure, plot(lambda,Error);

lambda_best = lambda(Error==min(Error));
lambda_best = lambda_best(1);

%% Solve using best Lambda

for blk=1:size(blocks,2)
    ind=sort(randperm(blkSize^2,lambda_best));
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
    for p=1:lambda_best
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
    end
    cSensed(:,blk) = A*alpha;
    blk
end

imOut = imassemble_ren(cSensed,size(imgIn,1),size(imgIn,2));
% figure;
% subplot(131), imgShow(imassemble_ren(cSensed,size(imgIn,1),size(imgIn,2)));
% title('Compressed Sensing');
% subplot(132), imgShow(medfilt2(imassemble_ren(cSensed,size(imgIn,1),size(imgIn,2)),[3 3]));
% title('Median Filtered');
% subplot(133), imgShow(imgIn);
% title('Original');
end