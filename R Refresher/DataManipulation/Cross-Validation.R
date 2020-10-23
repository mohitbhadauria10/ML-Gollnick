install.packages(dplyr)
babynames = library(babynames)
library(ggplot2)
library(dplyr)
data("babynames")
glimpse(babynames)
str(babynames)
## Getting the data from year 2014
most_popular_females = babynames%>%
  filter(year==2014)%>%
  filter(sex == "F")


## Understanding n-cross Validation
# Consider 3 fold Cross validation
# we will divide iris dataset 150 observation in 3 parts

# We train A & B and, test on C
# We train B & C and test on A
# We train A & C and test on B

# then we take out average of accuracy metric and this will tell how will it 
# perform in Unknown dataset.

## Cross Validation in R
set.seed(123)
# Importing the Library MASS for iris dataset and libarary caret for Cross Validation

library(MASS)
library(caret)

df = iris
str(iris)
# Check the first rows of data
head(iris)
summary(iris)
# Species Variable is Categorical and remaining all continuous.
# Partition the Dataset in training and Test datasets
ind = createDataPartition(df$Species, p = 2/3, list = FALSE)
# Now get train and test datasets
trainDF = df[ind,]
testDF = df[-ind,]

# Caret package will be used for n-cross validation

controlParameters = trainControl(method = "cv",
                                 number = 5,
                                 savePredictions = TRUE,
                                 classProbs = TRUE)






