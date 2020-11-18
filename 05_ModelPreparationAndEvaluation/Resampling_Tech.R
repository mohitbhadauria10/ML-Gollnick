### Data Splitting in Train, Validation and Test

# Installing the packages
install.packages("dplyr")
install.packages("caret")
install.packages("keras")
library(dplyr)
library(caret)
library(keras)

### Train/ Validation and Test Split
#Defining Dataset

## Data Import
# if file does not exist, download it first
file_path <- "./data/winequality-red.csv"
if (!file.exists(file_path)) {
  dir.create("./data")
  url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"
  download.file(url = url, 
                destfile = file_path)
}

df <- read.csv(file_path, sep = ";")
floor(nrow(df)*.6)

## Function for train, test and valid
train_val_test_split = function(df, train_ratio = 0.6, validation_ratio=.2, test_ratio = .2){
  n_obs = nrow(df)
  sample_size_train = floor(train_ratio*n_obs)
  sample_size_valid = floor(validation_ratio*n_obs)
  sample_size_test = floor(test_ratio*n_obs)
  
  # Calculating Indices
  indices_train = base::sample(x=1:n_obs, size = sample_size_train)%>%sort()
  indices_not_train = base::setdiff(x = 1:n_obs, indices_train)
  indices_validation = base::sample(x=indices_not_train, size = sample_size_valid)
  indices_test = base::setdiff(indices_train,indices_not_train)
  
  # getting the dataframe
  train = df[indices_train,]
  valid = df[indices_valid,]
  test = df[indices_test,]
  list(train,valid,test)
  
}

## Simple Train/Validation Split
c(train,valid,test) %<-% train_val_test_split(df, train_ratio = .6, validation_ratio = .2, test_ratio = .2)
model_train = caret::train(quality~., method ="lm", data = train)


## Training Performance
train$quality_pred = predict(object = model_train, newdata = train)
caret::postResample(pred = train$quality_pred, obs = train$quality)

## Validation Performance
valid$quality_valid = predict(object = model_train, newdata = valid)
caret::postResample(pred = valid$quality_valid, obs = valid$quality)


## Cross Validation - 10 Fold validation
c(train_val,dummy,test) %<-% train_val_test_split(df, train_ratio = .8, validation_ratio = 0, test_ratio = .2)
train_control = trainControl(method = "cv", number = 10)
model_10fold_cv = caret::train(quality ~., data = train_val, 
                               trControl = train_control,
                               method = "lm")
model_10fold_cv

## Check The performance
test$quality_pred = predict(object = model_10fold_cv, newdata = test)
caret::postResample(pred = test$quality_pred, obs = test$quality)

### Leave Out CV
train_control = trainControl(method = "LOOCV" )
model_loocv = caret::train(quality~., data=train_val, 
                           trControl = train_control,
                           method="lm")
model_loocv

## Model Performance
test$quality_pred = predict(object = model_loocv, newdata = test)
caret::postResample(pred = test$quality_pred, obs = test$quality)






