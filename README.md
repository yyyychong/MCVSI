#  Visual security index of selective encrypted images based on multi-directional structure and content-aware features  

In this work, we propose a multi-directional structure and content-aware features-based visual security index (MCVSI) to perform an objective assessment on selectively encrypted images. 

![1686053616632](https://github.com/yyyychong/MCVSI/blob/master/framework.png)

## Dataset

> IVC-SelectEncrypt

The [IVC-SelectEncrypt](http://f.autrusseau.free.fr/Databases/SelectiveEncryption/) database provides 200 encrypted images from 8 reference gray-scale images of size 720 × 480, encrypted with 5 different encryption schemes at 5 levels of security.

> Perceptually Encrypted Image Database (PEID)

The [PEID](https://sites.google.com/site/xiangtaooo/) database contains 20 reference gray-scale images of size 512 × 512, encrypted using 10 different encryption schemes at 4 to 6 level of perceptually encrypted images, resulting in a total of 1080 encrypted images.

## Experiments

All experiments were conducted on MATLAB 2019b under the software platform of Windows 10 Home Chinese version.

Two selective encryption databases, IVC-SelectEncrypt and PEID, were used to output experimental results.

This table shows the overall experimental results on the IVC-SelectEncrypt database (Black bold panel indicates the best experimental results).

| Evaluation                                                   | PSNR  | SSIM      | VIF   | LSS   | ESS   | LFBVS | VSI-Canny | MCVSI     |
| ------------------------------------------------------------ | ----- | --------- | ----- | ----- | ----- | ----- | --------- | --------- |
| μ<sub>D</sub> | 0.156 | **0.122** | 0.170 | 0.222 | 0.343 | 0.254 | 0.154     | 0.134     |
| σ<sub>D</sub> | 0.101 | 0.184     | 0.101 | 0.188 | 0.188 | 0.174 | 0.089     | **0.079** |
| max<sub>D</sub> | 0.394 | 0.708     | 0.404 | 0.520 | 0.610 | 0.613 | 0.415     | **0.304** |
| PLCC                                                         | 0.915 | 0.891     | 0.939 | 0.919 | 0.901 | 0.891 | 0.942     | **0.975** |
| SRCC                                                         | 0.911 | 0.869     | 0.939 | 0.932 | 0.909 | 0.891 | 0.935     | **0.955** |
| KRCC                                                         | 0.743 | 0.702     | 0.791 | 0.786 | 0.747 | 0.712 | 0.776     | **0.836** |
| RMSE                                                         | 0.543 | 0.645     | 0.455 | 0.658 | 0.506 | 0.601 | 0.446     | **0.299** |

 For details of the experiments, please see the paper. 

## Usage

 For evaluating, we provide two ways: 

1. Evaluate an image

You can predict the image by modifying the loaded images `img1ori `and `img2ori` in the `Predict_one_ picture.m` file and using the model `peidmodel.mat` or `ivcmodel.mat` we have trained.

2. Train the model and evaluate the database images

You can train and predict by modifying the address `refpath` and `encpath` of the original image and the encrypted image of the database in the `Predict_database.m` file, and modify the relevant information of the database `Database_related `(including the original image, the encrypted image and the corresponding subjective score MOS) of the database.

Note that the database is divided into 80% of the training set and 20% of the data set according to the reference image.

## File specification

1. img_feature.m 

Extracting the feature similarity vector between the original image and the encrypted image.

2. Predict_database.m

Train and predict on the database.（Taking database IVC-SelectEncrypt as an example）

3. SVR.m 

Calculate the regression relationship between feature similarity vector and image visual security score, and train the visual security model.

4. Predict_one_ picture.m

Use the trained model to predict the result of an image.

5. func_Gm.m

Calculate the gradient map.

6. GSIM.m

Calculate the structural similarity of images.

7. generate_data_mat.m

Integrate database related information into MAT files.

8. logistic_fun.m

nonlinear fitting function.

9. calculatrcorr.m

Calculate sroc, krocc, plcc, and rmse between predicted and true values.

10. generate_data_mat.m

Integrate database related information into MAT files.

##  Pretrained models

We have trained two models on IVC-SelectEncrypt and PEID databases that you can find in `.\ IVC\ ` and `.\PEID\ `.In addition, the two folders also house the experimental data from the pre-trained models.

