imcounterSMQT=0;
imcounterlowlight=0;
imcounterweiner=0;
psnrcounterSMQT=0;
psnrcounterlowlight=0;
psnrcounterweiner=0;
bricounterSMQT=0;
bricounterlowlight=0;
bricounterweiner=0;
imagerunner=30;
for k = 1:imagerunner
 jpgFilename = sprintf('%d.jpeg', k);
 fullFileName = fullfile('https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FImage&psig=AOvVaw3X8RyzTuPQeaoQYbil1mit&ust=1650398796551000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCJjK8OG0nvcCFQAAAAAdAAAAABAD',jpgFilename);
 if exist(fullFileName, 'file')
 imageData = imread(fullFileName);
 imageDatagray=rgb2gray(imageData);
 else
 warningMessage = sprintf('Warning: image file does not exist:\n%s', fullFileName);
 uiwait(warndlg(warningMessage));
 end
 M = uint8(SMQT(double(imageData),1,8));
 lowlight=lowlight2(imageData);
 weiner=weinerFinal(imageData);
 morph=morphological(imageDatagray);

 %add quality metrics here
 %immse needs a grey image
 if (immse((M),imageData)<immse((lowlight),imageData)) && (immse((M),imageData)<immse((weiner),imageDatagray))
 imcounterSMQT=imcounterSMQT+1;
 elseif(immse((lowlight),imageData)<immse((M),imageData)) && (immse((lowlight),imageData)<immse((weiner),imageDatagray))
 imcounterlowlight=imcounterlowlight+1;
 elseif(immse((weiner),imageDatagray)<immse((M),imageData)) && (immse((weiner),imageDatagray)<immse(((lowlight)),imageData))
 imcounterweiner=imcounterweiner+1;
 end
 [smqtpeaksnr, smqtsnr] = psnr((M), imageData);
 [lowlightpeaksnr, lowlightsnr] = psnr((lowlight), imageData);
 [weinerpeaksnr, weinersnr] = psnr(weiner, imageDatagray);
% fprintf('\n The SNR value is %0.4f\n', weinersnr);
% fprintf('\n The Peak-SNR value is %0.4f\n', weinerpeaksnr);
 %for peak snr
 if (smqtpeaksnr>lowlightpeaksnr) && (smqtpeaksnr>weinerpeaksnr)
 psnrcounterSMQT=psnrcounterSMQT+1;
 elseif(smqtpeaksnr<lowlightpeaksnr) && (lowlightpeaksnr>weinerpeaksnr)
 psnrcounterlowlight=psnrcounterlowlight+1;
 else
 psnrcounterweiner=psnrcounterweiner+1;
 end

 if (brisque((M))<brisque(lowlight)) && (brisque((M))<brisque(weiner))
 bricounterSMQT=bricounterSMQT+1;
 elseif(brisque((lowlight))<brisque(M)) && (brisque((lowlight))<brisque(weiner))
 bricounterlowlight=bricounterlowlight+1;
 else
 bricounterweiner=bricounterweiner+1;
 end
 montage({imageData, M,lowlight,weiner,morph})
 title('From L-R original, SMQT,lowlight,weiner');
 pause(0.5);
end
fprintf('Counter for SMQT (immse): %d \n',imcounterSMQT);
fprintf('Counter for lowlight(immse): %d \n',imcounterlowlight);
fprintf('Counter for weiner filter(immse): %d \n',imcounterweiner);
fprintf('Counter for SMQT (psnr): %d \n',psnrcounterSMQT);
fprintf('Counter for lowlight(psnr): %d \n',psnrcounterlowlight);
fprintf('Counter for weiner filter(psnr): %d \n',psnrcounterweiner);
fprintf('Counter for SMQT (brisque): %d \n',bricounterSMQT);
fprintf('Counter for lowlight(brisque): %d \n',bricounterlowlight);
fprintf('Counter for weiner filter(brisque): %d \n',bricounterweiner);
%psnr and snr seem to be the same
for k = 1:imagerunner
 jpgFilename = sprintf('%d.jpeg', k);
 fullFileName = fullfile('/home/tangobeer/Desktop/ImageEnchancement/DataSet/robbery',jpgFilename);
 if exist(fullFileName, 'file')
 imageData = imread(fullFileName );
 imageDatagray=rgb2gray(imageData);
 else
 warningMessage = sprintf('Warning: image file does not exist:\n%s', fullFileName);
 uiwait(warndlg(warningMessage));
 end
