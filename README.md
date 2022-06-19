# CCTV-FOOTAGE-ENHANCEMENT


A criminal investigation may be thought of as a set of questions: who was engaged in an event, where did it occur, what occurred, when did it occur, why did it occur, and how were any crimes committed. A high-quality video might allow investigators to observe an entire incident develop in full, revealing details such as the order of events, the tactics utilised, and the offender's access and leave routes. Even if this isn't feasible, CCTV footage may be valuable in correlating or disputing other evidence of what occurred

Image improvement is a focus of our research, we planned to promote the notion of boosting CCTV video because high-quality film or images would help investigators better grasp the case. we used four techniques to improve the images:

#### 1)Successive Mean Quantization Transform(SMQT):

SMQT is a contrast enhancement method that improves the image while revealing the data structure. There are levels in SMQT (like in a binary tree). If the total number of levels in the tree is L, the weight of each level is 2(L-i), where i>0 && i=L. After identifying the MQU, we partition the picture into two parts: one with all ones and the other with all zeros

#### 2)Low light image enhancement

Due to low lighting circumstances, images recorded in outdoor situations might be severely affected. Low dynamic range and excessive noise levels in these photos might influence the overall effectiveness of computer vision systems. Use low-light image enhancement to increase the visibility of an image to make computer vision algorithms more resilient in lowlight circumstances. The histogram of low-light or HDR photographs inverted pixel-by-pixel is remarkably similar to the histogram of hazy images.

#### 3)Wiener Filter

The Wiener filter is a method for improving photographs by removing blur.With the use of fourier transformations, it focuses on reducing the MSE between the original picture and the rebuilt image

#### 4)Morphological operators
Morphology refers to a group of image processing methods that work with pictures depending on their forms. There are four primary operations. 

a) Dilation:
   White pixels dilate or expand, while black pixels contract. 
b) Erosion: 
   The opposite of dilation. 
c) Closure: 
    Dilation followed by erosion.



## Screenshots of output:
![image](https://user-images.githubusercontent.com/63915610/174473241-8a4cd08a-b1e2-404d-b4ab-617aedee8e6a.png)
![image](https://user-images.githubusercontent.com/63915610/174473257-9379bb91-89f4-4905-89b2-7d9b5d8afc04.png)
![image](https://user-images.githubusercontent.com/63915610/174473275-7863a9f1-e9bf-400d-9060-e5ae21219b9a.png)


