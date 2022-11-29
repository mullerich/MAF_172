---
title: "O Fantástico Mundo do R - Parte VIII"
author: "Prof. Gérson Santos - IEF/UFV"
fig_caption: yes
output:
  html_document:
    highlight: pygments
    keep_md: yes
    lib_dir: libs
    mathjax: local
    number_sections: yes
    self_contained: no
    theme: cerulean
    toc: yes
    toc_float:
      collapsed: no
      smooth_scroll: yes
  pdf_document:
    toc: yes
  word_document:
    toc: yes
fig_width: 7
header-includes: \usepackage{bbm}
fig_height: 7
editor_options:
  chunk_output_type: console
---

> **ATENÇÃO:**
> Antes de qualquer outra instrução devemos fazer 2 procedimentos:
> 
> 1. Clicar em `File`, `Reopen with Encoding ...` e selecionar `UTF-8`;
> 2. Clicar em `File`, `Save with Encoding ...` e selecionar a opção com os dizeres `System Default`.

# - Diretório de Trabalho

**Importante:** Para configurar seu diretório de trabalho, clique em `Session`, `Set Working Directory` e `Choose Directory`. Então, navegue até sua pasta e clique em `Open`. O comando `setwd` que vai aparecer no Console do R deve ser copiado e colado no chunk abaixo:


```r
getwd()
```

```
## [1] "C:/Users/Usuario/Documents/Erich/GitHub/MAF_172/Semana 7"
```

```r
# setwd("~/Documents/Erich/GitHub/MAF_172/Semana 7")
getwd()
```

```
## [1] "C:/Users/Usuario/Documents/Erich/GitHub/MAF_172/Semana 7"
```

# - Machine Learning

## - Pacotes

Em primeiro lugar faremos o carregamento dos pacotes que usaresmos:


```r
# install.packages("pacman")
library(pacman)
```

```
## Warning: package 'pacman' was built under R version 4.2.2
```

```r
p_load(char=c("DescTools","readxl","janitor", "psych", "corrr", 
              "ggplot2", "dplyr", "caret", "corrplot","spatstat",
              "maptools", "gstat", "foreign",
              "geoR","moments","scatterplot3d","tcltk2",
              "sp", "rgdal", "raster", "doParallel", "GGally",
              "lattice", "e1071", "rpart", "mlbench",
              "randomForest", "party", "MASS", "vegan"))
```

```
## Installing package into 'C:/Users/Usuario/AppData/Local/R/win-library/4.2'
## (as 'lib' is unspecified)
```

```
## Warning: unable to access index for repository http://www.stats.ox.ac.uk/pub/RWin/bin/windows/contrib/4.2:
##   não foi possível abrir a URL 'http://www.stats.ox.ac.uk/pub/RWin/bin/windows/contrib/4.2/PACKAGES'
```

```
## package 'mlbench' successfully unpacked and MD5 sums checked
## 
## The downloaded binary packages are in
## 	C:\Users\Usuario\AppData\Local\Temp\RtmpAL0yIJ\downloaded_packages
```

```
## 
## mlbench installed
```

```
## Warning: package 'mlbench' was built under R version 4.2.2
```

```
## Installing package into 'C:/Users/Usuario/AppData/Local/R/win-library/4.2'
## (as 'lib' is unspecified)
```

```
## Warning: unable to access index for repository http://www.stats.ox.ac.uk/pub/RWin/bin/windows/contrib/4.2:
##   não foi possível abrir a URL 'http://www.stats.ox.ac.uk/pub/RWin/bin/windows/contrib/4.2/PACKAGES'
```

```
## package 'randomForest' successfully unpacked and MD5 sums checked
## 
## The downloaded binary packages are in
## 	C:\Users\Usuario\AppData\Local\Temp\RtmpAL0yIJ\downloaded_packages
```

```
## 
## randomForest installed
```

```
## Warning: package 'randomForest' was built under R version 4.2.2
```

```
## Installing package into 'C:/Users/Usuario/AppData/Local/R/win-library/4.2'
## (as 'lib' is unspecified)
```

