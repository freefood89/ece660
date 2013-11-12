clear all;
close all;

K = 8;
A = dctmtx_ren(K);
image = imgRead('fishing_boat.bmp');
blocks = imblock_ren(image,K);
%%
lambda=[30];

for blk=1:size(blocks,2)
    ind=sort(randperm(K^2,lambda(end)));
    B=blocks(ind,blk);
    C = A(ind,:);
    normC=A(ind,:);
    norms = zeros(1,K^2);
    means = mean(normC);
    for n=1:size(normC,2)
        norms(n) = norm(normC(:,n));
        normC(:,n) = normC(:,n)-means(n);
        normC(:,n) = normC(:,n)/norm(normC(:,n));
    end

    prod=0;
    alpha=zeros(K^2,1);
    F = B;
    omega = [];
    a = zeros(1,K^2); % Convenient for debug
    for p=1:lambda
        % Find Ai with largest inner product
        index = 0;
        prod = 0;
        for n=1:K^2 % optimize later (dont iterate if it's been picked)
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
subplot(131), imgShow(imassemble_ren(cSensed,size(image,1),size(image,2)));
title('Compressed Sensing');
subplot(132), imgShow(medfilt2(imassemble_ren(cSensed,size(image,1),size(image,2)),[3 3]));
title('Median Filtered');
subplot(133), imgShow(image);
title('Original');
% %%
% figure;
% subplot(131); imgShow((reshape(A*alpha,8,8))); title('OMP');
% subplot(132); imgShow(medfilt2(reshape(A*alpha,8,8),[3 3])); title('OMP');
% subplot(133); imgShow(reshape(blocks(:,1),8,8)); title('original');

% figure;
% imgShow(imassemble_ren(blocks,25,24));

lambda = 10:10:50;
Error = zero(1,length(lambda));
setSize = size
for L=1:length(lambda)
    for set=1:4
        
        orig
        cSensed
        Error(set) = imgCompare(orig,cSensed);

    end
end