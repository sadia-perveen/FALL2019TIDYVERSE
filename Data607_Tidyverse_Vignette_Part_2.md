Part 1 by Rosemond
==================

title: “Tidyverse Part 1” author: “C. Rosemond” date: “November 2, 2019”
output: html\_document

Library
-------

``` r
library(tidyverse)
```

Data Set(s)
-----------

I selected two fivethirtyeight data sets: one that contains current
Soccer Power Index (SPI) ratings and rankings for men’s club teams and a
second that contains match-by-match SPI ratings and forecasts back to
2016.

URL:
<a href="https://github.com/fivethirtyeight/data/tree/master/soccer-spi" class="uri">https://github.com/fivethirtyeight/data/tree/master/soccer-spi</a>

readr - read\_csv()
-------------------

The readr package facilitates the reading in of ‘rectangular’ data like
.csv files or other delimited files. Here, I use the read\_csv()
function to read in two data sets: the global rankings, or ‘rankings’,
and the matches, or ‘matches’.

``` r
rankings <- read_csv('https://projects.fivethirtyeight.com/soccer-api/club/spi_global_rankings.csv')
matches <- read_csv('https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv')
head(rankings)
```

    ## # A tibble: 6 x 7
    ##    rank prev_rank name              league                  off   def   spi
    ##   <dbl>     <dbl> <chr>             <chr>                 <dbl> <dbl> <dbl>
    ## 1     1         1 Manchester City   Barclays Premier Lea~  3.25  0.25  94.8
    ## 2     2         2 Bayern Munich     German Bundesliga      3.43  0.43  93.6
    ## 3     3         3 Liverpool         Barclays Premier Lea~  2.85  0.31  91.8
    ## 4     4         5 Barcelona         Spanish Primera Divi~  2.83  0.44  89.6
    ## 5     5         4 Paris Saint-Germ~ French Ligue 1         2.9   0.5   89.2
    ## 6     6         6 Real Madrid       Spanish Primera Divi~  2.86  0.49  89.1

``` r
tail(matches)
```

    ## # A tibble: 6 x 22
    ##   date       league_id league team1 team2  spi1  spi2 prob1 prob2 probtie
    ##   <date>         <dbl> <chr>  <chr> <chr> <dbl> <dbl> <dbl> <dbl>   <dbl>
    ## 1 2020-05-24      1869 Spani~ Atle~ Real~  86.5  76.7 0.590 0.166   0.245
    ## 2 2020-05-24      1869 Spani~ Espa~ Celt~  68.3  68.9 0.464 0.262   0.274
    ## 3 2020-05-24      1871 Spani~ Lugo  Mira~  27.2  28.6 0.438 0.279   0.284
    ## 4 2020-05-24      1871 Spani~ Depo~ Fuen~  28.5  33.9 0.389 0.309   0.302
    ## 5 2020-05-24      1869 Spani~ Lega~ Real~  65.5  89.1 0.170 0.616   0.214
    ## 6 2020-05-24      1871 Spani~ Las ~ Extr~  32.9  25.8 0.522 0.194   0.285
    ## # ... with 12 more variables: proj_score1 <dbl>, proj_score2 <dbl>,
    ## #   importance1 <dbl>, importance2 <dbl>, score1 <dbl>, score2 <dbl>,
    ## #   xg1 <dbl>, xg2 <dbl>, nsxg1 <dbl>, nsxg2 <dbl>, adj_score1 <dbl>,
    ## #   adj_score2 <dbl>

dplyr - mutate()
----------------

The dplyr package provides a grammar for the manipulation of
data–notably, in data frames or tibbles. Here, I use the mutate function
to add a new column–a match ID–to the matches tibble.

