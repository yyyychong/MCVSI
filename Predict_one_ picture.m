% Original images and the encrypted images (grayscale image,  0~255)
img1ori = imread('airport.bmp');
img2ori = imread('airport_02_2.jpg');

% The feature similarity vector was calculated
result=img_feature(img1ori,img2ori)

% Load model (two models have been trained, ivcmodel.mat and peidmodel.mat)
database_model= load('.\PEID\peidmodel.mat');
peidmodel = database_model.model;

% Iutput the model and the feature similarity vectors of  predicted images, and output the prediction results
[Predict,~,~] = libsvmpredict(ones(size(result, 1)),result,peidmodel);% SVR·ÂÕæÔ¤²â
