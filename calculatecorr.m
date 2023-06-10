function [srocc,krocc,plcc,rmse] = calculatecorr(quality,humanscores)
x = quality; 
y = humanscores; 
itr =1;
for fact = 0.01:0.1:10
    itr = itr+1;
beta0 = [max(y) min(y) fact*mean(x) 1 0];
b_blur = nlinfit(x,y,@logistic_fun,beta0);
x_hat = logistic_fun(b_blur,x);
Correlation(itr) = corr(x_hat,y);
rmses(itr) = sqrt(sum((x_hat - y).^2) / length(y));
sroccs(itr) = corr(y, x_hat, 'type','spearman');
kroccs(itr) = corr(y, x_hat, 'type','Kendall');
end
plcc = max(Correlation); number=find(Correlation==plcc);
rmse = rmses(number);
srocc= sroccs(number);
krocc= kroccs(number);