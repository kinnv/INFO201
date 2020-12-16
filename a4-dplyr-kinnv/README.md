# a4-data-wrangling

In this assignment, you'll complete the instructions in the
`assignment.R` file to demonstrate your data manipulations skills with
_dplyr_ package.  When
you're finished, please make sure to **submit this GitHub URL** to
Canvas on time for credit.

## The Data

The data for this challenge contains estimates for alcohol consumption
patterns at the U.S. county level each year from 2002 - 2012. More
specifically, for each county, the data represents the prevalence (=
drinkers/adult\_population) of drinking in each county. The two
measures of interest are:

* Any Drinking: At least one drink of any alcoholic beverage in the
  past 30 days
* Binge Drinking: The consumption of more than four drinks for women
or five drinks for men on a single occasion at least once in the past
30 days

Estimates are provided for males and females separately, as well as
both sexes combined. The data comes from the [Drinking-patterns
study](http://www.healthdata.org/research-article/drinking-patterns-us-counties-2002-2012).
at the [Institute for Health Metrics and
Evaluation](http://www.healthdata.org/) website, and was downloaded
from
[healthdata.org](http://www.healthdata.org/us-health/data-download).
(It is already downloaded and formatted).

Any drinking and binge drinking are saved in separate .csv files, both
the same format. Note, there are estimates at the county, state, and
national level.

The variables in both datasets are

* **state**: name of the state, including _National_, and _District of
  Columbia_   
  **Note**: _Washington, D.C_ stands for a city named _Washington_ inside
  District of Columbia (usually called DC).  As the Washington city
  takes up all the DC land, _Washington, D.C._ and
  _District of Columbia_ (or just _DC_) are usually treated as synonyms.  Most of the
  U.S. consists of _states_, but DC is not a state but a piece of
  federally controlled land.
* **location**: county name.  For state level observations it is the
  same as **state**
* **both\_sexes\_2002**, **females\_2002**, **males\_2002**: the
  corresponding drinking rates for everyone, females and males.  It
  includes years 2002--2012.
  

## Code

Your code should _print meaningful answers_ where applicable.  For
instance, if the question is _What is the binge drinking rate in the
US in 2012?_, the answer should be something like this:

> 2012 binge drinking rate in the US was 56 pct

The printed answer should be brief and explanatory, so persons who
know the data and questions can understand it.  And it should be
correct too!  Also, be reasonable.  If the question is to "create a
subdata for year 2012", you just create the data and do not print out
3000 lines!  When you run (source) your whole script, it should output
the messages so they form a readable text.  If in doubt imagine you
are creating a report for Congress, for busy politicians who want to
get the relevant answers quickly.


## Grading

### Set up (5 points)

* -1 if re-installing dplyr
* -1 if hardcoded setwd()
* -1 if directory creation produces errors/warnings

### Any drinking in 2012 (32 points)

* -1 if output missing
* -1 if outputs too much stuff (like large data frames)

### Binge drinking dataset (28 points)

* -1 if output missing
* -1 if outputs too much stuff (like large data frames)

### Joining Data (17 points)

* -5 if join keys wrong

### Write your own function (10 points)

- Write a well scoped function (**7 points**)
    - -1 function doesn't return anything
    - -1 purpose of function isn't clear
    - -1 function or parameter names unclear
- Demonstrates function works properly (**3 points**)

### Challenge (8 points)

- a one-liner for each state data: **3 points**
- select-state-year function: **5 points**
