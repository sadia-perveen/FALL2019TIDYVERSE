---
title: "Dplyr - a dive into filter and select"
author: "John Kellogg"
date: "`r Sys.Date()`"
output:
  prettydoc::html_pretty:
    theme: cayman
    highlight: github
vignette: >
  %\VignetteIndexEntry{Vignette Title}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

Tidyverse is a group of packages for R which allow for clean operations with in the software.  As all packages share common underlying design, structure and language, they can be used together and interchangeability.  the end user can start with data ingestion, flow to clean up and finish with the visualizations without leaving the same methods. 
---

Starting, we will need to ensure the tidyverse package is installed.  The code below will insure you have the all the packages being discussed in this paper.  

```{r setup}
require(tidyverse)
```

Tidy has the ability to read rectangular data (example: csv or tsv) and convert it to a dataframe though the package, readr.  It allows for clean and flexible parsing of the data while noting any failures due to unexpected values or changes.  

```{r}
# dowload file from github, save it locally in your home directory
download <- download.file('https://raw.githubusercontent.com/brkurzawa/brewpub-scraper/master/breweries_us.csv', destfile = "FILE.csv", method = "wininet") 

# read_csv from the readr package with no arguments except column names.
data_raw <- read_csv("FILE.csv", col_names = TRUE)

```

## readr - get the data

readr will attempt to automatically identify column types during the operation.  Using arguments, you can define the operation further, such as skip_empty_rows which gives the option to not parse blank rows into the dataframe, otherwise they will be listed as N/A. 

A list of the arguments can be found at:
https://readr.tidyverse.org/reference/read_delim.html

---

## dplyr - manipulate the data

So long as you don't need to any data wrangling or cleaning operations, which is done via [tidyr](https://tidyr.tidyverse.org/articles/tidy-data.html), the dataframe can be manipulated and modified to fit your needs via [dplyr](https://dplyr.tidyverse.org/).  Anyone familiar with SELECT operations in SQL will catch on to the operations in this package quickly.  

The main operations of dplyr include:

* filter() - select portions of the dataframe based on their value
* select() - select portions of the dataframe based on their name
* rename() - changes the name of the column while keeping all the data in the column
* mutate() - add to the dataframe by performing operations on other portions of the dataframe
* arrange() - much like ORDER BY; sorts the data by a specific column or columns 
* summarise() - condense values into a single value

All of these features can be combined to perform multiple operations within a single command.  "%>%" the pipe command links the operations together.

**Example:**  
Dataframe %>%  
  filter(column1 == "A")%>%  
  arrange(desc(column2))  
  
*This example we filtered the dataframe on values in column 1 then arranged the result by column2 in descending order.*
  
---
  
We are going to focus on two of the most powerful and used operations *filter* and *select*

### filter - select portions of the dataframe based on their value

filter allows the user to parse the data into separate dataframes or models.  Breaking down a large dataframe is essential to operations and readability of the later report. 
  
An example of the operation, we take our dataframe and separate out the Microbreweries from the others and put into it's own dataframe.

Syntax 1:
NEWDATAFRAMENAME <- Existing_Data_frame %>% filter(column_name *operator* value) 

Syntax 2:
NEWDATAFRAMENAME <- filter(Existing_Data_frame, column_name *operator* value)

The *operator* defines what you are trying to get from the operation; it equals, it does not equal, it's NA, it's between or near, etc..

Useful functions include:  
* ==, <, <=, etc   
* !=  
* is.na()    
* near()    
  
```{r}
microbreweries <- data_raw %>%
                    filter(type == "Microbrewery")

microbreweries %>% head(5)
```

We can perform multiple filter operations in the same command by combining them with either a "|" or a ","  The pipe gives us an OR value while the comma gives us an AND value.


```{r}
Non_micro_california <- data_raw %>%
                          filter(type != "Microbrewery", state == "california")
Non_micro_california %>% head(5)
```
  
---
  
### select - select portions of the dataframe based on their name 

The most used feature of *select* is selecting columns to return in the dataframe, typically by name, reducing the large dataframe to only what is useful for the operation at hand.  Lets look at the two dataframes we have already created and utilize the *select* function.  

**NOTE** - if you put a *-* (dash) ahead of the name, you are NOT selecting that column.  This is very useful if you only want to remove a few columns from a dataframe.

```{r}
# reusing the same code and piping in the select statement
microbreweries <- data_raw %>%
                    filter(type == "Microbrewery")%>%
                    select(brewery_name, address, website)
microbreweries %>% head(5)

# select statement removes two columns not needed from the first verion of the dataframe.
Non_micro_california <- data_raw %>%
                          filter(type != "Microbrewery", state == "california")%>%
                          select(-state, -state_breweries)
Non_micro_california %>% head(5)

```

