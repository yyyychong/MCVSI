addpath(genpath('E:\Demo_IQA_VSI\IQA\MCVSI'))
% refpath='..\PEID\refimg\';
% encpath='..\PEID\encimg\';
peid_name_mos=load('data.mat');
% ref=peid_name_mos.data.textdata(:,1);
% enc=peid_name_mos.data.textdata(:,2);
mos=peid_name_mos.data.mos.VS;
% 
% objective=[]; 
% for i=1:length(mos)
%       ref_name=ref{i};
%       enc_name=enc{i};
%       a=[refpath,ref_name];
%       b=[encpath,enc_name];
%       ratio=img_feature(imread(a),imread(b)); 
%       objective=[objective;ratio]; 
% end

objective=load('peid_feature.txt'); % The feature similarity degree vector of the PEID
data = 1:1100; 
testnum=load('peidtestnumber.txt');testnum=testnum'; % Test serial number of the model
test_mos=mos(testnum,1); 
data(testnum)=[];
xnum=data;
P=SVR(xnum,testnum,objective,mos);
[srocc,krocc,plcc,rmse] = calculatecorr(P,test_mos);
