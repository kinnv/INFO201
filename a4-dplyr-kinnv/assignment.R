### a4: data manipulation with dplyr

## In this problem set we want you to programmatically print meaningful answers where applicable. 
## For instance, if the question is What is the binge drinking rate in the US in 2012?, the answer
## should be something like this (as a comment):
## 2012 binge drinking rate in the US was 56%
##
## The printed answer should be brief and explanatory, so persons who know the data and questions 
## can understand it. And it should be correct too! Also, be reasonable. If the question is to 
## "create a subdata for year 2012", you just create the data and do not print out 3000 lines! 
## When you run (source) your whole script, it should output the messages so they form a readable 
## text. If in doubt imagine you are creating a report for Congress, for busy politicians who want
## to get the relevant answers quickly.


################################### Set up ###################################

## Install dplyr (if not installed)
## make sure you install it only once!

#install.packages("dplyr")

## Print your working directory.
## Ensure it is an appropriate project folder

cat(getwd(), "\n")

## load dplyr package 

library(dplyr)

# Read in `any_drinking.csv` data using relative path

any_drinking <- read.csv("data/any_drinking.csv", stringsAsFactors = FALSE)

# Read in `binge.drinking.csv` data using relative path

binge_drinking <- read.csv("data/binge_drinking.csv", stringsAsFactors = FALSE)

## Create a directory (using R) called "output" in your project directory
## Make sure the code works and does not print any warnings in case the directory already exists

dir.create("output", showWarnings = FALSE)

################################### Any drinking in 2012 ###################################

# For this first section, you will work only with the *any drinking* dataset.
# In particular, we'll focus on data from 2012, keeping track of the `state` and `location` variables

# Create a data frame that has the `state` and `location` columns, and all columns with data from 2012

data_2012 <- select(any_drinking, state, location, ends_with("2012"))


# Using the 2012 data, create a column that has the difference in male and female drinking patterns

data_2012 <- mutate(data_2012, male_female_diff = males_2012 - females_2012)

## Write your 2012 data to a .csv file in your `output/` directory with a good descriptive filename
## Make sure to exclude rownames

write.csv(data_2012, file="output/drinking-patterns-in-2012.csv", row.names = FALSE)

## Create a *dataframe* of the locations, states, and differences for all locations where females drink more than males
## (no extra columns).
## Are there any locations where females drink more than males?
## Comment your result (as a code comment)

more_females <- data_2012 %>%
  filter(male_female_diff < 0) %>%
  select(location, state, male_female_diff)
#There were no locations where females drank more than males.

## What is the location in which male and female drinking rates are most similar
## (*absolute* difference is smallest)?
## Your answer should be a *dataframe* of the location, state, and value of interest
## (no extra columns)

most_similar <- data_2012 %>%
  filter(male_female_diff == min(abs(male_female_diff))) %>%
  select(location, state, male_female_diff)
cat("The location where male and female drinking rates are most similar is", most_similar$location, "\n")


## As you've (hopefully) noticed, the `location` column includes national, state, and county level
## estimates. However, many audiences may only be interested in the *state* level data.
## Given that, you should do the following:
## * Create a new data frame that is only the state level observations in 2012
## * For the sake of this analysis, you should treat Washington D.C. as a *state*

state_level <- filter(data_2012, state == location)


## Which state had the **highest** drinking rate for both sexes combined? 
## Your answer should be a *dataframe* of the state and value of interest (no extra columns)
##
## For your check: this is Vermont

highest_drinking_rate <- state_level %>%
  filter(both_sexes_2012 == max(both_sexes_2012)) %>%
  select(state, both_sexes_2012)
cat(highest_drinking_rate$state, "had the highest drinking rate for both sexes combined.\n")

## Which state had the **lowest** drinking rate for both sexes combined?
## Your answer should be a *dataframe* of the state and value of interest (no extra columns)

lowest_drinking_rate <- state_level %>%
  filter(both_sexes_2012 == min(both_sexes_2012)) %>%
  select(state, both_sexes_2012)
cat(lowest_drinking_rate$state, "had the lowest drinking rate combined.\n")


## What was the difference in (any-drinking) prevalence between the state with the highest level of
## consumption, and the state with the lowest level of consumption?
## Your answer should be a single value (a dataframe storing one value is fine).

prevalence_diff <- select(highest_drinking_rate, both_sexes_2012) - select(lowest_drinking_rate, both_sexes_2012)
cat("Between", highest_drinking_rate$state, "and", lowest_drinking_rate$state, ", they had a difference in combined drinking rate of",
    prevalence_diff$both_sexes_2012, ".\n")



