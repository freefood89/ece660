clear all;
close all;

K = 8;
image = imgRead('fishing_boat.bmp');
blocks = imblock_ren(image,K);
S = [10 20 30 40 50];
e_recover = zeros(1,length(S));
e_filt = zeros(1,length(S));
for n=1:1%length(S)
   imgOut = imgRecover(image,K,S(n)); 
   filtered = medfilt2(imgOut,[3 3]);
   imwrite(uint8(imgOut),['boat' num2str(S(n)) '.png'],'png'); 
   imwrite(uint8(filtered),['boat_filt' num2str(S(n)) '.png'],'png');
   e_recover(n) = sum(sum((imgOut-image).^2))/size(image,1)/size(image,2);
   e_filt(n) = sum(sum((filtered-image).^2))/size(image,1)/size(image,2);
   h=figure; imgShow(imgOut); title('Recovered');
   saveas(h,['boat' num2str(S(n))],'fig')
   h=figure; imgShow(filtered); title('Median Filtered');
   saveas(h,['boat_filt' num2str(S(n))],'fig')
end

save('boat_errors.mat','e_recover','e_filt');
%%
close all;

K = 16;
image = imgRead('lena.bmp');
blocks = imblock_ren(image,K);
S = [10 30 50 100 150];
e_recover = zeros(1,length(S));
e_filt = zeros(1,length(S));
for n=1:length(S)
   imgOut = imgRecover(image,K,S(n)); 
   filtered = medfilt2(imgOut,[3 3]);
   imwrite(uint8(imgOut),['lena' num2str(S(n)) '.png'],'png'); 
   imwrite(uint8(filtered),['lena_filt' num2str(S(n)) '.png'],'png');
   e_recover = sum(sum((imgOut-image).^2))/size(image,1)/size(image,2);
   e_filt = sum(sum((filtered-image).^2))/size(image,1)/size(image,2);
   figure(1,'visible','off'); imgShow(imgOut); title('Compressed Sensing');
   saveas(1,['lena' num2str(S(n))],'fig');
   figure(1,'visible','off'); imgShow(filtered); title('Median Filtered');
   saveas(1,['lena_filt' num2str(S(n))],'fig');
end
save('boat_errors.mat',e_recover,e_filt);