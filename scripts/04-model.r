library(dplyr)
library(stargazer)

cleaned_data_path <- "inputs/cleaned_data.csv"
output_path <- "outputs/tables"

cleaned_data <- read.csv(cleaned_data_path)

# did model
did_model_no_control <- lm(count ~ treatment * gender, data = cleaned_data)
did_model_control <- lm(count ~treatment * gender + cause + age, data=cleaned_data)

# create stargazer to show the regression results
stargazer(did_model_no_control, did_model_control, type = "latex",
          title = "Impact of COVID-19 on Homeless Death Counts by Gender",
          dep.var.labels.include = FALSE,
          dep.var.caption = "Death Count", 
          covariate.labels = c("Pre-COVID Period", "Male", "Pre-COVID * Male"),
          omit = c("^cause", "^age"),
          omit.stat = c("all"), 
          add.lines = list(
            c("Cause of Death Controlled", "No", "Yes"),
            c("Age Controlled", "No", "Yes") 
          ),
          notes = "This table compares the difference in death counts between genders before and after the onset of COVID-19, with and without controls for cause of death and age.",
          out = file.path(output_path, "did_model.tex")
          )

stargazer(did_model_no_control, did_model_control, type = "html",
          title = "Impact of COVID-19 on Homeless Death Counts by Gender",
          dep.var.labels.include = FALSE,
          dep.var.caption = "Death Count", 
          covariate.labels = c("Pre-COVID Period", "Male", "Pre-COVID * Male"),
          omit = c("^cause", "^age"),
          omit.stat = c("all"), 
          add.lines = list(
            c("Cause of Death Controlled", "No", "Yes"),
            c("Age Controlled", "No", "Yes") 
          ),
          notes = "This table compares the difference in death counts between genders before and after the onset of COVID-19, with and without controls for cause of death and age.",
          out = file.path(output_path, "did_model.html")
)
