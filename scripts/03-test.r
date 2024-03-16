cleaned_data_path <- "inputs/cleaned_data.csv"
cleaned_data <- read.csv(cleaned_data_path)

# Test 1: Check Age Range
age_range <- range(cleaned_data$age)
if (age_range[1] < 0 | age_range[2] > 120) {
  print("Age range is not reasonable.")
} else {
  print("Age range is reasonable.")
}


# Test 2: Check for Missing Values
if (any(is.na(cleaned_data))) {
  print("There are missing values in the dataset.")
} else {
  print("No missing values found in the dataset.")
}

# Test 3: Verify Count Values
if (any(cleaned_data$count < 0)) {
  print("There are negative counts in the dataset.")
} else {
  print("All count values are non-negative.")
}