``` r
matches <- mutate(matches, match = row_number())
matches <- matches[,c(23,1:22)]
head(matches)
```

    ## # A tibble: 6 x 23
    ##   match date       league_id league team1 team2  spi1  spi2  prob1 prob2
    ##   <int> <date>         <dbl> <chr>  <chr> <chr> <dbl> <dbl>  <dbl> <dbl>
    ## 1     1 2016-08-12      1843 Frenc~ Bast~ Pari~  51.2  85.7 0.0463 0.838
    ## 2     2 2016-08-12      1843 Frenc~ AS M~ Guin~  68.8  56.5 0.571  0.167
    ## 3     3 2016-08-13      2411 Barcl~ Hull~ Leic~  53.6  66.8 0.346  0.362
    ## 4     4 2016-08-13      2411 Barcl~ Crys~ West~  55.2  58.7 0.421  0.294
    ## 5     5 2016-08-13      2411 Barcl~ Ever~ Tott~  68.0  73.2 0.391  0.340
    ## 6     6 2016-08-13      2411 Barcl~ Midd~ Stok~  56.3  60.4 0.438  0.269
    ## # ... with 13 more variables: probtie <dbl>, proj_score1 <dbl>,
    ## #   proj_score2 <dbl>, importance1 <dbl>, importance2 <dbl>, score1 <dbl>,
    ## #   score2 <dbl>, xg1 <dbl>, xg2 <dbl>, nsxg1 <dbl>, nsxg2 <dbl>,
    ## #   adj_score1 <dbl>, adj_score2 <dbl>

dplyr - select()
----------------

The select function from dplyr enables the selection of data frame
columns by name or helper function. Here, I select and keep the first
six columns (‘match’ through ‘team2’) from the matches tibble.

``` r
matches <- select(matches, match:team2)
head(matches)
```

    ## # A tibble: 6 x 6
    ##   match date       league_id league             team1       team2          
    ##   <int> <date>         <dbl> <chr>              <chr>       <chr>          
    ## 1     1 2016-08-12      1843 French Ligue 1     Bastia      Paris Saint-Ge~
    ## 2     2 2016-08-12      1843 French Ligue 1     AS Monaco   Guingamp       
    ## 3     3 2016-08-13      2411 Barclays Premier ~ Hull City   Leicester City 
    ## 4     4 2016-08-13      2411 Barclays Premier ~ Crystal Pa~ West Bromwich ~
    ## 5     5 2016-08-13      2411 Barclays Premier ~ Everton     Tottenham Hots~
    ## 6     6 2016-08-13      2411 Barclays Premier ~ Middlesbro~ Stoke City

dplyr - filter()
----------------

The filter function from dplyr enables the subsetting of rows based on
specified logical criteria. Here, I select matches that occurred from
November 1st through November 7th.

``` r
matches <- filter(matches, date >= '2019-11-01' & date <= '2019-11-07')
head(matches)
```

    ## # A tibble: 6 x 6
    ##   match date       league_id league              team1        team2        
    ##   <int> <date>         <dbl> <chr>               <chr>        <chr>        
    ## 1 26558 2019-11-01      1979 Chinese Super Leag~ Guizhou Ren~ Guangzhou RF 
    ## 2 26559 2019-11-01      1948 Australian A-League Sydney FC    Newcastle Je~
    ## 3 26560 2019-11-01      1947 Japanese J League   Kashima Ant~ Urawa Red Di~
    ## 4 26561 2019-11-01      1871 Spanish Segunda Di~ Numancia     Albacete     
    ## 5 26562 2019-11-01      1871 Spanish Segunda Di~ Cadiz        Sporting Gij~
    ## 6 26563 2019-11-01      1846 German 2. Bundesli~ Hannover 96  SV Sandhausen

tidyr - gather()
----------------

The tidyr package is designed to facilitate reshaping data. Here, I use
the gather() function to reshape the matches tibble from wide to long
format, gathering the separate team columns.

``` r
matches <- matches %>% gather(-match, -date, -league_id, -league, key=team_number, value=name) %>% select(-team_number)
head(matches)
```

    ## # A tibble: 6 x 5
    ##   match date       league_id league                   name           
    ##   <int> <date>         <dbl> <chr>                    <chr>          
    ## 1 26558 2019-11-01      1979 Chinese Super League     Guizhou Renhe  
    ## 2 26559 2019-11-01      1948 Australian A-League      Sydney FC      
    ## 3 26560 2019-11-01      1947 Japanese J League        Kashima Antlers
    ## 4 26561 2019-11-01      1871 Spanish Segunda Division Numancia       
    ## 5 26562 2019-11-01      1871 Spanish Segunda Division Cadiz          
    ## 6 26563 2019-11-01      1846 German 2. Bundesliga     Hannover 96

