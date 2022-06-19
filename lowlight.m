%import an RGB imge captured n low light
function lowlight = lowlight2(A)
%A =
imread('', jpgFilename');
%Invert the image.
AInv = imcomplement(A);
%Apply the dehazing algorithm.
BInv = imreducehaze(AInv, 'ContrastEnhancement', 'none');% name,value
% Invert the results.
lowlight = imcomplement(BInv);
%Display the original image and the enhanced images, side-by-side.
%figure, montage({A, B});
%imshow(B);
return;
