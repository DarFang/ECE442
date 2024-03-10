%%  Mean Frame Method
% question 1
clear
disp("Q1")
v1 = VideoReader("streetGray.mp4");
frame = read(v1, 400);
frame = rgb2gray(frame);
frame = double(frame);
nFrames = v1.NumberOfFrames;
h = v1.Height;
w = v1.Width;
frame_mean = zeros(h, w);
for i=1 : nFrames
    A = read(v1, i);
    A = double(rgb2gray(A));
    frame_mean = frame_mean +  A/nFrames;
end
fig = figure();
frame_mean = uint8(frame_mean);
imshow(frame_mean)
imwrite(frame_mean,'frameMean.bmp');
Threshold = 50;
forground = zeros(h,w);
for i = 1:h
    for j = 1:w
        if (abs(frame_mean(i,j) - frame(i,j)) > Threshold)
            forground(i,j) = frame(i,j);
        end
    end
end
fig = figure();
forground = uint8(forground);
imshow(forground)
imwrite(forground,'Q2Frame400Threshold50.bmp');
%% Mixture Gaussian Method
%Question 3
disp("Q3")
X = zeros(240,1);
for i = 1:240
    A= rgb2gray(read(v1,i));
    X(i) = A(50,50);
end
K = 5;
t = (-0.5:0.01:0.5)';
GModel = fitgmdist(X,K, "RegularizationValue", 0.1, "Start", "randSample", "Options", statset("MaxIter",500));
forground1= zeros(h,w);
Threshold = 0.001;
for i = 1:h
    for j = 1:w
        T = frame(i, j);
        pdf_t = pdf(GModel, T+t);
        P = trapz(T+t, pdf_t);
        if (P<Threshold)
            forground1(i,j) = T;
        end
    end
end
fig = figure();
forground1 = uint8(forground1);
imshow(forground1)
imwrite(forground1,'Q3K5.bmp');
disp("Q4")
%Question 4
K = [3,1];
for k = 1:2
    GModel = fitgmdist(X,K(k), "RegularizationValue", 0.1, "Start", "randSample", "Options", statset("MaxIter",500));
    forground1= zeros(h,w);
    for i = 1:h
        for j = 1:w
            T = frame(i, j);
            pdf_t = pdf(GModel, T+t);
            P = trapz(T+t, pdf_t);
            if (P<Threshold)
                forground1(i,j) = T;
            end
        end
    end
    fig = figure();
    message = ['Q4K' num2str(K(k)) '.bmp'];
    imwrite(uint8(forground1),message);
    imshow(uint8(forground1))

end
%Question 5
disp("Q5")
Threshold = [0.0001, 0.001, 0.01];
K = 5;
GModel = fitgmdist(X,K, "RegularizationValue", 0.1, "Start", "randSample", "Options", statset("MaxIter",500));
forground1= zeros(300,400);
forground2= zeros(300,400);
forground3= zeros(300,400);
offseth = (h/2-150);
offsetw = (w/2-200);
for i = offseth:offseth+300
    for j = offsetw:offsetw+400
        T = frame(i, j);
        pdf_t = pdf(GModel, T+t);
        P = trapz(T+t, pdf_t);
        k = i-offseth;
        m = j - offsetw;
        if (P<Threshold(3))
            forground3(k+1,m+1) = T;
            if (P<Threshold(2))
                forground2(k+1,m+1) = T;
                if (P<Threshold(1))
                    forground1(k+1,m+1) = T;
                end
            end
        end
    end
end
fig = figure();
imshow(uint8(forground1))
imwrite(uint8(forground1),'Q5K5A.bmp');
fig = figure();
imshow(uint8(forground2))
imwrite(uint8(forground2),'Q5K5B.bmp');
fig = figure();
imshow(uint8(forground3))
imwrite(uint8(forground3),'Q5K5C.bmp');
disp("done")