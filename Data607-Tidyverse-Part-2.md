TidyVerse Part 1 by Sie Siong Wong
==================================

Objective
---------

-   Dplyr annd GGPlot is the TidyVerse packages that I choose to create
    a programming sample to demonstrate how to use its capabilities from
    reshape the data to plot analysis result.The dataset is Ramen Rating
    and got this from Kaggle.

What is dplyr?
--------------

-   It is the next iteration of plyr package.
-   It is faster and has a more consistent of API.
-   It provides a set of tools that help you solve the most common data
    manipulation challenges.

What is GGPlot?
---------------

-   GGPlot was based on the Grammar of Graphics.
-   It puts an organized framework around the various parts of a graph.
-   The components of ggplot grammar are data, aesthetic mapping, geom,
    stat, scales, theme, and so on.
-   It can be used to create scatter plots, boxplots, histograms, lines
    best approximating data, etc.
-   It is robust and has served statisticians well.

Load the Packages
-----------------

``` r
library(dplyr)
library(ggplot2)
```

Load the Dataset
----------------

``` r
rr <- read.csv("https://raw.githubusercontent.com/SieSiongWong/DATA-607/master/Project%20TidyVerse/RamenRatings.csv", header=TRUE, stringsAsFactors = FALSE)
head(rr)
```

    ##   Review..          Brand
    ## 1     2580      New Touch
    ## 2     2579       Just Way
    ## 3     2578         Nissin
    ## 4     2577        Wei Lih
    ## 5     2576 Ching's Secret
    ## 6     2575  Samyang Foods
    ##                                                       Variety Style
    ## 1                                   T's Restaurant Tantanmen    Cup
    ## 2 Noodles Spicy Hot Sesame Spicy Hot Sesame Guan-miao Noodles  Pack
    ## 3                               Cup Noodles Chicken Vegetable   Cup
    ## 4                               GGE Ramen Snack Tomato Flavor  Pack
    ## 5                                             Singapore Curry  Pack
    ## 6                                      Kimchi song Song Ramen  Pack
    ##       Country Stars
    ## 1       Japan  3.75
    ## 2      Taiwan     1
    ## 3         USA  2.25
    ## 4      Taiwan  2.75
    ## 5       India  3.75
    ## 6 South Korea  4.75

Clean and Tidy the Data
-----------------------

``` r
# Convert Stars column from factor to numeric.
rr$Stars <-as.numeric(rr$Stars)
```

    ## Warning: NAs introduced by coercion

``` r
# You can use the 'select' function to pick variables based on their names.
rr.df <- select (rr, Brand, Country, Stars)
# or you can do this way using the combination of 'pipe' and 'select' functions. The pipe allows you to pipe the output of one function to the input of another function.
rr.df <- rr %>% select (Brand, Country, Stars)
# You can use the 'rename' function to rename the column name.
rr.df <- rr.df %>% rename ("Ratings"="Stars")
# Using filter to select only numeric data on Stars column.
rr.df <- rr.df %>% filter(!is.na(Ratings))
# To move specific column to the beginning of a dataframe, we can use the 'select' and 'everything' functions.
rr.df <- rr.df %>% select(Country, everything())
# To sort the Country column in descending order, we can use the 'arrange' function.
rr.df <- rr.df %>% arrange(Country)
```

Reshape and Analyze the Data
----------------------------

``` r
# Another very useful function is the 'group_by'. YOu can use this function to group the same elements together and then use the 'summarise' function to collapse each group into a single-row summary. For example, we can group country and brand and then do the average for each brand. 
rr.df.avg1 <- rr.df %>% group_by(Country, Brand) %>% summarise(Average=mean(Ratings))
# Very often you'll want to create new columns based on the values in existing columns, for example like previous example to get average ratings for each brand. In this case, you can use the 'mutate' function. The difference between summarise and mutate functions is that using 'mutate' will keep all existing columns in the output while 'summarise' will not show the column variable which is used to perform the calculation.  
rr.df.avg2 <- rr.df %>% group_by(Country, Brand) %>% mutate(Average=mean(Ratings))
# You also can use the 'transmute' to only show the grouped and new column variables just like the summarise function.
rr.df.avg3 <- rr.df %>% group_by(Country, Brand) %>% transmute(Average=mean(Ratings))
```

Plot the Analysis Result
------------------------

``` r
# In the ggplot() parenthesis, the data source is 'rr.df.avg1', and within the aesthetic parenthesis you'll need to define the x and y variables. In this case, the x=Country, y=Average. If you want to include legend, you can put fill=Country in the aes().
ggplot(rr.df.avg1, aes(x=Country, y=Average)) + geom_boxplot()
```

