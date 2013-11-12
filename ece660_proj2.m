clear all;
close all;

K = 8;
A = dctmtx_ren(K);
image = imgRead('fishing_boat.bmp');
blocks = imblock_ren(image,K);

%%
for blk=1:size(blocks,2)
    ind=sort(randperm(K^2,50));
    alpha = OMP_ren(blocks(ind,blk),A(ind,:),K,40);
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
