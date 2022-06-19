%a=imread('');
%imshow(a);
function weiner=weinerFinal(a)
I = rgb2gray(a);
%J = imnoise(I,'gaussian',0,0.50);
weiner = wiener2(I,[5 5]);%5,5 is neighbourbood size
%weiner=imsharpen(weiner,'Radius',2.5,'Amount',1.5);
%figure;
%imshow(K);
return;
