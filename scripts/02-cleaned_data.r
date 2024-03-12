library(readr)
library(dplyr)

# Define path
input_data_path <- "inputs/data.csv"
output_data_path <- "inputs/cleaned_data.csv"

# Read data
data <- read_csv(input_data_path, locale = locale(encoding = "UTF-8"))

# Data cleaning
# define a function to map categorical age to numerical
process_age <- function(age_group) {
  age_map <- list(
    "20-39" = round(mean(c(20, 39))),
    "40-59" = round(mean(c(40, 59))),
    "60+" = 70,
    "<20" = 15
  )
  
  if (age_group %in% names(age_map)) {
    return(age_map[[age_group]])
  } else {
    return(NA) 
  }
}

# Apply the function to Age_group column
data$Age <- sapply(data$Age_group, process_age)

# fill NA in age with mean
mean_age <- round(mean(data$Age, na.rm = TRUE))
data$Age[is.na(data$Age)] <- mean_age

# filter out unknown gender type
data <- data %>% filter(Gender != "Unknown")

# only select columns needed in DiD analysis
data <- data %>%
  select(
    year = 'Year of death',
    cause = Cause_of_death,
    gender = Gender,
    count = Count,
    age = Age
  )

# create covid-19 treatment (i.e., before/after covid for later use)
data$treatment <- ifelse(cleaned_data$year < 2020, "Before", "After")

write.csv(data, file = output_data_path, row.names = FALSE)

