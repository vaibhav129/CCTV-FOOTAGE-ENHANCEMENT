a=imread('');
imshow(a);
%[r c]=ginput(4);
% bw=roipoly(a,r,c);
h = drawassisted;
bw = createMask(h);
alphamat = imguidedfilter(single(bw),a,'DegreeOfSmoothing',2);
target = imread('');
imshow(target);
alphamat = imresize(alphamat,[size(target,1),size(target,2)]);
a = imresize(a,[size(target,1),size(target,2)]);
a2 = rgb2gray(a);
%fused1 = imsharpen(fused);
%p = imgaussfilt(fused1,2.5)
%contrast stretching
se = strel('disk',15)
background = imopen(a2,se);
I2 = a2 - background;
I3 = imadjust(I2);
J = imadjust(I3,stretchlim(I3),[]);
J=J+60;
K = imgaussfilt(J,1.5)
fused = single(K).*alphamat + (1-alphamat).*single(target);
fused = uint8(fused);
figure ,imshow(fused, []);
figure , imshow(a);
