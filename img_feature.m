% ========================================================================
%
% Inputs£º
% img1ori - the reference image (grayscale image,  0~255)
% img2ori - the encryption image (grayscale image,  0~255)
% 
% Outputs:
% result: 2-dimensional vector of feature similarity between img1ori and img2ori
% 
% ========================================================================
function result=img_feature(img1ori,img2ori)

% Calculate the gradient similarity between two images
SIM=GSIM(img1ori,img2ori);

% Calculate foreground and background masks based on the original image
img=im2double(img1ori);
threshold=graythresh(img1ori);
mask = img > threshold;

% Calculate bidirectional matching of sift feature points between two images
img1 = single(img1ori); 
img2 = single(img2ori); 
[f1,d1] = vl_sift(img1);
[f2,d2] = vl_sift(img2);
[matches1, ~] = vl_ubcmatch(d1, d2);
[matches2, ~] = vl_ubcmatch(d2, d1);
index1 = matches1(1, :);  
index2 = matches2(2, :); 
[intersection_indices,~,~]=intersect(index1,index2);
intersection_coordinates = f1(1:2, intersection_indices)';  

% Using mask to filter the original image feature points
ori_point_x=f1(1,:);
ori_point_y=f1(2,:);
ori_is_foreground = mask(sub2ind(size(mask), round(ori_point_y),round(ori_point_x)));
ori_point_sum=sum(ori_is_foreground);
% Using mask to filter bi-directional matching feature points
is_foreground = mask(sub2ind(size(mask),round(intersection_coordinates(:, 2)),round(intersection_coordinates(:, 1))));
mate_point_sum=sum(is_foreground);
point_ratio=mate_point_sum/ori_point_sum;

result=[point_ratio,SIM];