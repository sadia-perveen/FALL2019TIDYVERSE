---
title: "Tidyverse Assignment - Masculinity Data"
author: "Amber Ferger"
date: "11/28/2019"
output: html_document
---

## The Data: What Do Men Think It Means to be a Man?
For this assignment, I decided to use the dataset that corresponds to the *What Do Men Think It Means To Be A Man?* article on FiveThirtyEight.com. The article can be found here: https://fivethirtyeight.com/features/what-do-men-think-it-means-to-be-a-man/

It contains the results of a survey of 1,615 adult men conducted by SurveyMonkey in partnership with FiveThirtyEight and WNYC Studios from May 10-22, 2018. 

``` {r, warning = FALSE, message = FALSE}

library(tidyverse)
dat <- as_tibble(read.csv('https://raw.githubusercontent.com/amberferger/DATA607_Masculinity/master/raw-responses.csv'))

```


We have quite a bit of questions in this survey, so we will focus on just a few. For the purpose of this vignette, let's see what role demographics play in the answer to the question **How important is it to you that others see you as masculine?** We'll use the **select** command (from the tidyverse dependency *dplyr*) to return only the columns we are interested in looking at (race and orientation). We'll also use the **filter()** command to subset our data to only individuals that provided a response to these question. 


``` {r}

dat <- dat %>% 
  select(race2,orientation, q0002) %>%
  filter(q0002 != 'No answer' & race2 != 'No answer' & orientation != 'No answer')

```


## Data Aggregation

Our final data set has 1 response variable (the answer to the question) and 2 explanatory variables (our demographic data). We'll use the **group_by** function with the **count()** function to summarize our data. We will then transform our values by creating a percent for each of the of the groupings.
``` {r}

raceCount <- dat %>% 
  group_by(race2, q0002) %>%
  count()

raceCount <- raceCount %>% 
  group_by(race2) %>%
  mutate(RACE_PCT = n/sum(n))

raceCount

```

We'll do the same thing for the **orientation** variable. 

``` {r}

orientationCount <- dat %>% 
  group_by(orientation, q0002) %>%
  count()

orientationCount <- orientationCount %>% 
  group_by(orientation) %>%
  mutate(ORIENTATION_PCT = n/sum(n))

orientationCount

```


## Visualization 

Now let's visualize our data! We'll use the **ggplot** library to take a look: 

``` {r}
library(ggplot2)

ggplot(raceCount, aes(fill=race2, y=RACE_PCT, x=q0002)) + 
    geom_bar(position="dodge", stat="identity") +
    ggtitle("Race vs Answer")

```


``` {r}

ggplot(orientationCount, aes(fill=orientation, y=ORIENTATION_PCT, x=q0002)) + 
    geom_bar(position="dodge", stat="identity") +
    ggtitle("Orientation vs Answer")

```
