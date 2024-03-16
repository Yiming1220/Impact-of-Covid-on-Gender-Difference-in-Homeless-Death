# Data Analysis Visualization
library(ggplot2)

# Define path
cleaned_data_path <- "inputs/cleaned_data.csv"
output_path <- "outputs/figures"

cleaned_data <- read.csv(cleaned_data_path)


age_gender_plot <- ggplot(cleaned_data, aes(x = age_group, y = count, fill = gender)) +
  geom_bar(stat = "identity", position = position_dodge(), width = 0.5, alpha = 0.7) + 
  scale_fill_manual(values = c("#440154FF", "#FDE725FF")) + 
  theme_minimal() +
  labs(title = "Figure 3: Deaths by Age Group and Gender", x = "Age Group", y = "Death Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(file.path(output_path, "age_gender_death.png"), plot = age_gender_plot, width = 8, height = 6, dpi = 300)

# Figure 1: Distribution of Deaths by Cause

data_by_cause <- cleaned_data %>%
  group_by(cause) %>%
  summarise(count = sum(count), .groups = 'drop')

cause_hist = ggplot(data_by_cause, aes(x = cause, y = count, fill = cause)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Distribution of Deaths by Cause", x = "Cause of Death", y = "Death Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_viridis_d()

ggsave(file.path(output_path, "cause_hist.png"), plot = cause_hist, width = 8, height = 6, dpi = 300)


# Figure 2: Distribution of Deaths by Age Group
data_by_age <- cleaned_data %>%
  group_by(age_group) %>%
  summarise(count = sum(count), .groups = 'drop')

age_hist = ggplot(data_by_age, aes(x = age_group, y = count, fill = age_group)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Distribution of Deaths by Age Group", x = "Age Group", y = "Death Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_viridis_d()

ggsave(file.path(output_path, "age_hist.png"), plot = age_hist, width = 8, height = 6, dpi = 300)


# Figure 3: Yearly Total Death
data_by_year <- cleaned_data %>%
  group_by(year) %>%
  summarise(count = sum(count), .groups = 'drop')

year_plot = ggplot(data_by_year, aes(x = factor(year), y = count)) +
  geom_bar(stat = "identity", fill = "#440154FF", width = 0.5, alpha = 0.7) +  # Bar plot with a purple color
  geom_line(aes(group = 1), color = "#FDE725FF", linewidth = 1) +  # Line plot in yellow
  theme_minimal() +
  labs(title = "Figure 4: Yearly Total Death Count", x = "Year", y = "Death Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(file.path(output_path, "yearly_death.png"), plot = year_plot, width = 8, height = 6, dpi = 300)


# Figure 4: Yearly Total Death Count by Gender
data_by_gender_year <- cleaned_data %>%
  group_by(year, gender) %>%
  summarise(count = sum(count), .groups = 'drop')

gender_year_hist = ggplot(data_by_gender_year, aes(x = factor(year), y = count, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Yearly Total Death Count by Gender", x = "Year", y = "Death Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_viridis_d()

ggsave(file.path(output_path, "gender_year_hist.png"), plot = gender_year_hist, width = 8, height = 6, dpi = 300)


# Figure 5: Distribution of Death By Covide
death_counts <- cleaned_data %>%
  group_by(treatment) %>%
  summarise(
    count_mean = mean(count),
    count_sd = sd(count),
    n = n(),
    se = count_sd / sqrt(n)
  ) %>%
  mutate(
    lower_ci = count_mean - qt(1 - (0.05 / 2), n - 1) * se,
    upper_ci = count_mean + qt(1 - (0.05 / 2), n - 1) * se
  )

death_by_covid_plot = ggplot(death_counts, aes(x = treatment, y = count_mean, fill = treatment)) +
  geom_bar(stat = "identity", position = position_dodge(), width = 0.5) +
  geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), width = 0.2, position = position_dodge(0.5)) +
  theme_minimal() +
  labs(title = "Death Counts Before and After COVID with 95% CI",
       x = "Period",
       y = "Death Count") +
  scale_fill_manual(values = c("Before" = "#FDE725FF", "After" = "#440154FF"))

ggsave(file.path(output_path, "death_counts_by_covid.png"), plot = death_by_covid_plot, width = 8, height = 6, dpi = 300)


# Figure 6: Distribution of Death By Covide
data_summary <- cleaned_data %>%
  group_by(gender) %>%
  summarise(
    count_mean = mean(count),
    count_sd = sd(count),
    n = n(),
    se = count_sd / sqrt(n)
  ) %>%
  mutate(
    lower_ci = count_mean - qt(1 - (0.05 / 2), n - 1) * se,
    upper_ci = count_mean + qt(1 - (0.05 / 2), n - 1) * se
  )

death_by_gender_plot <- ggplot(data_summary, aes(x = gender, y = count_mean, fill = gender)) +
  geom_bar(stat = "identity", position = position_dodge(), width = 0.5) +
  geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), width = 0.2, position = position_dodge(0.5)) +
  theme_minimal() +
  labs(title = "Death Counts by Gender with 95% CI",
       x = "Gender",
       y = "Death Count") +
  scale_fill_manual(values = c("Female" = "#FDE725FF", "Male" = "#440154FF"))

ggsave(file.path(output_path, "death_counts_by_gender.png"), plot = death_by_gender_plot, width = 8, height = 6, dpi = 300)


# Figure 7 Death Counts by Gender and COVID Period
data_summary <- cleaned_data %>%
  group_by(gender, treatment) %>%
  summarise(
    count_mean = mean(count),
    count_sd = sd(count),
    n = n(),
    se = count_sd / sqrt(n),
    .groups = 'drop'
  ) %>%
  mutate(
    lower_ci = count_mean - qt(1 - (0.05 / 2), n - 1) * se,
    upper_ci = count_mean + qt(1 - (0.05 / 2), n - 1) * se
  )

death_by_gender_covid_plot <- ggplot(data_summary, aes(x = treatment, y = count_mean, fill = gender)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.75), width = 0.7) +
  geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), width = 0.25, position = position_dodge(width = 0.75)) +
  theme_minimal() +
  labs(title = "Death Counts by Gender and COVID Period with 95% CI",
       x = "COVID Period",
       y = "Death Count") +
  scale_fill_manual(values = c("Female" = "#FDE725FF", "Male" = "#440154FF"))
ggsave(file.path(output_path, "death_counts_by_gender_covid.png"), plot = death_by_gender_covid_plot, width = 8, height = 6, dpi = 300)
