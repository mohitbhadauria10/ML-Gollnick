## data Import
install.packages("dplyr")
library(dplyr)
install.packages("ggplot2")
library(ggplot2)
data("starwars")
set.seed(123)
glimpse(starwars)
str(starwars)
#View(starwars)

## data Visualization
plot_height_mass = function(df){
  g = ggplot(df, aes(x = height, y = mass))
  g= g+ geom_point()
  g = g + geom_smooth(method = "lm", se = F)
  g
}
plot_height_mass(starwars)
plot(starwars$mass ~ starwars$height, data = starwars,
   #  title="Mass and HeightRelationship",
     xlab="Height",
     ylab= "mass")


## Remove Outliar
starwars%>%
  filter(mass>1000)%>%
  select(name,height,mass)

##Another dataframe 
starwars_filt = starwars%>%
  filter(mass<1000)
plot_height_mass(starwars_filt)

## Modeling
starwars_model = lm(mass~height, data = starwars_filt)
## Check attributes of model
summary(starwars_model)$r.squared

## Predictions
starwars_model_p = predict(starwars_model, newdata = starwars_filt )
plot_height_mass(starwars_filt)


## Exercise 
## Import the data from lava package
install.packages("lava")
library(lava)
data("hubble")
View(hubble)
str(hubble)
glimpse(hubble)
help(hubble)
## Checking if linear model exist in V and D
plot(hubble$D ~ hubble$v, data = hubble)
plot(hubble$v ~ hubble$D, data = hubble)
# hence there is a linear relationship between distance and velocity
# Creating a Model
hubble_model = lm(D~v, data = hubble)
summary(hubble_model)
summary(hubble_model)$r.squared


## Predictions
new_data = data.frame(v = seq(0,30000, 1000))
new_data$D_pred = predict(hubble_model, newdata = new_data)



#### Polynomial Regression

## Data Creation
x = seq(-20,40,.5)
y = 50+.25*(x-5)**3
plot(y~x)
y_noise = y+rnorm(n = length(y),mean = 100, sd = 500)
sample_data = data.frame(x,y,y_noise)

## Visualization
plot(y~x, data = sample_data)
g = ggplot(sample_data, aes(x =x,y= y_noise))
g = g+ geom_point()
g = geom_line(aes(y=y), col="red", size=1)
g

## Linear Model
lm_fit = lm(y_noise~x, data = sample_data)
summary(lm_fit)$r.squared
# Since r squared is .77 so its not equal to 1, hence this is a underfit data.

## Polynomial Models
quad_fit = lm(y_noise~x + I(x^2), data = sample_data)
summary(quad_fit)
summary(quad_fit)$r.squared
cubic_fit = lm(y_noise ~x +I(x^2) +I(x^3), data = sample_data)
summary(cubic_fit)
summary(cubic_fit)$r.squared
poly_fit = lm(y_noise~poly(x,25), data = sample_data)
summary(poly_fit)
model_fitted = fitted(poly_fit)
model_residuals = residuals(poly_fit)
plot(model_fitted, model_residuals)

## Predictions
sample_data$y_pred = predict(poly_fit, newdata=sample_data)

## Visualization using predicted vs actual values
plot(sample_data$y_pred, sample_data$y_noise)

## Model Performance
model_summary = summary(poly_fit)
model_summary$adj.r.squared
model_summary$r.squared





## Multivariate Linear Regression
# Data Understanding
install.packages("dplyr")
install.packages("tibble")
install.packages("tidyr")
install.packages("ggplot2")
install.packages("corplot")
install.packages("car")
install.packages("caret")
library(dplyr)
library(tibble)
library(dplyr)
library(tidyr)
library(ggplot2)
library(corplot)
library(car)
library(caret)

## Data Import
file_path <- "./data/airfoil_noise.txt"
if (!file.exists(file_path)) {
  dir.create("./data")
  url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00291/airfoil_self_noise.dat"
  download.file(url = url, 
                destfile = file_path)}
airfoil_noise <- read.table(file = file_path)


## Data Summary
summary(airfoil_noise)
glimpse(airfoil_noise)
str(airfoil_noise)

## Check Collinearity
pairs(airfoil_noise)

## Correlation Matrix
cor_df = cor(airfoil_noise)
# Need to understand correlation matrix

## Modelling
model = lm(V1~., data = airfoil_noise)
summary(model)

## Predictions
airfoil_noise$pred = predict(model, newdata = airfoil_noise)
## Model Performance
model_summary = summary(model)
model_summary$adj.r.squared
# Error Independence
res = residuals(model)
car::qqplot(res)





















