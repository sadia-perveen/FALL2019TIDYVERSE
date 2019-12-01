## TidyVerse

I will be show-casing 2 powerfull libraries: the dplyr and the ggplot2.

We start by installing the packages, then loading the libraries.


#### dplyr

dplyr is a powerful R-package to transform and summarize tabular data with rows and columns. This package contains a set of functions that perform common data manipulation operations such as filtering for rows, selecting specific columns, re-ordering rows, adding new columns and summarizing data.
The functions in dplyr are easier to work with, comparing to R Base. They are more consistent in the syntax and are targeted for data analysis around data frames instead of just vectors.

To install dplyr : install.packages("dplyr")

To load dplyr : library(dplyr)

I show-case the following functions in my Vignette:

select() : select columns

filter() : filter rows

arrange() : re-order or arrange rows

mutate() : create new columns

summarise() : summarise values

%>% : pipe operator


#### ggplot2

ggplot2 is a system for declaratively creating graphics, based on The Grammar of Graphics. You provide the data, tell ggplot2 how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details.

To install ggplot2 : install.packages("tidyverse") OR install.packages("ggplot2")

To load ggplot2 : library(ggplot2)

In my vignette, I show the histogram plot.



#### DataSet 

The dataset used here in my Vignette is the NCAA Women's Basketball Tournament data containing information for every team that has participated in the NCAA Division I Women’s Basketball Tournament since it began in 1982. Every school is shown with its seed, conference record (when available), regular-season record, tournament record and full season record, including winning percentages.

* FiveThirtyEight.com datasets: https://github.com/fivethirtyeight/data/tree/master/ncaa-womens-basketball-tournament

* GitHub handle: https://github.com/theoracley/FALL2019TIDYVERSE

* TidyVerse Assignment: http://rpubs.com/ahajjam/554990

* TidyVerse Task1 Vignette: https://github.com/theoracley/FALL2019TIDYVERSE/blob/master/Abdelmalek_Hajjam_TidyVerse.Rmd

#### I also updated Salma's Vigntte using some dylyr functions:

* TidyVerse Task2 Updated Salma's Vignette: https://github.com/theoracley/FALL2019TIDYVERSE/blob/master/Abdelmalek_Hajjam_Updated_Salma_Vignette.Rmd





