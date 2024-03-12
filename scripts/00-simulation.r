file_path = "inputs/simulated_data.csv"

set.seed(100) 

num_obs <- 1000

# simulate year
year <- sample(2017:2022, size = num_obs, replace = TRUE)

# simulate Age
simulated_age <- rnorm(num_obs, mean = 50, sd = 10)
simulated_age <- round(simulated_age)

# simulate cause of death
simulated_cause_of_death <- sample(c("Accident", "Cancer", "Cardiovascular Disease","Drug Toxicity","Suicide","Pneumonia","Other","COVID-19","Homicide","Drug Toxicity"), num_obs, replace = TRUE)

# simulate gender
simulated_gender <- sample(c("Male", "Female"), num_obs, replace = TRUE)

# simulate death count
death_count <- floor(1 + (runif(num_obs)^10) * 50)

# create simulated dataset
simulated_data <- data.frame(Year = year, Age = simulated_age, Cause_of_death = simulated_cause_of_death, Gender = simulated_gender, Death_count = death_count)

write.csv(simulated_data, file = file_path, row.names = FALSE)
