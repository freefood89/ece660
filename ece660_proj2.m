clear all;
close all;

A = dctmtx(8^2);
image = imgRead('fishing_boat.bmp');
blocks = imblock_ren(image,8);

S=10;
ind=sort(randperm(8^2,S));
b=blocks(ind,1);
C=A(ind,:);

prod=0;
for m=1:8^2
    
    a = b'*C(:,m)/norm(C(:,m),2)
    if(a>prod)
        prod=a;
        index=m;
    end
    
    
end


%
% figure;
% imgShow(imassemble_ren(blocks,25,24));