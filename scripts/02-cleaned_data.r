library(readr)
library(dplyr)
library(kableExtra)

# Define path
input_data_path <- "inputs/data.csv"
output_data_path <- "inputs/cleaned_data.csv"
output_table_path <- "outputs/tables"

# Read data
data <- read_csv(input_data_path, locale = locale(encoding = "UTF-8"))


# PLot Head
renamed_data <- data %>%
  rename(
    "ID" = `_id`,
    "Year Of Death" = `Year of death`,
    "Cause Of Death" = Cause_of_death,
    "Age Group" = Age_group,
    "Gender" = Gender,
    "Death Count" = Count
  )

table <- kable(head(renamed_data), format = "latex", booktabs = TRUE, caption = "Preview of Homeless Deaths in Toronto")
writeLines(table, con = file.path(output_table_path, "head.tex"))




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
    age = Age,
    age_group = Age_group
  )

# create covid-19 treatment (i.e., before/after covid for later use)
data$treatment <- ifelse(cleaned_data$year < 2020, "Before", "After")

write.csv(data, file = output_data_path, row.names = FALSE)

