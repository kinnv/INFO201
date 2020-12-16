# a3-using-data

## Overview

In this challenge, you'll have the opportunity to work with built in R
data, as well as read in external data sources. In particular, you'll
focus on these skills:

* Practicing your foundational R skills (variable assignment, writing functions, etc.)
* Loading datasets from R packages
* Working with data frames objects, in particular indexing data frames
  using the built-in indexing tools
* Reading and writing comma separated values (.csv) files

## Instructions

In this assignment, you'll complete the instructions in the
`assignment.R` file to demonstrate foundational skills of working with
data in R. 

Although _dplyr_ is a powerful tool for working with data, we ask you
**NOT TO USE DPLYR FOR THIS ASSIGNMENT**.  You are supposed to be able
to manipulate data with base-R tools as well.  There are several
reasons for this: _dplyr_, although powerful, fails in certain cases;
there are other similar data structures and different programming
languages where _dplyr_-like approach is much more limited or missing;
and "thinking in dplyr" is not an efficient approach for certain type
of problems.

Please make sure to **submit this
GitHub URL** to Canvas on time for credit.  We recommend to submit the
link **right now**, in order to avoid potential issues with
non-working internet, broken computers, and humans just plain
forgetting. 


## Submission

Once you've finished editing your assignment.R file, use git to **add**
and **commit** the changes you've made, and **push** those changes to your
repository on GitHub.  Please **submit the URL of your GitHub Repository**
as you assignment submission on Canvas.


## Grading

### Set up (2 points)

- print working directory

### DataFrame Manipulation (**20 points**, 2 points each)

- -1 if wrong directory or not using a relative path when saving data to disk


### Loading R Data (**28 points**)

Most questions are 2 points.  Exceptions:

- `most_lost`: 4 points

- function `survival_rate`: 10 points


### Reading in Data (40 points)

Most questions are 2 points.  Exceptions:

- function `country_change` (**5 points**)
    - -1 if overly complex
    - -1 if incorrect value returned (i.e., not `change`)


- function `lle_region` (**7 points**)
    - -1 if overly complex
    - -1 if incorrect value returned (i.e., not lowest in the region)

- function `bigger_change` (**10 points**)
    - -1 if overly complex
    - -1 if gain not reported for country 1
    - -1 if gain not reported for country 2
    - -1 if difference not properly calculated
    - -1 for sentence errors

- save data to disk
    - -1 if wrong directory or not using a relative path

### Challenge (**10 points**)

- variable of the region with the highest average change in life expectancy (**4 points**)
    - -1 if overly complex
    - -3 if wrong value computed

- plot (**6 points**)
    - -1 for non-readable labels
    - -3 if not properly saved using `png()`
    - -1 if not interpreted
