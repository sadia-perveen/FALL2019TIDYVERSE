Part I
======

Using one or more TidyVerse packages, and any dataset from fivethirtyeight.com or Kaggle, create a programming sample "vignette" that demonstrates how to use one or more of the capabilities of the selected TidyVerse package with your selected dataset. (25 points)
=======================================================================================================================================================================================================================================================================

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 3.5.3

    ## -- Attaching packages ------------------------------------------------------------------------ tidyverse 1.2.1 --

    ## v ggplot2 3.1.1       v purrr   0.3.1  
    ## v tibble  2.0.1       v dplyr   0.8.0.1
    ## v tidyr   0.8.3       v stringr 1.4.0  
    ## v readr   1.3.1       v forcats 0.4.0

    ## Warning: package 'ggplot2' was built under R version 3.5.3

    ## Warning: package 'readr' was built under R version 3.5.3

    ## Warning: package 'forcats' was built under R version 3.5.3

    ## -- Conflicts --------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(dplyr)
library(ggplot2)
```

Load the data from Kaggle
=========================

``` r
avocado_price <- read.csv("https://raw.githubusercontent.com/Zchen116/tidyverse/master/avocado.csv")
head(avocado_price)
```

    ##   X       Date AveragePrice Total.Volume   X4046     X4225  X4770
    ## 1 0 2015-12-27         1.33     64236.62 1036.74  54454.85  48.16
    ## 2 1 2015-12-20         1.35     54876.98  674.28  44638.81  58.33
    ## 3 2 2015-12-13         0.93    118220.22  794.70 109149.67 130.50
    ## 4 3 2015-12-06         1.08     78992.15 1132.00  71976.41  72.58
    ## 5 4 2015-11-29         1.28     51039.60  941.48  43838.39  75.78
    ## 6 5 2015-11-22         1.26     55979.78 1184.27  48067.99  43.61
    ##   Total.Bags Small.Bags Large.Bags XLarge.Bags         type year region
    ## 1    8696.87    8603.62      93.25           0 conventional 2015 Albany
    ## 2    9505.56    9408.07      97.49           0 conventional 2015 Albany
    ## 3    8145.35    8042.21     103.14           0 conventional 2015 Albany
    ## 4    5811.16    5677.40     133.76           0 conventional 2015 Albany
    ## 5    6183.95    5986.26     197.69           0 conventional 2015 Albany
    ## 6    6683.91    6556.47     127.44           0 conventional 2015 Albany

``` r
summary(avocado_price)
```

    ##        X                 Date        AveragePrice    Total.Volume     
    ##  Min.   : 0.00   2015-01-04:  108   Min.   :0.440   Min.   :      85  
    ##  1st Qu.:10.00   2015-01-11:  108   1st Qu.:1.100   1st Qu.:   10839  
    ##  Median :24.00   2015-01-18:  108   Median :1.370   Median :  107377  
    ##  Mean   :24.23   2015-01-25:  108   Mean   :1.406   Mean   :  850644  
    ##  3rd Qu.:38.00   2015-02-01:  108   3rd Qu.:1.660   3rd Qu.:  432962  
    ##  Max.   :52.00   2015-02-08:  108   Max.   :3.250   Max.   :62505647  
    ##                  (Other)   :17601                                     
    ##      X4046              X4225              X4770        
    ##  Min.   :       0   Min.   :       0   Min.   :      0  
    ##  1st Qu.:     854   1st Qu.:    3009   1st Qu.:      0  
    ##  Median :    8645   Median :   29061   Median :    185  
    ##  Mean   :  293008   Mean   :  295155   Mean   :  22840  
    ##  3rd Qu.:  111020   3rd Qu.:  150207   3rd Qu.:   6243  
    ##  Max.   :22743616   Max.   :20470573   Max.   :2546439  
    ##                                                         
    ##    Total.Bags         Small.Bags         Large.Bags     
    ##  Min.   :       0   Min.   :       0   Min.   :      0  
    ##  1st Qu.:    5089   1st Qu.:    2849   1st Qu.:    127  
    ##  Median :   39744   Median :   26363   Median :   2648  
    ##  Mean   :  239639   Mean   :  182195   Mean   :  54338  
    ##  3rd Qu.:  110783   3rd Qu.:   83338   3rd Qu.:  22029  
    ##  Max.   :19373134   Max.   :13384587   Max.   :5719097  
    ##                                                         
    ##   XLarge.Bags                 type           year     
    ##  Min.   :     0.0   conventional:9126   Min.   :2015  
    ##  1st Qu.:     0.0   organic     :9123   1st Qu.:2015  
    ##  Median :     0.0                       Median :2016  
    ##  Mean   :  3106.4                       Mean   :2016  
    ##  3rd Qu.:   132.5                       3rd Qu.:2017  
    ##  Max.   :551693.7                       Max.   :2018  
    ##                                                       
    ##                  region     
    ##  Albany             :  338  
    ##  Atlanta            :  338  
    ##  BaltimoreWashington:  338  
    ##  Boise              :  338  
    ##  Boston             :  338  
    ##  BuffaloRochester   :  338  
    ##  (Other)            :16221

Use filter function to filter Boston's avocado price from the dataset
=====================================================================

``` r
head(filter(avocado_price,region== "Boston"))
```

    ##   X       Date AveragePrice Total.Volume   X4046    X4225    X4770
    ## 1 0 2015-12-27         1.13     450816.4 3886.27 346964.7 13952.56
    ## 2 1 2015-12-20         1.07     489802.9 4912.37 390101.0  5887.72
    ## 3 2 2015-12-13         1.01     549945.8 4641.02 455362.4   219.40
    ## 4 3 2015-12-06         1.02     488679.3 5126.32 407520.2   142.99
    ## 5 4 2015-11-29         1.19     350559.8 3609.25 272719.1   105.86
    ## 6 5 2015-11-22         1.07     466760.0 4457.62 383420.5   233.74
    ##   Total.Bags Small.Bags Large.Bags XLarge.Bags         type year region
    ## 1   86012.86   85913.60      99.26           0 conventional 2015 Boston
    ## 2   88901.80   88768.47     133.33           0 conventional 2015 Boston
    ## 3   89722.96   89523.38     199.58           0 conventional 2015 Boston
    ## 4   75889.78   75666.22     223.56           0 conventional 2015 Boston
    ## 5   74125.62   73864.52     261.10           0 conventional 2015 Boston
    ## 6   78648.17   78161.82     486.35           0 conventional 2015 Boston

Use arrange function to arrange the Average Price from the highest
==================================================================

``` r
head(avocado_price%>%arrange(desc(AveragePrice)))
```

    ##    X       Date AveragePrice Total.Volume   X4046    X4225  X4770
    ## 1  8 2016-10-30         3.25     16700.94 2325.93 11142.85   0.00
    ## 2 37 2017-04-16         3.17      3018.56 1255.55    82.31   0.00
    ## 3  7 2016-11-06         3.12     19043.80 5898.49 10039.34   0.00
    ## 4 42 2017-03-12         3.05      2068.26 1043.83    77.36   0.00
    ## 5 18 2017-08-27         3.04     12656.32  419.06  4851.90 145.09
    ## 6 12 2016-10-02         3.03      3714.71  296.71  2699.80   0.00
    ##   Total.Bags Small.Bags Large.Bags XLarge.Bags    type year
    ## 1    3232.16    3232.16       0.00           0 organic 2016
    ## 2    1680.70    1542.22     138.48           0 organic 2017
    ## 3    3105.97    3079.30      26.67           0 organic 2016
    ## 4     947.07     926.67      20.40           0 organic 2017
    ## 5    7240.27    6960.97     279.30           0 organic 2017
    ## 6     718.20     718.20       0.00           0 organic 2016
    ##              region
    ## 1      SanFrancisco
    ## 2             Tampa
    ## 3      SanFrancisco
    ## 4 MiamiFtLauderdale
    ## 5 RaleighGreensboro
    ## 6          LasVegas

Use arrange function to arrange the Average Price from the lowest
=================================================================

``` r
head(avocado_price%>%arrange(AveragePrice))
```

    ##    X       Date AveragePrice Total.Volume      X4046     X4225    X4770
    ## 1 43 2017-03-05         0.44     64057.04     223.84   4748.88     0.00
    ## 2 47 2017-02-05         0.46   2200550.27 1200632.86 531226.65 18324.93
    ## 3 43 2017-03-05         0.48     50890.73     717.57   4138.84     0.00
    ## 4  0 2015-12-27         0.49   1137707.43  738314.80 286858.37 11642.46
    ## 5 44 2017-02-26         0.49     44024.03     252.79   4472.68     0.00
    ## 6 36 2015-04-19         0.51   1366844.88 1097285.22 164460.99  7534.30
    ##   Total.Bags Small.Bags Large.Bags XLarge.Bags         type year
    ## 1   59084.32     638.68   58445.64        0.00      organic 2017
    ## 2  450365.83  113752.17  330583.10     6030.56 conventional 2017
    ## 3   46034.32    1385.06   44649.26        0.00      organic 2017
    ## 4  100891.80   70749.02   30142.78        0.00 conventional 2015
    ## 5   39298.56     600.00   38698.56        0.00      organic 2017
    ## 6   97564.37   44646.67   52917.70        0.00 conventional 2015
    ##             region
    ## 1 CincinnatiDayton
    ## 2    PhoenixTucson
    ## 3          Detroit
    ## 4    PhoenixTucson
    ## 5 CincinnatiDayton
    ## 6    PhoenixTucson

Use select function to choose data of region, year, type, and Average Price to create another data frame
========================================================================================================

``` r
head(avocado_price%>%select(region, year,type,AveragePrice))
```

    ##   region year         type AveragePrice
    ## 1 Albany 2015 conventional         1.33
    ## 2 Albany 2015 conventional         1.35
    ## 3 Albany 2015 conventional         0.93
    ## 4 Albany 2015 conventional         1.08
    ## 5 Albany 2015 conventional         1.28
    ## 6 Albany 2015 conventional         1.26

Use rename function to rename column
====================================

``` r
head(rename(avocado_price, city = region))
```

    ##   X       Date AveragePrice Total.Volume   X4046     X4225  X4770
    ## 1 0 2015-12-27         1.33     64236.62 1036.74  54454.85  48.16
    ## 2 1 2015-12-20         1.35     54876.98  674.28  44638.81  58.33
    ## 3 2 2015-12-13         0.93    118220.22  794.70 109149.67 130.50
    ## 4 3 2015-12-06         1.08     78992.15 1132.00  71976.41  72.58
    ## 5 4 2015-11-29         1.28     51039.60  941.48  43838.39  75.78
    ## 6 5 2015-11-22         1.26     55979.78 1184.27  48067.99  43.61
    ##   Total.Bags Small.Bags Large.Bags XLarge.Bags         type year   city
    ## 1    8696.87    8603.62      93.25           0 conventional 2015 Albany
    ## 2    9505.56    9408.07      97.49           0 conventional 2015 Albany
    ## 3    8145.35    8042.21     103.14           0 conventional 2015 Albany
    ## 4    5811.16    5677.40     133.76           0 conventional 2015 Albany
    ## 5    6183.95    5986.26     197.69           0 conventional 2015 Albany
    ## 6    6683.91    6556.47     127.44           0 conventional 2015 Albany

Use summarise function to a data frame about minium, mean, and maxium of Average Price
======================================================================================

``` r
filter(avocado_price,region == "Boston")%>%summarise(AveragePrice_min=min(AveragePrice), AveragePrice_mean=mean(AveragePrice),AveragePrice_max=max(AveragePrice))
```

    ##   AveragePrice_min AveragePrice_mean AveragePrice_max
    ## 1             0.85          1.530888             2.19

Use group\_by function
======================

``` r
by_region <- group_by(avocado_price, region)
sui <- summarise(by_region,
  count = n(),
  AveragePrice_mean = mean(AveragePrice, na.rm = TRUE))
