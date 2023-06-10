%
% refpath - Address of database reference image (grayscale image,  0~255)
% encpath - Address of encrypted images in the database (grayscale image,  0~255)
% ivc_name_mos - Relevant data of the database (names of original and encrypted images and corresponding subjective values)
% 
refpath='.\IVC-SelectEncrypt\SelectiveEncryption\images\ref\';
encpath='.\IVC-SelectEncrypt\SelectiveEncryption\images\enc\';
Database_related=load('.\IVC\ivc_ref_enc_mos.mat');
ref=Database_related.refname;
enc=Database_related.encname;
mos=Database_related.mos;

% Cycle through the database to calculate the feature similarity vector for each pair of images
objective=[];
for i=1:length(mos)
      ref_name=ref{i};
      enc_name=enc{i};
      a=[refpath,ref_name];
      b=[encpath,enc_name];
      ratio=img_feature(imread(a),imread(b)); 
      objective=[objective;ratio]; 
%       biaoji=i %tab
end

% Taking the data pattern of the database "IVC-SelectEncrypt" as an example, 
% the database was randomly divided into 80% and 20% according to the reference image division, 
% and training and testing sequences xnum and testnum were obtained

% objective=load('.\IVC\ivc_feature.txt'); % The feature similarity degree vector that has been calculated

data = 1:200; 
step = 25; 
numSelected = 5;  
testnum = [];  
for i = 1:step:numel(data)
    indices = randperm(step, numSelected); 
    testnum = [testnum, data(i+indices-1)];  
end
data(testnum)=[];
xnum=data;
test_mos=mos(testnum,1); 

P=SVR(xnum,testnum,objective,mos);% Training and prediction
[srocc,krocc,plcc,rmse] = calculatecorr(P,test_mos);% Experimental evaluation index



