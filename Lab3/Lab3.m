%% part 1
%1.2
clear
folders = dir('Face\training');
folders=folders(~ismember({folders.name},{'.','..'}));
subFolders = folders([folders.isdir]);
X = [];
for k = 1 : length(subFolders)
    cur_dr=['Face\training\' subFolders(k).name];
    images=dir(cur_dr);
    images=images(~ismember({images.name},{'.','..'}));
    
    x_i = 0;
    for i=1 : length(images)
        A = imread([cur_dr '\' images(i).name]);
        A = rgb2gray(A);
        x_i = x_i+1;
        X(:,x_i) = reshape(A,[10304,1]);
    end
end
%% part 2

X_mean= mean(X,2);
meanIMG = uint8(reshape(X_mean, [112,92]));
meanIMG = uint8(meanIMG);
imshow(meanIMG)
%imwrite(meanIMG,'‘mean.bmp');
for i = 1:8
    X(:,i) =  X(:,i) - X_mean;
end
T = 1/8*transpose(X)*X;
% 2.1 store eigenvalues       
eValT = eig(T);
[eValT1,eValT2] =eig(T);
eigenvectors = X*eValT1;
% Question 1
plot (diag(eValT2),eValT);


%% 3
[U,D,V] = svd(X);
% 3.1
%EQ 1
W = U(:,1:50)'*X(:,1);
W_mean= mean(W,2);
%3.2
Im = imread('arctichare.png');
Im = rgb2gray(Im);
Im = imresize(Im, [112, 92]);
Im_mean= mean(Im,2);
Im = double(Im);

for i = 1:92
    Im(:,i) =  Im(:,i) - Im_mean;
end


[U1,D1,V1] = svd(Im);

WImage = U1(:,1:50)'*Im(:,1);

EuclideanDistanceImage = norm(W_mean - WImage);


%Q2
Im = imread('Face\training\s1\1.png');
Im = rgb2gray(Im);
Im = imresize(Im, [112, 92]);
Im_mean= mean(Im,2);
Im = double(Im);
for i = 1:92
    Im(:,i) =  Im(:,i) - Im_mean;
end  
[U1,D1,V1] = svd(Im);
WImage = U1(:,1:50)'*Im(:,1);
EuclideanDistanceTest1 = norm(W_mean - WImage);

%Q3
%1
Im = imread('Face\training\s5\5.png');
Im = rgb2gray(Im);
Im = imresize(Im, [112, 92]);
Im_mean= mean(Im,2);
Im = double(Im);
for i = 1:92
    Im(:,i) =  Im(:,i) - Im_mean;
end  
[U1,D1,V1] = svd(Im);
WImage = U1(:,1:50)'*Im(:,1);
EuclideanDistanceTest2 = norm(W_mean - WImage);

%2
Im = imread('Face\training\s6\6.png');
Im = rgb2gray(Im);
Im = imresize(Im, [112, 92]);
Im_mean= mean(Im,2);
Im = double(Im);
for i = 1:92
    Im(:,i) =  Im(:,i) - Im_mean;
end  
[U1,D1,V1] = svd(Im);
WImage = U1(:,1:50)'*Im(:,1);
EuclideanDistanceTest3 = norm(W_mean - WImage);

%3
Im = imread('Face\training\s7\7.png');
Im = rgb2gray(Im);
Im = imresize(Im, [112, 92]);
Im_mean= mean(Im,2);
Im = double(Im);
for i = 1:92
    Im(:,i) =  Im(:,i) - Im_mean;
end  
[U1,D1,V1] = svd(Im);
WImage = U1(:,1:50)'*Im(:,1);
EuclideanDistanceTest4 = norm(W_mean - WImage);


%% Part 4
%4.1
 x_i = 0;
for k = 1 : length(subFolders)
    cur_dr=['Face\training\' subFolders(k).name];
    images=dir(cur_dr);
    images=images(~ismember({images.name},{'.','..'}));
    
    x_i = x_i+1;
    temp = zeros(112, 92);
    for i=1 : length(images)
        A = imread([cur_dr '\' images(i).name]);
        A = double(rgb2gray(A));
        temp = temp +  A/10;
    end
    meanP(x_i,:,: ) = temp;
end
%%Q4
fig = figure();
for i = 1:5
    subplot(1,5,i)
    im(:,:) = uint8(meanP(i,:,:));
    imshow(im);
end
%4.2

Im = imread('Face\training\s1\1.png');
Im = rgb2gray(Im);
Im = imresize(Im, [112, 92]);
Im_mean= mean(Im,2);
Im = double(Im);
for i = 1:92
    Im(:,i) =  Im(:,i) - Im_mean;
end  
[U1,D1,V1] = svd(Im);
WeightImage1 = U1(:,1:50)'*Im(:,1);

Im = imread('Face\training\s40\6.png');
Im = rgb2gray(Im);
Im = imresize(Im, [112, 92]);
Im_mean= mean(Im,2);
Im = double(Im);
for i = 1:92
    Im(:,i) =  Im(:,i) - Im_mean;
end  
[U1,D1,V1] = svd(Im);
WeightImage2 = U1(:,1:50)'*Im(:,1);
%4.3
distanceSample1 = [];
wTest = [];
for i = 1:40
    im = squeeze(meanP(i,:,: ));
    [U,D,V] = svd(im);
    WIMG = U(:,1:50)'*im(:,1);
    wTest = [wTest, WIMG];
    distanceSample1 = [distanceSample1, norm(WIMG- WeightImage1)];
end
[minSample1, shortestdistanceSample1] = min(distanceSample1);

distanceSample2 = [];
for i = 1:40
    im = squeeze(meanP(i,:,: ));
    [U,D,V] = svd(im);
    WIMG = U(:,1:50)'*im(:,1);
    wTest = [wTest, WIMG];
    distanceSample2 = [distanceSample2, norm(WIMG- WeightImage2)];
end
[minSample2, shortestdistanceSample2] = min(distanceSample2);
%4.4
w = [];
for k = 1 : length(subFolders)
    cur_dr=['Face\training\' subFolders(k).name];
    images=dir(cur_dr);
    images=images(~ismember({images.name},{'.','..'}));
    

    for i=1 : length(images)
        A = imread([cur_dr '\' images(i).name]);
        A = rgb2gray(A);
        A = double(A);
        [U,D,V] = svd(A);
        temp = U(:,1:50)'*A(:,1);
        w = [w, temp];
    end
end
%Q6
predictedIndex = zeros(1,80);
for i = 1:80
    d = zeros(1,320);
    for j = 1:320
        d(j) = norm(wTest(:,i) - w(:,j));
    end
    [~, k_nearest] = sort(d);
    k_nearest = floor(k_nearest(1:4)/8-0.01) + 1;
    predictedIndex(i) = mode(k_nearest);
end
A = [1:40;1:40];
A = A(:)';
accuracy = sum(A == predictedIndex)/80;

%Q7


Im = imread('face.jpg');
Im = rgb2gray(Im);
Im = imresize(Im, [112, 92]);
Im_mean= mean(Im,2);
Im = double(Im);
for i = 1:92
    Im(:,i) =  Im(:,i) - Im_mean;
end  
[U1,D1,V1] = svd(Im);
WeightImageFace = U1(:,1:50)'*Im(:,1);