data <- read.csv("data/presidential_2008-2016.csv.bz2", stringsAsFactors = FALSE, sep = "\t")
<<<<<<< HEAD
View(data)
=======
>>>>>>> markdown-connor

describeData <- function(data) {
  summary <- list()
  summary$counties <- nrow(data)
  summary$uniqueCounties <- length(unique(data$county))
  summary$total2008 <- sum(data$total_2008)
  summary$total2012 <- sum(data$total_2012)
  summary$total2016 <- sum(data$total_2016)
  summary$uniqueStates <- length(unique(data$state))
  return(summary)
}

print(describeData(data))