## Write your 2012 state data to an appropriately named file in your `output/` directory
## Make sure to exclude rownames

write.csv(state_level, file="output/state-only-2012-data", row.names = FALSE)

## Write a function that allows you to specify a state, then saves a .csv file with only observations from
## that state. This includes data about the state itself, as well as the counties within the state
## You should use the entire any.drinking dataset for this function
## The file you save in the `output` directory indicates the state name
## Make sure to exclude rownames!

state_data <- function(state_name) {
  selected_state <- any_drinking %>%
    filter(state == state_name) 
    write.csv(selected_state, file=paste0("output/", state_name, "-data-from-2012.csv"), row.names = FALSE)
}

## Demonstrate your function works by passing 3 states of your choice to the function

state_data("Alabama")
state_data("Washington")
state_data("California")

################################### Binge drinking Dataset ###################################
## In this section, we'll ask a variety of questions regarding our binge drinking dataset
## Moreover, we'll be looking at a subset of the observations which is just the counties 
## (i.e., exclude state/national estimates)
## In order to ask these questions, you'll need to first prepare a subset of the data for this section:

## Create a dataframe with only the county level observations from the binge_drinking dataset 
## This does include "county-like" areas such as parishes and boroughs
## You should (again) think of Washington D.C. as a state, and therefore *exclude it here*

county_level <- binge_drinking %>%
  filter(state != location, state != "National")

## What is the average level of binge drinking in 2012 for both sexes (across the counties)?
## Just compute a single average number over all 3000 or so counties
## (but do not include the national and state level figures)
##
## For your check: the answer should be 17.96.

avg_drinking_2012 <- county_level %>%
  summarise(mean = mean(both_sexes_2012))
  cat("The average level of binge drinking in 2012 for both sexes was", avg_drinking_2012$mean, ".\n")

## What is the *minimum* level of binge drinking in each state in 2012 for both sexes (across the counties)? 
## Your answer should contain roughly 50 values (one for each state), unless there are two counties in a
## state with the same value
## Your answer should be a *dataframe* with the 2012 binge drinking rate, location, and state
## Hint: use `group_by` function

min_drinking <- county_level %>%
  group_by(state) %>%
  filter(both_sexes_2012 == min(both_sexes_2012)) %>%
  select(both_sexes_2012, location, state)

## What is the county with the largest increase in male binge drinking between 2002 and 2012?
## Your answer should include the county, state, and value of interest

county_level <- mutate(county_level, male_difference = males_2012 - males_2002)

largest_male_increase <- county_level %>%
  filter(male_difference == max(male_difference)) %>%
  select(location, state, male_difference)
  cat(largest_male_increase$location, "had the largest increase in male binge drinking between 2002 and 2012.\n")
  

## How many counties experienced an increase in male binge drinking between 2002 and 2012?
## Your answer should be an integer (a dataframe with only one value is fine).

male_increase <- county_level %>%
  filter(male_difference > 0) %>%
  select(location) %>%
  count()
  cat("There were", male_increase$n, "counties that experienced an increase in male binge drinking between 2002 and 2012.\n")

## What percentage of counties experienced an increase in male binge drinking between 2002 and 2012?
## Your answer should be a fraction or percent (but please state that in your output)

male_percent_increase <- round((male_increase / count(county_level)) * 100, digits=2)
  #63.72% of counties experienced an increase in male binge drinking between 2002 and 2012.

## How many counties observed an increase in female binge drinking in this time period?
## Your answer should be an integer.

county_level <- mutate(county_level, female_difference = females_2012 - females_2002)

female_increase <- county_level %>%
  filter(female_difference > 0) %>%
  count()
  #2580 counties observed an increase in female binge drinking between 2002 and 2012.


## What percentage of counties experienced an increase in female binge drinking between 2002 and 2012?
## Your answer should be a fraction or percent (we're not picky)

female_percent_increase <- round((female_increase / count(county_level)) * 100, digits=2)
  #82.53% of counties experienced an increase in female binge drinkingb between 2002 and 2012.

## How many counties experienced a rise in female binge drinking *and* a decline in male binge drinking?
## Your answer should be an integer (a dataframe with only one value is fine)

increase_and_decline <- county_level %>%
  filter(female_difference > 0 && male_difference < 0) %>%
  count()
  #3126 counties experienced a rise in female binge drinking and a declinde in male binge drinking.

