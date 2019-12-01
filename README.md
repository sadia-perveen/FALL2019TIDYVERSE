# CUNY DATA 607 Fall 2019 Tidyverse recipes

# Avengers dataset 
Author: Bryan Persaud

I am using the Avengers dataset from FiveThirtyEight and using the dplyr package to demonstrate the filter and full_join function.
Avengers dataset: https://github.com/fivethirtyeight/data/tree/master/avengers

**Extend an Existing Example**

I extended Stephen Haslett's code.

=======
## Objective
In this assignment, you’ll practice collaborating around a code project with GitHub. You could consider our collective work as building out a book of examples on how to use TidyVerse functions.

## Tasks
You have two tasks:

 1. **Create an Example** Using one or more TidyVerse packages, and any dataset from fivethirtyeight.com or Kaggle, create a programming sample “vignette” that demonstrates how to use one or more of the capabilities of the selected TidyVerse package with your selected dataset. (25 points)

 1. **Extend an Existing Example** Using one of your classmate’s examples (as created above), extend his or her example with additional annotated code. (15 points)

## Collaboration
You should [fork](https://github.community/t5/Support-Protips/The-difference-between-forking-and-cloning-a-repository/ba-p/1372) the provided repository and then clone it locally if you wish. Once you have code to submit, you should make a pull request on the shared repository. Minimally, you should submit `.Rmd` files. Ideally, you should also submit an `.md` file and update the README.md file with your example.

### Advice
If you are going to use RStudio as your version control software, make sure to add `*.Rproj` and `.gitignore` to your .gitignore file **before** you make any commits. Otherwise you run the risk of trying to push that to the master repository in a pull request.

## Notification
***After you’ve completed both parts of the assignment, please submit your GitHub handle name in the submission link provided in the week 1 folder!*** This will let your instructor know that your work is ready to be graded.

## Deadline
You should complete both parts of the assignment and make your submission no later than end of day on Sunday, November 24th.

## References
* GitHub repository:  https://github.com/acatlin/FALL2019TIDYVERSE
* FiveThirtyEight.com datasets:  https://data.fivethirtyeight.com/
* Kaggle datasets:  https://www.kaggle.com/datasets

## Vignettes

### Ramen Ratings
Author: Stephen Haslett

**GitHub Repository**: https://github.com/stephen-haslett/FALL2019TIDYVERSE

**Data Source**: https://www.kaggle.com/residentmario/ramen-ratings/data

**RPubs Location**: http://rpubs.com/stephenhaslett/554575

**Task 1**: SHaslett-607-Tidyverse-assignment.Rmd. For task 1, I imported the ramen-ratings dataset from Kaggle (https://www.kaggle.com/residentmario/ramen-ratings/data)
into R using the "readr" package. I then demonstrated the dplyr package's "slice", "filter", and "select" functions.

### Create a Document Term Matrix
Author: Jai Jeffryes

A document term matrix (DTM) is a data structure that can serve as the input to machine learning models. Tidyverse tools can create this structure.

cf. `candidate_email_dtm.Rmd`

### Trump Approval Ratings from FiveThirtyEight
Author: Donny Lofland

FiveThirtyEight has aggregated polling data from a number of sources tracking Trump's approval rating since January 2017.  In this programming vignette, we will use TidyVerse packages to load, manipulate, summarize and plot Trump's approval rating over time. 

cf. `trump_approval_ratings.Rmd`

TidyVerse Assignment: 

Part 1:
Editor: Euclid Zhang
Date Completed: 11/11/2019
Action: Create a demonstration of how to use the functions in the purrr package.
Rpubs: http://rpubs.com/ezaccountz/TidyVerse_Assignment_EZ

Part 2:
Creator: Lin Li
Source: https://github.com/lincarrieli/FALL2019TIDYVERSE
Updater: Euclid Zhang
Date Completed: 11/17/2019
Action: Update with a few examples from TidyVerse package.

### Forcats Vignette
Author:Steven Ellingson

Part 1: Use forcats to easily change the way the levels of your factors are displayed in tables and plots.

cf. `forcats vignette.Rmd`

Part 2: Added some forcats and ggplot2 functions to C Rosemund's soccer data.

cf. `steven_ellingson_tidyverse_part_2.Rmd`
=======