![](Data607-Tidyverse-Part-2_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
# You notice that the boxplots are not in the order. To sort the boxplots in the order, we can use the 'reorder' function and use median as reference parameter to sort.
ggplot(rr.df.avg1, aes(x=reorder(factor(Country),Average, fun=median),y=Average)) + geom_boxplot() 
```

![](Data607-Tidyverse-Part-2_files/figure-markdown_github/unnamed-chunk-5-2.png)

``` r
# Also, we can further refine the plot to include title and y-axis label. To do this, the argument for title is 'title' and the argument for y-axis label is 'ylab'. 
ggplot(rr.df.avg1, aes(x=reorder(factor(Country), Average, fun=median),y=Average)) + geom_boxplot() + labs(title="Average Ramen Ratings for Each Country") + ylab("Average Ratings")
```

![](Data607-Tidyverse-Part-2_files/figure-markdown_github/unnamed-chunk-5-3.png)

``` r
# In this example, I will use the 'fill' to include legend so that color will be automatically assigned to each box plot and then remove the legend display manually. We can use 'theme()' to customize the plot's look. To remove legend display, you can use 'legend.position', and to remove x-axis label, you can use 'axis.title.x'. Also, we can adjust the plot title height position using' plot.title'.Since there are so many labels for the x-axis in this example, we can turn the x-axis text into 90 degree angle and adjust their margin using 'axis.text.x'. 
ggplot(rr.df.avg1, aes(x=reorder(factor(Country), Average, fun=median),y=Average,fill=factor(Country))) + geom_boxplot() + labs(title="Average Ramen Ratings for Each Country") + ylab("Average Ratings") + theme(legend.position = "none", axis.title.x = element_blank(), axis.text.x=element_text(angle=90, margin=margin(t = 10, r = 0, b = 0, l = 0)), plot.title = element_text(hjust=0.5))
```

![](Data607-Tidyverse-Part-2_files/figure-markdown_github/unnamed-chunk-5-4.png)

TidyVerse Part 2 Extended by Sin Ying Wong
==========================================

Select top n values: top\_n
---------------------------

``` r
library(tidyverse)
```

    ## -- Attaching packages ---------------------------------------------------------------------------------------------------------------------------- tidyverse 1.2.1 --

    ## v tibble  2.1.3     v purrr   0.3.2
    ## v tidyr   0.8.3     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.4.0

    ## -- Conflicts ------------------------------------------------------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

To extend the analysis, we may want to know the top n countries with
high ratings. we can use the `top_n` function for this task.

``` r
rr_top_10 <- rr.df %>% 
  group_by(Country) %>%
  summarise(Average = mean(Ratings)) %>%
  top_n(10, Average) 

rr_top_10
```

    ## # A tibble: 10 x 2
    ##    Country   Average
    ##    <chr>       <dbl>
    ##  1 Brazil       4.35
    ##  2 Cambodia     4.2 
    ##  3 Fiji         3.88
    ##  4 Hong Kong    3.80
    ##  5 Indonesia    4.07
    ##  6 Japan        3.98
    ##  7 Malaysia     4.15
    ##  8 Myanmar      3.95
    ##  9 Sarawak      4.33
    ## 10 Singapore    4.13

Reorder values: arrange & desc
------------------------------

The tbl above is ordered by its default index. We may use `arrange` to
rearrange the tbl with `Average` in ascending order, or combine `desc`
function for descending order.

``` r
rr_top_10 %>% arrange(Average)
```

    ## # A tibble: 10 x 2
    ##    Country   Average
    ##    <chr>       <dbl>
    ##  1 Hong Kong    3.80
    ##  2 Fiji         3.88
    ##  3 Myanmar      3.95
    ##  4 Japan        3.98
    ##  5 Indonesia    4.07
    ##  6 Singapore    4.13
    ##  7 Malaysia     4.15
    ##  8 Cambodia     4.2 
    ##  9 Sarawak      4.33
    ## 10 Brazil       4.35

``` r
rr_top_10 %>% arrange(desc(Average))
```

    ## # A tibble: 10 x 2
    ##    Country   Average
    ##    <chr>       <dbl>
    ##  1 Brazil       4.35
    ##  2 Sarawak      4.33
    ##  3 Cambodia     4.2 
    ##  4 Malaysia     4.15
    ##  5 Singapore    4.13
    ##  6 Indonesia    4.07
    ##  7 Japan        3.98
    ##  8 Myanmar      3.95
    ##  9 Fiji         3.88
    ## 10 Hong Kong    3.80

Lay out panels in ggplot
------------------------

For data that contains multiple attributes and we want to compare values
of one attribute across values of another attribute, we can use
`facet_grid` functions produce a grid lay out of plots.

``` r
rr %>% select(Country, Style, Ratings = Stars) %>%
  mutate_all(~ifelse(. == '',NA,.)) %>%
  drop_na() %>%
  group_by(Country, Style) %>%
  summarise(Avg_Rating = mean(Ratings)) %>%
  arrange(desc(Avg_Rating)) %>%
  ggplot(aes(x=Country, y=Avg_Rating, fill = Avg_Rating, label = round(Avg_Rating,2)))+
    geom_col()+
    facet_grid(~Style)+
    coord_flip()+
    geom_text(hjust = 1.1, vjust = 0.35, size = 2, color = 'white', face = 'bold')+
    labs(title = 'Average Ramen Rating of Different Countries',
         subtitle = 'By Style')
```

    ## Warning: Ignoring unknown parameters: face

![](Data607-Tidyverse-Part-2_files/figure-markdown_github/3-1.png)
