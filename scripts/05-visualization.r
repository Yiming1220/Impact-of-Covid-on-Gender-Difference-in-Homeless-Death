# Data Analysis Visualization
library(ggplot2)

# Define path
cleaned_data_path <- "inputs/cleaned_data.csv"
output_path <- "outputs/figures"

cleaned_data <- read.csv(cleaned_data_path)

# histogram of age distribution
age_histogram <- ggplot(cleaned_data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black", alpha = 0.8) +
  labs(title = "Distribution of Age", x = "Age", y = "Frequency")
ggsave(file.path(output_path, "age_histogram.png"), plot = age_histogram, width = 8, height = 6, dpi = 300)


# bar plot of death cause
cause_of_death_barplot <- ggplot(cleaned_data, aes(x = cause, fill = cause)) +
  geom_bar() +
  labs(title = "Distribution of Cause of Death", x = "Cause of Death", y = "Death Count") +
  theme(legend.position = "none")
ggsave(file.path(output_path, "cause_of_death_barplot.png"), plot = cause_of_death_barplot, width = 8, height = 6, dpi = 300)


# scatter plot of age_group vs. count
age_count_scatter <- ggplot(cleaned_data, aes(x = age, y = count)) +
  geom_point(color = "blue", alpha = 0.6) +
  labs(title = "Scatter Plot of Age vs. Death Count", x = "Age", y = "Death Count")
ggsave(file.path(output_path, "age_count_scatter.png"), plot = age_count_scatter, width = 8, height = 6, dpi = 300)