head(sui %>% arrange(desc(AveragePrice_mean)))
```

    ## # A tibble: 6 x 3
    ##   region              count AveragePrice_mean
    ##   <fct>               <int>             <dbl>
    ## 1 HartfordSpringfield   338              1.82
    ## 2 SanFrancisco          338              1.80
    ## 3 NewYork               338              1.73
    ## 4 Philadelphia          338              1.63
    ## 5 Sacramento            338              1.62
    ## 6 Charlotte             338              1.61

Use mutate function
===================

``` r
my_data<-head(sui %>% arrange(desc(AveragePrice_mean)) %>%  mutate(AveragePrice_mean = round(AveragePrice_mean, 2)),20)
my_data
```

    ## # A tibble: 20 x 3
    ##    region              count AveragePrice_mean
    ##    <fct>               <int>             <dbl>
    ##  1 HartfordSpringfield   338              1.82
    ##  2 SanFrancisco          338              1.8 
    ##  3 NewYork               338              1.73
    ##  4 Philadelphia          338              1.63
    ##  5 Sacramento            338              1.62
    ##  6 Charlotte             338              1.61
    ##  7 Northeast             338              1.6 
    ##  8 Albany                338              1.56
    ##  9 Chicago               338              1.56
    ## 10 RaleighGreensboro     338              1.56
    ## 11 BaltimoreWashington   338              1.53
    ## 12 Boston                338              1.53
    ## 13 Syracuse              338              1.52
    ## 14 BuffaloRochester      338              1.52
    ## 15 HarrisburgScranton    338              1.51
    ## 16 Jacksonville          338              1.51
    ## 17 Orlando               338              1.51
    ## 18 GrandRapids           338              1.5 
    ## 19 NorthernNewEngland    338              1.48
    ## 20 Spokane               338              1.45

Use ggplot2 function to create graph
====================================

``` r
my_data%>%ggplot(aes(x=region, y=AveragePrice_mean, fill=region))+
  geom_bar(stat = "identity", position = "dodge") + 
  guides(fill = FALSE) +
  ggtitle("Average Price mean") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))
