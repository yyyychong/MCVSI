% Calculate the gradient map
function [Gm] = func_Gm(input)
G1=[0  0  0  0  0
    1  3  8  3  1
    0  0  0  0  0
   -1 -3 -8 -3 -1
    0  0  0  0  0];

G2=[0 0  1  0  0
    0 8  3  0  0
    1 3  0 -3 -1
    0 0 -3 -8  0
    0 0 -1  0  0];

G3=[0  0  1 0 0
    0  0  3 8 0
   -1 -3  0 3 1
    0 -8 -3 0 0
    0  0 -1 0 0];

G4=[0 1 0 -1 0
    0 3 0 -3 0
    0 8 0 -8 0
    0 3 0 -3 0
    0 1 0 -1 0];
[H,W]=size(input);
grad=zeros(H,W,4);
grad(:,:,1) = filter2(G1,input)/16;
grad(:,:,2) = filter2(G2,input)/16;
grad(:,:,3) = filter2(G3,input)/16;
grad(:,:,4) = filter2(G4,input)/16;
Gm = max(abs(grad),[],3);
end
