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
df = tibble(x = 1:1000)
n_obs = nrow(df)
head(df)
# Defining Ratio
train_ratio = .6
validation_ratio = .2
test_ratio = (1- train_ratio - validation_ratio)
set.seed(123)
# Calculating sample size for train, valid and test
sample_size_train = floor(train_ratio*n_obs)
sample_size_valid = floor(validation_ratio*n_obs)
sample_size_test = floor(test_ratio*n_obs)
# Calculating Indices
indices_train = base::sample(x=1:n_obs, size = sample_size_train)%>%sort()
indices_not_train = base::setdiff(x = 1:n_obs, indices_train)
indices_valid = base::sample(x=indices_not_train, size = sample_size_valid)
indices_test = base::setdiff(indices_train,indices_not_train)
# getting the dataframe
train = df[indices_train,]
valid = df[indices_valid,]
test = df[indices_test,]

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
c(train,valid,test) %<-% train_val_test_split(df, train_ratio = .6, validation_ratio = .2, test_ratio = .2)








