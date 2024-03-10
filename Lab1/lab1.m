clear
%Question 1
vec = 2:3:100;
p = randperm(length(vec));
output = zeros(1,length(vec));
for i = 1:length(vec)
    output(i) = vec(p(i));
end
disp("Q1")
disp(output)
%Question 2
A=[1 3 5; 2 4 6;7 8 9];
B = A(2,:);
C = A(:,2);
D = A(:);
E = D([end:-1:5]);
disp("Q2")
disp(A)
disp(B)
disp(C)
disp(D)
disp(E)

Im = imread('lena_gray.bmp');
[height, width] = size(Im);
imshow(Im);
%method 1
sIm = Im(1:4:height, 1:4:width);
imshow(sIm);
imwrite(sIm,'Q3M1.bmp');
%method 2
FUN=@(x) mean2(x.data);
meansIm = uint8(blockproc(Im, [4 4], FUN));
imshow(meansIm);
imwrite(meansIm,'Q3M2.bmp');

%Question 4
bLiIm = imresize(meansIm, 4, 'nearest');
%imshow(bLiIm);
imwrite(bLiIm,'Q4bLi.bmp');
NNIm = imresize(meansIm, 4, 'bilinear');
%imshow(bLiIm);
imwrite(NNIm,'Q4bNN.bmp');
bCuIm = imresize(meansIm, 4, 'bicubic');
%imshow(bCuIm);
imwrite(bCuIm,'Q4bCu.bmp');

Im2= imread('marbles.bmp');
imwrite(Im2,'marbles.jpg');
imwrite(Im2,'marbles.png');





%2
[Music, Fs] = audioread('symphonic.wav');
[MusicLength, NumChannel] = size(Music);
%sound(Music, Fs);
subplot(2,1,1); plot(Music(:,1)); title('First Channel');
subplot(2,1,2); plot(Music(:,2)); title('Second Channel');



t = 0:1/44100:5;
y = sin(2*pi*262*t);
%sound(y, Fs);

t = 0:1/44100:5;
y=square(2*pi*t);
%sound(y, Fs);

Fs = 10000;
f=[260,260,295,260,350,330,260,260,295,260,390,350,260,260,525,440,350,330,295,465,465,525,350,390,350];

t = 0:1/10000:.5;
y = zeros(1, length(f) * length(t));
for i = 1:length(f)
    for j = 1:length(t)
        y((i-1)*size(t) + j)  = sin(2*pi*f(i)*t(j));
    end
end


%sound(y, Fs);

audiowrite('birthday.wav',y,Fs)