% M = uint8(SMQT(double(imageData),1,8));
% lowlight=lowlight2(M);
% figure; imshow(lowlight);
 if (psnrcounterSMQT<= psnrcounterweiner) && (psnrcounterSMQT<=psnrcounterlowlight)
 %SMQT lowest
 if psnrcounterweiner> psnrcounterlowlight
 weiner=weinerFinal(imageData);
 lowlight=lowlight2(weiner);
 montage({imageData,lowlight})
 title('Hybrid of best 2 algorithm with respect to PSNR (weiner->lowlight)')
 else
 lowlight=lowlight2(imageData);
 weiner=weinerFinal(lowlight);
 montage({imageData,weiner})
 title('Hybrid of best 2 algorithm with respect to PSNR (lowlight->weiner)')
 end


 elseif (psnrcounterSMQT>= psnrcounterweiner) && (psnrcounterweiner<=psnrcounterlowlight)
 %weiner lowest lowlight and weiner
 if psnrcounterSMQT>psnrcounterlowlight
 M = uint8(SMQT(double(imageData),1,8));
 lowlight=lowlight2(M);
 montage({imageData,lowlight}) 
 title('Hybrid of best 2 algorithm with respect to PSNR (SMQT->lowlight)')
 else
 lowlight=lowlight2(imageData);
 M = uint8(SMQT(double(lowlight),1,8));
 montage({imageData,M})
 title('Hybrid of best 2 algorithm with respect to PSNR (lowlight->SMQT)')
 end

 elseif (psnrcounterlowlight<=psnrcounterweiner) && (psnrcounterSMQT>=psnrcounterlowlight)
 %lowlight lowest smqt and weiner
 if psnrcounterSMQT>psnrcounterweiner
 M = uint8(SMQT(double(imageData),1,8));
 weiner=weinerFinal(M);
 montage({imageData,weiner})
 title('Hybrid of best 2 algorithm with respect to PSNR (SMQT->weiner)')
 else
 weiner=weinerFinal(imageData);
 M = uint8(SMQT(double(weiner),1,8));
 montage({imageData,M})
 title('Hybrid of best 2 algorithm with respect to PSNR (weiner->SMQT)')
 end
 %montage({imageData,finalimage})


 end
 pause(1);
end
for k = 1:imagerunner
 jpgFilename = sprintf('%d.jpeg', k);
 fullFileName = fullfile('/home/tangobeer/Desktop/ImageEnchancement/DataSet/robbery',jpgFilename);
 if exist(fullFileName, 'file')
 imageData = imread(fullFileName );
 imageDatagray=rgb2gray(imageData);
 else
 warningMessage = sprintf('Warning: image file does not exist:\n%s', fullFileName);
 uiwait(warndlg(warningMessage));
 end
