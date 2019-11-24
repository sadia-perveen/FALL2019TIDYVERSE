# CUNY DATA 607 Fall 2019 Tidyverse recipes

You have two tasks:

**Create an Example**  Using one or more TidyVerse packages, and any dataset from fivethirtyeight.com or Kaggle, create a programming sample “vignette” that demonstrates how to use one or more of the capabilities of the selected TidyVerse package with your selected dataset. (25 points)

**Extend an Existing Example**  Using one of your classmate’s examples (as created above), extend his or her example with additional annotated code. (15 points)

You should clone the provided repository.  Once you have code to submit, you should make a pull request on the shared repository.  Minimally, you should be submitted .Rmd files; ideally, you should also submit an .md file and update the README.md file with your example.

*After you’ve completed both parts of the assignment, please submit your GitHub handle name in the submission link provided in the week 1 folder!* This will let your instructor know that your work is ready to be graded.

You should complete both parts of the assignment and make your submission no later than end of day on Sunday, November 24th.

In this assignment, you’ll practice collaborating around a code project with GitHub.  You could consider our collective work as building out a book of examples on how to use TidyVerse functions.

* GitHub repository:  https://github.com/acatlin/FALL2019TIDYVERSE
* FiveThirtyEight.com datasets:  https://data.fivethirtyeight.com/
* Kaggle datasets:  https://www.kaggle.com/datasets

## Vignettes
### Create a Document Term Matrix
Author: Jai Jeffryes

A document term matrix (DTM) is a data structure that can serve as the input to machine learning models. Tidyverse tools can create this structure.

cf. `candidate_email_dtm.Rmd`

### Trump Approval Ratings from FiveThirtyEight
Author: Donny Lofland

FiveThirtyEight has aggregated polling data from a number of sources tracking Trump's approval rating since January 2017.  In this programming vignette, we will use TidyVerse packages to load, manipulate, summarize and plot Trump's approval rating over time. 

cf. `trump_approval_ratings.Rmd`