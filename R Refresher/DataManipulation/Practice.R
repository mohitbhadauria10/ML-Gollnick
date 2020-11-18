# Loading and installing babynames and dplyr package
install.packages(dplyr)
babynames = library(babynames)
library(ggplot2)
library(dplyr)
data("babynames")
glimpse(babynames)  # Function to see glimpse of data.
str(babynames)      # Function to know row and column and structureof data.

## Sorting the data
## Getting the data from year 2014
# All females from 2014 Using dplyr - filter and arrange function

most_popular_females = babynames%>%
  dplyr::filter(year==2014)%>%
  filter(sex == "F")%>%
  arrange(desc(prop))
  

## Column Selection
most_popular_females = babynames%>%
  dplyr::filter(sex=="F")%>%
  filter(year==2014)%>%
  arrange(desc(prop))%>%
  select(name,year)

## Select only top 5 names from them
most_popular_females = babynames%>%
  dplyr::filter(sex=="F")%>%
  filter(year==2014)%>%
  arrange(desc(prop))%>%
  select(name)%>%
  head(n =3)
most_popular_females$name

## Plot Results
# mutate create new variables and keep existing one intact
help(mutate)
babies_to_plot = babynames%>%
  filter(sex=="F")%>%
  mutate(prop = prop*100)%>%
  filter(name %in%most_popular_females$name)

# Create ggplot of top 5 names of 2014
ggplot(babies_to_plot, aes(year, prop, color = name)) +
  geom_line(size =2) +
  xlab("Year")+
  ylab("Proportion")+
  ggtitle("Most Popular Female names in 2014")+
  theme_bw()




## Data Reshaping
school_wide= data.frame(name = c("Mohit", "Ram", "Shyam"),
                        math= c(2,3,4),
                        sport = c(3,4,5),
                        art = c(2,4,5))

##From wide to tidy data
# For transforming wide to tidy, need to use tidyr package and use 
# gather() function
schoolTidy = tidyr::gather(school_wide)
school_tidy = school_wide%>%
  tidyr::gather(key="subject", value= "grade", 2:4)






















