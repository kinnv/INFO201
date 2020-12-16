# a3-using-data

################################### Set up ###################################

## Before you get started, make sure to set you are in the right working directory.
## Print your working directory (in R, not in shell!) here.

cat(getwd(), "\n")

################################### DataFrame Manipulation ###################################

# Create a vector `first_names` with 5 names in it

first_names <- c("Kin", "Alex", "Alan", "Andrew", "Mercedes")

# Create a vector `math_grades` with 5 hypothetical grades (0 - 100) in a math course (that correspond to the 5 names above)

math_grades <- c(100, 0, 75, 80, 95)

# Create a vector `spanish_grades` with 5 hypothetical grades (0 - 100) in a Spanish course (that correspond to the 5 names above)

spanish_grades <- c(78, 100, 50, 60, 90)

## Create a data.frame `students` by combining your vectors `first_names`, `math_grades`, and `spanish_grades`

students <- data.frame(first_names, math_grades, spanish_grades, stringsAsFactors = FALSE)

# Create a variable `num_students` that contains the number of rows in your data.frame `students`

num_students <- nrow(students)

# Create a variable `num_courses` that contains the number of columns in your data.frame `students` minus one (b/c of their names)

num_courses <- ncol(students) -1

## Add a new column `grade_diff` to your dataframe, which is equal to the difference between
## math_grades and spanish_grades.  Note: use the variables inside the dataframe (like "students$math_grade")
## not the ones in your workspace.

students$grade_diff <- students$math_grades - students$spanish_grades

# Add another column `better_at_math` as a boolean (TRUE/FALSE) variable that indicates that a student got a better grade in math

students$better_at_math <- students$grade_diff > 0


## Compute a variable `num_better_at_math` that is the number (i.e., one numeric value) of students better at math

num_better_at_math <- sum(students$better_at_math == TRUE)

## Write your `students` data.frame to a new .csv file inside your data/ directory with the filename `grades.csv`.
## Make sure not to write row names.

write.table(students, file="data/grades.csv", sep=",", row.names=FALSE)

################################### Loading R Data ###################################

## In this section, you'll work with some data that comes built into the R environment.
## Load the `Titanic` data set.  Inspect it's structure and data in it.
## You may just print a few lines of it, or use RStudio to `View()`

data(Titanic)
View(Titanic)

## This data set actually loads in a format called a *table*
## This is not a data frame. Use the `is.data.frame()` function to confirm this.

is.data.frame("Titanic")

## You should convert the `Titanic` variable into a data frame; you can use the
## `data.frame()` function or `as.data.frame()` Be sure to **not** treat strings as
## factors!

titanic <- as.data.frame(Titanic, stringsAsFactors = FALSE)

## Inspect the resulting data frame.  Make sure you understand what the values mean.
## The data frame has a row:
## 11   3rd   Male Adult       No  387
## What do all these values mean?  In particular, what does the number '387' tell us?

  ## 387 tells us that 387 3rd adult males did not survive

# Create a variable `children` that are the rows of the data frame with information about
# children on the Titanic.

children <- titanic[titanic$Age == "Child",]

# Create a variable `num_children` that is the total number of children on the Titanic.
# Hint: remember the `sum()` function!

num_children <- sum(children$Freq)
cat("There was a total of", num_children, "children on the Titanic.\n")

## Create a variable `most_lost` which has row with the largest absolute number of losses (people who did not survive).
## Tip: you can use multiple statements (lines of code), such as to make "intermediate" sub-frames
##  (similar to what you did with the `children` variables)

most_lost <- titanic[titanic$Survived == "No" & titanic$Freq == max(titanic$Freq),]

## Define a function called `survival_rate` that takes in a ticket class
## (i.e., "1st", "2nd", "3rd" or "Crew") as an argument.
## This function should return a sentence describing the total survival rate of men
## vs. "women and children" in that ticketing class.  
## 
## For example, for 'Crew' class, the function shoult report 87 and 22% in a sentence
## like this:
## 
##   "Of Crew class, 87% of women and children survived and 22% of men survived."
##
## Please be professional and round percentages, don't report figures like "87.66666666%"
## and such!
##
## The approach you take to generating the sentence to return is up to you. A good
## solution will likely utilize intermediate variables (subsets of data frames) and
## filtering to produce the required data.  Avoid using loops where you can utilize
## vectorized functions!

