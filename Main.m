clc
clear
shuttleVideo = VideoReader('TestVideo/Test2.mp4');
ii = 1;
vidHeight=shuttleVideo.Height;
vidWidth=shuttleVideo.Width;
numberOfFrames=round(shuttleVideo.FrameRate* shuttleVideo.duration);
framesToRead = 1:40:numberOfFrames;
% initialize a matrix for all frames to be read
allFrames = zeros(vidHeight, vidWidth, 3, length(framesToRead));
%%
% read in the frames
for k=1:length(framesToRead)
frameIdx = framesToRead(k);
currentFrame   = read(shuttleVideo,frameIdx);
combinedString = sprintf('%d.jpg',k-1);
%    imwrite(currentFrame,combinedString);
if k==1
% cast the all frames matrix appropriately
allFrames = cast(allFrames, class(currentFrame));
end
allFrames(:,:,:,k) = currentFrame;
end
%%
angle=6; %Projection to cylindor angle
finalimage=projection(allFrames(:,:,:,1),angle);
middle=size(allFrames,4)/2;
for k=2:size(allFrames,4)
img1=projection(allFrames(:,:,:,k),angle);
if k>=middle
finalimage=image_stitching(img1,finalimage);
else
finalimage=image_stitching(finalimage,img1);    
end
disp(k);
end
%%
img=lensdistort(finalimage, -0.01);
imshow(img);
%%
subplot(2,1,1),imshow(finalimage);
I2 = lensdistort(finalimage, -0.05); 
I2 = lensdistort(I2, -0.05); 
I2 = lensdistort(I2, -0.05); 
I2 = lensdistort(I2, -0.05); 
subplot(2,1,2),imshow(I2);
%%
% finalimage=image_stitching(allFrames(:,:,:,1),allFrames(:,:,:,2));
% i1=imread('1s.jpg');
% i2=imread('2s.jpg');
% qq=image_stitching(i1,i2);
%%
%img = projection(finalimage,9);
%imshow(img);
%%
angle=4;
img1 =projection(allFrames(:,:,:,1),angle);
img2 =projection(allFrames(:,:,:,2),angle);
%%
img2=projection(img1,-0.5);
figure;
subplot(1,2,1);
imshow(img1);
subplot(1,2,2);
imshow(img2);
%%
%out=image_stitching(img1,img2);