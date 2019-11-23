Library & Helpers
-----------------

    library(tidyverse)
    library(lubridate)

    # This helper function will load URL data and store it locally 
    # in a data/ folder for future loading without having to 
    # redownload the file every time.  The function will create the
    # data/ folder if it doesn't already exist.
    # 
    # Note that we are using the readr write_csv() method
    load_cached_url <- function(filename, url) {
      dir.create(file.path('.', 'data'), showWarnings = FALSE)
      fqfn <- paste('./data', filename, sep = '/')
      
      if(file.exists(fqfn)) {
        data <- read_csv(fqfn)
      } else {
        data <- read_csv(url)
        write_csv(data, fqfn)
      }
      
      return(as_tibble(data))
    }

Data Set(s)
-----------

FiveThirtyEight has aggregated polling data from a number of sources
tracking Trump’s approval rating since January 2017. In this programming
vignette, we will use TidyVerse packages to load, manipulate, summarize
and plot Trump’s approval rating over time.

URL:
<a href="https://github.com/fivethirtyeight/data/tree/master/trump-approval-ratings" class="uri">https://github.com/fivethirtyeight/data/tree/master/trump-approval-ratings</a>

There are two CSV files of interest: - [Approved
Polls](https://projects.fivethirtyeight.com/trump-approval-data/approval_polllist.csv)
- [Poll
Results](https://projects.fivethirtyeight.com/trump-approval-data/approval_topline.csv)

readr - read\_csv() method
--------------------------

The readr package provides methods for loading and saving data from both
the local file system and from url’s where data is hosted online. We
will use the read\_csv() and write\_csv() method to load our CSV data
and save it to a local cache.

    polls <- load_cached_url(
      'trump-approval-ratings-polls.csv', 
      'https://projects.fivethirtyeight.com/trump-approval-data/approval_polllist.csv'
      )


    results <- load_cached_url(
      'trump-approval-ratings-results.csv',
      'https://projects.fivethirtyeight.com/trump-approval-data/approval_topline.csv')

    head(polls)

    ## # A tibble: 6 x 22
    ##   president subgroup modeldate startdate enddate pollster grade samplesize
    ##   <chr>     <chr>    <chr>     <chr>     <chr>   <chr>    <chr>      <dbl>
    ## 1 Donald T… All pol… 11/22/20… 1/20/2017 1/22/2… Morning… B/C         1992
    ## 2 Donald T… All pol… 11/22/20… 1/20/2017 1/22/2… Gallup   B           1500
    ## 3 Donald T… All pol… 11/22/20… 1/20/2017 1/24/2… Ipsos    B-          1632
    ## 4 Donald T… All pol… 11/22/20… 1/21/2017 1/23/2… Gallup   B           1500
    ## 5 Donald T… All pol… 11/22/20… 1/22/2017 1/24/2… Rasmuss… C+          1500
    ## 6 Donald T… All pol… 11/22/20… 1/20/2017 1/25/2… Quinnip… B+          1190
    ## # … with 14 more variables: population <chr>, weight <dbl>,
    ## #   influence <dbl>, approve <dbl>, disapprove <dbl>,
    ## #   adjusted_approve <dbl>, adjusted_disapprove <dbl>,
    ## #   multiversions <chr>, tracking <lgl>, url <chr>, poll_id <dbl>,
    ## #   question_id <dbl>, createddate <chr>, timestamp <chr>

    head(results)

    ## # A tibble: 6 x 10
    ##   president subgroup modeldate approve_estimate approve_hi approve_lo
    ##   <chr>     <chr>    <chr>                <dbl>      <dbl>      <dbl>
    ## 1 Donald T… Voters   11/22/20…             43.0       48.4       37.7
    ## 2 Donald T… Adults   11/22/20…             40.2       44.0       36.4
    ## 3 Donald T… All pol… 11/22/20…             41.9       47.0       36.8
    ## 4 Donald T… Adults   11/21/20…             40.1       43.8       36.4
    ## 5 Donald T… Voters   11/21/20…             43.0       48.3       37.7
    ## 6 Donald T… All pol… 11/21/20…             41.9       47.0       36.8
    ## # … with 4 more variables: disapprove_estimate <dbl>, disapprove_hi <dbl>,
    ## #   disapprove_lo <dbl>, timestamp <chr>

lubridate
---------

Let’s make sure all date columns are treated as a date format using
lubridate’s mdy()

    date_cols <- c('modeldate', 'startdate', 'enddate', 'createddate')

    polls$modeldate   <- mdy(polls$modeldate)
    polls$startdate   <- mdy(polls$startdate)
    polls$enddate     <- mdy(polls$enddate)
    polls$createddate <- mdy(polls$createddate)

    results$modeldate   <- mdy(results$modeldate)

dplyr - filter() & select()
---------------------------

The dplyr:filter() function allows us to filter rows much like a ‘where’
statement in SQL. Here, we will only consider polls of Voters. The
dplyr:select() function will limit which columns are returned. Here, we
only want the date, approval and disapproval values. The dplyr:arrange()
functions allows us to sort the rows by model date. We leverage the
dyplr:gather() function to convert our tibble from wide to long format
which aids with plotting.

    # example filtering, selecting an sorting data
    res <- results %>%
      filter(subgroup == 'Voters') %>%
      select(modeldate, approve_estimate, disapprove_estimate) %>%
      arrange(modeldate)

    # example creating a new column
    res <- res %>%
      mutate(gap = (approve_estimate - disapprove_estimate))

    # example converting to long format for plotting
    res <- res %>% 
      gather('type', 'value', -modeldate) 

    head(res)

    ## # A tibble: 6 x 3
    ##   modeldate  type             value
    ##   <date>     <chr>            <dbl>
    ## 1 2017-01-23 approve_estimate  46  
    ## 2 2017-01-24 approve_estimate  46  
    ## 3 2017-01-25 approve_estimate  48.6
    ## 4 2017-01-26 approve_estimate  44.6
    ## 5 2017-01-27 approve_estimate  44.4
    ## 6 2017-01-28 approve_estimate  44.4

ggplot2
-------

Let’s see how Trump’s approval and disapproval ratings have varied over
time. We also plot the gap, calculated as approval minus disapproval. We
see that very early into his term, Trump’s disapproval rating exceeded
his approval rating and he has maintained a negative gap throughout his
presidency.

    # Multiple line plot
    ggplot(res, aes(x = modeldate, y = value)) + 
      geom_area(aes(color = type, fill = type), 
                alpha = 0.2, position = position_dodge(0.8)) +
      scale_color_manual(values = c("#00FF00", "#ff0000", "#ff0000")) +
      scale_fill_manual(values = c("#00FF00", "#ff0000", "#E7B800")) 

![](trump_approval_ratings_files/figure-markdown_strict/unnamed-chunk-2-1.png)
