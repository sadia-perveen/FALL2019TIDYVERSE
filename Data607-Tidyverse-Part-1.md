``` r
library(tidyverse)
```

Dataset
=======

The dataset I used is [Border Crossing Entry
Data](https://www.kaggle.com/akhilv11/border-crossing-entry-data/data)
from
<a href="https://www.kaggle.com/datasets" class="uri">https://www.kaggle.com/datasets</a>.
To reduce size of the data, I select data from year 2002 to 2019.

readr–read\_csv
===============

`read_csv` from `readr` (a sub-package of `tidyverse`) is a faster
function to import csv files in terms of performance than the R default
function `read.csv`, especially for large data sets.

``` r
data <- read_csv('https://raw.githubusercontent.com/shirley-wong/Data-607/master/Border_Crossing_Entry_Data_2002-2019.csv')
```

    ## Parsed with column specification:
    ## cols(
    ##   `Port Name` = col_character(),
    ##   State = col_character(),
    ##   `Port Code` = col_double(),
    ##   Border = col_character(),
    ##   Date = col_character(),
    ##   Measure = col_character(),
    ##   Value = col_double(),
    ##   Location = col_character()
    ## )

``` r
data
```

    ## # A tibble: 257,741 x 8
    ##    `Port Name` State  `Port Code` Border   Date  Measure   Value Location  
    ##    <chr>       <chr>        <dbl> <chr>    <chr> <chr>     <dbl> <chr>     
    ##  1 Alcan       Alaska        3104 US-Cana~ 3/1/~ Truck Co~   392 POINT (-1~
    ##  2 Alcan       Alaska        3104 US-Cana~ 3/1/~ Truck Co~   162 POINT (-1~
    ##  3 Alcan       Alaska        3104 US-Cana~ 3/1/~ Personal~  3399 POINT (-1~
    ##  4 Alcan       Alaska        3104 US-Cana~ 3/1/~ Trucks      553 POINT (-1~
    ##  5 Alcan       Alaska        3104 US-Cana~ 3/1/~ Personal~  1481 POINT (-1~
    ##  6 Alcan       Alaska        3104 US-Cana~ 2/1/~ Pedestri~    42 POINT (-1~
    ##  7 Alcan       Alaska        3104 US-Cana~ 2/1/~ Personal~   827 POINT (-1~
    ##  8 Alcan       Alaska        3104 US-Cana~ 2/1/~ Trucks      397 POINT (-1~
    ##  9 Alcan       Alaska        3104 US-Cana~ 2/1/~ Truck Co~   315 POINT (-1~
    ## 10 Alcan       Alaska        3104 US-Cana~ 2/1/~ Truck Co~    85 POINT (-1~
    ## # ... with 257,731 more rows

Pipe operator %\>%
==================

`tidyverse` incorperates the pipe operator `%>%` from the `magrittr`
package. The pipe `%>%` help writing code in a way that is easier to
read and understand. Ranther than embed the ‘input’ of a function within
the arguments (eg: function(input = data, argument1, argument2…)), the
pipe `%>%` seperates ‘input’ from the function (eg: input %\>%
function(argument1, argument2…)), and enable recursive application,
which means the output of the preceding piece of the code can be used as
the input the folloing piece of code. (eg: input %\>%
function1(argument1, argument2…) %\>% function2(argument1, argument2…)).

``` r
data_mod <- data
data_mod$Date <- data_mod$Date %>% as.Date('%m/%d/%Y')
data_mod
```

    ## # A tibble: 257,741 x 8
    ##    `Port Name` State  `Port Code` Border  Date       Measure Value Location
    ##    <chr>       <chr>        <dbl> <chr>   <date>     <chr>   <dbl> <chr>   
    ##  1 Alcan       Alaska        3104 US-Can~ 2019-03-01 Truck ~   392 POINT (~
    ##  2 Alcan       Alaska        3104 US-Can~ 2019-03-01 Truck ~   162 POINT (~
    ##  3 Alcan       Alaska        3104 US-Can~ 2019-03-01 Person~  3399 POINT (~
    ##  4 Alcan       Alaska        3104 US-Can~ 2019-03-01 Trucks    553 POINT (~
    ##  5 Alcan       Alaska        3104 US-Can~ 2019-03-01 Person~  1481 POINT (~
    ##  6 Alcan       Alaska        3104 US-Can~ 2019-02-01 Pedest~    42 POINT (~
    ##  7 Alcan       Alaska        3104 US-Can~ 2019-02-01 Person~   827 POINT (~
    ##  8 Alcan       Alaska        3104 US-Can~ 2019-02-01 Trucks    397 POINT (~
    ##  9 Alcan       Alaska        3104 US-Can~ 2019-02-01 Truck ~   315 POINT (~
    ## 10 Alcan       Alaska        3104 US-Can~ 2019-02-01 Truck ~    85 POINT (~
    ## # ... with 257,731 more rows

dplyr–mutate
============

the `mutate` function from `dplyr` (a sub-package in `tidyverse`), adds
new variables and preserves existing ones. Here I will use `mutate` as
well as the `%>%` to demostrate the operation above again.

``` r
data_mod2 <- data %>%
  mutate(Date = as.Date(Date, '%m/%d/%Y'))

data_mod2
```

    ## # A tibble: 257,741 x 8
    ##    `Port Name` State  `Port Code` Border  Date       Measure Value Location
    ##    <chr>       <chr>        <dbl> <chr>   <date>     <chr>   <dbl> <chr>   
    ##  1 Alcan       Alaska        3104 US-Can~ 2019-03-01 Truck ~   392 POINT (~
    ##  2 Alcan       Alaska        3104 US-Can~ 2019-03-01 Truck ~   162 POINT (~
    ##  3 Alcan       Alaska        3104 US-Can~ 2019-03-01 Person~  3399 POINT (~
    ##  4 Alcan       Alaska        3104 US-Can~ 2019-03-01 Trucks    553 POINT (~
    ##  5 Alcan       Alaska        3104 US-Can~ 2019-03-01 Person~  1481 POINT (~
    ##  6 Alcan       Alaska        3104 US-Can~ 2019-02-01 Pedest~    42 POINT (~
    ##  7 Alcan       Alaska        3104 US-Can~ 2019-02-01 Person~   827 POINT (~
    ##  8 Alcan       Alaska        3104 US-Can~ 2019-02-01 Trucks    397 POINT (~
    ##  9 Alcan       Alaska        3104 US-Can~ 2019-02-01 Truck ~   315 POINT (~
    ## 10 Alcan       Alaska        3104 US-Can~ 2019-02-01 Truck ~    85 POINT (~
    ## # ... with 257,731 more rows

stringr–str\_replace
====================

the `str_replace` function from `stringr` (a sub-package in
`tidyverse`), replace content in a string with a defined common pattern
by another content. In this example I will use backreferences in regular
expressions to retain only the numerical parts in column `Location`.

``` r
data_mod3 <- data_mod2 %>%
  mutate(Location = str_replace(Location, '.+\\((.+)\\).*', '\\1'))

data_mod3
```

    ## # A tibble: 257,741 x 8
    ##    `Port Name` State  `Port Code` Border  Date       Measure Value Location
    ##    <chr>       <chr>        <dbl> <chr>   <date>     <chr>   <dbl> <chr>   
    ##  1 Alcan       Alaska        3104 US-Can~ 2019-03-01 Truck ~   392 -142.98~
    ##  2 Alcan       Alaska        3104 US-Can~ 2019-03-01 Truck ~   162 -142.98~
    ##  3 Alcan       Alaska        3104 US-Can~ 2019-03-01 Person~  3399 -142.98~
    ##  4 Alcan       Alaska        3104 US-Can~ 2019-03-01 Trucks    553 -142.98~
    ##  5 Alcan       Alaska        3104 US-Can~ 2019-03-01 Person~  1481 -142.98~
    ##  6 Alcan       Alaska        3104 US-Can~ 2019-02-01 Pedest~    42 -142.98~
    ##  7 Alcan       Alaska        3104 US-Can~ 2019-02-01 Person~   827 -142.98~
    ##  8 Alcan       Alaska        3104 US-Can~ 2019-02-01 Trucks    397 -142.98~
    ##  9 Alcan       Alaska        3104 US-Can~ 2019-02-01 Truck ~   315 -142.98~
    ## 10 Alcan       Alaska        3104 US-Can~ 2019-02-01 Truck ~    85 -142.98~
    ## # ... with 257,731 more rows

tidyr-separate
==============

the `separate` function from `tidyr` (a sub-package in `tidyverse`),
splites one column into multiple columns by defined delimiter. In this
example, I will demostrator this function by spliting the `Date` column
into `Year`, `Month` and `Date` 3 columns, as well as spliting
`Location` column into `Latitude` and `Longitude` 2 columns.

``` r
data_mod4 <- data_mod3 %>%
  separate(Date,c('Year','Month','Date')) %>%
  separate(Location, c('Latitute','Longitude'), sep = ' ')

data_mod4
```

    ## # A tibble: 257,741 x 11
    ##    `Port Name` State `Port Code` Border Year  Month Date  Measure Value
    ##    <chr>       <chr>       <dbl> <chr>  <chr> <chr> <chr> <chr>   <dbl>
    ##  1 Alcan       Alas~        3104 US-Ca~ 2019  03    01    Truck ~   392
    ##  2 Alcan       Alas~        3104 US-Ca~ 2019  03    01    Truck ~   162
    ##  3 Alcan       Alas~        3104 US-Ca~ 2019  03    01    Person~  3399
    ##  4 Alcan       Alas~        3104 US-Ca~ 2019  03    01    Trucks    553
    ##  5 Alcan       Alas~        3104 US-Ca~ 2019  03    01    Person~  1481
    ##  6 Alcan       Alas~        3104 US-Ca~ 2019  02    01    Pedest~    42
    ##  7 Alcan       Alas~        3104 US-Ca~ 2019  02    01    Person~   827
    ##  8 Alcan       Alas~        3104 US-Ca~ 2019  02    01    Trucks    397
    ##  9 Alcan       Alas~        3104 US-Ca~ 2019  02    01    Truck ~   315
    ## 10 Alcan       Alas~        3104 US-Ca~ 2019  02    01    Truck ~    85
    ## # ... with 257,731 more rows, and 2 more variables: Latitute <chr>,
    ## #   Longitude <chr>

dplyr–select
============

the `select` function from `dplyr` keeps only the variables that are
mention, or use minus sign ‘-’ to drop the variables that are mentioned.
In this example I will drop the `Port Code` column which contains
duplicate information compared to `Port Name` column.

``` r
data_mod5 <-data_mod4 %>%
  select(-`Port Code`)

data_mod5
```

    ## # A tibble: 257,741 x 10
    ##    `Port Name` State Border Year  Month Date  Measure Value Latitute
    ##    <chr>       <chr> <chr>  <chr> <chr> <chr> <chr>   <dbl> <chr>   
    ##  1 Alcan       Alas~ US-Ca~ 2019  03    01    Truck ~   392 -142.98~
    ##  2 Alcan       Alas~ US-Ca~ 2019  03    01    Truck ~   162 -142.98~
    ##  3 Alcan       Alas~ US-Ca~ 2019  03    01    Person~  3399 -142.98~
    ##  4 Alcan       Alas~ US-Ca~ 2019  03    01    Trucks    553 -142.98~
    ##  5 Alcan       Alas~ US-Ca~ 2019  03    01    Person~  1481 -142.98~
    ##  6 Alcan       Alas~ US-Ca~ 2019  02    01    Pedest~    42 -142.98~
    ##  7 Alcan       Alas~ US-Ca~ 2019  02    01    Person~   827 -142.98~
    ##  8 Alcan       Alas~ US-Ca~ 2019  02    01    Trucks    397 -142.98~
    ##  9 Alcan       Alas~ US-Ca~ 2019  02    01    Truck ~   315 -142.98~
    ## 10 Alcan       Alas~ US-Ca~ 2019  02    01    Truck ~    85 -142.98~
    ## # ... with 257,731 more rows, and 1 more variable: Longitude <chr>

dplyr–filter
============

the `filter` function from `dplyr` choose rows/cases where conditions
are true. In this example I will filter cases in year 2019 only.

``` r
data_mod6 <- data_mod5 %>%
  filter(Year == 2019)

data_mod6
```

    ## # A tibble: 2,364 x 10
    ##    `Port Name` State Border Year  Month Date  Measure Value Latitute
    ##    <chr>       <chr> <chr>  <chr> <chr> <chr> <chr>   <dbl> <chr>   
    ##  1 Alcan       Alas~ US-Ca~ 2019  03    01    Truck ~   392 -142.98~
    ##  2 Alcan       Alas~ US-Ca~ 2019  03    01    Truck ~   162 -142.98~
    ##  3 Alcan       Alas~ US-Ca~ 2019  03    01    Person~  3399 -142.98~
    ##  4 Alcan       Alas~ US-Ca~ 2019  03    01    Trucks    553 -142.98~
    ##  5 Alcan       Alas~ US-Ca~ 2019  03    01    Person~  1481 -142.98~
    ##  6 Alcan       Alas~ US-Ca~ 2019  02    01    Pedest~    42 -142.98~
    ##  7 Alcan       Alas~ US-Ca~ 2019  02    01    Person~   827 -142.98~
    ##  8 Alcan       Alas~ US-Ca~ 2019  02    01    Trucks    397 -142.98~
    ##  9 Alcan       Alas~ US-Ca~ 2019  02    01    Truck ~   315 -142.98~
    ## 10 Alcan       Alas~ US-Ca~ 2019  02    01    Truck ~    85 -142.98~
    ## # ... with 2,354 more rows, and 1 more variable: Longitude <chr>

dplyr–group\_by, summarise
==========================

the `group_by` and `summarise` functions from `dplyr` are often used
together. `group_by` takes an existing table and converts it into a
grouped table where operations are performed “by group”. `summarise`
creates one or more scalar variables summarizing the variables of an
existing table, such as calculating column sum, mean, etc.,.

``` r
data_mod7 <- data_mod6 %>%
  group_by(`State`) %>%
  summarise(Ttl_Value = sum(Value))

data_mod7
```

    ## # A tibble: 14 x 2
    ##    State        Ttl_Value
    ##    <chr>            <dbl>
    ##  1 Alaska           27540
    ##  2 Arizona        8265657
    ##  3 California    26402444
    ##  4 Idaho           163881
    ##  5 Maine          1120795
    ##  6 Michigan       4987431
    ##  7 Minnesota       699670
    ##  8 Montana         360238
    ##  9 New Mexico      870187
    ## 10 New York       5196702
    ## 11 North Dakota    629362
    ## 12 Texas         32418383
    ## 13 Vermont         697182
    ## 14 Washington     4508927

dplyr–arrange & desc
====================

the `arrange` function sorts variables in ascending order. `Desc`
function sorts a vector in descending order. Combine these two function
allow as to arrange a table in desending order

``` r
data_mod8 <- data_mod7 %>%
  arrange(desc(Ttl_Value))

data_mod8
```

    ## # A tibble: 14 x 2
    ##    State        Ttl_Value
    ##    <chr>            <dbl>
    ##  1 Texas         32418383
    ##  2 California    26402444
    ##  3 Arizona        8265657
    ##  4 New York       5196702
    ##  5 Michigan       4987431
    ##  6 Washington     4508927
    ##  7 Maine          1120795
    ##  8 New Mexico      870187
    ##  9 Minnesota       699670
    ## 10 Vermont         697182
    ## 11 North Dakota    629362
    ## 12 Montana         360238
    ## 13 Idaho           163881
    ## 14 Alaska           27540

ggplot2 & fct\_reorder
======================

the `fct_reorder` function from `forcats` (a sub-package in `tidyverse`)
offers a handy solution to reorder values in ggplot functions.

``` r
data_mod6 %>% 
  group_by(State) %>%
  summarise(Sum_Value = sum(Value)) %>%
  ggplot(aes(x=fct_reorder(State, Sum_Value), y=Sum_Value,fill=Sum_Value,label = Sum_Value))+
  geom_col()+
  ylim(0,40000000)+
  coord_flip()+
  geom_text(hjust = -0.1, size = 3)+
  labs(
    title='Border Crossing Activity Count by State',
    subtitle = 'Year 2019')+
  xlab('State')+
  ylab('Count')
```

![](Data607-Tidyverse-Part-1_files/figure-markdown_github/plots-1.png)

``` r
data_mod5 %>%
  group_by(Measure,Year) %>%
  summarise(Sum_Value = sum(Value)) %>% 
  mutate(Year = as.numeric(Year)) %>%
  ggplot() +
  geom_line(aes(x= Year, y = Sum_Value, colour = Measure))+
  scale_x_discrete(limits = c(2002:2019))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  labs(
    title = 'Total Border Crossing Activity Count 2002 - 2019',
    subtitle = 'by Measure')+
  ylab('Count')+
  geom_vline(xintercept = 2018, linetype = 'dashed', color = 'steelblue', size = 1)
```

![](Data607-Tidyverse-Part-1_files/figure-markdown_github/plots-2.png)