```
## also installing the dependencies 'TH.data', 'libcoin', 'matrixStats', 'multcomp', 'modeltools', 'strucchange', 'coin', 'sandwich'
```

```
## Warning: unable to access index for repository http://www.stats.ox.ac.uk/pub/RWin/bin/windows/contrib/4.2:
##   não foi possível abrir a URL 'http://www.stats.ox.ac.uk/pub/RWin/bin/windows/contrib/4.2/PACKAGES'
```

```
## package 'TH.data' successfully unpacked and MD5 sums checked
## package 'libcoin' successfully unpacked and MD5 sums checked
## package 'matrixStats' successfully unpacked and MD5 sums checked
## package 'multcomp' successfully unpacked and MD5 sums checked
## package 'modeltools' successfully unpacked and MD5 sums checked
## package 'strucchange' successfully unpacked and MD5 sums checked
## package 'coin' successfully unpacked and MD5 sums checked
## package 'sandwich' successfully unpacked and MD5 sums checked
## package 'party' successfully unpacked and MD5 sums checked
## 
## The downloaded binary packages are in
## 	C:\Users\Usuario\AppData\Local\Temp\RtmpAL0yIJ\downloaded_packages
```

```
## 
## party installed
```

```
## Warning: package 'party' was built under R version 4.2.2
```

```
## Warning: package 'strucchange' was built under R version 4.2.2
```

```
## Warning: package 'zoo' was built under R version 4.2.2
```

```
## Warning: package 'sandwich' was built under R version 4.2.2
```

```
## Installing package into 'C:/Users/Usuario/AppData/Local/R/win-library/4.2'
## (as 'lib' is unspecified)
```

```
## also installing the dependency 'permute'
```

```
## Warning: unable to access index for repository http://www.stats.ox.ac.uk/pub/RWin/bin/windows/contrib/4.2:
##   não foi possível abrir a URL 'http://www.stats.ox.ac.uk/pub/RWin/bin/windows/contrib/4.2/PACKAGES'
```

```
## package 'permute' successfully unpacked and MD5 sums checked
## package 'vegan' successfully unpacked and MD5 sums checked
## 
## The downloaded binary packages are in
## 	C:\Users\Usuario\AppData\Local\Temp\RtmpAL0yIJ\downloaded_packages
```

```
## 
## vegan installed
```

```
## Warning: package 'vegan' was built under R version 4.2.2
```

```
## Warning: package 'permute' was built under R version 4.2.2
```

## - Support Vector Machine - Classificação


```r
data(Glass, package="mlbench")
head(Glass)
```

```
##        RI    Na   Mg   Al    Si    K   Ca Ba   Fe Type
## 1 1.52101 13.64 4.49 1.10 71.78 0.06 8.75  0 0.00    1
## 2 1.51761 13.89 3.60 1.36 72.73 0.48 7.83  0 0.00    1
## 3 1.51618 13.53 3.55 1.54 72.99 0.39 7.78  0 0.00    1
## 4 1.51766 13.21 3.69 1.29 72.61 0.57 8.22  0 0.00    1
## 5 1.51742 13.27 3.62 1.24 73.08 0.55 8.07  0 0.00    1
## 6 1.51596 12.79 3.61 1.62 72.97 0.64 8.07  0 0.26    1
```

```r
tail(Glass)
```

```
##          RI    Na Mg   Al    Si    K   Ca   Ba Fe Type
## 209 1.51640 14.37  0 2.74 72.85 0.00 9.45 0.54  0    7
## 210 1.51623 14.14  0 2.88 72.61 0.08 9.18 1.06  0    7
## 211 1.51685 14.92  0 1.99 73.06 0.00 8.40 1.59  0    7
## 212 1.52065 14.36  0 2.02 73.42 0.00 8.44 1.64  0    7
## 213 1.51651 14.38  0 1.94 73.61 0.00 8.48 1.57  0    7
## 214 1.51711 14.23  0 2.08 73.36 0.00 8.62 1.67  0    7
```