survival_rate <- function(ticket_class) {
  frequency <- titanic[titanic$Class == ticket_class & titanic$Freq > 0,]
  children <- frequency[frequency$Age == "Child",]
  children_survived <- children[children$Survived == "Yes",]
  total_children <- sum(children$Freq)
  total_csurvived <- sum(children_survived$Freq)
  women <- frequency[frequency$Sex == "Female" & frequency$Age == "Adult",]
  women_survived <- women[women$Survived == "Yes",]
  total_women <- sum(women$Freq)
  total_wsurvived <- sum(women_survived$Freq)
  total_wc <- sum(total_children, total_women)
  total_wcsurvived <- sum(total_csurvived, total_wsurvived)
  wc_survival_frequency <- paste0((round(total_wcsurvived / total_wc * 100)), "%")
  men <- frequency[frequency$Sex =="Male" & frequency$Age == "Adult",]
  men_survived <- men[men$Survived == "Yes",]
  total_men <- sum(men$Freq)
  total_msurvived <- sum(men_survived$Freq)
  m_survival_frequency <- paste0((round(total_msurvived / total_men * 100)), "%")
  cat(paste("Of", ticket_class, "class,", wc_survival_frequency, "of women and children survived and", m_survival_frequency, "of men survived.\n"))
}

## Call your `survival_rate()` function on each of the ticketing classes (`Crew`, `1st`, `2nd`, and `3rd`)

survival_rate("Crew")
survival_rate("1st")
survival_rate("2nd")
survival_rate("3rd")

### ------------------------------ Reading in Data ------------------------------

## In this section, we'll read in a .csv file, which is essentially a tabular row/column layout 
## This is like Microsoft Excel or Google Docs, but without the formatting. 
## The .csv file we'll be working with has the life expectancy for each country in 1960 and 2013. 
## We'll ask real-world questions about the data by writing the code that answers our question.
## Here are the steps you should walk through:

# Using the `read.csv` function, read the life-expectancy.csv file into a variable called `life_expectancy`
# Makes sure not to read strings as factors

life_expectancy <- read.csv("data/life-expectancy.csv", stringsAsFactors = FALSE)

## Determine if life_expectancy is a data.frame by using the is.data.frame function.
## You may also want to inspect it's content by View() or by just printing chunks of it.

is.data.frame(life_expectancy)
View(life_expectancy)

# Create a column `life_expectancy$change` that is the change in life expectancy from 1960 to 2013

life_expectancy$change <- life_expectancy$le_2013 - life_expectancy$le_1960
  
# Create a variable `most_improved` that is the name of the country with the largest gain in life expectancy

most_improved <- life_expectancy[life_expectancy$change == max(life_expectancy$change),]$country
cat("The", most_improved, "had the largest gain in life expectancy. \n")

## Create a variable `num_small_gain` that has the number of countries
## whose life expectance has improved fewer than 5 years between 1960 and 2013

num_small_gain <- sum(life_expectancy$change < 5)
cat(num_small_gain, "countries had life expectancies improved fewer than 5 years between 1960 and 2013.\n")

## Write a function `country_change` that takes in a country's name as a parameter,
## and returns it's change in life expectancy from 1960 to 2013

country_change <- function(country) {
  expectancy_change <- life_expectancy$change[life_expectancy$country == country]
  paste0(country, "'s life expectancy changed by ", expectancy_change, " years.\n")
}

## Using your `country_change` function, create a variable `sweden_change`
## that is the change in life expectancy from 1960 to 2013 in Sweden

sweden_change <- cat(country_change("Sweden"))

# Define a function `lle_region` that takes in a **region** as an argument, and returns 
# the **name of the country** with the lowest life expectancy in 2013 (in that region)