dplyr - arrange()
-----------------

The arrange function from dplyr enables the sorting of data based upon
column values. Here, I arrange the matches tibble by match number.

``` r
matches <- arrange(matches, match)
head(matches)
```

    ## # A tibble: 6 x 5
    ##   match date       league_id league               name              
    ##   <int> <date>         <dbl> <chr>                <chr>             
    ## 1 26558 2019-11-01      1979 Chinese Super League Guizhou Renhe     
    ## 2 26558 2019-11-01      1979 Chinese Super League Guangzhou RF      
    ## 3 26559 2019-11-01      1948 Australian A-League  Sydney FC         
    ## 4 26559 2019-11-01      1948 Australian A-League  Newcastle Jets    
    ## 5 26560 2019-11-01      1947 Japanese J League    Kashima Antlers   
    ## 6 26560 2019-11-01      1947 Japanese J League    Urawa Red Diamonds

dplyr - left\_join()
--------------------

The left\_join function works similarly to its SQL counterparts. I
finish by using ‘name’ to merge the matches tibble with the rankings
tibble, which contains club rankings and ratings as of November 7th.

``` r
merged <- dplyr::left_join(matches, rankings, by='name')
merged <- select(merged, -league.y, - off, -def)
head(merged)
```

    ## # A tibble: 6 x 8
    ##   match date       league_id league.x      name        rank prev_rank   spi
    ##   <int> <date>         <dbl> <chr>         <chr>      <dbl>     <dbl> <dbl>
    ## 1 26558 2019-11-01      1979 Chinese Supe~ Guizhou R~   486       488  26.8
    ## 2 26558 2019-11-01      1979 Chinese Supe~ Guangzhou~   392       388  33.7
    ## 3 26559 2019-11-01      1948 Australian A~ Sydney FC    285       281  41.9
    ## 4 26559 2019-11-01      1948 Australian A~ Newcastle~   470       464  28.5
    ## 5 26560 2019-11-01      1947 Japanese J L~ Kashima A~   220       202  47.4
    ## 6 26560 2019-11-01      1947 Japanese J L~ Urawa Red~   469       476  28.6

Part 2 Extension by Fan Xu
==========================

title: “Data607\_Tidyverse\_Vignette\_Part\_2” author: “Fan Xu” date:
“12/1/2019”

stringr::str\_extract
---------------------

`str_extract` is used when I want to get content from a string according
to a comment pattern denoted by regular expression. Regular expression
is out of the scope of this assignment so I won’t go further into
details. In this example I used `str_extract` the first 4 digit combo in
column ‘date’ which is the year.

``` r
date_year <- mutate(merged, year = str_extract(date, '[0-9]{4}'))
date_year
```

    ## # A tibble: 646 x 9
    ##    match date       league_id league.x   name    rank prev_rank   spi year 
    ##    <int> <date>         <dbl> <chr>      <chr>  <dbl>     <dbl> <dbl> <chr>
    ##  1 26558 2019-11-01      1979 Chinese S~ Guizh~   486       488  26.8 2019 
    ##  2 26558 2019-11-01      1979 Chinese S~ Guang~   392       388  33.7 2019 
    ##  3 26559 2019-11-01      1948 Australia~ Sydne~   285       281  41.9 2019 
    ##  4 26559 2019-11-01      1948 Australia~ Newca~   470       464  28.5 2019 
    ##  5 26560 2019-11-01      1947 Japanese ~ Kashi~   220       202  47.4 2019 
    ##  6 26560 2019-11-01      1947 Japanese ~ Urawa~   469       476  28.6 2019 
    ##  7 26561 2019-11-01      1871 Spanish S~ Numan~   424       401  31.3 2019 
    ##  8 26561 2019-11-01      1871 Spanish S~ Albac~   440       429  30.2 2019 
    ##  9 26562 2019-11-01      1871 Spanish S~ Cadiz    268       257  43.2 2019 
    ## 10 26562 2019-11-01      1871 Spanish S~ Sport~   401       398  33.2 2019 
    ## # ... with 636 more rows