################################### Joining Data ###################################
## You'll often have to join different datasets together in order to ask more involved questions of your
## dataset.
## Note that the dataframes include a large number of similar column names.
## You have to either rename these, or ensure that both will be renamed automatically
## with descriptive prefixes (or suffixes), such as 'any_' and 'binge_'.

colnames(any_drinking)[3:length(any_drinking)] <- paste0("any_", colnames(any_drinking)[3:length(any_drinking)])
colnames(binge_drinking)[3:length(binge_drinking)] <- paste0("binge_", colnames(binge_drinking)[3:length(binge_drinking)])

## Join the dataframes: create a dataframe with all of the columns from both datasets. 
## Think carefully about the *type* of join you want to do, and what the *keys*
## (identifiers) are

all_drinking <- full_join(any_drinking, binge_drinking)

## Create a column of difference between `any` and `binge` drinking for both sexes in 2012

both_drinking <- all_drinking %>%
  select(contains("both_sexes_2012")) %>%
  mutate(drinking_differences = any_both_sexes_2012 - binge_both_sexes_2012)

all_drinking <- mutate(all_drinking, both_difference_2012 = both_drinking$drinking_differences)

## Which location has the greatest *absolute* difference between `any` and `binge` drinking?
## Your answer should be a one row data frame with the state, location, and value of interest (difference)

greatest_difference <- all_drinking %>%
  filter(both_difference_2012 == max(both_difference_2012)) %>%
  select(state, location, both_difference_2012)
  #Falls Church City in Virginia had the greatest difference between 'any' and 'binge' drinking at 53.1.

## ------------------------------ Write a function to ask your own question(s) ------------------------------
## Even in an entry level data analyst role, people are expected to come up with their own questions
## of interest (not just answer the questions that other people have). For this section, you should
## *write a function* that allows you to ask the same question on different subsets of data. For
## example, you may want to ask about the highest/lowest drinking level given a state or year. The
## purpose of your function should be evident given the input parameters and function name. However,
## add also explanation of what it does and what are the input parameters in comments inside the
## function definition.
##
## Note: the question should be relevant for this data, i.e. related to drinking and geography, or any other
## interesting features this data is well suited for.  Do not ask questions you may get better answer
## from different data (e.g. only about geography).

## After writing your function, *demonstrate* that the function works by passing in different
## parameters to your function.

#A function I wanted to write was to find the average drinking rates of each sex and both sexes combined of 
#the year of interest. 

get_average_drinking <- function(year) {
  any_drinking %>% # calls any_drinking data frame and pipes
    select(contains(year)) %>% #selects only columns that contain year of interest and pipes
    summarise_all(funs(mean)) #collectively finds the mean of each column
}

get_average_drinking("2012")
get_average_drinking("2002")
get_average_drinking("2003")

################################### Challenge ###################################

## Using your function from part 1 (that wrote a .csv file given a state name), write a separate file 
## for each of the 51 states (including Washington D.C.)
## The challenge is to do this in a *single line of (concise) code*

lapply(state_level$state, state_data)

## Using a dataframe of your choice from above, write a function that allows you to specify a *year* and
## *state* of interest,
## that saves a .csv file with observations from that state's counties (and the state itself) 
## It should only write the columns `state`, `location`, and data from the specified year. 
## Before writing the .csv file, you should *sort* the data_frame in descending order
## by the both_sexes drinking rate in the specified year. 
## Again, make sure the file name you save in the output directory indicates the year and state,
## and that it does not include row names.
## 
## Note: depending on how you approach this problem, you may confront how dplyr uses *non-standard evaluation*
## Hint: https://cran.r-project.org/web/packages/dplyr/vignettes/nse.html
## If you find this to be overwhelming, consider using the base-R indexing instead.
##
## Alternatively, I recommend to use 'tidyr' tools to transform the data into long form
## (tidy form), perform selection in long form, and transform it back into the wide form thereafter.
## Hint: https://r4ds.had.co.nz/tidy-data.html

get_state_year <- function(year_desired, state_desired) {
  state_data <- filter(any_drinking, state == state_desired) %>%
    select(state, location, contains(year_desired)) %>%
    rename(both_sexes = 3, female = 4, male = 5)
    state_data <- arrange(state_data, desc(both_sexes)) 
    write.csv(state_data, file=paste0("output/data-from-", state_desired, "-in-", year_desired, ".csv"), row.names = FALSE)
}

## Demonstrate that your function works by passing a year and state of your interest to the function

get_state_year("2012", "Vermont")
