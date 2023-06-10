% refpath='.\images\ref\';
% encpath='.\images\enc\';
Database_related=load('ivc_ref_enc_mos.mat');
% ref=Database_related.refname;
% enc=Database_related.encname;
mos=Database_related.mos;

% objective=[];
% for i=1:length(mos)
%       ref_name=ref{i};
%       enc_name=enc{i};
%       a=[refpath,ref_name];
%       b=[encpath,enc_name];
%       ratio=img_feature(imread(a),imread(b)); 
%       objective=[objective;ratio]; 
% end
objective=load('ivc_feature.txt'); % IVC数据库图像的特征相似度向量
data = 1:200;
testnum=load('model1_testnum.txt');
data(testnum)=[];
xnum=data;
test_mos=mos(testnum,1); 

P=SVR(xnum,testnum,objective,mos);
[srocc,krocc,plcc,rmse] = calculatecorr(P,test_mos);



