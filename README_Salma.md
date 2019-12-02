# How to use forcat-tidyverse

## Forcats package

forcats provides a suite of useful tools that solve common problems with factors. R uses factors to handle categorical variables, variables that have a fixed and known set of possible values.

In the following dataset, we have some categorical variables like **type_of_subject**, **subject_race**. R uses factors to handle those kinds of variables that have  a fixed set of possible values. The forcats package goal is to provide a convenient tools that can solve some issues when dealing with factors, for example, changing the order of  levels or the  values. The following vignette will demonestrate more.

The used dataset is a collection of imdb movies including some data about release dat, country of origin,..etc. The dataset was imported from the fivethirtyeight github repo.

I used another useful tidyverse package called **readr** which gives the flexibility to import different file format into your r workspace.

* GitHub handle:  https://github.com/salma71
* FiveThirtyEight.com datasets:  https://github.com/fivethirtyeight/data/tree/master/biopics