```r
## split data into a train and test set
index     <- 1:nrow(Glass)
testindex <- sample(index, trunc(length(index)/3))
testset   <- Glass[testindex,]
trainset  <- Glass[-testindex,]
```

Vamos ajustar o modelo de aprendizagem e fazer a predição ainda no banco de treinamento (**lembrando que a variável resposta é a coluna 10**):


```r
## svm
svm.model <- svm(Type ~ ., data = trainset, cost = 100, gamma = 1)
svm.pred  <- predict(svm.model, testset[,-10])
```


```r
## rpart
rpart.model <- rpart(Type ~ ., data = trainset)
rpart.pred  <- predict(rpart.model, testset[,-10], type = "class")
```


```r
# compute svm confusion matrix
table(pred = svm.pred, true = testset[,10])
```

```
##     true
## pred  1  2  3  5  6  7
##    1 17  4  2  0  0  0
##    2  6 22  1  7  1  2
##    3  2  0  0  0  0  0
##    5  0  0  0  0  0  0
##    6  0  0  0  0  2  0
##    7  0  0  0  0  0  5
```


```r
# compute rpart confusion matrix
table(pred = rpart.pred, true = testset[,10])
```

```
##     true
## pred  1  2  3  5  6  7
##    1 18  3  2  0  0  1
##    2  7 20  0  0  0  0
##    3  0  1  1  0  1  0
##    5  0  2  0  7  2  0
##    6  0  0  0  0  0  0
##    7  0  0  0  0  0  6
```

## - Support Vector Machine - Regression


```r
data(Ozone, package="mlbench")
## split data into a train and test set
index     <- 1:nrow(Ozone)
testindex <- sample(index, trunc(length(index)/3))
testset   <- na.omit(Ozone[testindex,-3])
trainset  <- na.omit(Ozone[-testindex,-3])
```



```r
## svm
svm.model <- svm(V4 ~ ., data = trainset, cost = 1000, gamma = 0.0001)
svm.pred  <- predict(svm.model, testset[,-3])
crossprod(svm.pred - testset[,3]) / length(testindex)
```

```
##          [,1]
## [1,] 10.97352
```


```r
## rpart
rpart.model <- rpart(V4 ~ ., data = trainset)
rpart.pred  <- predict(rpart.model, testset[,-3])
crossprod(rpart.pred - testset[,3]) / length(testindex)
```

```
##         [,1]
## [1,] 25.9026
```

## - Random Forest - Classificação


```r
data(readingSkills)
head(readingSkills)
```

```
##   nativeSpeaker age shoeSize    score
## 1           yes   5 24.83189 32.29385
## 2           yes   6 25.95238 36.63105
## 3            no  11 30.42170 49.60593
## 4           yes   7 28.66450 40.28456
## 5           yes  11 31.88207 55.46085
## 6           yes  10 30.07843 52.83124
```

```r
tail(readingSkills)
```

```
##     nativeSpeaker age shoeSize    score
## 195           yes  10 29.48948 50.39916
## 196            no   8 26.44756 37.54887
## 197           yes   5 23.98370 32.17017
## 198           yes   7 27.94532 40.38110
## 199            no   7 26.89888 33.63669
## 200            no   8 26.70672 38.68543
```

```r
# Create the forest
output.forest <- randomForest(nativeSpeaker ~ age + shoeSize + score, 
           data = readingSkills)
# View the forest results
print(output.forest) 
```

```
## 
## Call:
##  randomForest(formula = nativeSpeaker ~ age + shoeSize + score,      data = readingSkills) 
##                Type of random forest: classification
##                      Number of trees: 500
## No. of variables tried at each split: 1
## 
##         OOB estimate of  error rate: 1%
## Confusion matrix:
##     no yes class.error
## no  98   2        0.02
## yes  0 100        0.00
```

```r
# Importance of each predictor
importance(output.forest,type = 2)
```

```
##          MeanDecreaseGini
## age              13.56604
## shoeSize         18.86010
## score            57.44457
```

**Obs.:** Apenas 1% de erro.

## - Random Forest - Regressão


```r
data(Boston)
head(Boston)
```

