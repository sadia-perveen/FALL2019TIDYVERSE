Assignment Description
======================

In this assignment, you’ll practice collaborating around a code project
with GitHub. You could consider our collective work as building out a
book of examples on how to use TidyVerse functions.

GitHub repository:
<a href="https://github.com/acatlin/FALL2019TIDYVERSE" class="uri">https://github.com/acatlin/FALL2019TIDYVERSE</a>

[FiveThirtyEight.com datasets.](https://data.fivethirtyeight.com/)

[Kaggle datasets.](https://www.kaggle.com/datasets)

You have two tasks:

1.  Create an Example. Using one or more TidyVerse packages, and any
    dataset from fivethirtyeight.com or Kaggle, create a programming
    sample “vignette” that demonstrates how to use one or more of the
    capabilities of the selected TidyVerse package with your selected
    dataset. (25 points)

2.  Extend an Existing Example. Using one of your classmate’s examples
    (as created above), extend his or her example with additional
    annotated code. (15 points)

You should clone the provided repository. Once you have code to submit,
you should make a pull request on the shared repository. Minimally, you
should be submitted .Rmd files; ideally, you should also submit an .md
file and update the README.md file with your example.

After you’ve completed both parts of the assignment, please submit your
GitHub handle name in the submission link provided in the week 1 folder!
This will let your instructor know that your work is ready to be graded.

You should complete both parts of the assignment and make your
submission no later than the end of day on Sunday, December 1st.

Part 1
======

Introduction
------------

There are currently 8 packages in the `tidyverse` package bundle
including:

-   `dplyr`: a set of tools for efficiently manipulating datasets;
-   `forcats`: a package for manipulating categorical variables /
    factors;
-   `ggplots2`: a classic package for data visualization;
-   `purrr`: another set of tools for manipulating datasets, specially
    vecters, a complement to `dplyr`;
-   `readr`: a set of faster and more user friendly functions to read
    data than R default functions;
-   `stringr`: a package for common string operations;
-   `tibble`：a package for reimagining data.frames in a modern way;
-   `tidyr`: a package for reshaping data, a complement to `dplyr`.

In this assignment, I will use some handy functions in `tidyverse`
package to perform data cleaning.

``` r
library(tidyverse)
```

Dataset
-------

The dataset in this project is called ‘London bike sharing dataset’ from
<a href="https://www.kaggle.com/datasets" class="uri">https://www.kaggle.com/datasets</a>;
The description of data is as below:

    "timestamp" - timestamp field for grouping the data 
    "cnt" - the count of a new bike shares 
    "t1" - real temperature in C 
    "t2" - temperature in C "feels like" 
    "hum" - humidity in percentage 
    "wind_speed" - wind speed in km/h 
    "weather_code" - category of the weather 
    "is_holiday" - boolean field - 1 holiday / 0 non holiday 
    "is_weekend" - boolean field - 1 if the day is weekend 
    "season" - category field meteorological seasons: 0-spring ; 1-summer; 2-fall; 3-winter. 
    "weathe_code" category description: 
    1 = Clear ; mostly clear but have some values with haze/fog/patches of fog/ fog in vicinity 
    2 = scattered clouds / few clouds 
    3 = Broken clouds 
    4 = Cloudy 
    7 = Rain/ light Rain shower/ Light rain 
    10 = rain with thunderstorm 
    26 = snowfall 
    94 = Freezing Fog

readr::read\_csv
----------------

I use `read_csv` function from `readr` to import csv file.

``` r
data_raw <- read_csv("https://raw.githubusercontent.com/oggyluky11/Data607-Tidyverse_Vignette/master/london_merged.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   timestamp = col_datetime(format = ""),
    ##   cnt = col_double(),
    ##   t1 = col_double(),
    ##   t2 = col_double(),
    ##   hum = col_double(),
    ##   wind_speed = col_double(),
    ##   weather_code = col_double(),
    ##   is_holiday = col_double(),
    ##   is_weekend = col_double(),
    ##   season = col_double()
    ## )

``` r
head(data_raw)
```

    ## # A tibble: 6 x 10
    ##   timestamp             cnt    t1    t2   hum wind_speed weather_code
    ##   <dttm>              <dbl> <dbl> <dbl> <dbl>      <dbl>        <dbl>
    ## 1 2015-01-04 00:00:00   182   3     2    93          6              3
    ## 2 2015-01-04 01:00:00   138   3     2.5  93          5              1
    ## 3 2015-01-04 02:00:00   134   2.5   2.5  96.5        0              1
    ## 4 2015-01-04 03:00:00    72   2     2   100          0              1
    ## 5 2015-01-04 04:00:00    47   2     0    93          6.5            1
    ## 6 2015-01-04 05:00:00    46   2     2    93          4              1
    ## # ... with 3 more variables: is_holiday <dbl>, is_weekend <dbl>,
    ## #   season <dbl>

There is a default function `read.csv` in R to import CSV files.
However, the comment below shows that the readr::read\_csv performs much
faster than the default `read.csv`.

``` r
#readr function
system.time(d<-read_csv("https://raw.githubusercontent.com/oggyluky11/Data607-Tidyverse_Vignette/master/london_merged.csv"))
```

    ##    user  system elapsed 
    ##    0.04    0.01    0.09

``` r
#default function
system.time(d<-read.csv("https://raw.githubusercontent.com/oggyluky11/Data607-Tidyverse_Vignette/master/london_merged.csv"))
```

    ##    user  system elapsed 
    ##    0.89    0.02    1.00

dplyr::case\_when
-----------------

`case_when` is a handly function when we want to modify values in a
column according to a predefined logic. It the dataset above, all the
factors are represented by numerical values. I use `case_when` to assign
text strings ‘spring’, ‘summer’, ‘fall’, ‘winter’ back to their
corresponding numerical representations ‘0’, ‘1’, ‘2’, ‘3’. Note that
this function is handly because the original data type in the data set
is ‘double’ for value 0,1,2,3, use `case_when` to rewrite numerical
values by text values doesn’t trigger any errors.

``` r
season <- data_raw$season
season <- case_when(season == 0 ~ 'spring',
                  season == 1 ~ 'summer',
                  season == 2 ~ 'fall',
                  season == 3 ~ 'winter')
table(data_raw$season)
```

    ## 
    ##    0    1    2    3 
    ## 4394 4387 4303 4330

``` r
table(season)
```

    ## season
    ##   fall spring summer winter 
    ##   4303   4394   4387   4330

dplyr::recode
-------------

While `case_When` is a general process to modify values according to
predefined logics, another function `recode` can do the task in this
example in a more convenient way. `case_when` is more generalized if
there are more complicated logics applied, such as mathematical
functions.

``` r
season <- recode(data_raw$season, '0'='spring' , '1'='summer', '2'='fall', '3'='winter')
table(season)
```

    ## season
    ##   fall spring summer winter 
    ##   4303   4394   4387   4330

tidyr::gather & spread
----------------------

An important data transformation is converting data between ‘long
format’ and ‘wide format’. The `gather` and `spread` functions in
`tidyr` package do the job easily. Please note that I use these two
functions here for demostration purpose, the use of these two functions
doesn’t have actual meanings to this example.

1.  `gather`. Here I will reshape the last 4 columns in this dataset, -
    which are ‘is\_holiday’, ‘is\_weekend’, ‘season’, ‘weather\_code’,
    into two columns. One column is called ‘atrribute’ which contains
    the name of the original columns, the other is called ‘value’ which
    contains the original column values. Doing this operation we
    converted the original data from ‘wide format’ into ‘long format’.
    This operation benefits when we want to consolidate values from
    columns of similar natures. For example. when we have location names
    as columns names in our dataset, we may want to consolidate values
    from all locations into one column for better analysis. In this
    example, gathering columns ‘is\_holiday’, ‘is\_weekend’, ‘season’,
    ‘weather\_code’ is meaningless, so I will reverse the process in the
    following chunk.

``` r
gather_data <- gather(data_raw,key = 'atrribute', value = 'value', 7:10)

gather_data
```

    ## # A tibble: 69,656 x 8
    ##    timestamp             cnt    t1    t2   hum wind_speed atrribute   value
    ##    <dttm>              <dbl> <dbl> <dbl> <dbl>      <dbl> <chr>       <dbl>
    ##  1 2015-01-04 00:00:00   182   3     2    93          6   weather_co~     3
    ##  2 2015-01-04 01:00:00   138   3     2.5  93          5   weather_co~     1
    ##  3 2015-01-04 02:00:00   134   2.5   2.5  96.5        0   weather_co~     1
    ##  4 2015-01-04 03:00:00    72   2     2   100          0   weather_co~     1
    ##  5 2015-01-04 04:00:00    47   2     0    93          6.5 weather_co~     1
    ##  6 2015-01-04 05:00:00    46   2     2    93          4   weather_co~     1
    ##  7 2015-01-04 06:00:00    51   1    -1   100          7   weather_co~     4
    ##  8 2015-01-04 07:00:00    75   1    -1   100          7   weather_co~     4
    ##  9 2015-01-04 08:00:00   131   1.5  -1    96.5        8   weather_co~     4
    ## 10 2015-01-04 09:00:00   301   2    -0.5 100          9   weather_co~     3
    ## # ... with 69,646 more rows

``` r
table(gather_data$atrribute)
```

    ## 
    ##   is_holiday   is_weekend       season weather_code 
    ##        17414        17414        17414        17414

1.  `spread`. This function is used to convert data from ‘long format’
    into ‘wide format’. In the example above, we have a column called
    ‘atrribute’, and its correspoding value column ‘values’ and I want
    to break this ‘long’ column into ‘shorter’ columns by the factors in
    `atrribute`. There are four factors ‘is\_holiday’, ‘is\_weekend’,
    ‘season’ and ‘weather\_code’, therefore when `spread` is applied, 4
    new columns are created, each for one of the four factors.

We can see that `gather` and `spread` are reverse processes of each
other. When we gather and again spread out the dataset, we get our
original dataset again.

``` r
spread_data <- spread(gather_data,key = 'atrribute', value = 'value')

spread_data
```

    ## # A tibble: 17,414 x 10
    ##    timestamp             cnt    t1    t2   hum wind_speed is_holiday
    ##    <dttm>              <dbl> <dbl> <dbl> <dbl>      <dbl>      <dbl>
    ##  1 2015-01-04 00:00:00   182   3     2    93          6            0
    ##  2 2015-01-04 01:00:00   138   3     2.5  93          5            0
    ##  3 2015-01-04 02:00:00   134   2.5   2.5  96.5        0            0
    ##  4 2015-01-04 03:00:00    72   2     2   100          0            0
    ##  5 2015-01-04 04:00:00    47   2     0    93          6.5          0
    ##  6 2015-01-04 05:00:00    46   2     2    93          4            0
    ##  7 2015-01-04 06:00:00    51   1    -1   100          7            0
    ##  8 2015-01-04 07:00:00    75   1    -1   100          7            0
    ##  9 2015-01-04 08:00:00   131   1.5  -1    96.5        8            0
    ## 10 2015-01-04 09:00:00   301   2    -0.5 100          9            0
    ## # ... with 17,404 more rows, and 3 more variables: is_weekend <dbl>,
    ## #   season <dbl>, weather_code <dbl>

``` r
all.equal(spread_data, data_raw)
```

    ## [1] TRUE

dplyr:mutate
------------

`mutate` function adds new variables into the dataframe and presevers
the existing ones. For example, if I want to calculate the Fahrenheit
degrees of ‘t1’ and ‘t2’ and retain ‘t1’ and ‘t2’, I do the following:

``` r
data_f <- mutate(data_raw, f1 = t1*9/5+32, f2 = t2*9/5+32)

data_f
```

    ## # A tibble: 17,414 x 12
    ##    timestamp             cnt    t1    t2   hum wind_speed weather_code
    ##    <dttm>              <dbl> <dbl> <dbl> <dbl>      <dbl>        <dbl>
    ##  1 2015-01-04 00:00:00   182   3     2    93          6              3
    ##  2 2015-01-04 01:00:00   138   3     2.5  93          5              1
    ##  3 2015-01-04 02:00:00   134   2.5   2.5  96.5        0              1
    ##  4 2015-01-04 03:00:00    72   2     2   100          0              1
    ##  5 2015-01-04 04:00:00    47   2     0    93          6.5            1
    ##  6 2015-01-04 05:00:00    46   2     2    93          4              1
    ##  7 2015-01-04 06:00:00    51   1    -1   100          7              4
    ##  8 2015-01-04 07:00:00    75   1    -1   100          7              4
    ##  9 2015-01-04 08:00:00   131   1.5  -1    96.5        8              4
    ## 10 2015-01-04 09:00:00   301   2    -0.5 100          9              3
    ## # ... with 17,404 more rows, and 5 more variables: is_holiday <dbl>,
    ## #   is_weekend <dbl>, season <dbl>, f1 <dbl>, f2 <dbl>

dplyr:select
------------

the `select` function is straightforward, I can select the functions
that I want. If I want to drop columns such as the ‘t1’ and ‘t2’ in the
example above, the `select` function is also handy.

``` r
data_f_selected <- select(data_f, -t1, -t2)

data_f_selected
```

    ## # A tibble: 17,414 x 10
    ##    timestamp             cnt   hum wind_speed weather_code is_holiday
    ##    <dttm>              <dbl> <dbl>      <dbl>        <dbl>      <dbl>
    ##  1 2015-01-04 00:00:00   182  93          6              3          0
    ##  2 2015-01-04 01:00:00   138  93          5              1          0
    ##  3 2015-01-04 02:00:00   134  96.5        0              1          0
    ##  4 2015-01-04 03:00:00    72 100          0              1          0
    ##  5 2015-01-04 04:00:00    47  93          6.5            1          0
    ##  6 2015-01-04 05:00:00    46  93          4              1          0
    ##  7 2015-01-04 06:00:00    51 100          7              4          0
    ##  8 2015-01-04 07:00:00    75 100          7              4          0
    ##  9 2015-01-04 08:00:00   131  96.5        8              4          0
    ## 10 2015-01-04 09:00:00   301 100          9              3          0
    ## # ... with 17,404 more rows, and 4 more variables: is_weekend <dbl>,
    ## #   season <dbl>, f1 <dbl>, f2 <dbl>

stringr::str\_extract
---------------------

`str_extract` is used when I want to get content from a string according
to a comment pattern denoted by regular expression. Regular expression
is out of the scope of this assignment so I won’t go further into
details. In this example I used `str_extract` the first 4 digit combo in
column ‘timestamp’ which is the year.

``` r
data_year <- mutate(data_f, year = str_extract(timestamp, '[0-9]{4}'))
data_year
```

    ## # A tibble: 17,414 x 13
    ##    timestamp             cnt    t1    t2   hum wind_speed weather_code
    ##    <dttm>              <dbl> <dbl> <dbl> <dbl>      <dbl>        <dbl>
    ##  1 2015-01-04 00:00:00   182   3     2    93          6              3
    ##  2 2015-01-04 01:00:00   138   3     2.5  93          5              1
    ##  3 2015-01-04 02:00:00   134   2.5   2.5  96.5        0              1
    ##  4 2015-01-04 03:00:00    72   2     2   100          0              1
    ##  5 2015-01-04 04:00:00    47   2     0    93          6.5            1
    ##  6 2015-01-04 05:00:00    46   2     2    93          4              1
    ##  7 2015-01-04 06:00:00    51   1    -1   100          7              4
    ##  8 2015-01-04 07:00:00    75   1    -1   100          7              4
    ##  9 2015-01-04 08:00:00   131   1.5  -1    96.5        8              4
    ## 10 2015-01-04 09:00:00   301   2    -0.5 100          9              3
    ## # ... with 17,404 more rows, and 6 more variables: is_holiday <dbl>,
    ## #   is_weekend <dbl>, season <dbl>, f1 <dbl>, f2 <dbl>, year <chr>

tidyr::seperate
---------------

Another way to get the year column is to convert the column into ‘Date’
format then use `seperate` function to seperate ‘year’, ‘month’ and
‘date’ into three columns.

``` r
data_year <- mutate(data_f, timestamp = as.Date(timestamp))
data_year <- separate(data_year, timestamp, c('year','month','date'))

data_year
```

    ## # A tibble: 17,414 x 14
    ##    year  month date    cnt    t1    t2   hum wind_speed weather_code
    ##    <chr> <chr> <chr> <dbl> <dbl> <dbl> <dbl>      <dbl>        <dbl>
    ##  1 2015  01    04      182   3     2    93          6              3
    ##  2 2015  01    04      138   3     2.5  93          5              1
    ##  3 2015  01    04      134   2.5   2.5  96.5        0              1
    ##  4 2015  01    04       72   2     2   100          0              1
    ##  5 2015  01    04       47   2     0    93          6.5            1
    ##  6 2015  01    04       46   2     2    93          4              1
    ##  7 2015  01    04       51   1    -1   100          7              4
    ##  8 2015  01    04       75   1    -1   100          7              4
    ##  9 2015  01    04      131   1.5  -1    96.5        8              4
    ## 10 2015  01    04      301   2    -0.5 100          9              3
    ## # ... with 17,404 more rows, and 5 more variables: is_holiday <dbl>,
    ## #   is_weekend <dbl>, season <dbl>, f1 <dbl>, f2 <dbl>

tidyr::unite
------------

The `unite` function is used to comcatnate values of two columns into a
new column. The argument ‘remove’ is to indicate whether to remove the
original columns that to be united.

``` r
data_unite <- unite(data_year,year_month, year,month, sep = '-', remove = FALSE)
data_unite
```

    ## # A tibble: 17,414 x 15
    ##    year_month year  month date    cnt    t1    t2   hum wind_speed
    ##    <chr>      <chr> <chr> <chr> <dbl> <dbl> <dbl> <dbl>      <dbl>
    ##  1 2015-01    2015  01    04      182   3     2    93          6  
    ##  2 2015-01    2015  01    04      138   3     2.5  93          5  
    ##  3 2015-01    2015  01    04      134   2.5   2.5  96.5        0  
    ##  4 2015-01    2015  01    04       72   2     2   100          0  
    ##  5 2015-01    2015  01    04       47   2     0    93          6.5
    ##  6 2015-01    2015  01    04       46   2     2    93          4  
    ##  7 2015-01    2015  01    04       51   1    -1   100          7  
    ##  8 2015-01    2015  01    04       75   1    -1   100          7  
    ##  9 2015-01    2015  01    04      131   1.5  -1    96.5        8  
    ## 10 2015-01    2015  01    04      301   2    -0.5 100          9  
    ## # ... with 17,404 more rows, and 6 more variables: weather_code <dbl>,
    ## #   is_holiday <dbl>, is_weekend <dbl>, season <dbl>, f1 <dbl>, f2 <dbl>

dplyr::group\_by
----------------

The `group_by` function groups the dataframe into groups to allow the
following operations to be performed by group. In this example I group
the data by the column `year_month`, then calculate the mean of each
‘year-month’ group.

``` r
data_group <- group_by(data_unite, year_month)
data_group_mean_cnt <- mutate(data_group, mean_cnt = mean(cnt))
data_group_mean_cnt
```

    ## # A tibble: 17,414 x 16
    ## # Groups:   year_month [25]
    ##    year_month year  month date    cnt    t1    t2   hum wind_speed
    ##    <chr>      <chr> <chr> <chr> <dbl> <dbl> <dbl> <dbl>      <dbl>
    ##  1 2015-01    2015  01    04      182   3     2    93          6  
    ##  2 2015-01    2015  01    04      138   3     2.5  93          5  
    ##  3 2015-01    2015  01    04      134   2.5   2.5  96.5        0  
    ##  4 2015-01    2015  01    04       72   2     2   100          0  
    ##  5 2015-01    2015  01    04       47   2     0    93          6.5
    ##  6 2015-01    2015  01    04       46   2     2    93          4  
    ##  7 2015-01    2015  01    04       51   1    -1   100          7  
    ##  8 2015-01    2015  01    04       75   1    -1   100          7  
    ##  9 2015-01    2015  01    04      131   1.5  -1    96.5        8  
    ## 10 2015-01    2015  01    04      301   2    -0.5 100          9  
    ## # ... with 17,404 more rows, and 7 more variables: weather_code <dbl>,
    ## #   is_holiday <dbl>, is_weekend <dbl>, season <dbl>, f1 <dbl>, f2 <dbl>,
    ## #   mean_cnt <dbl>

``` r
unique(data_group_mean_cnt$year_month)
```

    ##  [1] "2015-01" "2015-02" "2015-03" "2015-04" "2015-05" "2015-06" "2015-07"
    ##  [8] "2015-08" "2015-09" "2015-10" "2015-11" "2015-12" "2016-01" "2016-02"
    ## [15] "2016-03" "2016-04" "2016-05" "2016-06" "2016-07" "2016-08" "2016-09"
    ## [22] "2016-10" "2016-11" "2016-12" "2017-01"

``` r
unique(data_group_mean_cnt$mean_cnt)
```

    ##  [1]  814.6632  810.1252  941.7240 1156.5814 1203.5121 1441.0767 1514.4419
    ##  [8] 1389.7191 1255.2433 1175.3342  952.6470  814.6459  782.9543  861.7878
    ## [15]  900.5857 1069.3255 1346.6868 1324.6496 1572.9109 1536.9108 1462.1069
    ## [22] 1259.3620  978.9416  876.2204  523.3333

Pipe Operator: %&gt;%
---------------------

The pipe operator ‘%&gt;%’,comes from the `magrittr` package, are
embeded in `tidyverse`. It enables a handy coding by inserting the
output of the preceding code into the following code by the operator
‘%&gt;%’, which makes R coding cleaner, easier and more straightforward
visually. I can combine all the codes in all previous example chunks
into one piece of code as below:

``` r
data <- data_raw %>%
  mutate(season = case_when(season == 0 ~ 'spring',
                  season == 1 ~ 'summer',
                  season == 2 ~ 'fall',
                  season == 3 ~ 'winter'),
         weather_code = recode(weather_code,
                               '1' = 'Clear',
                               '2' = 'scattered clouds / few clouds', 
                               '3' = 'Broken clouds',
                               '4' = 'Cloudy', 
                               '7' = 'Rain/ light Rain shower/ Light rain', 
                              '10' = 'rain with thunderstorm',
                              '26' = 'snowfall', 
                              '94' = 'Freezing Fog'),
         is_holiday = recode(is_holiday, '1' = 'Yes', '0' = 'No'),
         is_weekend = recode(is_weekend,'1' = 'Yes', '0' = 'No'),
         f1 = t1*9/5+32, 
         f2 = t2*9/5+32,
         timestamp = as.Date(timestamp)) %>%
  select(-t1, -t2) %>%
  separate(timestamp, c('year','month', 'date')) %>%
  unite(year_month, year, month, sep = '-', remove = FALSE) %>%
  group_by(year_month) %>%
  mutate(mean_cnt = mean(cnt)) %>%
  ungroup()


data
```

    ## # A tibble: 17,414 x 14
    ##    year_month year  month date    cnt   hum wind_speed weather_code
    ##    <chr>      <chr> <chr> <chr> <dbl> <dbl>      <dbl> <chr>       
    ##  1 2015-01    2015  01    04      182  93          6   Broken clou~
    ##  2 2015-01    2015  01    04      138  93          5   Clear       
    ##  3 2015-01    2015  01    04      134  96.5        0   Clear       
    ##  4 2015-01    2015  01    04       72 100          0   Clear       
    ##  5 2015-01    2015  01    04       47  93          6.5 Clear       
    ##  6 2015-01    2015  01    04       46  93          4   Clear       
    ##  7 2015-01    2015  01    04       51 100          7   Cloudy      
    ##  8 2015-01    2015  01    04       75 100          7   Cloudy      
    ##  9 2015-01    2015  01    04      131  96.5        8   Cloudy      
    ## 10 2015-01    2015  01    04      301 100          9   Broken clou~
    ## # ... with 17,404 more rows, and 6 more variables: is_holiday <chr>,
    ## #   is_weekend <chr>, season <chr>, f1 <dbl>, f2 <dbl>, mean_cnt <dbl>

Visualization: ggplot2
----------------------

`ggplot2` is a classific package for ploting the data. In this example I
plot a bar chart with column `year_month` as x-axis and `mean_cnt` as
y-axis.

``` r
data %>% 
  group_by(year_month) %>%
  summarise(mean_cnt = mean(cnt)) %>%
  ungroup() %>%
  ggplot(aes(x = year_month, y = mean_cnt, fill = mean_cnt, label = round(mean_cnt))) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = 'Average New Bike Shares by Month',
       subtitle = '2015-01 to 2017-01')+
  xlab('Year-Month') +
  ylab('Average Count') +
  scale_fill_continuous(name = 'Average Count')+
  geom_text(angle = 90, vjust = 0.4, hjust = 1.1, color = 'white', size = 3)
```

![](Data607_Tidyverse_Vignette_Part_1_files/figure-markdown_github/10-1.png)