lle_region <- function(region){
  lle_in_region <- min(life_expectancy$le_2013[life_expectancy$region == region])
  lle_country <- life_expectancy$country[life_expectancy$le_2013 == lle_in_region]
  paste0("In 2013, ", lle_country, " had the lowest life expectancy in ", region, ".\n")
}

## Using the function you just wrote, create a variable `lowest_in_south_asia`
## that is the country with the lowest life expectancy in 2013 in South Asia

lowest_in_south_asia <- cat(lle_region("South Asia"))

## Write a function `bigger_change` that takes in two country names as parameters, and
## returns a sentence that describes which country experienced a larger gain in life
## expectancy (and by how many years).  For example, if you passed the values "China",
## and "Bolivia" into your function, it would return this:
##
## "The country with the bigger change in life expectancy was China (gain=31.9),
## whose life expectancy grew by 7.4 years more than Bolivia's (gain=24.5)."
## 
## Make sure to round your numbers.

bigger_change <- function(country1, country2) {
  le_country1 <- life_expectancy$change[life_expectancy$country == country1]
  le_country2 <- life_expectancy$change[life_expectancy$country == country2]
  if(le_country1 > le_country2) {
    paste0("The country with the bigger change in life expectancy was ", country1, " (gained=", round(le_country1, digits = 1), "), whose life expectancy grew by ", round(le_country1 - le_country2, digits = 1), " more than ", country2, "'s (gain=", round(le_country2, digits = 2), ").\n")
  } else {
    paste0("The country with the bigger change in life expectancy was ", country2, " (gained=", round(le_country2, digits = 1), "), whose life expectancy grew by ", round(le_country2 - le_country1, digits = 1), " more than ", country1, "'s (gain=", round(le_country1, digits = 2), ").\n")
  }
}

## Using your `bigger_change` function, create a variable `usa_or_france` that describes who had a larger gain in life expectancy
## (the United States or France)

usa_or_france <- cat(bigger_change("China", "Bolivia"))

## Write your `life_expectancy` data.frame to a new .csv file to your data/ directory
## with the filename `life-expectancy-with-change.csv`.
## Make sure not to write row names.

write.table(life_expectancy, file="data/life-expectancy-with-change.csv", sep=",", row.names = FALSE)

################################### Challenge ###################################

## Create a variable that has the name of the region with the 
## highest average change in life expectancy between the two time points.
## Your are welcome to weight the change by population, but just unweighted average over countries is good as well.
## To do this, you'll need to compute the average change across the countries in each region, and then 
## compare the averages across regions.
## Use base-R functions!

regions <- unique(life_expectancy$region)
for (i in regions) {
  highest_average_change <- 0
  average <- sum(life_expectancy$change[life_expectancy$region == i]) / nrow(life_expectancy[life_expectancy$region == 1])
  if (any(average > highest_average_change)){
    highest_average_change <- average
    highest_average_region <- life_expectancy[life_expectancy$region == i,]
  }
  return (highest_average_region)
}
View(highest_average_region)
View(regions)

## Create a *well labeled* plot (readable title, x-axis, y-axis) showing Life expectancy
## in 1960 v.s. Change in life expectancy Programmatically save (i.e., with code, not
## using the Export button) your graph as a .png or .jpg file in your repo Then, in a comment
## below, provide an *interpretation* of the relationship you observe Feel free to use
## any library of your choice, or base R functions.

png(filename="Life Expectancy Change in 1960 v.s. Change in Life Expectancy.png")
plot(x = life_expectancy$le_1960, y = life_expectancy$change, xlab = "Life Expectancy Change in 1960", ylab = "Change in Life Expectancy")
title(main="Life Expectancy Change in 1960 v.s. Change in Life Expectancy")
dev.off()

## What do you notice?
  #It seems as if there is a negative correlation (life expenctancy in 1960 increases, change in life expectancy decreases)
  #in life expectancy  between life expectancy in 1960 and the change in life expectancy.
## What is your interpretation of the observed relationship?
  #This means that the higher the life expectancy in 1960 already is, the less change in life expectancy there is.
