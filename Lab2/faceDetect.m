C = webcamlist;
cam=webcam(C{1});
preview(cam);
NotYet = false;
faceDetector = vision.CascadeObjectDetector;
while ~NotYet
pause(2);
I = snapshot(cam);
disp('took a snapshot. checking to find a face ....')
bboxes = step(faceDetector, I);
if ~isempty(bboxes)
NotYet = true;
disp('face found!');
break;
end
disp('no face detected :(, repeating...');
end
closePreview(cam);
clear('cam');
face=rgb2gray(imcrop(I, bboxes));
face_result=imresize(face,[112 92]);
x=input('Enter the name for the image','s')
imwrite(face_result,strcat(x,'1.jpg'));