% M = uint8(SMQT(double(imageData),1,8));
% lowlight=lowlight2(M);
% figure; imshow(lowlight);
 if (bricounterSMQT<= bricounterweiner) && (bricounterSMQT<=bricounterlowlight)
 %SMQT lowest
 if bricounterweiner> bricounterlowlight
 weiner=weinerFinal(imageData);
 lowlight=lowlight2(weiner);
 montage({imageData,lowlight})
 title('Hybrid of best 2 algorithm with respect to BRISQUE (weiner->lowlight)')
 else
 lowlight=lowlight2(imageData);
 weiner=weinerFinal(lowlight);
 montage({imageData,weiner})
 title('Hybrid of best 2 algorithm with respect to BRISQUE (lowlight->weiner)')
 end

 elseif (bricounterSMQT>= bricounterweiner) && (bricounterweiner<=bricounterlowlight)
 %weiner lowest lowlight and weiner
 if bricounterSMQT>bricounterlowlight
 M = uint8(SMQT(double(imageData),1,8));
 lowlight=lowlight2(M);
 montage({imageData,lowlight})
 title('Hybrid of best 2 algorithm with respect to Brisque (SMQT->lowlight)')
 else
 lowlight=lowlight2(imageData);
 M = uint8(SMQT(double(lowlight),1,8));
 montage({imageData,M})
 title('Hybrid of best 2 algorithm with respect to Brisque (lowlight->SMQT)')
 end

 elseif (bricounterlowlight<=bricounterweiner) && (bricounterSMQT>=bricounterlowlight)
 %lowlight lowest smqt and weiner
 if bricounterSMQT>bricounterweiner
 M = uint8(SMQT(double(imageData),1,8));
 weiner=weinerFinal(M);
 montage({imageData,weiner})
 title('Hybrid of best 2 algorithm with respect to Brisque (SMQT->weiner)')
 else
 weiner=weinerFinal(imageData);
 M = uint8(SMQT(double(weiner),1,8));
 montage({imageData,M})
 title('Hybrid of best 2 algorithm with respect to Brisque (weiner->SMQT)')
 end
 end
 %montage({imageData,finalimage})
 pause(1);

end
for k = 1:imagerunner
 jpgFilename = sprintf('%d.jpeg', k);
 fullFileName = fullfile('/home/tangobeer/Desktop/ImageEnchancement/DataSet/robbery',jpgFilename);
 if exist(fullFileName, 'file')
 imageData = imread(fullFileName );
 imageDatagray=rgb2gray(imageData);
 else
 warningMessage = sprintf('Warning: image file does not exist:\n%s', fullFileName);
 uiwait(warndlg(warningMessage));
 end
% M = uint8(SMQT(double(imageData),1,8));
% lowlight=lowlight2(M);
% figure; imshow(lowlight);
 if (imcounterSMQT<= imcounterweiner) && (imcounterSMQT<=imcounterlowlight)
 %SMQT lowest
 if imcounterweiner>imcounterlowlight
 weiner=weinerFinal(imageData);
 lowlight=lowlight2(weiner);
 montage({imageData,lowlight})
 title('Hybrid of best 2 algorithm with respect to IMMSE (weiner->lowlight)');
 else
 lowlight=lowlight2(imageData);
 weiner=weinerFinal(lowlight);
 montage({imageData,weiner})
 title('Hybrid of best 2 algorithm with respect to IMMSE (lowlight->weiner)');

 end

 elseif (imcounterSMQT>= imcounterweiner) && (imcounterweiner<=imcounterlowlight)
 %weiner lowest lowlight and weiner
 if imcounterSMQT>imcounterlowlight
 M = uint8(SMQT(double(imageData),1,8));
 lowlight=lowlight2(M);
 montage({imageData,lowlight})
 title('Hybrid of best 2 algorithm with respect to IMMSE (SMQT->lowlight)')
 else
 lowlight=lowlight2(imageData);
 M = uint8(SMQT(double(lowlight),1,8));
 montage({imageData,M})
 title('Hybrid of best 2 algorithm with respect to IMMSE (lowlight->SMQT)')

 end

 elseif (imcounterlowlight<=imcounterweiner) && (imcounterSMQT>=imcounterlowlight)
 %lowlight lowest smqt and weiner
 if imcounterSMQT>imcounterweiner
 M = uint8(SMQT(double(imageData),1,8));
 weiner=weinerFinal(M);
 montage({imageData,weiner})
 title('Hybrid of best 2 algorithm with respect to IMMSE (SMQT->weiner)')
 else
 weiner=weinerFinal(imageData);
 M = uint8(SMQT(double(weiner),1,8));
 montage({imageData,M})
 title('Hybrid of best 2 algorithm with respect to IMMSE (weiner->SMQT)')
 end

 end
 %montage({imageData,finalimage})
 pause(1);

end
