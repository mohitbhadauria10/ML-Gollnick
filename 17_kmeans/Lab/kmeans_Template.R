file_path <- "./data/zoo.csv"
if (!file.exists(file_path)) { 
  dir.create("./data")
  url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/zoo/zoo.data"
  download.file(url = url, 
                destfile = file_path)
}

zoo_raw <- read.csv(file = file_path)
head(zoo_raw)
str(zoo_raw)

# Setting Column Names
colnames(zoo_raw) <- c("animal_name", "hair", "feathers", "eggs", 
                       "milk", "airborne", "aquatic", "predator", "toothed", 
                       "backbone", "breathes",    "venomous",  "fins","legs", 
                       "tail", "domestic", "catsize", "class_type" )

# Data manipulation
summary(zoo_raw)
table(zoo_raw$class_type)

file_class = "./data/class.csv"
sclass_names









