clear all;
close all;

K = 8;
image = imgRead('fishing_boat.bmp');
blocks = imblock_ren(image,K);
S = [10 20 30 40 50];
for n=1:length(S)
   imgOut = imgRecover(image,K,S(n)); 
   filtered = medfilt2(imgOut,[3 3]);
   imwrite(imgOut,['boat' num2str(S(n))],'png'); 
   imwrite(imgOut,['boat_filt' num2str(S(n))],'png');
end
%%
K = 8;
image = imgRead('lena.bmp');
blocks = imblock_ren(image,K);
S = [10 30 50 100 150];
for n=1:length(S)
   imgOut = imgRecover(image,K,S(n)); 
   filtered = medfilt2(imgOut,[3 3]);
   imwrite(imgOut,['lena' num2str(S(n))],'png'); 
   imwrite(imgOut,['lena_filt' num2str(S(n))],'png');
end
%%
% S = 50;
% for blk=1:size(blocks,2)
%     ind=sort(randperm(K^2,S)); % indexes of working set
%     m = floor(S/6); % number of elements in test set
%     lambdas = 5:5:20;
%     Error = zeros(1,length(lambdas));
%     for L=1:length(lambdas)
%         for iter=1:min(lambdas(L),20)
%             iTest = randperm(length(ind),m);
%             iTrain = ind;
%             iTrain(iTest) = []; % remove testing set from training set
%             iTest = ind(sort(iTest)); % indexes of test Set
%             
%             trainSet = blocks(iTrain,blk);
%             alpha = OMP_ren(trainSet,A(iTrain,:),K,lambdas(L));
%             eps = A(iTest,:)*alpha -  blocks(iTest,blk);
%             Error(L) = Error(L) + sum(eps.^2)/(K^2)/length(iTest);
%         end
%     end
%     lambda = lambdas(Error==min(Error));
% %     lambda=20;
%     alpha = OMP_ren(blocks(ind,blk),A(ind,:),K,lambda);
%     cSensed(:,blk) = A*alpha;
%     [blk, lambda]
%     if(lambda~=10)
% % %         figure, plot(lambdas,Error);
%     end
% end
%%
imgOut = imgRecover(image,8,30);

figure; imgShow(imgOut);
title('Compressed Sensing');
filtered = medfilt2(imgOut,[3 3]);
figure, imgShow(filtered);
title('Median Filtered');

e_recover = sum(sum((imgOut-image).^2))/size(image,1)/size(image,2)
e_filt = sum(sum((filtered-image).^2))/size(image,1)/size(image,2)