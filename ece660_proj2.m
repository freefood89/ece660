clear all;
close all;

image = imgRead('fishing_boat.bmp');
blocks = imsegment_ren(image,8);
image2= imassemble_ren(blocks,25,24);

figure;
imgShow(image2);