tidyr::seperate
---------------

Another way to get the year column is to convert the column into ‘Date’
format then use `seperate` function to seperate ‘year’, ‘month’ and
‘date’ into three columns.

``` r
date_year <- mutate(merged, date = as.Date(date))
date_year <- separate(date_year, date, c('year','month','date'))

date_year
```

    ## # A tibble: 646 x 10
    ##    match year  month date  league_id league.x   name   rank prev_rank   spi
    ##    <int> <chr> <chr> <chr>     <dbl> <chr>      <chr> <dbl>     <dbl> <dbl>
    ##  1 26558 2019  11    01         1979 Chinese S~ Guiz~   486       488  26.8
    ##  2 26558 2019  11    01         1979 Chinese S~ Guan~   392       388  33.7
    ##  3 26559 2019  11    01         1948 Australia~ Sydn~   285       281  41.9
    ##  4 26559 2019  11    01         1948 Australia~ Newc~   470       464  28.5
    ##  5 26560 2019  11    01         1947 Japanese ~ Kash~   220       202  47.4
    ##  6 26560 2019  11    01         1947 Japanese ~ Uraw~   469       476  28.6
    ##  7 26561 2019  11    01         1871 Spanish S~ Numa~   424       401  31.3
    ##  8 26561 2019  11    01         1871 Spanish S~ Alba~   440       429  30.2
    ##  9 26562 2019  11    01         1871 Spanish S~ Cadiz   268       257  43.2
    ## 10 26562 2019  11    01         1871 Spanish S~ Spor~   401       398  33.2
    ## # ... with 636 more rows

tidyr::unite
------------

The `unite` function is used to comcatnate values of two columns into a
new column. The argument ‘remove’ is to indicate whether to remove the
original columns that to be united.

``` r
date_unite <- unite(date_year, year_month, year, month, sep = '-', remove = TRUE)
date_unite
```

    ## # A tibble: 646 x 9
    ##    match year_month date  league_id league.x   name    rank prev_rank   spi
    ##    <int> <chr>      <chr>     <dbl> <chr>      <chr>  <dbl>     <dbl> <dbl>
    ##  1 26558 2019-11    01         1979 Chinese S~ Guizh~   486       488  26.8
    ##  2 26558 2019-11    01         1979 Chinese S~ Guang~   392       388  33.7
    ##  3 26559 2019-11    01         1948 Australia~ Sydne~   285       281  41.9
    ##  4 26559 2019-11    01         1948 Australia~ Newca~   470       464  28.5
    ##  5 26560 2019-11    01         1947 Japanese ~ Kashi~   220       202  47.4
    ##  6 26560 2019-11    01         1947 Japanese ~ Urawa~   469       476  28.6
    ##  7 26561 2019-11    01         1871 Spanish S~ Numan~   424       401  31.3
    ##  8 26561 2019-11    01         1871 Spanish S~ Albac~   440       429  30.2
    ##  9 26562 2019-11    01         1871 Spanish S~ Cadiz    268       257  43.2
    ## 10 26562 2019-11    01         1871 Spanish S~ Sport~   401       398  33.2
    ## # ... with 636 more rows

dplyr::group\_by & dplyr::tally
-------------------------------

The `group_by` function groups the dataframe into groups to allow the
following operations to be performed by group. Here, I use `group_by` to
group the data by the column `league` and `team_name`, then use `tally`
to take a look at how many times each team shows up.

