clear;
%% Part 1
x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];
y = [3.32, 1.48, 5.21, 7.82, 6, 9.72, 10.12, 12.22, 13.55, 11.99, 17.18, 18.12, 18.59, 19.91, 19.46];
% 1.2
for i = 1:length(x)
    x(i) = x(i)-mean(x);
end
for i = 1:length(y)
    y(i) = y(i)-mean(y);
end
% 1.3
C = cov(x,y);
% 1.4
eVal = eig(C);
[eVec1, eVec2] = eig(C);

% 1.5
clear
x1 = rand([1 100]);
y1 = rand([1 100]);

for i = 1:length(x1)
    x1(i) = x1(i)-mean(x1);
end
for i = 1:length(y1)
    y1(i) = y1(i)-mean(y1);
end
plot(x1,y1)
C1 = cov(x1,y1);
eVal1 = eig(C1);
[eVec11, eVec12] = eig(C1);
%% Part 2
clear;

%EigenFaces
folders = dir('Face/training');
folders=folders(~ismember({folders.name},{'.','..'}));
subFolders = folders([folders.isdir]);
X = [];
x_i = 0;
for k = 1 : length(subFolders)
    cur_dr=['Face/training\' subFolders(k).name];
    images=dir(cur_dr);
    images=images(~ismember({images.name},{'.','..'}));
    for i=1 : length(images)
        A = imread([cur_dr '\' images(i).name]);
        A = rgb2gray(A);
        x_i = x_i+1;
        X(:,x_i) = reshape(A,[10304,1]);
    end
end
X_mean= mean(X,2);
%Question 4
figure;

meanIMG = uint8(reshape(X_mean, [112,92]));
meanIMG = uint8(meanIMG);
imshow(meanIMG)
imwrite(meanIMG,'‘mean.bmp');

for i = 1:320
    X(:,i) =  X(:,i) - X_mean;
end

T = 1/320*transpose(X)*X;
       
eValT = eig(T);
[eValT1,eValT2] =eig(T);
eigenvectors = X*eValT1;


fig = figure();

%Question 5

for i = 1:5
    subplot(1,5,i)
    imshow(reshape(eigenvectors(:,i),[112,92]),[]);
end
saveas(fig, "Q5_ithEigen.bmp")
%Question 6
fig = figure();

for i = 1:5
    subplot(1,5,i)
    imshow(reshape(eigenvectors(:,i+315),[112,92]),[]);
end
saveas(fig, "Q6_ithEigen.bmp")
%% Part 3: SVD composition
[U,D,V] = svd(X);

%imshow(eigface_1,[])
D2 = 1/320*transpose(D)*D;

%Question 7
fig = figure();
for i = 1:5
    subplot(1,5,i)
    eigface_1 = [reshape(U(:,i),[112,92])];
    imshow(eigface_1,[]);
end
saveas(fig, "Q7_ithEigen.bmp")
%% Part 4: reconstruction
%Question 8
fig = figure();
W = U(:,1:50)'*X(:,9);
im = U(:,1:50)*W + X_mean ;
imshow(reshape(im,[112,92]),[])
saveas(fig, "Q8rec.bmp")
fig = figure();
imshow(reshape(X(:,9),[112,92]),[])
saveas(fig, "Q8org.bmp")
%Question 9
fig = figure();
for i = 1:100
    subplot(10,10,i)
    W = U(:,1:50)'*X(:,i);
    im = U(:,1:50)*W + X_mean ;
    imshow(reshape(im,[112,92]),[])
end
saveas(fig, "Q9rec.bmp")
