---
title: "Tidyverse Part 1"
author: "C. Rosemond"
date: "November 2, 2019"
output: md_document
---

Library
-------

    library(tidyverse)

Data Set(s)
-----------

I selected two fivethirtyeight data sets: one that contains current
Soccer Power Index (SPI) ratings and rankings for men's club teams and a
second that contains match-by-match SPI ratings and forecasts back to
2016.

URL: <https://github.com/fivethirtyeight/data/tree/master/soccer-spi>

readr - read\_csv()
-------------------

The readr package facilitates the reading in of 'rectangular' data like
.csv files or other delimited files. Here, I use the read\_csv()
function to read in two data sets: the global rankings, or 'rankings',
and the matches, or 'matches'.

    rankings <- read_csv('https://projects.fivethirtyeight.com/soccer-api/club/spi_global_rankings.csv')
    matches <- read_csv('https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv')
    head(rankings)

    ## # A tibble: 6 x 7
    ##    rank prev_rank name              league                  off   def   spi
    ##   <dbl>     <dbl> <chr>             <chr>                 <dbl> <dbl> <dbl>
    ## 1     1         1 Manchester City   Barclays Premier Lea~  3.36 0.23   95.4
    ## 2     2         2 Liverpool         Barclays Premier Lea~  2.93 0.290  92.7
    ## 3     3         3 Bayern Munich     German Bundesliga      3.23 0.49   91.6
    ## 4     4         4 Paris Saint-Germ~ French Ligue 1         2.9  0.45   90.0
    ## 5     5         5 Barcelona         Spanish Primera Divi~  2.83 0.5    88.8
    ## 6     6         7 Real Madrid       Spanish Primera Divi~  2.73 0.49   88.0

    tail(matches)

    ## # A tibble: 6 x 22
    ##   date       league_id league team1 team2  spi1  spi2 prob1 prob2 probtie
    ##   <date>         <dbl> <chr>  <chr> <chr> <dbl> <dbl> <dbl> <dbl>   <dbl>
    ## 1 2020-05-24      1871 Spani~ Alme~ MÃ¡la~  40.3  37.2 0.464 0.229   0.307
    ## 2 2020-05-24      1871 Spani~ Depo~ Fuen~  31.9  33.0 0.439 0.277   0.284
    ## 3 2020-05-24      1871 Spani~ Spor~ SD H~  36.7  36.9 0.439 0.258   0.304
    ## 4 2020-05-24      1871 Spani~ Las ~ Extr~  31.7  28.8 0.475 0.234   0.291
    ## 5 2020-05-24      1871 Spani~ AD A~ Giro~  29.2  47.4 0.276 0.451   0.273
    ## 6 2020-05-24      1871 Spani~ Numa~ Tene~  31.4  30.5 0.462 0.240   0.298
    ## # ... with 12 more variables: proj_score1 <dbl>, proj_score2 <dbl>,
    ## #   importance1 <dbl>, importance2 <dbl>, score1 <dbl>, score2 <dbl>,
    ## #   xg1 <dbl>, xg2 <dbl>, nsxg1 <dbl>, nsxg2 <dbl>, adj_score1 <dbl>,
    ## #   adj_score2 <dbl>

dplyr - mutate()
----------------

The dplyr package provides a grammar for the manipulation of
data--notably, in data frames or tibbles. Here, I use the mutate
function to add a new column--a match ID--to the matches tibble.

    matches <- mutate(matches, match = row_number())
    matches <- matches[,c(23,1:22)]
    head(matches)

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
six columns ('match' through 'team2') from the matches tibble.

    matches <- select(matches, match:team2)
    head(matches)

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

    matches <- filter(matches, date >= '2019-11-01' & date <= '2019-11-07')
    head(matches)

    ## # A tibble: 6 x 6
    ##   match date       league_id league              team1        team2        
    ##   <int> <date>         <dbl> <chr>               <chr>        <chr>        
    ## 1 26562 2019-11-01      1979 Chinese Super Leag~ Guizhou Ren~ Guangzhou RF 
    ## 2 26563 2019-11-01      1948 Australian A-League Sydney FC    Newcastle Je~
    ## 3 26564 2019-11-01      1947 Japanese J League   Kashima Ant~ Urawa Red Di~
    ## 4 26565 2019-11-01      1871 Spanish Segunda Di~ Numancia     Albacete     
    ## 5 26566 2019-11-01      1871 Spanish Segunda Di~ Cadiz        Sporting Gij~
    ## 6 26567 2019-11-01      1846 German 2. Bundesli~ Hannover 96  SV Sandhausen

tidyr - gather()
----------------

The tidyr package is designed to facilitate reshaping data. Here, I use
the gather() function to reshape the matches tibble from wide to long
format, gathering the separate team columns.

    matches <- matches %>% gather(-match, -date, -league_id, -league, key=team_number, value=name) %>% select(-team_number)
    head(matches)

    ## # A tibble: 6 x 5
    ##   match date       league_id league                   name           
    ##   <int> <date>         <dbl> <chr>                    <chr>          
    ## 1 26562 2019-11-01      1979 Chinese Super League     Guizhou Renhe  
    ## 2 26563 2019-11-01      1948 Australian A-League      Sydney FC      
    ## 3 26564 2019-11-01      1947 Japanese J League        Kashima Antlers
    ## 4 26565 2019-11-01      1871 Spanish Segunda Division Numancia       
    ## 5 26566 2019-11-01      1871 Spanish Segunda Division Cadiz          
    ## 6 26567 2019-11-01      1846 German 2. Bundesliga     Hannover 96

dplyr - arrange()
-----------------

The arrange function from dplyr enables the sorting of data based upon
column values. Here, I arrange the matches tibble by match number.

    matches <- arrange(matches, match)
    head(matches)

    ## # A tibble: 6 x 5
    ##   match date       league_id league               name              
    ##   <int> <date>         <dbl> <chr>                <chr>             
    ## 1 26562 2019-11-01      1979 Chinese Super League Guizhou Renhe     
    ## 2 26562 2019-11-01      1979 Chinese Super League Guangzhou RF      
    ## 3 26563 2019-11-01      1948 Australian A-League  Sydney FC         
    ## 4 26563 2019-11-01      1948 Australian A-League  Newcastle Jets    
    ## 5 26564 2019-11-01      1947 Japanese J League    Kashima Antlers   
    ## 6 26564 2019-11-01      1947 Japanese J League    Urawa Red Diamonds

dplyr - left\_join()
--------------------

The left\_join function works similarly to its SQL counterparts. I
finish by using 'name' to merge the matches tibble with the rankings
tibble, which contains club rankings and ratings as of November 7th.

    merged <- dplyr::left_join(matches, rankings, by='name')
    merged <- select(merged, -league.y, - off, -def)
    head(merged)

    ## # A tibble: 6 x 8
    ##   match date       league_id league.x      name        rank prev_rank   spi
    ##   <int> <date>         <dbl> <chr>         <chr>      <dbl>     <dbl> <dbl>
    ## 1 26562 2019-11-01      1979 Chinese Supe~ Guizhou R~   493       486  26.1
    ## 2 26562 2019-11-01      1979 Chinese Supe~ Guangzhou~   397       402  33.4
    ## 3 26563 2019-11-01      1948 Australian A~ Sydney FC    314       327  40.1
    ## 4 26563 2019-11-01      1948 Australian A~ Newcastle~   474       471  28.2
    ## 5 26564 2019-11-01      1947 Japanese J L~ Kashima A~   181       178  51.8
    ## 6 26564 2019-11-01      1947 Japanese J L~ Urawa Red~   475       455  28.0
