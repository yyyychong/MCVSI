% Calculate the gradient similarity between two images
function mgsim=GSIM(I1,I2)
[H, W]=size(I1);
f = max(1,round(min(H,W)/256));
if(f>1)
    lpf = ones(f,f);
    lpf = lpf/sum(lpf(:));
    I1 = imfilter(I1,lpf,'symmetric','same');
    I2 = imfilter(I2,lpf,'symmetric','same');

    I1 = I1(1:f:end,1:f:end);
    I2 = I2(1:f:end,1:f:end);
end
[grad1]=func_Gm(I1);
[grad2]=func_Gm(I2);
Pm=200;
C=1e-5+Pm*max(grad1,grad2);
g_map=(2*grad1.*grad2+C)./(grad1.^2+grad2.^2+C);
mgsim=mean2(g_map);
end


