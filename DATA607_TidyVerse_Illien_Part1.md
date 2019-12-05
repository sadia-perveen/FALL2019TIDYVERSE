Tidyverse stringr vignette
==========================

stringr
-------

The `stringr` package is an integral part of the Tidyverse and it is the
package of choice for working with character strings.

We will be using the pipe notation `%>%` throughout this vignette.

``` r
library(tidyverse)
```

We start by loading into R data from Kaggle containing information about
breweries in the United States found
[here](https://www.kaggle.com/brkurzawa/us-breweries/data).

``` r
url <- 'https://raw.githubusercontent.com/maelillien/tidyverse/master/breweries_us.csv'
breweries <- read.csv(url)
head(breweries)
```

    ##            brewery_name         type
    ## 1    Valley Brewing Co.      Brewpub
    ## 2    Valley Brewing Co.      Brewpub
    ## 3     Valley Brewing Co Microbrewery
    ## 4 Ukiah Brewing Company      Brewpub
    ## 5    Tustin Brewing Co.      Brewpub
    ## 6       Trumer Brauerei Microbrewery
    ##                                              address
    ## 1           PO Box 4653, Stockton, California, 95204
    ## 2         157 Adams St., Stockton, California, 95204
    ## 3       1950 W Freemont, Stockton, California, 95203
    ## 4         102 S. State St., Ukiah, California, 95482
    ## 5 13011 Newport Ave. #100, Tustin, California, 92780
    ## 6          1404 4th St., Berkeley, California, 94608
    ##                                website      state state_breweries
    ## 1           http://www.valleybrew.com/ california             284
    ## 2           http://www.valleybrew.com/ california             284
    ## 3           http://www.valleybrew.com/ california             284
    ## 4       http://www.ukiahbrewingco.com/ california             284
    ## 5        http://www.tustinbrewery.com/ california             284
    ## 6 http://www.trumer-international.com/ california             284

Detecting Matches
=================

Here we look into some of the functions we can use to detect pattern
matches in a string.

str\_detect
-----------

The `str_detect` function takes in a column character vector and a
pattern, and returns a boolean vector indicating which strings contain
the pattern, in this case `PO`. We can use this functionality to
identify which addresses are PO boxes.

``` r
t0 <- breweries$address %>% str_detect("PO")
head(t0)
```

    ## [1]  TRUE FALSE FALSE FALSE FALSE FALSE

``` r
head(breweries[t0,])
```

    ##                   brewery_name            type
    ## 1           Valley Brewing Co.         Brewpub
    ## 28  Spanish Peaks Brewing Co.  ContractBrewery
    ## 33        Snowshoe Brewing Co.         Brewpub
    ## 153      Half Moon Bay Brewing         Brewpub
    ## 196                  Chau Tien ContractBrewery
    ## 251           Bison Brewing Co    Microbrewery
    ##                                        address
    ## 1     PO Box 4653, Stockton, California, 95204
    ## 28    PO Box 820, King City, California, 93930
    ## 33      PO Box 2224, Arnold, California, 95223
    ## 153 PO Box 879, El Granada , California, 94018
    ## 196   PO Box 221185, Carmel, California, 93923
    ## 251   PO Box 4821, Berkeley, California, 94704
    ##                             website      state state_breweries
    ## 1        http://www.valleybrew.com/ california             284
    ## 28     http://www.blackdogales.com/ california             284
    ## 33  http://www.snowshoebrewing.com/ california             284
    ## 153    http://www.hmbbrewingco.com/ california             284
    ## 196         http://www.paleale.com/ california             284
    ## 251       http://www.bisonbrew.com/ california             284

str\_which
----------

The `str_which` function behaves similarly but instead it returns the
indexes of the rows in the data frame where PO is found in the `address`
column.

``` r
t1 <- breweries$address %>% str_which("PO")
head(t1)
```

    ## [1]   1  28  33 153 196 251

We obtain the same result as above.

``` r
head(breweries[t1,])
```

    ##                   brewery_name            type
    ## 1           Valley Brewing Co.         Brewpub
    ## 28  Spanish Peaks Brewing Co.  ContractBrewery
    ## 33        Snowshoe Brewing Co.         Brewpub
    ## 153      Half Moon Bay Brewing         Brewpub
    ## 196                  Chau Tien ContractBrewery
    ## 251           Bison Brewing Co    Microbrewery
    ##                                        address
    ## 1     PO Box 4653, Stockton, California, 95204
    ## 28    PO Box 820, King City, California, 93930
    ## 33      PO Box 2224, Arnold, California, 95223
    ## 153 PO Box 879, El Granada , California, 94018
    ## 196   PO Box 221185, Carmel, California, 93923
    ## 251   PO Box 4821, Berkeley, California, 94704
    ##                             website      state state_breweries
    ## 1        http://www.valleybrew.com/ california             284
    ## 28     http://www.blackdogales.com/ california             284
    ## 33  http://www.snowshoebrewing.com/ california             284
    ## 153    http://www.hmbbrewingco.com/ california             284
    ## 196         http://www.paleale.com/ california             284
    ## 251       http://www.bisonbrew.com/ california             284

Mutating Strings
================

Here we look at some of the functions that can be used to modify or
mutate strings.

str\_replace
------------

The `str_replace` function can be used to replace a pattern matched in a
string by another string. In the example below, we look for brewery
addresses containing `Inc.` or all its variants in order to standardize
the nomenclature. We reuse the `str_which` function to identify the rows
containing the pattern of interest.

``` r
inc <- breweries$brewery_name %>% str_which("INC.|inc.|Inc.|INC|inc|Inc")
head(inc)
```

    ## [1]  94 108 177 273 278 343

We can see below that Inc has been correct to Inc. in the first two
rows. The remaining rows were formatted correctly to begin with.

``` r
t1 <- breweries %>% select(brewery_name) %>% slice(inc)
head(t1)
```

    ##                                   brewery_name
    ## 1                  New English Brewing Co. Inc
    ## 2                        Marauder Brewing, Inc
    ## 3                   Etna Brewing Company, Inc.
    ## 4             Anheuser-Busch Inc.- Los Angeles
    ## 5                        American Beerguy Inc.
    ## 6 St. Louis Brewery, Inc./Schlafly Bottleworks

``` r
breweries$brewery_name <- breweries$brewery_name %>% str_replace("INC.|inc.|Inc.|INC|inc|Inc", "Inc.")
t2 <- breweries %>% select(brewery_name) %>% slice(inc)
head(t2)
```

    ##                                   brewery_name
    ## 1                 New English Brewing Co. Inc.
    ## 2                       Marauder Brewing, Inc.
    ## 3                   Etna Brewing Company, Inc.
    ## 4             Anheuser-Busch Inc.- Los Angeles
    ## 5                        American Beerguy Inc.
    ## 6 St. Louis Brewery, Inc./Schlafly Bottleworks

str\_to\_upper
--------------

There are three functions we can use to modify the case of a string:
`str_to_upper`, `str_to_lower` and `str_to_tile`. The below is an
example of the first function.

``` r
t4 <- sapply(breweries$address, function(x) str_to_upper(x))
head(t4)
```

    ## [1] "PO BOX 4653, STOCKTON, CALIFORNIA, 95204"          
    ## [2] "157 ADAMS ST., STOCKTON, CALIFORNIA, 95204"        
    ## [3] "1950 W FREEMONT, STOCKTON, CALIFORNIA, 95203"      
    ## [4] "102 S. STATE ST., UKIAH, CALIFORNIA, 95482"        
    ## [5] "13011 NEWPORT AVE. #100, TUSTIN, CALIFORNIA, 92780"
    ## [6] "1404 4TH ST., BERKELEY, CALIFORNIA, 94608"

Subseting Strings
=================

Here we look at some functionaliy for subsetting strings.

str\_extract and str\_extract\_all
----------------------------------

The `str_extract` function takes a character string column and a patern,
and returns the first occurence of the matched pattern. The more general
function `str_extract_all` returns all matches of the pattern. We use it
below to extract the zip codes from the address column. We should be
mindful that building numbers corresponding to the pattern will also be
matched.

``` r
t5 <- breweries$address %>% str_extract_all("([:digit:]{5})$")
head(t5)
```

    ## [[1]]
    ## [1] "95204"
    ## 
    ## [[2]]
    ## [1] "95204"
    ## 
    ## [[3]]
    ## [1] "95203"
    ## 
    ## [[4]]
    ## [1] "95482"
    ## 
    ## [[5]]
    ## [1] "92780"
    ## 
    ## [[6]]
    ## [1] "94608"

Join and Split
==============

Here we look some functionaliy for joining and splititng strings.

str\_split
----------

The `str_split` takes in a column vector and a separator character or
pattern. We use it below to separate the `brewery_address` column by `,`
into its individual components for further processing.

``` r
t6 <- breweries$address %>% str_split(",")
head(t6)
```

    ## [[1]]
    ## [1] "PO Box 4653" " Stockton"   " California" " 95204"     
    ## 
    ## [[2]]
    ## [1] "157 Adams St." " Stockton"     " California"   " 95204"       
    ## 
    ## [[3]]
    ## [1] "1950 W Freemont" " Stockton"       " California"     " 95203"         
    ## 
    ## [[4]]
    ## [1] "102 S. State St." " Ukiah"           " California"     
    ## [4] " 95482"          
    ## 
    ## [[5]]
    ## [1] "13011 Newport Ave. #100" " Tustin"                
    ## [3] " California"             " 92780"                 
    ## 
    ## [[6]]
    ## [1] "1404 4th St." " Berkeley"    " California"  " 94608"

str\_c
------

The `str_c` will do just the opposite of the `sr_split` function and
will instead concatenate individual strings into a single string.

``` r
t7 <- sapply(t6, function(x) str_c(x, collapse = ","))
head(t7)
```

    ## [1] "PO Box 4653, Stockton, California, 95204"          
    ## [2] "157 Adams St., Stockton, California, 95204"        
    ## [3] "1950 W Freemont, Stockton, California, 95203"      
    ## [4] "102 S. State St., Ukiah, California, 95482"        
    ## [5] "13011 Newport Ave. #100, Tustin, California, 92780"
    ## [6] "1404 4th St., Berkeley, California, 94608"

We should note that `stringr` is a package for manipulating strings.
Some of the examples above like splitting the address column into its
constituent parts would be better served by the use of the
`str_separate` function from the `dplyr` package.

For more information, check out the `stringr` cheatsheet on
[github](https://github.com/rstudio/cheatsheets/blob/master/strings.pdf).
