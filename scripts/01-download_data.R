library(opendatatoronto)
library(tidyverse)

library(readr)


# Read data
data <- read_csv(
  file = "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/a7ae08f3-c512-4a88-bb3c-ab40eca50c5e/resource/ceafdcdf-5f41-4ba5-9b69-f4c8e581ab6e/download/Homeless%20deaths%20by%20cause.csv"
  
)


# set pathway
path <- "input/data/data.csv"

# write data
write_csv(x = data, file = path)

