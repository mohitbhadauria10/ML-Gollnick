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
