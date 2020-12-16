### This file will contain your main code.
### Feel free to rename it, or split it into several files.
###
### Your final product should contain the code along the following lines:
### the main part of it should be a function (e.g. 'repTable') that takes
### address as the argument, and returns a markdown table of representatives.

##    ---------- Google Civic Platform ----------
## 1. create the google civic platform request and httr::GET() the result
##    you need to include your api key in the request.  See the documentation
##    https://developers.google.com/civic-information/
##    in particular the reference section.
##
##    There is also console where you can experiment with requests and see what do
##    these return.
library(httr)
library(knitr)
library(dplyr)
library(jsonlite)

##Introduction
getwd()
get_representative <- function(selected_address) {
  source("~/documents/keys.R")
  query_parameters <- list(key=print(google.key), address=selected_address) #this is where that weird code is printed.
  response <- GET("https://www.googleapis.com/civicinfo/v2/representatives", query=query_parameters)
  body <- content(response, "text")
  parsed_data <- fromJSON(body)
  names(parsed_data)
  offices <- parsed_data$offices %>%
    flatten(offices)
  officials <- parsed_data$officials %>%
    flatten(officials)
  mergedDataFrame <- NULL

  for(i in 1:nrow(offices)) {
    indicies <- offices$officialIndices[i]#add one to the indices
    cat("Loop 1, itr:", i, "\n")
    
    #for the amount stored in officialIndicies it should run this loop and put both inside. offices$officialIndicies[i]+1
    for(j in indicies) {
      index <- j + 1
      cat("Loop 2, itr:", index, "\n")
      mergedRow <- data.frame(office = offices$name[i],
                              name = officials$name[index],
                              party = officials$party[index],
                              photo = officials$photoUrl[index])
      
      # For some reason these ones require checks
      if(is.null(officials$urls[index])) {
        mergedRow$url = NULL
      } else {
        mergedRow$url = officials$urls[index]
      }
      
      if(is.null(officials$emails[index])) {
        mergedRow$email = NULL
      } else {
        mergedRow$email = officials$emails[index]
      }
      
      if(is.null(officials$channels[index])) {
        mergedRow$channels = NULL
      } else {
        mergedRow$channels = officials$channels[index]
      }
      
      if(is.null(officials$phones[index])) {
        mergedRow$phone = NULL
      } else {
        mergedRow$phone = officials$phones[index]
      }
      
      if(is.null(officials$address[index])) {
        mergedRow$address = NULL
      } else {
        mergedRow$address = officials$address[index]
      }
      
  
      
  
      mergedDataFrame <- rbind(mergedDataFrame, mergedRow)
    }
  }
  return(mergedDataFrame)
}

sea <- get_representative("Seattle")
View(sea)

#get_representative("Philadelphia")

##
##    Note: you can submit the requests through your browser.  If unsure, or if
##    httr::GET gives you an error, you may always put the address in your browser's
##    address bar.  If correct, it will display the corresponding JSON data.  If
##    incorrect, you get an error message.

## 2. extract the elected officials' data from the result
##    The data contains many relevant variables, including normalized address,
##    'offices' and 'officials'.  In order to attach the officials (people)
##    with offices (jobs), I recommend to use dplyr joins (what would be the key?)
##    More about joins in
##    http://r4ds.had.co.nz/relational-data.html

## 3. transform the data into a well formatted table
##    I recommend you transform the data into markdown strings.  For instance,
##    to display a html link as a link in the markdown file, you may want to
##    embed it between "[](" and ")".  You may format emails as
##    "[john@example.com](mailto:john@example.com)" to make these into a link.