``` r
group <- group_by(date_unite, league.x, name)
group <- tally(group)
group <- arrange(group, n)
group
```

    ## # A tibble: 619 x 3
    ## # Groups:   league.x [34]
    ##    league.x                   name                                    n
    ##    <chr>                      <chr>                               <int>
    ##  1 Argentina Primera Division Aldosivi                                1
    ##  2 Argentina Primera Division Argentinos Juniors                      1
    ##  3 Argentina Primera Division Arsenal Sarandi                         1
    ##  4 Argentina Primera Division Atlético Tucumán                        1
    ##  5 Argentina Primera Division Banfield                                1
    ##  6 Argentina Primera Division Boca Juniors                            1
    ##  7 Argentina Primera Division CA Independiente                        1
    ##  8 Argentina Primera Division Central Córdoba Santiago del Estero     1
    ##  9 Argentina Primera Division Colon Santa Fe                          1
    ## 10 Argentina Primera Division Defensa y Justicia                      1
    ## # ... with 609 more rows

Pipe Operator %&gt;% & dplyr::rename
------------------------------------

The pipe operator ‘%&gt;%’,comes from the `magrittr` package, are
embeded in `tidyverse`. It enables a handy coding by inserting the
output of the preceding code into the following code by the operator
‘%&gt;%’, which makes R coding cleaner, easier and more straightforward
visually. I can perform similar actions from the above code chunks into
one piece of code as below:

Note that I used the original spi\_matches.csv to extract my desired
dataset.

``` r
# To generate a new dataset from spi_matches.csv
matches_orig <- read_csv('https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv')

overall <- matches_orig %>%
  mutate(match = row_number()) %>%
  .[,c(23,1:22)] %>%
  select(match:spi2) %>%
  filter(team1=='Liverpool' | team1=='Arsenal' | team1=='Barcelona') %>%
  select(-team2, -spi2) %>%
  arrange(date) %>%
  rename(name = team1, SPI = spi1) %>%
  left_join(rankings, by='name') %>%
  select(-league.y, - off, -def, -spi, -rank, -prev_rank) %>%
  separate(date, c('year','month','date')) %>%
  unite(month_date, month, date, sep = '-', remove = TRUE) %>%
  mutate(year = as.numeric(year))
  
  
overall
```

    ## # A tibble: 283 x 7
    ##    match  year month_date league_id league.x                 name       SPI
    ##    <int> <dbl> <chr>          <dbl> <chr>                    <chr>    <dbl>
    ##  1    17  2016 08-14           2411 Barclays Premier League  Arsenal   82.6
    ##  2    33  2016 08-20           1869 Spanish Primera Division Barcelo~  96.4
    ##  3   121  2016 09-10           2411 Barclays Premier League  Arsenal   81.7
    ##  4   131  2016 09-10           2411 Barclays Premier League  Liverpo~  78.4
    ##  5   138  2016 09-10           1869 Spanish Primera Division Barcelo~  96.6
    ##  6   161  2016 09-13           1818 UEFA Champions League    Barcelo~  95.9
    ##  7   258  2016 09-21           1869 Spanish Primera Division Barcelo~  96.5
    ##  8   277  2016 09-24           2411 Barclays Premier League  Liverpo~  79.9
    ##  9   281  2016 09-24           2411 Barclays Premier League  Arsenal   83.2
    ## 10   322  2016 09-28           1818 UEFA Champions League    Arsenal   84.3
    ## # ... with 273 more rows

Visualization: ggplot2
----------------------

`ggplot2` is a classific package for ploting the data.

In this example I plot a line graph with column `full_date` as x-axis
and `SPI` as y-axis. The graph below shows the averaged forecasted SPI
values from 2016 to 2020 for the teams Liverpool, Arsenal and Barcelona.

``` r
overall %>% 
  group_by(name, year) %>%
  summarise(avg_SPI = mean(SPI)) %>%
  ggplot() +
  geom_point(aes(x = year, y = avg_SPI)) +
  geom_line(aes(x = year, y = avg_SPI, colour = name)) +
  ggtitle('SPI Forecast from 2016 to 2020') +
  xlab('Year') +
  ylab('Average SPI')
```

![](Data607_Tidyverse_Vignette_Part_2_files/figure-markdown_github/plot-1.png)
