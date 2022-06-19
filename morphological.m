function morph=morphological(I)
se = strel('disk',15);
background = imopen(I,se);
I2 = I - background;
I3 = imadjust(I2);
bw = imbinarize(I3);
bw = bwareaopen(bw,50);
morph=bw;
return;