```

![](tidy01_files/figure-markdown_github/unnamed-chunk-11-1.png) \#Part 2 \#Extend an Existing Example. Using one of your classmate's examples (as created above), extend his or her example with additional annotated code. (15 points) \#1, Get dataset from 538 (existing code)

``` r
weather <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/us-weather-history/KCLT.csv")
summary(weather)
```

    ##          date     actual_mean_temp actual_min_temp actual_max_temp 
    ##  2014-10-1 :  1   Min.   :18.00    Min.   : 7.00   Min.   : 26.00  
    ##  2014-10-10:  1   1st Qu.:47.00    1st Qu.:37.00   1st Qu.: 58.00  
    ##  2014-10-11:  1   Median :63.00    Median :52.00   Median : 73.00  
    ##  2014-10-12:  1   Mean   :61.05    Mean   :49.96   Mean   : 71.63  
    ##  2014-10-13:  1   3rd Qu.:75.00    3rd Qu.:65.00   3rd Qu.: 86.00  
    ##  2014-10-14:  1   Max.   :88.00    Max.   :75.00   Max.   :100.00  
    ##  (Other)   :359                                                    
    ##  average_min_temp average_max_temp record_min_temp record_max_temp 
    ##  Min.   :29.00    Min.   :50.00    Min.   :-5.00   Min.   : 69.00  
    ##  1st Qu.:36.00    1st Qu.:58.00    1st Qu.:15.00   1st Qu.: 79.00  
    ##  Median :48.00    Median :72.00    Median :30.00   Median : 90.00  
    ##  Mean   :48.82    Mean   :70.98    Mean   :31.47   Mean   : 88.73  
    ##  3rd Qu.:63.00    3rd Qu.:84.00    3rd Qu.:49.00   3rd Qu.: 98.00  
    ##  Max.   :68.00    Max.   :89.00    Max.   :62.00   Max.   :104.00  
    ##                                                                    
    ##  record_min_temp_year record_max_temp_year actual_precipitation
    ##  Min.   :1879         Min.   :1879         Min.   :0.0000      
    ##  1st Qu.:1918         1st Qu.:1931         1st Qu.:0.0000      
    ##  Median :1963         Median :1953         Median :0.0000      
    ##  Mean   :1953         Mean   :1954         Mean   :0.1024      
    ##  3rd Qu.:1983         3rd Qu.:1984         3rd Qu.:0.0300      
    ##  Max.   :2015         Max.   :2015         Max.   :2.6500      
    ##                                                                
    ##  average_precipitation record_precipitation
    ##  Min.   :0.0900        Min.   :0.850       
    ##  1st Qu.:0.1000        1st Qu.:1.650       
    ##  Median :0.1100        Median :1.980       
    ##  Mean   :0.1141        Mean   :2.209       
    ##  3rd Qu.:0.1200        3rd Qu.:2.540       
    ##  Max.   :0.1500        Max.   :6.880       
    ## 

2, Tidyr separate function (existing code):
===========================================

``` r
library(tidyr)
weather2 <- weather %>% separate(date, c("year", "month", "day"), sep = "-")
summary(weather2)
```

    ##      year              month               day            actual_mean_temp
    ##  Length:365         Length:365         Length:365         Min.   :18.00   
    ##  Class :character   Class :character   Class :character   1st Qu.:47.00   
    ##  Mode  :character   Mode  :character   Mode  :character   Median :63.00   
    ##                                                           Mean   :61.05   
    ##                                                           3rd Qu.:75.00   
    ##                                                           Max.   :88.00   
    ##  actual_min_temp actual_max_temp  average_min_temp average_max_temp
    ##  Min.   : 7.00   Min.   : 26.00   Min.   :29.00    Min.   :50.00   
    ##  1st Qu.:37.00   1st Qu.: 58.00   1st Qu.:36.00    1st Qu.:58.00   
    ##  Median :52.00   Median : 73.00   Median :48.00    Median :72.00   
    ##  Mean   :49.96   Mean   : 71.63   Mean   :48.82    Mean   :70.98   
    ##  3rd Qu.:65.00   3rd Qu.: 86.00   3rd Qu.:63.00    3rd Qu.:84.00   
    ##  Max.   :75.00   Max.   :100.00   Max.   :68.00    Max.   :89.00   
    ##  record_min_temp record_max_temp  record_min_temp_year
    ##  Min.   :-5.00   Min.   : 69.00   Min.   :1879        
    ##  1st Qu.:15.00   1st Qu.: 79.00   1st Qu.:1918        
    ##  Median :30.00   Median : 90.00   Median :1963        
    ##  Mean   :31.47   Mean   : 88.73   Mean   :1953        
    ##  3rd Qu.:49.00   3rd Qu.: 98.00   3rd Qu.:1983        
    ##  Max.   :62.00   Max.   :104.00   Max.   :2015        
    ##  record_max_temp_year actual_precipitation average_precipitation
    ##  Min.   :1879         Min.   :0.0000       Min.   :0.0900       
    ##  1st Qu.:1931         1st Qu.:0.0000       1st Qu.:0.1000       
    ##  Median :1953         Median :0.0000       Median :0.1100       
    ##  Mean   :1954         Mean   :0.1024       Mean   :0.1141       
    ##  3rd Qu.:1984         3rd Qu.:0.0300       3rd Qu.:0.1200       
    ##  Max.   :2015         Max.   :2.6500       Max.   :0.1500       
    ##  record_precipitation
    ##  Min.   :0.850       
    ##  1st Qu.:1.650       
    ##  Median :1.980       
    ##  Mean   :2.209       
    ##  3rd Qu.:2.540       
    ##  Max.   :6.880

3, Dplyr select function (existing code):
=========================================

``` r
head(select(weather2, year, actual_mean_temp, record_min_temp, record_max_temp, record_precipitation))
```

    ##   year actual_mean_temp record_min_temp record_max_temp
    ## 1 2014               81              56             104
    ## 2 2014               85              56             101
    ## 3 2014               82              56              99
    ## 4 2014               75              55              99
    ## 5 2014               72              57             100
    ## 6 2014               74              57              99
    ##   record_precipitation
    ## 1                 5.91
    ## 2                 1.53
    ## 3                 2.50
    ## 4                 2.63
    ## 5                 1.65
    ## 6                 1.95

4, Dplyr filter (subsetting dataset) (existing code):
=====================================================

``` r
head(filter(weather2, year == "2014"))
```

    ##   year month day actual_mean_temp actual_min_temp actual_max_temp
    ## 1 2014     7   1               81              70              91
    ## 2 2014     7   2               85              74              95
    ## 3 2014     7   3               82              71              93
    ## 4 2014     7   4               75              64              86
    ## 5 2014     7   5               72              60              84
    ## 6 2014     7   6               74              61              87
    ##   average_min_temp average_max_temp record_min_temp record_max_temp
    ## 1               67               89              56             104
    ## 2               68               89              56             101
    ## 3               68               89              56              99
    ## 4               68               89              55              99
    ## 5               68               89              57             100
    ## 6               68               89              57              99
    ##   record_min_temp_year record_max_temp_year actual_precipitation
    ## 1                 1919                 2012                 0.00
    ## 2                 2008                 1931                 0.00
    ## 3                 2010                 1931                 0.14
    ## 4                 1933                 1955                 0.00
    ## 5                 1967                 1954                 0.00
    ## 6                 1964                 1948                 0.00
    ##   average_precipitation record_precipitation
    ## 1                  0.10                 5.91
    ## 2                  0.10                 1.53
    ## 3                  0.11                 2.50
    ## 4                  0.10                 2.63
    ## 5                  0.10                 1.65
    ## 6                  0.10                 1.95

Extend Part:
============

Use select and filter funtion
=============================

``` r
weather3 <- weather2 %>%select(year, actual_mean_temp, actual_min_temp, actual_max_temp, actual_precipitation)
head(filter(weather3, year == "2014"))
```

    ##   year actual_mean_temp actual_min_temp actual_max_temp
    ## 1 2014               81              70              91
    ## 2 2014               85              74              95
    ## 3 2014               82              71              93
    ## 4 2014               75              64              86
    ## 5 2014               72              60              84
    ## 6 2014               74              61              87
    ##   actual_precipitation
    ## 1                 0.00
    ## 2                 0.00
    ## 3                 0.14
    ## 4                 0.00
    ## 5                 0.00
    ## 6                 0.00

Use summarise function to a data frame about minium, mean, and maxium
=====================================================================

``` r
filter(weather3, year == "2014")%>%summarise(min=min(actual_min_temp), mean=mean(actual_mean_temp),max=max(actual_max_temp))
```

    ##   min     mean max
    ## 1  14 63.97283  96
