% ========================================================================
%
% Inputs£º
% xnum - The training sequence of the database
% testnum - The test sequence of the database
% obj - Feature similarity vector of the original and encrypted images
% subj - The real visual security score of the encrypted image
%
% Outputs:
% Predict: Predictive visual safety scores for the test images
% Save the trained model while exporting Predict
%
% ========================================================================
function Predict=SVR(xnum,testnum,obj,subj)
p_train=obj(xnum,:);   
t_train=subj(xnum,1);
p_test=obj(testnum,:);
t_test=subj(testnum,1);

% Data were normalized
[pn_train,ps1] = mapminmax(p_train');
pn_train = pn_train';
pn_test = mapminmax('apply',p_test',ps1);
pn_test = pn_test';
[tn_train,ps2] = mapminmax(t_train');
tn_train = tn_train';
tn_test = mapminmax('apply',t_test',ps2);
tn_test = tn_test';

% Model creation and training
[c,g] = meshgrid(-10:0.5:10,-10:0.5:10);
[m,n] = size(c);
cg = zeros(m,n);
eps = 10^(-4);
v = 5;
bestc = 0;
bestg = 0;
error = Inf;
for i = 1:m
    for j = 1:n
        cmd = ['-v ',num2str(v),' -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j) ),' -s 3 -p 0.1'];
        cg(i,j) = libsvmtrain(tn_train,pn_train,cmd);
        if cg(i,j) < error
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
        if abs(cg(i,j) - error) <= eps && bestc > 2^c(i,j)
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
    end
end
cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];
model = libsvmtrain(tn_train,pn_train,cmd);
% save('peidmodel',"model");% Save the model
[Predict,~,~] = libsvmpredict(tn_test,pn_test,model);% prediction