```
##      crim zn indus chas   nox    rm  age    dis rad tax ptratio  black lstat
## 1 0.00632 18  2.31    0 0.538 6.575 65.2 4.0900   1 296    15.3 396.90  4.98
## 2 0.02731  0  7.07    0 0.469 6.421 78.9 4.9671   2 242    17.8 396.90  9.14
## 3 0.02729  0  7.07    0 0.469 7.185 61.1 4.9671   2 242    17.8 392.83  4.03
## 4 0.03237  0  2.18    0 0.458 6.998 45.8 6.0622   3 222    18.7 394.63  2.94
## 5 0.06905  0  2.18    0 0.458 7.147 54.2 6.0622   3 222    18.7 396.90  5.33
## 6 0.02985  0  2.18    0 0.458 6.430 58.7 6.0622   3 222    18.7 394.12  5.21
##   medv
## 1 24.0
## 2 21.6
## 3 34.7
## 4 33.4
## 5 36.2
## 6 28.7
```

```r
tail(Boston)
```

```
##        crim zn indus chas   nox    rm  age    dis rad tax ptratio  black lstat
## 501 0.22438  0  9.69    0 0.585 6.027 79.7 2.4982   6 391    19.2 396.90 14.33
## 502 0.06263  0 11.93    0 0.573 6.593 69.1 2.4786   1 273    21.0 391.99  9.67
## 503 0.04527  0 11.93    0 0.573 6.120 76.7 2.2875   1 273    21.0 396.90  9.08
## 504 0.06076  0 11.93    0 0.573 6.976 91.0 2.1675   1 273    21.0 396.90  5.64
## 505 0.10959  0 11.93    0 0.573 6.794 89.3 2.3889   1 273    21.0 393.45  6.48
## 506 0.04741  0 11.93    0 0.573 6.030 80.8 2.5050   1 273    21.0 396.90  7.88
##     medv
## 501 16.8
## 502 22.4
## 503 20.6
## 504 23.9
## 505 22.0
## 506 11.9
```

```r
set.seed(1341)
BH.rf <- randomForest(medv ~ ., Boston)
print(BH.rf)
```

```
## 
## Call:
##  randomForest(formula = medv ~ ., data = Boston) 
##                Type of random forest: regression
##                      Number of trees: 500
## No. of variables tried at each split: 4
## 
##           Mean of squared residuals: 10.34864
##                     % Var explained: 87.74
```

> Particionando os dados


```r
set.seed(100)
intrain = createDataPartition(Boston$medv, p = 0.75, list = FALSE)
treino = Boston[intrain,]
valida = Boston[-intrain,]
set.seed(100)
fit.rf = randomForest(medv~., data = treino)
fit.rf
```

```
## 
## Call:
##  randomForest(formula = medv ~ ., data = treino) 
##                Type of random forest: regression
##                      Number of trees: 500
## No. of variables tried at each split: 4
## 
##           Mean of squared residuals: 10.33751
##                     % Var explained: 87.32
```

```r
varImpPlot(fit.rf)
```

![](UseR-8-ML_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

```r
v = predict(fit.rf,valida)
plot(v, valida$medv)
abline(0,1,col = "red")
```

![](UseR-8-ML_files/figure-html/unnamed-chunk-13-2.png)<!-- -->

```r
postResample(v, valida$medv)
```

```
##      RMSE  Rsquared       MAE 
## 3.5851617 0.8680898 2.3151151
```

# - Treinando em ExtraTrees


```r
# ## Installing:
# install.packages("extraTrees")
# ## Loading ExtraTrees:
# library("extraTrees")
# ## Generating artificial data:
# n <- 1000  ## number of samples
# p <- 5     ## number of dimensions
# ## x - inputs
# ## y - outputs to predict
# x <- matrix(runif(n*p), n, p)
# y <- (x[,1]>0.5) + 0.8*(x[,2]>0.6) + 0.5*(x[,3]>0.4) +
#      0.1*runif(nrow(x))
# ## Training and predicting with ExtraTrees:
# et <- extraTrees(x, y)
# yhat <- predict(et, x)
```

