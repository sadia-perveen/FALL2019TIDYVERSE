# CUNY DATA 607 Fall 2019 Tidyverse recipes

I am using the Avengers dataset from FiveThirtyEight and using the dplyr package to demonstrate the filter and full_join function.
Avengers dataset: https://github.com/fivethirtyeight/data/tree/master/avengers.

---
title: "Data 607 TidyVerse Assignment Part 1"
author: "Bryan Persaud"
date: "11/26/2019"
output: html_document
---

```{r}
library(tidyverse)
```

# I chose to work with the Avengers dataset 

```{r}
# Get dataset from URL from FiveThirtyEight github
Avengers <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/avengers/avengers.csv")
```

# I chose to demonstrate the dplyr package

```{r}
# Use filter to extract an individual avenger
Captain_America <- filter(Avengers, Name.Alias == "Steven Rogers")
Iron_Man <- filter(Avengers, Appearances == "3068")
Thor <- filter(Avengers, Name.Alias == "Thor Odinson")
Black_Widow <- filter(Avengers, Name.Alias == "Natalia Alianovna Romanova")
The_Hulk <- filter(Avengers, Name.Alias == "Robert Bruce Banner")
Hawkeye <- filter(Avengers, Name.Alias == "Clinton Francis Barton")
```

```{r}
# Use full_join to combine everything into one data frame
Avengers_2012 <- list(Captain_America, Iron_Man, Thor, Black_Widow, The_Hulk, Hawkeye) %>%
  reduce(full_join, by.x = "URL", by.y = "Appearances")
Avengers_2012
```

For my Tidyverse example I used the Avengers dataset from FiveThirtyEight. The dataset contains a list of members of the Avengers group from the Marvel comics. The list shows appearances of when they were first introduced in the comics and if/when they died and/or returned. I used the filter function from the dplyr package to extract every avenger from the 2012 Avengers film. I then put them into a list and used the full_join function from the dplyr function to put every avenger that I got from using the filter function into one data frame.

**Extend an Existing Example**

I extended Stephen Haslett's code as seen below. 

# This is what Bryan Persaud is adding to Stephen Haslett's code

```{r}
ggplot(ramen_top_ten, aes(x = Brand, y = Stars)) + geom_bar(stat = "identity") + labs(title = "Top Ten Listings by Stars", x = "Brand", y = "Stars") + theme(axis.text.x = element_text(angle = 75, size = 14, hjust = 1), axis.text.y = element_text(size = 10))
```

```{r}
ggplot(five_stars, aes(x = Brand, y = Country)) + geom_bar(stat = "identity") + labs(title = "Five Star Ramens by Country", x = "Brand", y = "Country") + theme(axis.text.x = element_text(angle = 75, size = 14, hjust = 1), axis.text.y = element_text(size = 10))
```

I chose to use ggplot2 package to plot a graph to show the ramens that got a top ten listings from the ramen_top_ten dataframe created. I also used ggplot2 to show the ramens that got a five star rating from the five_stars dataframe.
