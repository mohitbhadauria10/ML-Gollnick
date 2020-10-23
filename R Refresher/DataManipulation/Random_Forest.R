# We will discuss Random Forest using iris dataset.
# Set seeds, so each time when you run, you will get the same results.

set.seed(123)
library(MASS)
library(randomForest)
birthwt = MASS::birthwt
str(birthwt)
head(birthwt)
help("birthwt")
summary(birthwt)

# Numeric and Categorical Values - race, smoke, low, ptl, ht, ui
# Target Variable -  
# dividing dataset to train and test dataset

## Function to check number of Unique Values
help(apply)
apply(birthwt, 2, function(x) length(unique(x)))

par(mfrow=c(1,2))
hist(birthwt$race)
hist(birthwt$smoke)

## Seems Like variables - low, race, smoke, ptl, ht, ui, ftv are categorical so we need to 
# convert them to factors.
# we can use - as.factor

# Converting all Categorical Data to Factor Variables
col = c("low","race","smoke","ptl","ht","ui","ftv")
for (i in col) {
  df[,i] = as.factor(df[,i])
}

## Create Train and Test Datasets by using Split Method of caTools
install.packages("caTools")
library(caTools)
# target Variable - low
ind = sample.split(Y = df$low, SplitRatio = 0.7)
trainDF = df[ind,]
testDF = df[-ind,]









