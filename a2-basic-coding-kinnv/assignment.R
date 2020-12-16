## a2-foundational-skills

## -------------------- Set up --------------------
## In this assignment we ask you to use `stringr` package for the string functions.
## Read more about it in Wickham & Grolemund "R for Data Science"
## http://r4ds.had.co.nz/strings.html

## install.packages("stringr")

## Install the library if needed and load it
## Ensure you don't install the library more than once!

library(stringr)

## -------------------- Defining variables --------------------
## Here we ask you to define, compute, and print a number of variables
## ---------- Example: ----------
## Create variable `my_name` that is equal to your first name

my_name <- "Kin"
cat("I am", my_name, "\n")

## ---------- end of the example ----------


## Create a numeric variable `my_age` that is equal to your age

my_age <-  19
cat("I am", my_age, "\n")

## Using multiplication, create a variable `minutes_in_day` that is equal to the number of minutes in a day

minutes_in_day <- 60 * 24 
cat("There are", minutes_in_day, "minutes in a day\n")

## Using multiplication, create a variable `hours_in_year` that is the number of hours in a year

hours_in_year <- 24 * 365
cat("There are", hours_in_year, "hours in a year\n")

## Create a variable `minutes_rule` that is a boolean value (TRUE/FALSE) by logical operations
## It should be TRUE if there are more minutes in a day than hours in a year, otherwise FALSE

minutes_rule <- (minutes_in_day > hours_in_year)
cat(minutes_rule, "\n")

## Compute the following a bit useful numbers.
## Assign the results to suitably named variables.
## 
## How many seconds are there in year?

seconds_in_year <- 60 * 60 * 24 * 365
cat("There are", seconds_in_year, "seconds in a year\n")

## How many seconds is a typical human lifetime?

seconds_in_human_lifetime <- seconds_in_year * 79 #avg human life time
cat("There are", seconds_in_human_lifetime, "seconds in a typical human lifetime\n")
  
## Age of the universe is 13.8 billion years.  What is it's age in seconds?
## Comment:
## If you estimate, based on timings on a small dataset, that your task on the full data
## takes more than this many seconds on a fast computer,
## we can safely say that your code fails :-)

age_of_universe <- seconds_in_year * 13800000000
cat("The universes is", age_of_universe, "seconds old\n")

### -------------------- Working with functions --------------------

## Write a function called `make_introduction` that takes in two arguments: name, and age. 
## This function should return a string value that says something like "Hello, my name is {name}, and I'm
## {age} years old".  

make_introduction <- function(name, age) {
  paste0("Hello, my name is ", name, ", and I'm ", age, " years old\n")
}
## Create a variable `my_intro` by passing your variables `my_name` and `my_age` into your `make_introduction`
## function.  Always print the result!

my_intro <- make_introduction (my_name, my_age)
cat(my_intro)

## Create a variable `casual_intro` by substituting "Hello, my name is ", with "Hey, I'm" in your `my_intro`
## variable.  Check out base R functions 'su b' and 'gsub', and stringr functions 'str_replace' and 'str_replace_all'

casual_intro <- sub("Hello, my name is", "Hey, I'm", my_intro)
cat(casual_intro)
## Create a new variable `loud_intro`, which is your `my_intro` variable in all upper-case letters

loud_intro <- toupper(my_intro)
cat(loud_intro)

## Create a new variable `quiet_intro`, which is your `my_intro` variable in all lower-case letters

quiet_intro <- tolower(my_intro)
cat(quiet_intro)

## Create a new variable capitalized, which is your `my_intro` variable with each word capitalized 
## hint: consult the stringr function `str_to_title`

capitalized <- str_to_title(my_intro)
cat(capitalized)

## Using the `str_count` function, create a variable `occurrences` that stores the # of times the letter "e"
## appears in `my_intro`

occurences <- str_count(my_intro, "e")
cat(occurences,"\n")

## Write another function `double` that takes in a (numeric) variable and returns that variable times two

double <- function(number) {
  number * 2
}

## Using your `double` function, create a variable `minutes_in_two_days`, which is the number of minutes in
## two days

minutes_in_two_days <- double(minutes_in_day)
cat("There are", minutes_in_two_days, "minutes in two days\n")

## Write another function `third_power` that takes in a value and returns that value cubed

third_power <- function(value) {
  value ^ 3
}

## Create a variable `twenty_seven`` by passing the number 3 to your `cube` function

twenty_seven <- third_power(3)
cat("3 to the power of 3 is", twenty_seven, "\n")

### ------------------------------ working with vectors ------------------------------

