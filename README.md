# CUNY DATA 607 Fall 2019 Tidyverse recipes

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



## Vignettes:
Author: Mario Pena

**Part 1**: Created a .Rmd document to demonstrate how to use some of the TidyVerse functions such as select(), mutate(), count() and ggplot(). 
Rpubs: http://rpubs.com/marioipena/553779

**Part 2**: Made an extension to the work of C. Rosemond to add a few more examples with the functions count() and ggplot().
Github: https://github.com/chrosemo/FALL2019TIDYVERSE/pull/1/commits/7eb56a3490d59ef5ca4f29aaacea6b5c9ed4822f
=======
=======
  * You can find this here: 
  
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


### Fight Songs Vignette
Author:Scott Reed

Part 1: Use readr, stringr, purr, and dplyr to analyze fightsongs and see if spelling is more common with authors with longer names.

cf. `fightsongs_tidyvrese.rmd`

Part 2: switch to readr then use stringr, lubridate to fix a problem with the data, and then graph using ggplot.

cf. `NFL Runningback's BMI_sr.rmd`

# Avengers dataset 
Author: Bryan Persaud

I am using the Avengers dataset from FiveThirtyEight and using the dplyr package to demonstrate the filter and full_join function.
Avengers dataset: https://github.com/fivethirtyeight/data/tree/master/avengers

**Extend an Existing Example**

I extended Stephen Haslett's code.

## FiveThirtyEight TidyVerse Vignette
Author: Zach Alexander

* Part 1: I will be making a TidyVerse vignette for the tidyr package, using the NFL elo ratings dataset from FiveThirtyEight.
  * You can find this here: http://rpubs.com/zachalexander/tidyverse

* Part 2: I extended Euclid Zhang's example, adding to his great plots by creating a ggplot2 plot of my own, as well as utilizing some tidyr and dplyr functions to manipulate the weather data he provided.
  * You can find this here: http://rpubs.com/zachalexander/tidyext
  
## Masculinity Dataset
Author: Amber Ferger

* Part 1: I decided to use the dataset that corresponds to the What Do Men Think It Means To Be A Man? article on FiveThirtyEight.com. The article can be found here: https://fivethirtyeight.com/features/what-do-men-think-it-means-to-be-a-man/. This project focuses on the tibble, dplyr, and ggplot 2 packages. I focus on aggregating the data and displaying differences in responses between 2 demographic features. The final markdown file can be found here: http://rpubs.com/amberferger/DATA607_Tidyverse

* Part 2: I extended the Fight Songs vignette by Scott Reed to include additional aggregations.

## Kaggle TidyVerse Vignette
Author: Forhad Akbar
Part 01: 
* GitHub handle: https://github.com/forhadakbar
* Data Source: https://www.kaggle.com/ronitf/heart-disease-uci/version/1
* slice() to filter out everything except a specified subset of the data.
* mutate() to add new variables that are functions of existing variables.
* summarise() to condense multiple values to a single value.
* group_by() Groups data by specified columns

Part 02: Tidyverse Assignment Part 02 Extended from SHaslett-607-Tidyverse-assignment.Rmd
* Added group_by()
* Added ggplot()

## Kaggle TidyVerse Vignette
Author: Shovan Biswas Part 01:

The **dplyr** package makes these steps fast and easy:

* Provides appropriate functions manipulate data.
* Uses efficient backends.

Part 01: 
* GitHub handle: https://github.com/ShovanBiswas
* Data Source: https://www.kaggle.com/ronitf/heart-disease-uci

* arrange() to order tbl rows by an expression involving its variables.
* group_by() Groups data by specified columns
* select() to Choose variables from a tbl. select() keeps only the variables you mention.
* summarise() to condense multiple values to a single value.

Part 02: Tidyverse Assignment Part 02 extended from 'purrr - Euclid Zhang.RMD'
* Added select(), as intermediate step.
* Added group_by()
* Added top_n()
* Added ggplot()

## FiveThirtyEight TidyVerse Data Source: president_primary_polls
Author: Samuel Kigamba
Data selected: https://projects.fivethirtyeight.com/polls-page/president_primary_polls.csv 
Github repository: https://github.com/igukusamuel/FALL2019TIDYVERSE/edit/master/README.md

Section 1
Load DAta
rename()
slice()
groupby()
tally()
glimpse()

Section 2
Extended: https://github.com/forhadakbar/FALL2019TIDYVERSE/blob/master/DATA607_TidyVerse_ForhadAkbar_01.Rmd
rename() function


## TidyVerse Vignette - Kaggle
Author: Fan Xu

* Part 1: I will be making a TidyVerse vignette for some handly functions in the tidyverse package, using the [London bike sharing dataset](https://www.kaggle.com/hmavrodiev/london-bike-sharing-dataset/data) from <https://www.kaggle.com/datasets>;.
  * You can find this here: [http://rpubs.com/oggyluky11/555248]

* Part 2: I extended C. Rosemond's example, utilizing some tidyr and dplyr functions to manipulate the Soccer Power Index data he provided and creating a ggplot.
  * You can find this here: [http://rpubs.com/oggyluky11/555371]


### Kaggle Student Performace Dataset

Author: Mengqin Cai
Part1: Use readr(),map(), gather(),filter（）,mutate（）and summarise() to import the data and compare students math performance base on their parents education. ggplot2 to visualize the data.

Part2: Extend Amber Ferger's example, use arrange(), and ggplot2 to show the filtered dataset.

Rpubs: http://rpubs.com/DaisyCai/data607_Tidyverse
Github:https://github.com/DaisyCai2019/Homework/blob/master/data607_tidyverse.Rmd
       https://github.com/DaisyCai2019/Homework/blob/master/data607_tidyverse.md

### Kaggle Avocado Price Dataset

Author: Zhi Ying Chen
Part1: Use filter(), arrange(), select(), rename（）,mutate（）and summaries() to import and analyze the data and useggplot2 to visualize the data.

Part2: Extend Lin Li's example, use select(), filter(), and summaries to show the filtered dataset.

       