## Create a vector `movies` that contains the names of six movies you like
## Always print your results!

movies <- c("Fast and Furious 7", "A Quiet Place", "Crazy Rich Asians", "Train to Busan", "The Nun", "The Maze Runner")
cat(movies, "\n")

## Create a vector `top_three` that only contains the first three movies in the vector.
## Use indexing.

top_three <- movies[1:3]
cat(top_three, "\n")

## Using your vector and the paste method, create a vector `excited` that adds the phrase -
## " is a great movie!" to the end of each element in your movies vector

excited <- print(paste0(movies, " is a great movie!"))

## Create a vector `without_four` that has your first three movies, and your 5th and 6th movies.

without_four <- paste(movies[-4])
cat(without_four, "\n")

## Create a vector `numbers` that is the numbers 700 through 999

numbers <- 700:999
cat("List of numbers:", numbers, "\n")

## Using the built in length function, create a variable `len` that is equal to the length of your vector
## `numbers`

len <- length(numbers)
cat(len, "\n")

## Using the `mean` function, create a variable `numbers_mean` that is the mean of your vector `numbers`

numbers_mean <- mean(numbers)
cat("The mean of numbers is", numbers_mean, "\n")

## Using the `median` function, create a variable `numbers_median` that is the median of your vector `numbers`

numbers_median <- median(numbers)
cat("The median of numbers is",numbers_median, "\n")

## Create a vector `lower_numbers` that is the numbers 600:699

lower_numbers <- 600:699
cat("List of lower numbers:",lower_numbers, "\n")

## Create a vector `all_numbers` that combines your `lower_numbers` and `numbers` vectors

all_numbers <- c(lower_numbers, numbers)
cat("List of all numbers:", all_numbers, "\n")

### -------------------- Dates --------------------
## you may also consult 'lubridate' package for additional date-time functionality

library(lubridate)

## Use the `as.Date()` function to create a variable `today` that represents today's date
## You can pass in a character string of the day you wrote this, or you can get the current date
## Hint: check documentation for 'Sys.time' and 'Sys.Date'
## Always print your results!
## Note: if you just 'cat' a date, it justprints the unix epoch number.  Try to 'format' the date like
## cat(format(date))

today <- as.Date(Sys.Date())
cat("Todays date is", format(today), "\n")

## Create a variable `anniversary` that represents the 50th anniversary of the first Moon landings (July 20, 2019). 
## Make sure to use the `as.Date` function again

anniversary <- as.Date("2019-07-20")
cat("The 50th anniversary of the first Moon landings is", format(anniversary), "\n")

## Create a variable `days_to_anniversary` that is how many days until the anniversary (hint: subtract the dates!)
 
days_to_anniversary <- anniversary - today
cat("There are", days_to_anniversary, "days until the anniversary of the first Moon landings\n")

## Define a function called `bday_intro` that takes in three arguments: 
## a name, an age, and a character string for your next (upcoming) birthday.
## This method should return a character string of the format:
##  "Hello, my name is {name} and I'm {age} years old. In {N} days I'll be {new_age}" 
## You should utilize your `make_introduction` function from Part 1, and compute {N} and {new_age} in your
## function

bday_intro <- function(name, age, birthday) {
  n <- birthday - Sys.Date() 
  new_age <- age + 1
  paste0(make_introduction(name, age), "In ", n, " days I'll be ", new_age)
}

## Create a variable `my_bday_intro` using the `bday_intro` function, passing in `my_name`, `my_age`,
## and your upcoming birthday.

my_bday_intro <- bday_intro(my_name, my_age, as.Date("2019-07-06"))
cat(my_bday_intro, "\n")

## Note: you may look up 'lubridate' package by Hadley Wickham for more convenient handling of dates


### -------------------- Challenge --------------------
## Write a function `RemoveDigits` that will remove all digits (i.e., 0 through 9) from all elements in a
## *vector of strings*.

RemoveDigits <- function(string){
  gsub('[0-9]+', '', string)
}

## Demonstrate that your approach is successful by passing a vector of courses to your function
## For example, RemoveDigits(c("INFO 201", "CSE 142", "mps-803c"))

digitsRemoved <- RemoveDigits(c("INFO 201", "CSE 142", "mps-803c"))
cat(digitsRemoved, "\n")

## Write an if/else statement that checks to see if your vector has any digits. If it does have
## digits, print "Oh no!", if it does not then print "Yay!"

ifelse(str_detect(digitsRemoved, '[0-9]+'), print("Oh no!"), print("Yay!"))

