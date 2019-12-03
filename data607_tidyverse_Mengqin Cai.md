Section I
=========

Create an Example. Using one or more TidyVerse packages, and any dataset
from fivethirtyeight.com or Kaggle, create a programming sample
“vignette” that demonstrates how to use one or more of the capabilities
of the selected TidyVerse package with your selected dataset.

Data source:
<a href="https://www.kaggle.com/spscientist/students-performance-in-exams" class="uri">https://www.kaggle.com/spscientist/students-performance-in-exams</a>

``` r
library(tidyr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(stringr)
library(ggplot2)
library(purrr)
```

Importing Data
==============

**Readr: The goal of ‘readr’ is to provide a fast and friendly way to
read rectangular data (like ‘csv’, ‘tsv’, and ‘fwf’).**

We use readr to read csv into R.

``` r
Students<-read.csv('https://raw.githubusercontent.com/DaisyCai2019/Homework/master/StudentsPerformance.csv')
head(Students)
```

    ##   gender race.ethnicity parental.level.of.education        lunch
    ## 1 female        group B           bachelor's degree     standard
    ## 2 female        group C                some college     standard
    ## 3 female        group B             master's degree     standard
    ## 4   male        group A          associate's degree free/reduced
    ## 5   male        group C                some college     standard
    ## 6 female        group B          associate's degree     standard
    ##   test.preparation.course math.score reading.score writing.score
    ## 1                    none         72            72            74
    ## 2               completed         69            90            88
    ## 3                    none         90            95            93
    ## 4                    none         47            57            44
    ## 5                    none         76            78            75
    ## 6                    none         71            83            78

``` r
name<-c("Gender","Race","Parent_Eduction","Lunch","Test_preparation_course", "math", "reading", "writing")
colnames(Students) <- name
head(Students)
```

    ##   Gender    Race    Parent_Eduction        Lunch Test_preparation_course
    ## 1 female group B  bachelor's degree     standard                    none
    ## 2 female group C       some college     standard               completed
    ## 3 female group B    master's degree     standard                    none
    ## 4   male group A associate's degree free/reduced                    none
    ## 5   male group C       some college     standard                    none
    ## 6 female group B associate's degree     standard                    none
    ##   math reading writing
    ## 1   72      72      74
    ## 2   69      90      88
    ## 3   90      95      93
    ## 4   47      57      44
    ## 5   76      78      75
    ## 6   71      83      78

Data Summary
============

Purrr: The purrr package in R provides a complete toolkit for enhancing
R’s functional programming. summary() function gives us the descriptive
statistics for each column.An even better way to just deduce the mean
value, without using any ugly loops, is to use the “map” function.

**map():The map functions transform their input by applying a function
to each element and returning a vector the same length as the input.**

map\_dbl()calculate the average score for each column and only the
numeric column will show the final result.

``` r
summary(Students)
```

    ##     Gender         Race               Parent_Eduction          Lunch    
    ##  female:518   group A: 89   associate's degree:222    free/reduced:355  
    ##  male  :482   group B:190   bachelor's degree :118    standard    :645  
    ##               group C:319   high school       :196                      
    ##               group D:262   master's degree   : 59                      
    ##               group E:140   some college      :226                      
    ##                             some high school  :179                      
    ##  Test_preparation_course      math           reading      
    ##  completed:358           Min.   :  0.00   Min.   : 17.00  
    ##  none     :642           1st Qu.: 57.00   1st Qu.: 59.00  
    ##                          Median : 66.00   Median : 70.00  
    ##                          Mean   : 66.09   Mean   : 69.17  
    ##                          3rd Qu.: 77.00   3rd Qu.: 79.00  
    ##                          Max.   :100.00   Max.   :100.00  
    ##     writing      
    ##  Min.   : 10.00  
    ##  1st Qu.: 57.75  
    ##  Median : 69.00  
    ##  Mean   : 68.05  
    ##  3rd Qu.: 79.00  
    ##  Max.   :100.00

``` r
map_dbl(Students,~mean(.x))
```

    ## Warning in mean.default(.x): argument is not numeric or logical: returning
    ## NA

    ## Warning in mean.default(.x): argument is not numeric or logical: returning
    ## NA

    ## Warning in mean.default(.x): argument is not numeric or logical: returning
    ## NA

    ## Warning in mean.default(.x): argument is not numeric or logical: returning
    ## NA

    ## Warning in mean.default(.x): argument is not numeric or logical: returning
    ## NA

    ##                  Gender                    Race         Parent_Eduction 
    ##                      NA                      NA                      NA 
    ##                   Lunch Test_preparation_course                    math 
    ##                      NA                      NA                  66.089 
    ##                 reading                 writing 
    ##                  69.169                  68.054

Data Wrangling
==============

tidyr
-----

The tidyr package complements dplyr perfectly. It boosts the power of
dplyr for data manipulation and pre-processing.

**gather():Gather takes multiple columns and collapses into key-value
pairs, duplicating all other columns as needed. You use gather() when
you notice that you have columns that are not variables.**

We use gather()to gather columns math, writing, reading and writing into
rows

``` r
Students<-gather(Students,"Subject","Score",6:8)
Students
```

    ##      Gender    Race    Parent_Eduction        Lunch
    ## 1    female group B  bachelor's degree     standard
    ## 2    female group C       some college     standard
    ## 3    female group B    master's degree     standard
    ## 4      male group A associate's degree free/reduced
    ## 5      male group C       some college     standard
    ## 6    female group B associate's degree     standard
    ## 7    female group B       some college     standard
    ## 8      male group B       some college free/reduced
    ## 9      male group D        high school free/reduced
    ## 10   female group B        high school free/reduced
    ## 11     male group C associate's degree     standard
    ## 12     male group D associate's degree     standard
    ## 13   female group B        high school     standard
    ## 14     male group A       some college     standard
    ## 15   female group A    master's degree     standard
    ## 16   female group C   some high school     standard
    ## 17     male group C        high school     standard
    ## 18   female group B   some high school free/reduced
    ## 19     male group C    master's degree free/reduced
    ## 20   female group C associate's degree free/reduced
    ## 21     male group D        high school     standard
    ## 22   female group B       some college free/reduced
    ## 23     male group D       some college     standard
    ## 24   female group C   some high school     standard
    ## 25     male group D  bachelor's degree free/reduced
    ## 26     male group A    master's degree free/reduced
    ## 27     male group B       some college     standard
    ## 28   female group C  bachelor's degree     standard
    ## 29     male group C        high school     standard
    ## 30   female group D    master's degree     standard
    ## 31   female group D       some college     standard
    ## 32   female group B       some college     standard
    ## 33   female group E    master's degree free/reduced
    ## 34     male group D       some college     standard
    ## 35     male group E       some college     standard
    ## 36     male group E associate's degree     standard
    ## 37   female group D associate's degree     standard
    ## 38   female group D   some high school free/reduced
    ## 39   female group D associate's degree free/reduced
    ## 40     male group B associate's degree free/reduced
    ## 41     male group C associate's degree free/reduced
    ## 42   female group C associate's degree     standard
    ## 43   female group B associate's degree     standard
    ## 44     male group B       some college free/reduced
    ## 45   female group E associate's degree free/reduced
    ## 46     male group B associate's degree     standard
    ## 47   female group A associate's degree     standard
    ## 48   female group C        high school     standard
    ## 49   female group D associate's degree free/reduced
    ## 50     male group C        high school     standard
    ## 51     male group E       some college     standard
    ## 52     male group E associate's degree free/reduced
    ## 53     male group C       some college     standard
    ## 54     male group D        high school     standard
    ## 55   female group C   some high school free/reduced
    ## 56   female group C        high school free/reduced
    ## 57   female group E associate's degree     standard
    ## 58     male group D associate's degree     standard
    ## 59     male group D       some college     standard
    ## 60   female group C   some high school free/reduced
    ## 61     male group E  bachelor's degree free/reduced
    ## 62     male group A   some high school free/reduced
    ## 63     male group A associate's degree free/reduced
    ## 64   female group C associate's degree     standard
    ## 65   female group D   some high school     standard
    ## 66     male group B   some high school     standard
    ## 67     male group D   some high school free/reduced
    ## 68   female group C       some college     standard
    ## 69     male group B associate's degree free/reduced
    ## 70   female group C associate's degree     standard
    ## 71   female group D       some college free/reduced
    ## 72     male group D       some college     standard
    ## 73   female group A associate's degree free/reduced
    ## 74     male group C   some high school free/reduced
    ## 75     male group C   some high school     standard
    ## 76     male group B associate's degree free/reduced
    ## 77     male group E   some high school     standard
    ## 78     male group A  bachelor's degree     standard
    ## 79   female group D   some high school     standard
    ## 80   female group E    master's degree     standard
    ## 81   female group B associate's degree     standard
    ## 82     male group B        high school free/reduced
    ## 83     male group A       some college free/reduced
    ## 84     male group E associate's degree     standard
    ## 85     male group D        high school free/reduced
    ## 86   female group C       some college     standard
    ## 87   female group C       some college free/reduced
    ## 88   female group D associate's degree     standard
    ## 89   female group A       some college     standard
    ## 90   female group D   some high school     standard
    ## 91   female group C  bachelor's degree     standard
    ## 92     male group C        high school free/reduced
    ## 93     male group C        high school     standard
    ## 94     male group C associate's degree free/reduced
    ## 95   female group B       some college     standard
    ## 96     male group C associate's degree free/reduced
    ## 97     male group B   some high school     standard
    ## 98   female group E       some college     standard
    ## 99   female group D       some college free/reduced
    ## 100  female group D  bachelor's degree     standard
    ## 101    male group B       some college     standard
    ## 102    male group D  bachelor's degree     standard
    ## 103  female group D associate's degree     standard
    ## 104    male group B        high school     standard
    ## 105    male group C       some college     standard
    ## 106  female group C       some college     standard
    ## 107  female group D    master's degree     standard
    ## 108    male group E associate's degree     standard
    ## 109  female group B associate's degree free/reduced
    ## 110  female group B   some high school     standard
    ## 111  female group D associate's degree free/reduced
    ## 112    male group C        high school     standard
    ## 113    male group A associate's degree     standard
    ## 114  female group D       some college     standard
    ## 115  female group E  bachelor's degree     standard
    ## 116    male group C        high school     standard
    ## 117  female group B  bachelor's degree free/reduced
    ## 118  female group D  bachelor's degree     standard
    ## 119  female group D   some high school     standard
    ## 120  female group C       some college     standard
    ## 121  female group C  bachelor's degree     standard
    ## 122    male group B associate's degree     standard
    ## 123  female group C       some college     standard
    ## 124    male group D        high school free/reduced
    ## 125    male group E       some college     standard
    ## 126  female group B        high school     standard
    ## 127    male group B   some high school     standard
    ## 128    male group D       some college     standard
    ## 129    male group D    master's degree     standard
    ## 130  female group A  bachelor's degree     standard
    ## 131    male group D    master's degree     standard
    ## 132    male group C   some high school free/reduced
    ## 133    male group E       some college free/reduced
    ## 134  female group C       some college     standard
    ## 135    male group D  bachelor's degree free/reduced
    ## 136    male group C  bachelor's degree     standard
    ## 137    male group B   some high school     standard
    ## 138    male group E        high school     standard
    ## 139  female group C associate's degree     standard
    ## 140    male group D       some college     standard
    ## 141  female group D   some high school     standard
    ## 142  female group C       some college free/reduced
    ## 143  female group E       some college free/reduced
    ## 144    male group A        high school     standard
    ## 145    male group D       some college     standard
    ## 146  female group C       some college free/reduced
    ## 147    male group B   some high school     standard
    ## 148    male group C associate's degree free/reduced
    ## 149  female group D  bachelor's degree     standard
    ## 150    male group E associate's degree free/reduced
    ## 151    male group A   some high school     standard
    ## 152    male group A  bachelor's degree     standard
    ## 153  female group B associate's degree     standard
    ## 154    male group D  bachelor's degree     standard
    ## 155    male group D   some high school     standard
    ## 156  female group C       some college     standard
    ## 157  female group E        high school free/reduced
    ## 158    male group B       some college free/reduced
    ## 159  female group B associate's degree     standard
    ## 160    male group D associate's degree free/reduced
    ## 161    male group B associate's degree free/reduced
    ## 162  female group E       some college free/reduced
    ## 163    male group B    master's degree free/reduced
    ## 164    male group C        high school     standard
    ## 165  female group E    master's degree     standard
    ## 166  female group C  bachelor's degree     standard
    ## 167    male group C        high school free/reduced
    ## 168  female group B    master's degree free/reduced
    ## 169  female group B        high school     standard
    ## 170  female group C       some college free/reduced
    ## 171    male group A        high school     standard
    ## 172    male group E   some high school     standard
    ## 173  female group D       some college     standard
    ## 174  female group C associate's degree     standard
    ## 175  female group C  bachelor's degree free/reduced
    ## 176  female group C    master's degree     standard
    ## 177  female group B        high school free/reduced
    ## 178  female group C associate's degree     standard
    ## 179  female group B    master's degree free/reduced
    ## 180  female group D   some high school     standard
    ## 181    male group C    master's degree free/reduced
    ## 182  female group C       some college free/reduced
    ## 183  female group E        high school     standard
    ## 184  female group D associate's degree     standard
    ## 185    male group C   some high school free/reduced
    ## 186    male group C associate's degree free/reduced
    ## 187    male group E        high school     standard
    ## 188    male group D   some high school     standard
    ## 189    male group B   some high school free/reduced
    ## 190  female group C  bachelor's degree     standard
    ## 191  female group E associate's degree     standard
    ## 192    male group D       some college     standard
    ## 193  female group B   some high school     standard
    ## 194    male group D       some college     standard
    ## 195  female group C    master's degree     standard
    ## 196    male group D associate's degree     standard
    ## 197    male group C   some high school free/reduced
    ## 198    male group E        high school free/reduced
    ## 199  female group B       some college free/reduced
    ## 200  female group B  bachelor's degree free/reduced
    ## 201  female group C associate's degree     standard
    ## 202  female group D       some college free/reduced
    ## 203    male group C associate's degree     standard
    ## 204  female group B associate's degree     standard
    ## 205    male group C       some college     standard
    ## 206    male group D   some high school     standard
    ## 207    male group E  bachelor's degree     standard
    ## 208    male group E        high school     standard
    ## 209  female group B       some college free/reduced
    ## 210  female group B       some college free/reduced
    ## 211    male group D   some high school free/reduced
    ## 212    male group C       some college free/reduced
    ## 213  female group C        high school free/reduced
    ## 214    male group C associate's degree free/reduced
    ## 215    male group E        high school     standard
    ## 216    male group B   some high school     standard
    ## 217  female group E associate's degree free/reduced
    ## 218  female group C        high school free/reduced
    ## 219    male group B        high school free/reduced
    ## 220    male group B   some high school     standard
    ## 221  female group D        high school     standard
    ## 222    male group B associate's degree     standard
    ## 223  female group C   some high school free/reduced
    ## 224    male group D   some high school     standard
    ## 225  female group B associate's degree     standard
    ## 226  female group E    master's degree free/reduced
    ## 227  female group C       some college     standard
    ## 228    male group D        high school     standard
    ## 229    male group A   some high school free/reduced
    ## 230  female group C       some college     standard
    ## 231    male group D       some college     standard
    ## 232    male group C associate's degree     standard
    ## 233  female group B  bachelor's degree     standard
    ## 234    male group E   some high school     standard
    ## 235    male group C  bachelor's degree     standard
    ## 236    male group D associate's degree     standard
    ## 237    male group D  bachelor's degree free/reduced
    ## 238  female group D   some high school     standard
    ## 239    male group B       some college     standard
    ## 240    male group C associate's degree     standard
    ## 241    male group D        high school free/reduced
    ## 242  female group E  bachelor's degree     standard
    ## 243  female group D        high school     standard
    ## 244    male group E       some college     standard
    ## 245    male group D   some high school     standard
    ## 246    male group C associate's degree     standard
    ## 247    male group E associate's degree     standard
    ## 248  female group B        high school     standard
    ## 249  female group B        high school     standard
    ## 250    male group C        high school     standard
    ## 251    male group A   some high school     standard
    ## 252  female group D       some college free/reduced
    ## 253  female group B   some high school     standard
    ## 254    male group D    master's degree     standard
    ## 255    male group D        high school     standard
    ## 256  female group E       some college     standard
    ## 257  female group C associate's degree free/reduced
    ## 258    male group C associate's degree     standard
    ## 259  female group B       some college     standard
    ## 260  female group C    master's degree free/reduced
    ## 261  female group C   some high school free/reduced
    ## 262    male group C       some college     standard
    ## 263  female group C   some high school free/reduced
    ## 264  female group E        high school     standard
    ## 265    male group D        high school     standard
    ## 266    male group D   some high school free/reduced
    ## 267  female group C  bachelor's degree     standard
    ## 268  female group D        high school     standard
    ## 269  female group D associate's degree     standard
    ## 270  female group E       some college free/reduced
    ## 271    male group C  bachelor's degree     standard
    ## 272    male group C       some college     standard
    ## 273  female group D associate's degree free/reduced
    ## 274  female group D       some college     standard
    ## 275    male group B       some college     standard
    ## 276    male group C  bachelor's degree     standard
    ## 277  female group C   some high school     standard
    ## 278  female group E        high school     standard
    ## 279  female group C   some high school free/reduced
    ## 280    male group B  bachelor's degree free/reduced
    ## 281    male group D        high school     standard
    ## 282    male group D        high school     standard
    ## 283  female group D  bachelor's degree free/reduced
    ## 284  female group D       some college free/reduced
    ## 285  female group B   some high school     standard
    ## 286    male group B associate's degree     standard
    ## 287    male group E associate's degree     standard
    ## 288  female group B   some high school     standard
    ## 289    male group B  bachelor's degree free/reduced
    ## 290    male group E   some high school     standard
    ## 291    male group C associate's degree     standard
    ## 292    male group D   some high school     standard
    ## 293    male group C   some high school     standard
    ## 294  female group E  bachelor's degree     standard
    ## 295    male group D        high school free/reduced
    ## 296    male group B associate's degree free/reduced
    ## 297    male group A   some high school     standard
    ## 298    male group E associate's degree     standard
    ## 299    male group C        high school free/reduced
    ## 300    male group D associate's degree free/reduced
    ## 301    male group A       some college free/reduced
    ## 302    male group D   some high school free/reduced
    ## 303  female group C associate's degree     standard
    ## 304    male group B associate's degree     standard
    ## 305  female group C associate's degree     standard
    ## 306    male group A       some college     standard
    ## 307    male group E       some college     standard
    ## 308    male group C   some high school     standard
    ## 309  female group B associate's degree free/reduced
    ## 310  female group D        high school free/reduced
    ## 311  female group B associate's degree     standard
    ## 312    male group B  bachelor's degree     standard
    ## 313    male group D  bachelor's degree     standard
    ## 314  female group C associate's degree free/reduced
    ## 315  female group C  bachelor's degree     standard
    ## 316    male group C        high school     standard
    ## 317  female group D    master's degree     standard
    ## 318    male group C associate's degree     standard
    ## 319    male group B  bachelor's degree     standard
    ## 320  female group D associate's degree free/reduced
    ## 321  female group C        high school free/reduced
    ## 322  female group E        high school     standard
    ## 323  female group C       some college     standard
    ## 324  female group C   some high school free/reduced
    ## 325  female group C        high school free/reduced
    ## 326  female group C       some college     standard
    ## 327    male group C       some college     standard
    ## 328    male group A       some college free/reduced
    ## 329    male group C associate's degree     standard
    ## 330  female group B   some high school     standard
    ## 331    male group C        high school     standard
    ## 332    male group C associate's degree     standard
    ## 333    male group E associate's degree     standard
    ## 334    male group B associate's degree     standard
    ## 335  female group C  bachelor's degree     standard
    ## 336  female group B       some college free/reduced
    ## 337    male group D   some high school     standard
    ## 338    male group C associate's degree     standard
    ## 339  female group B   some high school free/reduced
    ## 340  female group D   some high school free/reduced
    ## 341    male group C        high school free/reduced
    ## 342  female group C        high school     standard
    ## 343  female group B        high school     standard
    ## 344    male group D associate's degree     standard
    ## 345    male group D       some college     standard
    ## 346  female group C        high school     standard
    ## 347    male group B       some college     standard
    ## 348  female group C  bachelor's degree     standard
    ## 349    male group D        high school free/reduced
    ## 350    male group E associate's degree     standard
    ## 351  female group B  bachelor's degree     standard
    ## 352    male group E       some college     standard
    ## 353  female group C       some college     standard
    ## 354  female group C associate's degree     standard
    ## 355  female group C       some college     standard
    ## 356  female group B  bachelor's degree     standard
    ## 357    male group A associate's degree     standard
    ## 358  female group C       some college free/reduced
    ## 359    male group D       some college free/reduced
    ## 360  female group D       some college     standard
    ## 361  female group B        high school     standard
    ## 362    male group B   some high school     standard
    ## 363  female group C       some college     standard
    ## 364  female group D   some high school free/reduced
    ## 365    male group C       some college     standard
    ## 366    male group A  bachelor's degree free/reduced
    ## 367    male group C        high school     standard
    ## 368    male group C  bachelor's degree free/reduced
    ## 369  female group A   some high school free/reduced
    ## 370  female group D   some high school     standard
    ## 371    male group E       some college     standard
    ## 372  female group C       some college free/reduced
    ## 373    male group D   some high school     standard
    ## 374  female group D       some college     standard
    ## 375  female group D  bachelor's degree     standard
    ## 376    male group E associate's degree free/reduced
    ## 377  female group D   some high school     standard
    ## 378  female group D    master's degree free/reduced
    ## 379  female group A   some high school     standard
    ## 380    male group A  bachelor's degree     standard
    ## 381  female group B associate's degree     standard
    ## 382    male group C associate's degree     standard
    ## 383    male group C    master's degree free/reduced
    ## 384  female group E   some high school free/reduced
    ## 385  female group A   some high school free/reduced
    ## 386  female group E       some college     standard
    ## 387  female group E  bachelor's degree     standard
    ## 388  female group C associate's degree free/reduced
    ## 389  female group D        high school     standard
    ## 390    male group D    master's degree     standard
    ## 391    male group E   some high school free/reduced
    ## 392  female group D       some college     standard
    ## 393    male group E       some college     standard
    ## 394    male group C associate's degree     standard
    ## 395  female group C   some high school     standard
    ## 396    male group A        high school free/reduced
    ## 397  female group B        high school free/reduced
    ## 398  female group C associate's degree     standard
    ## 399    male group B   some high school     standard
    ## 400    male group D   some high school     standard
    ## 401  female group C   some high school     standard
    ## 402    male group A       some college     standard
    ## 403  female group A       some college free/reduced
    ## 404  female group D        high school     standard
    ## 405  female group C        high school     standard
    ## 406  female group C   some high school     standard
    ## 407    male group B associate's degree     standard
    ## 408  female group B associate's degree     standard
    ## 409  female group D        high school free/reduced
    ## 410    male group D associate's degree     standard
    ## 411  female group D    master's degree     standard
    ## 412    male group E       some college     standard
    ## 413    male group D associate's degree     standard
    ## 414    male group B   some high school     standard
    ## 415  female group C  bachelor's degree free/reduced
    ## 416    male group E        high school     standard
    ## 417    male group C  bachelor's degree     standard
    ## 418    male group C associate's degree     standard
    ## 419    male group D       some college     standard
    ## 420    male group E        high school free/reduced
    ## 421  female group C associate's degree free/reduced
    ## 422  female group D        high school     standard
    ## 423  female group D    master's degree free/reduced
    ## 424  female group A   some high school     standard
    ## 425    male group B       some college free/reduced
    ## 426  female group C       some college free/reduced
    ## 427    male group C  bachelor's degree     standard
    ## 428    male group C   some high school free/reduced
    ## 429    male group A   some high school free/reduced
    ## 430    male group C   some high school free/reduced
    ## 431    male group C associate's degree free/reduced
    ## 432  female group C        high school     standard
    ## 433    male group C        high school     standard
    ## 434  female group A   some high school free/reduced
    ## 435    male group C   some high school     standard
    ## 436    male group C       some college free/reduced
    ## 437    male group D associate's degree     standard
    ## 438    male group D associate's degree free/reduced
    ## 439    male group C        high school     standard
    ## 440    male group D   some high school     standard
    ## 441  female group C       some college     standard
    ## 442  female group D        high school     standard
    ## 443  female group A   some high school free/reduced
    ## 444  female group B associate's degree     standard
    ## 445    male group A   some high school free/reduced
    ## 446  female group C   some high school     standard
    ## 447    male group D       some college free/reduced
    ## 448    male group C        high school     standard
    ## 449    male group B        high school     standard
    ## 450    male group B associate's degree     standard
    ## 451  female group C       some college free/reduced
    ## 452  female group E       some college     standard
    ## 453  female group C associate's degree free/reduced
    ## 454    male group C       some college free/reduced
    ## 455  female group C associate's degree free/reduced
    ## 456    male group C  bachelor's degree free/reduced
    ## 457  female group D  bachelor's degree     standard
    ## 458    male group D associate's degree free/reduced
    ## 459  female group E  bachelor's degree     standard
    ## 460    male group B        high school     standard
    ## 461    male group C  bachelor's degree free/reduced
    ## 462    male group B       some college free/reduced
    ## 463  female group E       some college     standard
    ## 464  female group C       some college free/reduced
    ## 465    male group A  bachelor's degree     standard
    ## 466  female group C       some college     standard
    ## 467  female group D associate's degree free/reduced
    ## 468    male group A        high school free/reduced
    ## 469  female group A        high school free/reduced
    ## 470    male group C       some college     standard
    ## 471  female group C associate's degree     standard
    ## 472  female group C        high school     standard
    ## 473  female group C associate's degree     standard
    ## 474  female group D   some high school     standard
    ## 475  female group B associate's degree     standard
    ## 476  female group D  bachelor's degree     standard
    ## 477    male group E  bachelor's degree     standard
    ## 478    male group D associate's degree     standard
    ## 479  female group D    master's degree     standard
    ## 480    male group E associate's degree     standard
    ## 481    male group B        high school     standard
    ## 482  female group D associate's degree free/reduced
    ## 483    male group C       some college free/reduced
    ## 484    male group A        high school     standard
    ## 485  female group B associate's degree     standard
    ## 486    male group C        high school     standard
    ## 487    male group D       some college free/reduced
    ## 488  female group C associate's degree free/reduced
    ## 489    male group B   some high school     standard
    ## 490    male group A associate's degree free/reduced
    ## 491  female group A associate's degree free/reduced
    ## 492  female group C associate's degree     standard
    ## 493  female group C       some college     standard
    ## 494  female group C  bachelor's degree     standard
    ## 495  female group B        high school     standard
    ## 496    male group D        high school     standard
    ## 497  female group C       some college     standard
    ## 498  female group D       some college free/reduced
    ## 499  female group B   some high school     standard
    ## 500    male group E       some college     standard
    ## 501  female group D    master's degree     standard
    ## 502  female group B associate's degree     standard
    ## 503    male group C       some college free/reduced
    ## 504  female group E associate's degree     standard
    ## 505  female group D    master's degree free/reduced
    ## 506  female group B   some high school     standard
    ## 507    male group A        high school     standard
    ## 508    male group B  bachelor's degree free/reduced
    ## 509    male group C    master's degree     standard
    ## 510  female group C  bachelor's degree     standard
    ## 511    male group D       some college     standard
    ## 512    male group A   some high school     standard
    ## 513    male group D   some high school free/reduced
    ## 514  female group B   some high school     standard
    ## 515  female group B    master's degree free/reduced
    ## 516  female group C   some high school     standard
    ## 517  female group D       some college     standard
    ## 518  female group E       some college     standard
    ## 519  female group D   some high school     standard
    ## 520  female group B        high school free/reduced
    ## 521    male group D       some college     standard
    ## 522  female group C associate's degree     standard
    ## 523    male group D  bachelor's degree     standard
    ## 524    male group C    master's degree free/reduced
    ## 525    male group C        high school     standard
    ## 526    male group E       some college     standard
    ## 527    male group C   some high school free/reduced
    ## 528  female group C        high school free/reduced
    ## 529  female group D  bachelor's degree free/reduced
    ## 530  female group C associate's degree     standard
    ## 531  female group C associate's degree     standard
    ## 532  female group C   some high school     standard
    ## 533    male group E associate's degree     standard
    ## 534  female group E associate's degree     standard
    ## 535    male group B        high school     standard
    ## 536  female group C  bachelor's degree free/reduced
    ## 537    male group C associate's degree     standard
    ## 538  female group D        high school     standard
    ## 539    male group E  bachelor's degree     standard
    ## 540    male group A associate's degree     standard
    ## 541    male group C        high school     standard
    ## 542    male group D associate's degree free/reduced
    ## 543  female group C associate's degree     standard
    ## 544  female group D associate's degree     standard
    ## 545  female group D    master's degree     standard
    ## 546    male group E   some high school free/reduced
    ## 547  female group A   some high school     standard
    ## 548    male group C        high school     standard
    ## 549  female group C        high school free/reduced
    ## 550    male group C    master's degree     standard
    ## 551    male group C   some high school free/reduced
    ## 552    male group B  bachelor's degree free/reduced
    ## 553  female group B associate's degree     standard
    ## 554    male group D       some college free/reduced
    ## 555    male group E associate's degree     standard
    ## 556  female group C       some college free/reduced
    ## 557  female group C associate's degree     standard
    ## 558    male group C    master's degree free/reduced
    ## 559  female group B associate's degree free/reduced
    ## 560    male group D   some high school     standard
    ## 561  female group D       some college     standard
    ## 562  female group C       some college     standard
    ## 563    male group C  bachelor's degree     standard
    ## 564  female group D       some college free/reduced
    ## 565    male group B  bachelor's degree free/reduced
    ## 566    male group B associate's degree     standard
    ## 567  female group E  bachelor's degree free/reduced
    ## 568  female group D    master's degree free/reduced
    ## 569    male group B        high school free/reduced
    ## 570    male group D  bachelor's degree free/reduced
    ## 571    male group B       some college     standard
    ## 572    male group A  bachelor's degree     standard
    ## 573  female group C       some college     standard
    ## 574  female group C        high school free/reduced
    ## 575  female group E        high school     standard
    ## 576    male group A associate's degree free/reduced
    ## 577    male group A       some college     standard
    ## 578  female group B        high school     standard
    ## 579  female group B       some college free/reduced
    ## 580  female group D    master's degree     standard
    ## 581  female group D   some high school     standard
    ## 582  female group E   some high school     standard
    ## 583  female group D  bachelor's degree free/reduced
    ## 584  female group D associate's degree     standard
    ## 585  female group D       some college     standard
    ## 586  female group C associate's degree     standard
    ## 587  female group A        high school     standard
    ## 588  female group C  bachelor's degree free/reduced
    ## 589  female group C       some college     standard
    ## 590  female group A   some high school     standard
    ## 591    male group C       some college free/reduced
    ## 592    male group A   some high school     standard
    ## 593    male group E  bachelor's degree     standard
    ## 594  female group E        high school     standard
    ## 595  female group C  bachelor's degree     standard
    ## 596  female group C  bachelor's degree     standard
    ## 597    male group B        high school free/reduced
    ## 598    male group A   some high school     standard
    ## 599  female group D        high school     standard
    ## 600  female group D   some high school     standard
    ## 601  female group D    master's degree     standard
    ## 602  female group C        high school     standard
    ## 603  female group E       some college     standard
    ## 604    male group D        high school free/reduced
    ## 605    male group D    master's degree free/reduced
    ## 606    male group C   some high school     standard
    ## 607  female group C associate's degree     standard
    ## 608  female group C    master's degree free/reduced
    ## 609  female group E       some college     standard
    ## 610  female group B associate's degree     standard
    ## 611    male group D       some college free/reduced
    ## 612  female group C       some college     standard
    ## 613    male group C  bachelor's degree     standard
    ## 614  female group C associate's degree     standard
    ## 615  female group A associate's degree     standard
    ## 616  female group C        high school     standard
    ## 617  female group E  bachelor's degree     standard
    ## 618    male group D  bachelor's degree     standard
    ## 619    male group D    master's degree     standard
    ## 620    male group C associate's degree free/reduced
    ## 621  female group C        high school free/reduced
    ## 622    male group B  bachelor's degree free/reduced
    ## 623    male group C        high school free/reduced
    ## 624    male group A       some college     standard
    ## 625  female group E  bachelor's degree free/reduced
    ## 626    male group D       some college     standard
    ## 627    male group B associate's degree free/reduced
    ## 628    male group D associate's degree     standard
    ## 629    male group D       some college free/reduced
    ## 630  female group C   some high school     standard
    ## 631    male group D       some college     standard
    ## 632    male group B        high school     standard
    ## 633  female group B  bachelor's degree     standard
    ## 634  female group C        high school     standard
    ## 635    male group D   some high school     standard
    ## 636    male group A        high school     standard
    ## 637  female group B        high school free/reduced
    ## 638  female group D   some high school     standard
    ## 639    male group E       some college     standard
    ## 640  female group D associate's degree     standard
    ## 641    male group D        high school     standard
    ## 642  female group D associate's degree free/reduced
    ## 643  female group B   some high school free/reduced
    ## 644  female group E        high school     standard
    ## 645    male group B        high school     standard
    ## 646  female group B  bachelor's degree     standard
    ## 647  female group D associate's degree     standard
    ## 648  female group E        high school free/reduced
    ## 649  female group B        high school     standard
    ## 650  female group D       some college     standard
    ## 651    male group C   some high school free/reduced
    ## 652  female group A        high school     standard
    ## 653  female group D       some college     standard
    ## 654  female group A associate's degree     standard
    ## 655  female group B   some high school     standard
    ## 656  female group B       some college     standard
    ## 657    male group C associate's degree free/reduced
    ## 658    male group D   some high school     standard
    ## 659  female group D associate's degree free/reduced
    ## 660    male group D associate's degree     standard
    ## 661    male group C       some college free/reduced
    ## 662    male group C   some high school     standard
    ## 663  female group D       some college free/reduced
    ## 664  female group C        high school     standard
    ## 665    male group D associate's degree     standard
    ## 666  female group C   some high school free/reduced
    ## 667  female group C       some college free/reduced
    ## 668  female group B  bachelor's degree free/reduced
    ## 669    male group C       some college     standard
    ## 670    male group D associate's degree     standard
    ## 671  female group C        high school free/reduced
    ## 672    male group D associate's degree free/reduced
    ## 673  female group C       some college     standard
    ## 674  female group C associate's degree     standard
    ## 675  female group D        high school     standard
    ## 676  female group B       some college     standard
    ## 677  female group E       some college     standard
    ## 678  female group C   some high school     standard
    ## 679    male group D associate's degree free/reduced
    ## 680    male group D       some college free/reduced
    ## 681  female group D        high school     standard
    ## 682    male group B        high school     standard
    ## 683    male group B        high school     standard
    ## 684  female group C   some high school free/reduced
    ## 685    male group B       some college     standard
    ## 686  female group E    master's degree     standard
    ## 687    male group E       some college     standard
    ## 688    male group D associate's degree free/reduced
    ## 689    male group A        high school free/reduced
    ## 690    male group E       some college free/reduced
    ## 691  female group C associate's degree     standard
    ## 692  female group E associate's degree free/reduced
    ## 693  female group C  bachelor's degree free/reduced
    ## 694  female group D associate's degree     standard
    ## 695  female group C   some high school     standard
    ## 696  female group D       some college free/reduced
    ## 697  female group C associate's degree     standard
    ## 698  female group A  bachelor's degree     standard
    ## 699  female group D associate's degree     standard
    ## 700    male group C        high school free/reduced
    ## 701  female group E  bachelor's degree     standard
    ## 702  female group B   some high school     standard
    ## 703    male group A  bachelor's degree     standard
    ## 704  female group D       some college     standard
    ## 705  female group B   some high school free/reduced
    ## 706    male group A  bachelor's degree free/reduced
    ## 707    male group D        high school     standard
    ## 708    male group C       some college     standard
    ## 709    male group D        high school     standard
    ## 710  female group D associate's degree free/reduced
    ## 711    male group C       some college     standard
    ## 712  female group E   some high school     standard
    ## 713  female group D       some college     standard
    ## 714    male group D    master's degree     standard
    ## 715  female group B   some high school     standard
    ## 716  female group B associate's degree free/reduced
    ## 717    male group C associate's degree     standard
    ## 718  female group C associate's degree     standard
    ## 719  female group C        high school     standard
    ## 720    male group E associate's degree free/reduced
    ## 721  female group C       some college free/reduced
    ## 722    male group D   some high school free/reduced
    ## 723  female group B   some high school free/reduced
    ## 724    male group C        high school     standard
    ## 725    male group B       some college     standard
    ## 726    male group E       some college     standard
    ## 727  female group E associate's degree     standard
    ## 728    male group E   some high school     standard
    ## 729  female group D        high school free/reduced
    ## 730    male group C       some college     standard
    ## 731  female group B associate's degree free/reduced
    ## 732    male group A   some high school free/reduced
    ## 733  female group C       some college     standard
    ## 734    male group D   some high school     standard
    ## 735  female group E       some college free/reduced
    ## 736    male group C    master's degree     standard
    ## 737    male group C associate's degree     standard
    ## 738  female group B       some college free/reduced
    ## 739    male group D associate's degree     standard
    ## 740    male group C        high school free/reduced
    ## 741    male group D  bachelor's degree     standard
    ## 742  female group A associate's degree free/reduced
    ## 743  female group C        high school     standard
    ## 744  female group C associate's degree     standard
    ## 745    male group B       some college free/reduced
    ## 746    male group D associate's degree     standard
    ## 747    male group D        high school     standard
    ## 748    male group C       some college     standard
    ## 749  female group C  bachelor's degree free/reduced
    ## 750    male group B       some college     standard
    ## 751    male group D   some high school     standard
    ## 752    male group E       some college     standard
    ## 753    male group C    master's degree free/reduced
    ## 754  female group C   some high school     standard
    ## 755    male group C associate's degree free/reduced
    ## 756  female group E associate's degree     standard
    ## 757    male group D       some college     standard
    ## 758    male group E  bachelor's degree free/reduced
    ## 759  female group D       some college free/reduced
    ## 760    male group B       some college     standard
    ## 761  female group C        high school free/reduced
    ## 762  female group D   some high school     standard
    ## 763    male group D   some high school     standard
    ## 764  female group B        high school     standard
    ## 765    male group D       some college     standard
    ## 766  female group B        high school     standard
    ## 767  female group C        high school     standard
    ## 768    male group B        high school     standard
    ## 769  female group D   some high school     standard
    ## 770    male group A       some college free/reduced
    ## 771    male group B        high school     standard
    ## 772    male group D  bachelor's degree     standard
    ## 773  female group B   some high school free/reduced
    ## 774  female group C  bachelor's degree free/reduced
    ## 775    male group B       some college     standard
    ## 776  female group B   some high school free/reduced
    ## 777  female group B        high school     standard
    ## 778  female group C       some college free/reduced
    ## 779  female group A       some college     standard
    ## 780    male group E associate's degree     standard
    ## 781  female group D associate's degree free/reduced
    ## 782  female group B    master's degree     standard
    ## 783  female group B        high school free/reduced
    ## 784  female group C associate's degree     standard
    ## 785    male group C  bachelor's degree     standard
    ## 786  female group B   some high school     standard
    ## 787  female group E   some high school free/reduced
    ## 788  female group B       some college     standard
    ## 789    male group C associate's degree free/reduced
    ## 790  female group C    master's degree free/reduced
    ## 791  female group B        high school     standard
    ## 792  female group D       some college free/reduced
    ## 793    male group D        high school free/reduced
    ## 794    male group E   some high school     standard
    ## 795  female group B        high school     standard
    ## 796  female group E associate's degree free/reduced
    ## 797    male group D        high school     standard
    ## 798  female group E associate's degree free/reduced
    ## 799    male group E       some college     standard
    ## 800  female group C associate's degree     standard
    ## 801    male group C   some high school     standard
    ## 802    male group C   some high school     standard
    ## 803  female group E associate's degree     standard
    ## 804  female group B       some college     standard
    ## 805  female group C       some college     standard
    ## 806    male group A       some college free/reduced
    ## 807  female group D       some college free/reduced
    ## 808  female group E        high school free/reduced
    ## 809    male group C        high school     standard
    ## 810    male group B  bachelor's degree     standard
    ## 811    male group A   some high school     standard
    ## 812    male group A        high school free/reduced
    ## 813  female group C    master's degree     standard
    ## 814    male group E   some high school     standard
    ## 815  female group C        high school     standard
    ## 816    male group B   some high school     standard
    ## 817  female group A  bachelor's degree     standard
    ## 818    male group D  bachelor's degree free/reduced
    ## 819  female group B        high school free/reduced
    ## 820  female group C   some high school     standard
    ## 821  female group A   some high school     standard
    ## 822  female group D  bachelor's degree free/reduced
    ## 823    male group E       some college free/reduced
    ## 824  female group B        high school free/reduced
    ## 825  female group C   some high school free/reduced
    ## 826    male group C        high school     standard
    ## 827  female group C associate's degree free/reduced
    ## 828  female group C   some high school     standard
    ## 829  female group D   some high school free/reduced
    ## 830    male group B   some high school     standard
    ## 831  female group A       some college free/reduced
    ## 832  female group C  bachelor's degree free/reduced
    ## 833    male group A  bachelor's degree     standard
    ## 834  female group B        high school     standard
    ## 835    male group B       some college     standard
    ## 836  female group C        high school     standard
    ## 837    male group E        high school     standard
    ## 838  female group A        high school     standard
    ## 839    male group B associate's degree free/reduced
    ## 840  female group C associate's degree     standard
    ## 841  female group D        high school free/reduced
    ## 842    male group C   some high school     standard
    ## 843  female group B        high school free/reduced
    ## 844    male group B       some college free/reduced
    ## 845  female group D   some high school free/reduced
    ## 846    male group E    master's degree     standard
    ## 847    male group C    master's degree     standard
    ## 848    male group D        high school     standard
    ## 849  female group C        high school     standard
    ## 850    male group D associate's degree     standard
    ## 851    male group C    master's degree     standard
    ## 852  female group A        high school     standard
    ## 853  female group E       some college     standard
    ## 854    male group E   some high school     standard
    ## 855    male group C   some high school     standard
    ## 856  female group B  bachelor's degree     standard
    ## 857    male group B       some college free/reduced
    ## 858  female group C  bachelor's degree     standard
    ## 859    male group B        high school     standard
    ## 860    male group C associate's degree free/reduced
    ## 861  female group C associate's degree     standard
    ## 862  female group E    master's degree free/reduced
    ## 863    male group D  bachelor's degree free/reduced
    ## 864  female group C       some college     standard
    ## 865    male group C associate's degree     standard
    ## 866    male group D       some college     standard
    ## 867    male group C        high school free/reduced
    ## 868    male group B associate's degree     standard
    ## 869    male group E associate's degree free/reduced
    ## 870    male group C associate's degree free/reduced
    ## 871    male group B        high school     standard
    ## 872  female group C       some college     standard
    ## 873    male group B associate's degree     standard
    ## 874    male group E associate's degree free/reduced
    ## 875  female group C  bachelor's degree free/reduced
    ## 876    male group C       some college free/reduced
    ## 877    male group D       some college     standard
    ## 878    male group C   some high school     standard
    ## 879  female group D   some high school     standard
    ## 880  female group D associate's degree     standard
    ## 881    male group C  bachelor's degree     standard
    ## 882  female group E  bachelor's degree     standard
    ## 883  female group B        high school free/reduced
    ## 884    male group D  bachelor's degree free/reduced
    ## 885  female group E associate's degree     standard
    ## 886  female group C associate's degree     standard
    ## 887  female group E associate's degree     standard
    ## 888    male group C        high school free/reduced
    ## 889  female group D       some college free/reduced
    ## 890    male group D        high school free/reduced
    ## 891  female group E       some college     standard
    ## 892  female group E associate's degree     standard
    ## 893  female group A    master's degree free/reduced
    ## 894    male group D   some high school     standard
    ## 895  female group E associate's degree     standard
    ## 896  female group E   some high school free/reduced
    ## 897    male group B        high school free/reduced
    ## 898  female group B   some high school free/reduced
    ## 899    male group D associate's degree     standard
    ## 900  female group D   some high school     standard
    ## 901    male group D    master's degree     standard
    ## 902  female group C    master's degree     standard
    ## 903  female group A        high school free/reduced
    ## 904  female group D  bachelor's degree free/reduced
    ## 905  female group D   some high school free/reduced
    ## 906    male group D       some college     standard
    ## 907    male group B        high school     standard
    ## 908  female group D       some college     standard
    ## 909  female group C  bachelor's degree free/reduced
    ## 910    male group E  bachelor's degree     standard
    ## 911    male group D  bachelor's degree free/reduced
    ## 912  female group A       some college     standard
    ## 913  female group C  bachelor's degree     standard
    ## 914  female group C  bachelor's degree free/reduced
    ## 915  female group B associate's degree free/reduced
    ## 916  female group E       some college     standard
    ## 917    male group E  bachelor's degree     standard
    ## 918  female group C        high school     standard
    ## 919  female group C associate's degree     standard
    ## 920    male group B       some college     standard
    ## 921    male group D        high school free/reduced
    ## 922  female group C        high school free/reduced
    ## 923    male group D        high school     standard
    ## 924  female group B associate's degree free/reduced
    ## 925    male group D        high school free/reduced
    ## 926    male group E   some high school     standard
    ## 927    male group E associate's degree free/reduced
    ## 928  female group D        high school free/reduced
    ## 929    male group E associate's degree free/reduced
    ## 930  female group C   some high school free/reduced
    ## 931    male group C       some college free/reduced
    ## 932    male group D       some college free/reduced
    ## 933    male group D associate's degree free/reduced
    ## 934    male group C  bachelor's degree free/reduced
    ## 935    male group C associate's degree     standard
    ## 936    male group D       some college free/reduced
    ## 937    male group A associate's degree     standard
    ## 938  female group E        high school free/reduced
    ## 939    male group D       some college     standard
    ## 940    male group D   some high school     standard
    ## 941    male group C    master's degree free/reduced
    ## 942  female group D    master's degree     standard
    ## 943    male group C        high school     standard
    ## 944    male group A   some high school free/reduced
    ## 945  female group B        high school     standard
    ## 946  female group C associate's degree     standard
    ## 947    male group B        high school     standard
    ## 948  female group D       some college free/reduced
    ## 949    male group B   some high school free/reduced
    ## 950  female group E        high school free/reduced
    ## 951    male group E        high school     standard
    ## 952  female group D       some college     standard
    ## 953  female group E   some high school free/reduced
    ## 954    male group C        high school     standard
    ## 955  female group C       some college     standard
    ## 956    male group E associate's degree     standard
    ## 957    male group C       some college     standard
    ## 958  female group D    master's degree     standard
    ## 959  female group D        high school     standard
    ## 960    male group C        high school     standard
    ## 961  female group A       some college     standard
    ## 962  female group D   some high school free/reduced
    ## 963  female group E associate's degree     standard
    ## 964  female group C   some high school free/reduced
    ## 965    male group D       some college     standard
    ## 966  female group D       some college     standard
    ## 967    male group A   some high school     standard
    ## 968    male group C       some college     standard
    ## 969  female group E associate's degree     standard
    ## 970  female group B  bachelor's degree     standard
    ## 971  female group D  bachelor's degree     standard
    ## 972    male group C   some high school     standard
    ## 973  female group A        high school free/reduced
    ## 974  female group D       some college free/reduced
    ## 975  female group A       some college     standard
    ## 976  female group C       some college     standard
    ## 977    male group B       some college free/reduced
    ## 978    male group C associate's degree     standard
    ## 979    male group D        high school     standard
    ## 980  female group C associate's degree     standard
    ## 981  female group B        high school free/reduced
    ## 982    male group D   some high school     standard
    ## 983    male group B   some high school     standard
    ## 984  female group A       some college     standard
    ## 985  female group C   some high school     standard
    ## 986    male group A        high school     standard
    ## 987  female group C associate's degree     standard
    ## 988    male group E   some high school     standard
    ## 989  female group A   some high school free/reduced
    ## 990  female group D       some college free/reduced
    ## 991    male group E        high school free/reduced
    ## 992  female group B   some high school     standard
    ## 993  female group D associate's degree free/reduced
    ## 994  female group D  bachelor's degree free/reduced
    ## 995    male group A        high school     standard
    ## 996  female group E    master's degree     standard
    ## 997    male group C        high school free/reduced
    ## 998  female group C        high school free/reduced
    ## 999  female group D       some college     standard
    ## 1000 female group D       some college free/reduced
    ## 1001 female group B  bachelor's degree     standard
    ## 1002 female group C       some college     standard
    ## 1003 female group B    master's degree     standard
    ## 1004   male group A associate's degree free/reduced
    ## 1005   male group C       some college     standard
    ## 1006 female group B associate's degree     standard
    ## 1007 female group B       some college     standard
    ## 1008   male group B       some college free/reduced
    ## 1009   male group D        high school free/reduced
    ## 1010 female group B        high school free/reduced
    ## 1011   male group C associate's degree     standard
    ## 1012   male group D associate's degree     standard
    ## 1013 female group B        high school     standard
    ## 1014   male group A       some college     standard
    ## 1015 female group A    master's degree     standard
    ## 1016 female group C   some high school     standard
    ## 1017   male group C        high school     standard
    ## 1018 female group B   some high school free/reduced
    ## 1019   male group C    master's degree free/reduced
    ## 1020 female group C associate's degree free/reduced
    ## 1021   male group D        high school     standard
    ## 1022 female group B       some college free/reduced
    ## 1023   male group D       some college     standard
    ## 1024 female group C   some high school     standard
    ## 1025   male group D  bachelor's degree free/reduced
    ## 1026   male group A    master's degree free/reduced
    ## 1027   male group B       some college     standard
    ## 1028 female group C  bachelor's degree     standard
    ## 1029   male group C        high school     standard
    ## 1030 female group D    master's degree     standard
    ## 1031 female group D       some college     standard
    ## 1032 female group B       some college     standard
    ## 1033 female group E    master's degree free/reduced
    ## 1034   male group D       some college     standard
    ## 1035   male group E       some college     standard
    ## 1036   male group E associate's degree     standard
    ## 1037 female group D associate's degree     standard
    ## 1038 female group D   some high school free/reduced
    ## 1039 female group D associate's degree free/reduced
    ## 1040   male group B associate's degree free/reduced
    ## 1041   male group C associate's degree free/reduced
    ## 1042 female group C associate's degree     standard
    ## 1043 female group B associate's degree     standard
    ## 1044   male group B       some college free/reduced
    ## 1045 female group E associate's degree free/reduced
    ## 1046   male group B associate's degree     standard
    ## 1047 female group A associate's degree     standard
    ## 1048 female group C        high school     standard
    ## 1049 female group D associate's degree free/reduced
    ## 1050   male group C        high school     standard
    ## 1051   male group E       some college     standard
    ## 1052   male group E associate's degree free/reduced
    ## 1053   male group C       some college     standard
    ## 1054   male group D        high school     standard
    ## 1055 female group C   some high school free/reduced
    ## 1056 female group C        high school free/reduced
    ## 1057 female group E associate's degree     standard
    ## 1058   male group D associate's degree     standard
    ## 1059   male group D       some college     standard
    ## 1060 female group C   some high school free/reduced
    ## 1061   male group E  bachelor's degree free/reduced
    ## 1062   male group A   some high school free/reduced
    ## 1063   male group A associate's degree free/reduced
    ## 1064 female group C associate's degree     standard
    ## 1065 female group D   some high school     standard
    ## 1066   male group B   some high school     standard
    ## 1067   male group D   some high school free/reduced
    ## 1068 female group C       some college     standard
    ## 1069   male group B associate's degree free/reduced
    ## 1070 female group C associate's degree     standard
    ## 1071 female group D       some college free/reduced
    ## 1072   male group D       some college     standard
    ## 1073 female group A associate's degree free/reduced
    ## 1074   male group C   some high school free/reduced
    ## 1075   male group C   some high school     standard
    ## 1076   male group B associate's degree free/reduced
    ## 1077   male group E   some high school     standard
    ## 1078   male group A  bachelor's degree     standard
    ## 1079 female group D   some high school     standard
    ## 1080 female group E    master's degree     standard
    ## 1081 female group B associate's degree     standard
    ## 1082   male group B        high school free/reduced
    ## 1083   male group A       some college free/reduced
    ## 1084   male group E associate's degree     standard
    ## 1085   male group D        high school free/reduced
    ## 1086 female group C       some college     standard
    ## 1087 female group C       some college free/reduced
    ## 1088 female group D associate's degree     standard
    ## 1089 female group A       some college     standard
    ## 1090 female group D   some high school     standard
    ## 1091 female group C  bachelor's degree     standard
    ## 1092   male group C        high school free/reduced
    ## 1093   male group C        high school     standard
    ## 1094   male group C associate's degree free/reduced
    ## 1095 female group B       some college     standard
    ## 1096   male group C associate's degree free/reduced
    ## 1097   male group B   some high school     standard
    ## 1098 female group E       some college     standard
    ## 1099 female group D       some college free/reduced
    ## 1100 female group D  bachelor's degree     standard
    ## 1101   male group B       some college     standard
    ## 1102   male group D  bachelor's degree     standard
    ## 1103 female group D associate's degree     standard
    ## 1104   male group B        high school     standard
    ## 1105   male group C       some college     standard
    ## 1106 female group C       some college     standard
    ## 1107 female group D    master's degree     standard
    ## 1108   male group E associate's degree     standard
    ## 1109 female group B associate's degree free/reduced
    ## 1110 female group B   some high school     standard
    ## 1111 female group D associate's degree free/reduced
    ## 1112   male group C        high school     standard
    ## 1113   male group A associate's degree     standard
    ## 1114 female group D       some college     standard
    ## 1115 female group E  bachelor's degree     standard
    ## 1116   male group C        high school     standard
    ## 1117 female group B  bachelor's degree free/reduced
    ## 1118 female group D  bachelor's degree     standard
    ## 1119 female group D   some high school     standard
    ## 1120 female group C       some college     standard
    ## 1121 female group C  bachelor's degree     standard
    ## 1122   male group B associate's degree     standard
    ## 1123 female group C       some college     standard
    ## 1124   male group D        high school free/reduced
    ## 1125   male group E       some college     standard
    ## 1126 female group B        high school     standard
    ## 1127   male group B   some high school     standard
    ## 1128   male group D       some college     standard
    ## 1129   male group D    master's degree     standard
    ## 1130 female group A  bachelor's degree     standard
    ## 1131   male group D    master's degree     standard
    ## 1132   male group C   some high school free/reduced
    ## 1133   male group E       some college free/reduced
    ## 1134 female group C       some college     standard
    ## 1135   male group D  bachelor's degree free/reduced
    ## 1136   male group C  bachelor's degree     standard
    ## 1137   male group B   some high school     standard
    ## 1138   male group E        high school     standard
    ## 1139 female group C associate's degree     standard
    ## 1140   male group D       some college     standard
    ## 1141 female group D   some high school     standard
    ## 1142 female group C       some college free/reduced
    ## 1143 female group E       some college free/reduced
    ## 1144   male group A        high school     standard
    ## 1145   male group D       some college     standard
    ## 1146 female group C       some college free/reduced
    ## 1147   male group B   some high school     standard
    ## 1148   male group C associate's degree free/reduced
    ## 1149 female group D  bachelor's degree     standard
    ## 1150   male group E associate's degree free/reduced
    ## 1151   male group A   some high school     standard
    ## 1152   male group A  bachelor's degree     standard
    ## 1153 female group B associate's degree     standard
    ## 1154   male group D  bachelor's degree     standard
    ## 1155   male group D   some high school     standard
    ## 1156 female group C       some college     standard
    ## 1157 female group E        high school free/reduced
    ## 1158   male group B       some college free/reduced
    ## 1159 female group B associate's degree     standard
    ## 1160   male group D associate's degree free/reduced
    ## 1161   male group B associate's degree free/reduced
    ## 1162 female group E       some college free/reduced
    ## 1163   male group B    master's degree free/reduced
    ## 1164   male group C        high school     standard
    ## 1165 female group E    master's degree     standard
    ## 1166 female group C  bachelor's degree     standard
    ## 1167   male group C        high school free/reduced
    ## 1168 female group B    master's degree free/reduced
    ## 1169 female group B        high school     standard
    ## 1170 female group C       some college free/reduced
    ## 1171   male group A        high school     standard
    ## 1172   male group E   some high school     standard
    ## 1173 female group D       some college     standard
    ## 1174 female group C associate's degree     standard
    ## 1175 female group C  bachelor's degree free/reduced
    ## 1176 female group C    master's degree     standard
    ## 1177 female group B        high school free/reduced
    ## 1178 female group C associate's degree     standard
    ## 1179 female group B    master's degree free/reduced
    ## 1180 female group D   some high school     standard
    ## 1181   male group C    master's degree free/reduced
    ## 1182 female group C       some college free/reduced
    ## 1183 female group E        high school     standard
    ## 1184 female group D associate's degree     standard
    ## 1185   male group C   some high school free/reduced
    ## 1186   male group C associate's degree free/reduced
    ## 1187   male group E        high school     standard
    ## 1188   male group D   some high school     standard
    ## 1189   male group B   some high school free/reduced
    ## 1190 female group C  bachelor's degree     standard
    ## 1191 female group E associate's degree     standard
    ## 1192   male group D       some college     standard
    ## 1193 female group B   some high school     standard
    ## 1194   male group D       some college     standard
    ## 1195 female group C    master's degree     standard
    ## 1196   male group D associate's degree     standard
    ## 1197   male group C   some high school free/reduced
    ## 1198   male group E        high school free/reduced
    ## 1199 female group B       some college free/reduced
    ## 1200 female group B  bachelor's degree free/reduced
    ## 1201 female group C associate's degree     standard
    ## 1202 female group D       some college free/reduced
    ## 1203   male group C associate's degree     standard
    ## 1204 female group B associate's degree     standard
    ## 1205   male group C       some college     standard
    ## 1206   male group D   some high school     standard
    ## 1207   male group E  bachelor's degree     standard
    ## 1208   male group E        high school     standard
    ## 1209 female group B       some college free/reduced
    ## 1210 female group B       some college free/reduced
    ## 1211   male group D   some high school free/reduced
    ## 1212   male group C       some college free/reduced
    ## 1213 female group C        high school free/reduced
    ## 1214   male group C associate's degree free/reduced
    ## 1215   male group E        high school     standard
    ## 1216   male group B   some high school     standard
    ## 1217 female group E associate's degree free/reduced
    ## 1218 female group C        high school free/reduced
    ## 1219   male group B        high school free/reduced
    ## 1220   male group B   some high school     standard
    ## 1221 female group D        high school     standard
    ## 1222   male group B associate's degree     standard
    ## 1223 female group C   some high school free/reduced
    ## 1224   male group D   some high school     standard
    ## 1225 female group B associate's degree     standard
    ## 1226 female group E    master's degree free/reduced
    ## 1227 female group C       some college     standard
    ## 1228   male group D        high school     standard
    ## 1229   male group A   some high school free/reduced
    ## 1230 female group C       some college     standard
    ## 1231   male group D       some college     standard
    ## 1232   male group C associate's degree     standard
    ## 1233 female group B  bachelor's degree     standard
    ## 1234   male group E   some high school     standard
    ## 1235   male group C  bachelor's degree     standard
    ## 1236   male group D associate's degree     standard
    ## 1237   male group D  bachelor's degree free/reduced
    ## 1238 female group D   some high school     standard
    ## 1239   male group B       some college     standard
    ## 1240   male group C associate's degree     standard
    ## 1241   male group D        high school free/reduced
    ## 1242 female group E  bachelor's degree     standard
    ## 1243 female group D        high school     standard
    ## 1244   male group E       some college     standard
    ## 1245   male group D   some high school     standard
    ## 1246   male group C associate's degree     standard
    ## 1247   male group E associate's degree     standard
    ## 1248 female group B        high school     standard
    ## 1249 female group B        high school     standard
    ## 1250   male group C        high school     standard
    ## 1251   male group A   some high school     standard
    ## 1252 female group D       some college free/reduced
    ## 1253 female group B   some high school     standard
    ## 1254   male group D    master's degree     standard
    ## 1255   male group D        high school     standard
    ## 1256 female group E       some college     standard
    ## 1257 female group C associate's degree free/reduced
    ## 1258   male group C associate's degree     standard
    ## 1259 female group B       some college     standard
    ## 1260 female group C    master's degree free/reduced
    ## 1261 female group C   some high school free/reduced
    ## 1262   male group C       some college     standard
    ## 1263 female group C   some high school free/reduced
    ## 1264 female group E        high school     standard
    ## 1265   male group D        high school     standard
    ## 1266   male group D   some high school free/reduced
    ## 1267 female group C  bachelor's degree     standard
    ## 1268 female group D        high school     standard
    ## 1269 female group D associate's degree     standard
    ## 1270 female group E       some college free/reduced
    ## 1271   male group C  bachelor's degree     standard
    ## 1272   male group C       some college     standard
    ## 1273 female group D associate's degree free/reduced
    ## 1274 female group D       some college     standard
    ## 1275   male group B       some college     standard
    ## 1276   male group C  bachelor's degree     standard
    ## 1277 female group C   some high school     standard
    ## 1278 female group E        high school     standard
    ## 1279 female group C   some high school free/reduced
    ## 1280   male group B  bachelor's degree free/reduced
    ## 1281   male group D        high school     standard
    ## 1282   male group D        high school     standard
    ## 1283 female group D  bachelor's degree free/reduced
    ## 1284 female group D       some college free/reduced
    ## 1285 female group B   some high school     standard
    ## 1286   male group B associate's degree     standard
    ## 1287   male group E associate's degree     standard
    ## 1288 female group B   some high school     standard
    ## 1289   male group B  bachelor's degree free/reduced
    ## 1290   male group E   some high school     standard
    ## 1291   male group C associate's degree     standard
    ## 1292   male group D   some high school     standard
    ## 1293   male group C   some high school     standard
    ## 1294 female group E  bachelor's degree     standard
    ## 1295   male group D        high school free/reduced
    ## 1296   male group B associate's degree free/reduced
    ## 1297   male group A   some high school     standard
    ## 1298   male group E associate's degree     standard
    ## 1299   male group C        high school free/reduced
    ## 1300   male group D associate's degree free/reduced
    ## 1301   male group A       some college free/reduced
    ## 1302   male group D   some high school free/reduced
    ## 1303 female group C associate's degree     standard
    ## 1304   male group B associate's degree     standard
    ## 1305 female group C associate's degree     standard
    ## 1306   male group A       some college     standard
    ## 1307   male group E       some college     standard
    ## 1308   male group C   some high school     standard
    ## 1309 female group B associate's degree free/reduced
    ## 1310 female group D        high school free/reduced
    ## 1311 female group B associate's degree     standard
    ## 1312   male group B  bachelor's degree     standard
    ## 1313   male group D  bachelor's degree     standard
    ## 1314 female group C associate's degree free/reduced
    ## 1315 female group C  bachelor's degree     standard
    ## 1316   male group C        high school     standard
    ## 1317 female group D    master's degree     standard
    ## 1318   male group C associate's degree     standard
    ## 1319   male group B  bachelor's degree     standard
    ## 1320 female group D associate's degree free/reduced
    ## 1321 female group C        high school free/reduced
    ## 1322 female group E        high school     standard
    ## 1323 female group C       some college     standard
    ## 1324 female group C   some high school free/reduced
    ## 1325 female group C        high school free/reduced
    ## 1326 female group C       some college     standard
    ## 1327   male group C       some college     standard
    ## 1328   male group A       some college free/reduced
    ## 1329   male group C associate's degree     standard
    ## 1330 female group B   some high school     standard
    ## 1331   male group C        high school     standard
    ## 1332   male group C associate's degree     standard
    ## 1333   male group E associate's degree     standard
    ## 1334   male group B associate's degree     standard
    ## 1335 female group C  bachelor's degree     standard
    ## 1336 female group B       some college free/reduced
    ## 1337   male group D   some high school     standard
    ## 1338   male group C associate's degree     standard
    ## 1339 female group B   some high school free/reduced
    ## 1340 female group D   some high school free/reduced
    ## 1341   male group C        high school free/reduced
    ## 1342 female group C        high school     standard
    ## 1343 female group B        high school     standard
    ## 1344   male group D associate's degree     standard
    ## 1345   male group D       some college     standard
    ## 1346 female group C        high school     standard
    ## 1347   male group B       some college     standard
    ## 1348 female group C  bachelor's degree     standard
    ## 1349   male group D        high school free/reduced
    ## 1350   male group E associate's degree     standard
    ## 1351 female group B  bachelor's degree     standard
    ## 1352   male group E       some college     standard
    ## 1353 female group C       some college     standard
    ## 1354 female group C associate's degree     standard
    ## 1355 female group C       some college     standard
    ## 1356 female group B  bachelor's degree     standard
    ## 1357   male group A associate's degree     standard
    ## 1358 female group C       some college free/reduced
    ## 1359   male group D       some college free/reduced
    ## 1360 female group D       some college     standard
    ## 1361 female group B        high school     standard
    ## 1362   male group B   some high school     standard
    ## 1363 female group C       some college     standard
    ## 1364 female group D   some high school free/reduced
    ## 1365   male group C       some college     standard
    ## 1366   male group A  bachelor's degree free/reduced
    ## 1367   male group C        high school     standard
    ## 1368   male group C  bachelor's degree free/reduced
    ## 1369 female group A   some high school free/reduced
    ## 1370 female group D   some high school     standard
    ## 1371   male group E       some college     standard
    ## 1372 female group C       some college free/reduced
    ## 1373   male group D   some high school     standard
    ## 1374 female group D       some college     standard
    ## 1375 female group D  bachelor's degree     standard
    ## 1376   male group E associate's degree free/reduced
    ## 1377 female group D   some high school     standard
    ## 1378 female group D    master's degree free/reduced
    ## 1379 female group A   some high school     standard
    ## 1380   male group A  bachelor's degree     standard
    ## 1381 female group B associate's degree     standard
    ## 1382   male group C associate's degree     standard
    ## 1383   male group C    master's degree free/reduced
    ## 1384 female group E   some high school free/reduced
    ## 1385 female group A   some high school free/reduced
    ## 1386 female group E       some college     standard
    ## 1387 female group E  bachelor's degree     standard
    ## 1388 female group C associate's degree free/reduced
    ## 1389 female group D        high school     standard
    ## 1390   male group D    master's degree     standard
    ## 1391   male group E   some high school free/reduced
    ## 1392 female group D       some college     standard
    ## 1393   male group E       some college     standard
    ## 1394   male group C associate's degree     standard
    ## 1395 female group C   some high school     standard
    ## 1396   male group A        high school free/reduced
    ## 1397 female group B        high school free/reduced
    ## 1398 female group C associate's degree     standard
    ## 1399   male group B   some high school     standard
    ## 1400   male group D   some high school     standard
    ## 1401 female group C   some high school     standard
    ## 1402   male group A       some college     standard
    ## 1403 female group A       some college free/reduced
    ## 1404 female group D        high school     standard
    ## 1405 female group C        high school     standard
    ## 1406 female group C   some high school     standard
    ## 1407   male group B associate's degree     standard
    ## 1408 female group B associate's degree     standard
    ## 1409 female group D        high school free/reduced
    ## 1410   male group D associate's degree     standard
    ## 1411 female group D    master's degree     standard
    ## 1412   male group E       some college     standard
    ## 1413   male group D associate's degree     standard
    ## 1414   male group B   some high school     standard
    ## 1415 female group C  bachelor's degree free/reduced
    ## 1416   male group E        high school     standard
    ## 1417   male group C  bachelor's degree     standard
    ## 1418   male group C associate's degree     standard
    ## 1419   male group D       some college     standard
    ## 1420   male group E        high school free/reduced
    ## 1421 female group C associate's degree free/reduced
    ## 1422 female group D        high school     standard
    ## 1423 female group D    master's degree free/reduced
    ## 1424 female group A   some high school     standard
    ## 1425   male group B       some college free/reduced
    ## 1426 female group C       some college free/reduced
    ## 1427   male group C  bachelor's degree     standard
    ## 1428   male group C   some high school free/reduced
    ## 1429   male group A   some high school free/reduced
    ## 1430   male group C   some high school free/reduced
    ## 1431   male group C associate's degree free/reduced
    ## 1432 female group C        high school     standard
    ## 1433   male group C        high school     standard
    ## 1434 female group A   some high school free/reduced
    ## 1435   male group C   some high school     standard
    ## 1436   male group C       some college free/reduced
    ## 1437   male group D associate's degree     standard
    ## 1438   male group D associate's degree free/reduced
    ## 1439   male group C        high school     standard
    ## 1440   male group D   some high school     standard
    ## 1441 female group C       some college     standard
    ## 1442 female group D        high school     standard
    ## 1443 female group A   some high school free/reduced
    ## 1444 female group B associate's degree     standard
    ## 1445   male group A   some high school free/reduced
    ## 1446 female group C   some high school     standard
    ## 1447   male group D       some college free/reduced
    ## 1448   male group C        high school     standard
    ## 1449   male group B        high school     standard
    ## 1450   male group B associate's degree     standard
    ## 1451 female group C       some college free/reduced
    ## 1452 female group E       some college     standard
    ## 1453 female group C associate's degree free/reduced
    ## 1454   male group C       some college free/reduced
    ## 1455 female group C associate's degree free/reduced
    ## 1456   male group C  bachelor's degree free/reduced
    ## 1457 female group D  bachelor's degree     standard
    ## 1458   male group D associate's degree free/reduced
    ## 1459 female group E  bachelor's degree     standard
    ## 1460   male group B        high school     standard
    ## 1461   male group C  bachelor's degree free/reduced
    ## 1462   male group B       some college free/reduced
    ## 1463 female group E       some college     standard
    ## 1464 female group C       some college free/reduced
    ## 1465   male group A  bachelor's degree     standard
    ## 1466 female group C       some college     standard
    ## 1467 female group D associate's degree free/reduced
    ## 1468   male group A        high school free/reduced
    ## 1469 female group A        high school free/reduced
    ## 1470   male group C       some college     standard
    ## 1471 female group C associate's degree     standard
    ## 1472 female group C        high school     standard
    ## 1473 female group C associate's degree     standard
    ## 1474 female group D   some high school     standard
    ## 1475 female group B associate's degree     standard
    ## 1476 female group D  bachelor's degree     standard
    ## 1477   male group E  bachelor's degree     standard
    ## 1478   male group D associate's degree     standard
    ## 1479 female group D    master's degree     standard
    ## 1480   male group E associate's degree     standard
    ## 1481   male group B        high school     standard
    ## 1482 female group D associate's degree free/reduced
    ## 1483   male group C       some college free/reduced
    ## 1484   male group A        high school     standard
    ## 1485 female group B associate's degree     standard
    ## 1486   male group C        high school     standard
    ## 1487   male group D       some college free/reduced
    ## 1488 female group C associate's degree free/reduced
    ## 1489   male group B   some high school     standard
    ## 1490   male group A associate's degree free/reduced
    ## 1491 female group A associate's degree free/reduced
    ## 1492 female group C associate's degree     standard
    ## 1493 female group C       some college     standard
    ## 1494 female group C  bachelor's degree     standard
    ## 1495 female group B        high school     standard
    ## 1496   male group D        high school     standard
    ## 1497 female group C       some college     standard
    ## 1498 female group D       some college free/reduced
    ## 1499 female group B   some high school     standard
    ## 1500   male group E       some college     standard
    ## 1501 female group D    master's degree     standard
    ## 1502 female group B associate's degree     standard
    ## 1503   male group C       some college free/reduced
    ## 1504 female group E associate's degree     standard
    ## 1505 female group D    master's degree free/reduced
    ## 1506 female group B   some high school     standard
    ## 1507   male group A        high school     standard
    ## 1508   male group B  bachelor's degree free/reduced
    ## 1509   male group C    master's degree     standard
    ## 1510 female group C  bachelor's degree     standard
    ## 1511   male group D       some college     standard
    ## 1512   male group A   some high school     standard
    ## 1513   male group D   some high school free/reduced
    ## 1514 female group B   some high school     standard
    ## 1515 female group B    master's degree free/reduced
    ## 1516 female group C   some high school     standard
    ## 1517 female group D       some college     standard
    ## 1518 female group E       some college     standard
    ## 1519 female group D   some high school     standard
    ## 1520 female group B        high school free/reduced
    ## 1521   male group D       some college     standard
    ## 1522 female group C associate's degree     standard
    ## 1523   male group D  bachelor's degree     standard
    ## 1524   male group C    master's degree free/reduced
    ## 1525   male group C        high school     standard
    ## 1526   male group E       some college     standard
    ## 1527   male group C   some high school free/reduced
    ## 1528 female group C        high school free/reduced
    ## 1529 female group D  bachelor's degree free/reduced
    ## 1530 female group C associate's degree     standard
    ## 1531 female group C associate's degree     standard
    ## 1532 female group C   some high school     standard
    ## 1533   male group E associate's degree     standard
    ## 1534 female group E associate's degree     standard
    ## 1535   male group B        high school     standard
    ## 1536 female group C  bachelor's degree free/reduced
    ## 1537   male group C associate's degree     standard
    ## 1538 female group D        high school     standard
    ## 1539   male group E  bachelor's degree     standard
    ## 1540   male group A associate's degree     standard
    ## 1541   male group C        high school     standard
    ## 1542   male group D associate's degree free/reduced
    ## 1543 female group C associate's degree     standard
    ## 1544 female group D associate's degree     standard
    ## 1545 female group D    master's degree     standard
    ## 1546   male group E   some high school free/reduced
    ## 1547 female group A   some high school     standard
    ## 1548   male group C        high school     standard
    ## 1549 female group C        high school free/reduced
    ## 1550   male group C    master's degree     standard
    ## 1551   male group C   some high school free/reduced
    ## 1552   male group B  bachelor's degree free/reduced
    ## 1553 female group B associate's degree     standard
    ## 1554   male group D       some college free/reduced
    ## 1555   male group E associate's degree     standard
    ## 1556 female group C       some college free/reduced
    ## 1557 female group C associate's degree     standard
    ## 1558   male group C    master's degree free/reduced
    ## 1559 female group B associate's degree free/reduced
    ## 1560   male group D   some high school     standard
    ## 1561 female group D       some college     standard
    ## 1562 female group C       some college     standard
    ## 1563   male group C  bachelor's degree     standard
    ## 1564 female group D       some college free/reduced
    ## 1565   male group B  bachelor's degree free/reduced
    ## 1566   male group B associate's degree     standard
    ## 1567 female group E  bachelor's degree free/reduced
    ## 1568 female group D    master's degree free/reduced
    ## 1569   male group B        high school free/reduced
    ## 1570   male group D  bachelor's degree free/reduced
    ## 1571   male group B       some college     standard
    ## 1572   male group A  bachelor's degree     standard
    ## 1573 female group C       some college     standard
    ## 1574 female group C        high school free/reduced
    ## 1575 female group E        high school     standard
    ## 1576   male group A associate's degree free/reduced
    ## 1577   male group A       some college     standard
    ## 1578 female group B        high school     standard
    ## 1579 female group B       some college free/reduced
    ## 1580 female group D    master's degree     standard
    ## 1581 female group D   some high school     standard
    ## 1582 female group E   some high school     standard
    ## 1583 female group D  bachelor's degree free/reduced
    ## 1584 female group D associate's degree     standard
    ## 1585 female group D       some college     standard
    ## 1586 female group C associate's degree     standard
    ## 1587 female group A        high school     standard
    ## 1588 female group C  bachelor's degree free/reduced
    ## 1589 female group C       some college     standard
    ## 1590 female group A   some high school     standard
    ## 1591   male group C       some college free/reduced
    ## 1592   male group A   some high school     standard
    ## 1593   male group E  bachelor's degree     standard
    ## 1594 female group E        high school     standard
    ## 1595 female group C  bachelor's degree     standard
    ## 1596 female group C  bachelor's degree     standard
    ## 1597   male group B        high school free/reduced
    ## 1598   male group A   some high school     standard
    ## 1599 female group D        high school     standard
    ## 1600 female group D   some high school     standard
    ## 1601 female group D    master's degree     standard
    ## 1602 female group C        high school     standard
    ## 1603 female group E       some college     standard
    ## 1604   male group D        high school free/reduced
    ## 1605   male group D    master's degree free/reduced
    ## 1606   male group C   some high school     standard
    ## 1607 female group C associate's degree     standard
    ## 1608 female group C    master's degree free/reduced
    ## 1609 female group E       some college     standard
    ## 1610 female group B associate's degree     standard
    ## 1611   male group D       some college free/reduced
    ## 1612 female group C       some college     standard
    ## 1613   male group C  bachelor's degree     standard
    ## 1614 female group C associate's degree     standard
    ## 1615 female group A associate's degree     standard
    ## 1616 female group C        high school     standard
    ## 1617 female group E  bachelor's degree     standard
    ## 1618   male group D  bachelor's degree     standard
    ## 1619   male group D    master's degree     standard
    ## 1620   male group C associate's degree free/reduced
    ## 1621 female group C        high school free/reduced
    ## 1622   male group B  bachelor's degree free/reduced
    ## 1623   male group C        high school free/reduced
    ## 1624   male group A       some college     standard
    ## 1625 female group E  bachelor's degree free/reduced
    ## 1626   male group D       some college     standard
    ## 1627   male group B associate's degree free/reduced
    ## 1628   male group D associate's degree     standard
    ## 1629   male group D       some college free/reduced
    ## 1630 female group C   some high school     standard
    ## 1631   male group D       some college     standard
    ## 1632   male group B        high school     standard
    ## 1633 female group B  bachelor's degree     standard
    ## 1634 female group C        high school     standard
    ## 1635   male group D   some high school     standard
    ## 1636   male group A        high school     standard
    ## 1637 female group B        high school free/reduced
    ## 1638 female group D   some high school     standard
    ## 1639   male group E       some college     standard
    ## 1640 female group D associate's degree     standard
    ## 1641   male group D        high school     standard
    ## 1642 female group D associate's degree free/reduced
    ## 1643 female group B   some high school free/reduced
    ## 1644 female group E        high school     standard
    ## 1645   male group B        high school     standard
    ## 1646 female group B  bachelor's degree     standard
    ## 1647 female group D associate's degree     standard
    ## 1648 female group E        high school free/reduced
    ## 1649 female group B        high school     standard
    ## 1650 female group D       some college     standard
    ## 1651   male group C   some high school free/reduced
    ## 1652 female group A        high school     standard
    ## 1653 female group D       some college     standard
    ## 1654 female group A associate's degree     standard
    ## 1655 female group B   some high school     standard
    ## 1656 female group B       some college     standard
    ## 1657   male group C associate's degree free/reduced
    ## 1658   male group D   some high school     standard
    ## 1659 female group D associate's degree free/reduced
    ## 1660   male group D associate's degree     standard
    ## 1661   male group C       some college free/reduced
    ## 1662   male group C   some high school     standard
    ## 1663 female group D       some college free/reduced
    ## 1664 female group C        high school     standard
    ## 1665   male group D associate's degree     standard
    ## 1666 female group C   some high school free/reduced
    ## 1667 female group C       some college free/reduced
    ## 1668 female group B  bachelor's degree free/reduced
    ## 1669   male group C       some college     standard
    ## 1670   male group D associate's degree     standard
    ## 1671 female group C        high school free/reduced
    ## 1672   male group D associate's degree free/reduced
    ## 1673 female group C       some college     standard
    ## 1674 female group C associate's degree     standard
    ## 1675 female group D        high school     standard
    ## 1676 female group B       some college     standard
    ## 1677 female group E       some college     standard
    ## 1678 female group C   some high school     standard
    ## 1679   male group D associate's degree free/reduced
    ## 1680   male group D       some college free/reduced
    ## 1681 female group D        high school     standard
    ## 1682   male group B        high school     standard
    ## 1683   male group B        high school     standard
    ## 1684 female group C   some high school free/reduced
    ## 1685   male group B       some college     standard
    ## 1686 female group E    master's degree     standard
    ## 1687   male group E       some college     standard
    ## 1688   male group D associate's degree free/reduced
    ## 1689   male group A        high school free/reduced
    ## 1690   male group E       some college free/reduced
    ## 1691 female group C associate's degree     standard
    ## 1692 female group E associate's degree free/reduced
    ## 1693 female group C  bachelor's degree free/reduced
    ## 1694 female group D associate's degree     standard
    ## 1695 female group C   some high school     standard
    ## 1696 female group D       some college free/reduced
    ## 1697 female group C associate's degree     standard
    ## 1698 female group A  bachelor's degree     standard
    ## 1699 female group D associate's degree     standard
    ## 1700   male group C        high school free/reduced
    ## 1701 female group E  bachelor's degree     standard
    ## 1702 female group B   some high school     standard
    ## 1703   male group A  bachelor's degree     standard
    ## 1704 female group D       some college     standard
    ## 1705 female group B   some high school free/reduced
    ## 1706   male group A  bachelor's degree free/reduced
    ## 1707   male group D        high school     standard
    ## 1708   male group C       some college     standard
    ## 1709   male group D        high school     standard
    ## 1710 female group D associate's degree free/reduced
    ## 1711   male group C       some college     standard
    ## 1712 female group E   some high school     standard
    ## 1713 female group D       some college     standard
    ## 1714   male group D    master's degree     standard
    ## 1715 female group B   some high school     standard
    ## 1716 female group B associate's degree free/reduced
    ## 1717   male group C associate's degree     standard
    ## 1718 female group C associate's degree     standard
    ## 1719 female group C        high school     standard
    ## 1720   male group E associate's degree free/reduced
    ## 1721 female group C       some college free/reduced
    ## 1722   male group D   some high school free/reduced
    ## 1723 female group B   some high school free/reduced
    ## 1724   male group C        high school     standard
    ## 1725   male group B       some college     standard
    ## 1726   male group E       some college     standard
    ## 1727 female group E associate's degree     standard
    ## 1728   male group E   some high school     standard
    ## 1729 female group D        high school free/reduced
    ## 1730   male group C       some college     standard
    ## 1731 female group B associate's degree free/reduced
    ## 1732   male group A   some high school free/reduced
    ## 1733 female group C       some college     standard
    ## 1734   male group D   some high school     standard
    ## 1735 female group E       some college free/reduced
    ## 1736   male group C    master's degree     standard
    ## 1737   male group C associate's degree     standard
    ## 1738 female group B       some college free/reduced
    ## 1739   male group D associate's degree     standard
    ## 1740   male group C        high school free/reduced
    ## 1741   male group D  bachelor's degree     standard
    ## 1742 female group A associate's degree free/reduced
    ## 1743 female group C        high school     standard
    ## 1744 female group C associate's degree     standard
    ## 1745   male group B       some college free/reduced
    ## 1746   male group D associate's degree     standard
    ## 1747   male group D        high school     standard
    ## 1748   male group C       some college     standard
    ## 1749 female group C  bachelor's degree free/reduced
    ## 1750   male group B       some college     standard
    ## 1751   male group D   some high school     standard
    ## 1752   male group E       some college     standard
    ## 1753   male group C    master's degree free/reduced
    ## 1754 female group C   some high school     standard
    ## 1755   male group C associate's degree free/reduced
    ## 1756 female group E associate's degree     standard
    ## 1757   male group D       some college     standard
    ## 1758   male group E  bachelor's degree free/reduced
    ## 1759 female group D       some college free/reduced
    ## 1760   male group B       some college     standard
    ## 1761 female group C        high school free/reduced
    ## 1762 female group D   some high school     standard
    ## 1763   male group D   some high school     standard
    ## 1764 female group B        high school     standard
    ## 1765   male group D       some college     standard
    ## 1766 female group B        high school     standard
    ## 1767 female group C        high school     standard
    ## 1768   male group B        high school     standard
    ## 1769 female group D   some high school     standard
    ## 1770   male group A       some college free/reduced
    ## 1771   male group B        high school     standard
    ## 1772   male group D  bachelor's degree     standard
    ## 1773 female group B   some high school free/reduced
    ## 1774 female group C  bachelor's degree free/reduced
    ## 1775   male group B       some college     standard
    ## 1776 female group B   some high school free/reduced
    ## 1777 female group B        high school     standard
    ## 1778 female group C       some college free/reduced
    ## 1779 female group A       some college     standard
    ## 1780   male group E associate's degree     standard
    ## 1781 female group D associate's degree free/reduced
    ## 1782 female group B    master's degree     standard
    ## 1783 female group B        high school free/reduced
    ## 1784 female group C associate's degree     standard
    ## 1785   male group C  bachelor's degree     standard
    ## 1786 female group B   some high school     standard
    ## 1787 female group E   some high school free/reduced
    ## 1788 female group B       some college     standard
    ## 1789   male group C associate's degree free/reduced
    ## 1790 female group C    master's degree free/reduced
    ## 1791 female group B        high school     standard
    ## 1792 female group D       some college free/reduced
    ## 1793   male group D        high school free/reduced
    ## 1794   male group E   some high school     standard
    ## 1795 female group B        high school     standard
    ## 1796 female group E associate's degree free/reduced
    ## 1797   male group D        high school     standard
    ## 1798 female group E associate's degree free/reduced
    ## 1799   male group E       some college     standard
    ## 1800 female group C associate's degree     standard
    ## 1801   male group C   some high school     standard
    ## 1802   male group C   some high school     standard
    ## 1803 female group E associate's degree     standard
    ## 1804 female group B       some college     standard
    ## 1805 female group C       some college     standard
    ## 1806   male group A       some college free/reduced
    ## 1807 female group D       some college free/reduced
    ## 1808 female group E        high school free/reduced
    ## 1809   male group C        high school     standard
    ## 1810   male group B  bachelor's degree     standard
    ## 1811   male group A   some high school     standard
    ## 1812   male group A        high school free/reduced
    ## 1813 female group C    master's degree     standard
    ## 1814   male group E   some high school     standard
    ## 1815 female group C        high school     standard
    ## 1816   male group B   some high school     standard
    ## 1817 female group A  bachelor's degree     standard
    ## 1818   male group D  bachelor's degree free/reduced
    ## 1819 female group B        high school free/reduced
    ## 1820 female group C   some high school     standard
    ## 1821 female group A   some high school     standard
    ## 1822 female group D  bachelor's degree free/reduced
    ## 1823   male group E       some college free/reduced
    ## 1824 female group B        high school free/reduced
    ## 1825 female group C   some high school free/reduced
    ## 1826   male group C        high school     standard
    ## 1827 female group C associate's degree free/reduced
    ## 1828 female group C   some high school     standard
    ## 1829 female group D   some high school free/reduced
    ## 1830   male group B   some high school     standard
    ## 1831 female group A       some college free/reduced
    ## 1832 female group C  bachelor's degree free/reduced
    ## 1833   male group A  bachelor's degree     standard
    ## 1834 female group B        high school     standard
    ## 1835   male group B       some college     standard
    ## 1836 female group C        high school     standard
    ## 1837   male group E        high school     standard
    ## 1838 female group A        high school     standard
    ## 1839   male group B associate's degree free/reduced
    ## 1840 female group C associate's degree     standard
    ## 1841 female group D        high school free/reduced
    ## 1842   male group C   some high school     standard
    ## 1843 female group B        high school free/reduced
    ## 1844   male group B       some college free/reduced
    ## 1845 female group D   some high school free/reduced
    ## 1846   male group E    master's degree     standard
    ## 1847   male group C    master's degree     standard
    ## 1848   male group D        high school     standard
    ## 1849 female group C        high school     standard
    ## 1850   male group D associate's degree     standard
    ## 1851   male group C    master's degree     standard
    ## 1852 female group A        high school     standard
    ## 1853 female group E       some college     standard
    ## 1854   male group E   some high school     standard
    ## 1855   male group C   some high school     standard
    ## 1856 female group B  bachelor's degree     standard
    ## 1857   male group B       some college free/reduced
    ## 1858 female group C  bachelor's degree     standard
    ## 1859   male group B        high school     standard
    ## 1860   male group C associate's degree free/reduced
    ## 1861 female group C associate's degree     standard
    ## 1862 female group E    master's degree free/reduced
    ## 1863   male group D  bachelor's degree free/reduced
    ## 1864 female group C       some college     standard
    ## 1865   male group C associate's degree     standard
    ## 1866   male group D       some college     standard
    ## 1867   male group C        high school free/reduced
    ## 1868   male group B associate's degree     standard
    ## 1869   male group E associate's degree free/reduced
    ## 1870   male group C associate's degree free/reduced
    ## 1871   male group B        high school     standard
    ## 1872 female group C       some college     standard
    ## 1873   male group B associate's degree     standard
    ## 1874   male group E associate's degree free/reduced
    ## 1875 female group C  bachelor's degree free/reduced
    ## 1876   male group C       some college free/reduced
    ## 1877   male group D       some college     standard
    ## 1878   male group C   some high school     standard
    ## 1879 female group D   some high school     standard
    ## 1880 female group D associate's degree     standard
    ## 1881   male group C  bachelor's degree     standard
    ## 1882 female group E  bachelor's degree     standard
    ## 1883 female group B        high school free/reduced
    ## 1884   male group D  bachelor's degree free/reduced
    ## 1885 female group E associate's degree     standard
    ## 1886 female group C associate's degree     standard
    ## 1887 female group E associate's degree     standard
    ## 1888   male group C        high school free/reduced
    ## 1889 female group D       some college free/reduced
    ## 1890   male group D        high school free/reduced
    ## 1891 female group E       some college     standard
    ## 1892 female group E associate's degree     standard
    ## 1893 female group A    master's degree free/reduced
    ## 1894   male group D   some high school     standard
    ## 1895 female group E associate's degree     standard
    ## 1896 female group E   some high school free/reduced
    ## 1897   male group B        high school free/reduced
    ## 1898 female group B   some high school free/reduced
    ## 1899   male group D associate's degree     standard
    ## 1900 female group D   some high school     standard
    ## 1901   male group D    master's degree     standard
    ## 1902 female group C    master's degree     standard
    ## 1903 female group A        high school free/reduced
    ## 1904 female group D  bachelor's degree free/reduced
    ## 1905 female group D   some high school free/reduced
    ## 1906   male group D       some college     standard
    ## 1907   male group B        high school     standard
    ## 1908 female group D       some college     standard
    ## 1909 female group C  bachelor's degree free/reduced
    ## 1910   male group E  bachelor's degree     standard
    ## 1911   male group D  bachelor's degree free/reduced
    ## 1912 female group A       some college     standard
    ## 1913 female group C  bachelor's degree     standard
    ## 1914 female group C  bachelor's degree free/reduced
    ## 1915 female group B associate's degree free/reduced
    ## 1916 female group E       some college     standard
    ## 1917   male group E  bachelor's degree     standard
    ## 1918 female group C        high school     standard
    ## 1919 female group C associate's degree     standard
    ## 1920   male group B       some college     standard
    ## 1921   male group D        high school free/reduced
    ## 1922 female group C        high school free/reduced
    ## 1923   male group D        high school     standard
    ## 1924 female group B associate's degree free/reduced
    ## 1925   male group D        high school free/reduced
    ## 1926   male group E   some high school     standard
    ## 1927   male group E associate's degree free/reduced
    ## 1928 female group D        high school free/reduced
    ## 1929   male group E associate's degree free/reduced
    ## 1930 female group C   some high school free/reduced
    ## 1931   male group C       some college free/reduced
    ## 1932   male group D       some college free/reduced
    ## 1933   male group D associate's degree free/reduced
    ## 1934   male group C  bachelor's degree free/reduced
    ## 1935   male group C associate's degree     standard
    ## 1936   male group D       some college free/reduced
    ## 1937   male group A associate's degree     standard
    ## 1938 female group E        high school free/reduced
    ## 1939   male group D       some college     standard
    ## 1940   male group D   some high school     standard
    ## 1941   male group C    master's degree free/reduced
    ## 1942 female group D    master's degree     standard
    ## 1943   male group C        high school     standard
    ## 1944   male group A   some high school free/reduced
    ## 1945 female group B        high school     standard
    ## 1946 female group C associate's degree     standard
    ## 1947   male group B        high school     standard
    ## 1948 female group D       some college free/reduced
    ## 1949   male group B   some high school free/reduced
    ## 1950 female group E        high school free/reduced
    ## 1951   male group E        high school     standard
    ## 1952 female group D       some college     standard
    ## 1953 female group E   some high school free/reduced
    ## 1954   male group C        high school     standard
    ## 1955 female group C       some college     standard
    ## 1956   male group E associate's degree     standard
    ## 1957   male group C       some college     standard
    ## 1958 female group D    master's degree     standard
    ## 1959 female group D        high school     standard
    ## 1960   male group C        high school     standard
    ## 1961 female group A       some college     standard
    ## 1962 female group D   some high school free/reduced
    ## 1963 female group E associate's degree     standard
    ## 1964 female group C   some high school free/reduced
    ## 1965   male group D       some college     standard
    ## 1966 female group D       some college     standard
    ## 1967   male group A   some high school     standard
    ## 1968   male group C       some college     standard
    ## 1969 female group E associate's degree     standard
    ## 1970 female group B  bachelor's degree     standard
    ## 1971 female group D  bachelor's degree     standard
    ## 1972   male group C   some high school     standard
    ## 1973 female group A        high school free/reduced
    ## 1974 female group D       some college free/reduced
    ## 1975 female group A       some college     standard
    ## 1976 female group C       some college     standard
    ## 1977   male group B       some college free/reduced
    ## 1978   male group C associate's degree     standard
    ## 1979   male group D        high school     standard
    ## 1980 female group C associate's degree     standard
    ## 1981 female group B        high school free/reduced
    ## 1982   male group D   some high school     standard
    ## 1983   male group B   some high school     standard
    ## 1984 female group A       some college     standard
    ## 1985 female group C   some high school     standard
    ## 1986   male group A        high school     standard
    ## 1987 female group C associate's degree     standard
    ## 1988   male group E   some high school     standard
    ## 1989 female group A   some high school free/reduced
    ## 1990 female group D       some college free/reduced
    ## 1991   male group E        high school free/reduced
    ## 1992 female group B   some high school     standard
    ## 1993 female group D associate's degree free/reduced
    ## 1994 female group D  bachelor's degree free/reduced
    ## 1995   male group A        high school     standard
    ## 1996 female group E    master's degree     standard
    ## 1997   male group C        high school free/reduced
    ## 1998 female group C        high school free/reduced
    ## 1999 female group D       some college     standard
    ## 2000 female group D       some college free/reduced
    ## 2001 female group B  bachelor's degree     standard
    ## 2002 female group C       some college     standard
    ## 2003 female group B    master's degree     standard
    ## 2004   male group A associate's degree free/reduced
    ## 2005   male group C       some college     standard
    ## 2006 female group B associate's degree     standard
    ## 2007 female group B       some college     standard
    ## 2008   male group B       some college free/reduced
    ## 2009   male group D        high school free/reduced
    ## 2010 female group B        high school free/reduced
    ## 2011   male group C associate's degree     standard
    ## 2012   male group D associate's degree     standard
    ## 2013 female group B        high school     standard
    ## 2014   male group A       some college     standard
    ## 2015 female group A    master's degree     standard
    ## 2016 female group C   some high school     standard
    ## 2017   male group C        high school     standard
    ## 2018 female group B   some high school free/reduced
    ## 2019   male group C    master's degree free/reduced
    ## 2020 female group C associate's degree free/reduced
    ## 2021   male group D        high school     standard
    ## 2022 female group B       some college free/reduced
    ## 2023   male group D       some college     standard
    ## 2024 female group C   some high school     standard
    ## 2025   male group D  bachelor's degree free/reduced
    ## 2026   male group A    master's degree free/reduced
    ## 2027   male group B       some college     standard
    ## 2028 female group C  bachelor's degree     standard
    ## 2029   male group C        high school     standard
    ## 2030 female group D    master's degree     standard
    ## 2031 female group D       some college     standard
    ## 2032 female group B       some college     standard
    ## 2033 female group E    master's degree free/reduced
    ## 2034   male group D       some college     standard
    ## 2035   male group E       some college     standard
    ## 2036   male group E associate's degree     standard
    ## 2037 female group D associate's degree     standard
    ## 2038 female group D   some high school free/reduced
    ## 2039 female group D associate's degree free/reduced
    ## 2040   male group B associate's degree free/reduced
    ## 2041   male group C associate's degree free/reduced
    ## 2042 female group C associate's degree     standard
    ## 2043 female group B associate's degree     standard
    ## 2044   male group B       some college free/reduced
    ## 2045 female group E associate's degree free/reduced
    ## 2046   male group B associate's degree     standard
    ## 2047 female group A associate's degree     standard
    ## 2048 female group C        high school     standard
    ## 2049 female group D associate's degree free/reduced
    ## 2050   male group C        high school     standard
    ## 2051   male group E       some college     standard
    ## 2052   male group E associate's degree free/reduced
    ## 2053   male group C       some college     standard
    ## 2054   male group D        high school     standard
    ## 2055 female group C   some high school free/reduced
    ## 2056 female group C        high school free/reduced
    ## 2057 female group E associate's degree     standard
    ## 2058   male group D associate's degree     standard
    ## 2059   male group D       some college     standard
    ## 2060 female group C   some high school free/reduced
    ## 2061   male group E  bachelor's degree free/reduced
    ## 2062   male group A   some high school free/reduced
    ## 2063   male group A associate's degree free/reduced
    ## 2064 female group C associate's degree     standard
    ## 2065 female group D   some high school     standard
    ## 2066   male group B   some high school     standard
    ## 2067   male group D   some high school free/reduced
    ## 2068 female group C       some college     standard
    ## 2069   male group B associate's degree free/reduced
    ## 2070 female group C associate's degree     standard
    ## 2071 female group D       some college free/reduced
    ## 2072   male group D       some college     standard
    ## 2073 female group A associate's degree free/reduced
    ## 2074   male group C   some high school free/reduced
    ## 2075   male group C   some high school     standard
    ## 2076   male group B associate's degree free/reduced
    ## 2077   male group E   some high school     standard
    ## 2078   male group A  bachelor's degree     standard
    ## 2079 female group D   some high school     standard
    ## 2080 female group E    master's degree     standard
    ## 2081 female group B associate's degree     standard
    ## 2082   male group B        high school free/reduced
    ## 2083   male group A       some college free/reduced
    ## 2084   male group E associate's degree     standard
    ## 2085   male group D        high school free/reduced
    ## 2086 female group C       some college     standard
    ## 2087 female group C       some college free/reduced
    ## 2088 female group D associate's degree     standard
    ## 2089 female group A       some college     standard
    ## 2090 female group D   some high school     standard
    ## 2091 female group C  bachelor's degree     standard
    ## 2092   male group C        high school free/reduced
    ## 2093   male group C        high school     standard
    ## 2094   male group C associate's degree free/reduced
    ## 2095 female group B       some college     standard
    ## 2096   male group C associate's degree free/reduced
    ## 2097   male group B   some high school     standard
    ## 2098 female group E       some college     standard
    ## 2099 female group D       some college free/reduced
    ## 2100 female group D  bachelor's degree     standard
    ## 2101   male group B       some college     standard
    ## 2102   male group D  bachelor's degree     standard
    ## 2103 female group D associate's degree     standard
    ## 2104   male group B        high school     standard
    ## 2105   male group C       some college     standard
    ## 2106 female group C       some college     standard
    ## 2107 female group D    master's degree     standard
    ## 2108   male group E associate's degree     standard
    ## 2109 female group B associate's degree free/reduced
    ## 2110 female group B   some high school     standard
    ## 2111 female group D associate's degree free/reduced
    ## 2112   male group C        high school     standard
    ## 2113   male group A associate's degree     standard
    ## 2114 female group D       some college     standard
    ## 2115 female group E  bachelor's degree     standard
    ## 2116   male group C        high school     standard
    ## 2117 female group B  bachelor's degree free/reduced
    ## 2118 female group D  bachelor's degree     standard
    ## 2119 female group D   some high school     standard
    ## 2120 female group C       some college     standard
    ## 2121 female group C  bachelor's degree     standard
    ## 2122   male group B associate's degree     standard
    ## 2123 female group C       some college     standard
    ## 2124   male group D        high school free/reduced
    ## 2125   male group E       some college     standard
    ## 2126 female group B        high school     standard
    ## 2127   male group B   some high school     standard
    ## 2128   male group D       some college     standard
    ## 2129   male group D    master's degree     standard
    ## 2130 female group A  bachelor's degree     standard
    ## 2131   male group D    master's degree     standard
    ## 2132   male group C   some high school free/reduced
    ## 2133   male group E       some college free/reduced
    ## 2134 female group C       some college     standard
    ## 2135   male group D  bachelor's degree free/reduced
    ## 2136   male group C  bachelor's degree     standard
    ## 2137   male group B   some high school     standard
    ## 2138   male group E        high school     standard
    ## 2139 female group C associate's degree     standard
    ## 2140   male group D       some college     standard
    ## 2141 female group D   some high school     standard
    ## 2142 female group C       some college free/reduced
    ## 2143 female group E       some college free/reduced
    ## 2144   male group A        high school     standard
    ## 2145   male group D       some college     standard
    ## 2146 female group C       some college free/reduced
    ## 2147   male group B   some high school     standard
    ## 2148   male group C associate's degree free/reduced
    ## 2149 female group D  bachelor's degree     standard
    ## 2150   male group E associate's degree free/reduced
    ## 2151   male group A   some high school     standard
    ## 2152   male group A  bachelor's degree     standard
    ## 2153 female group B associate's degree     standard
    ## 2154   male group D  bachelor's degree     standard
    ## 2155   male group D   some high school     standard
    ## 2156 female group C       some college     standard
    ## 2157 female group E        high school free/reduced
    ## 2158   male group B       some college free/reduced
    ## 2159 female group B associate's degree     standard
    ## 2160   male group D associate's degree free/reduced
    ## 2161   male group B associate's degree free/reduced
    ## 2162 female group E       some college free/reduced
    ## 2163   male group B    master's degree free/reduced
    ## 2164   male group C        high school     standard
    ## 2165 female group E    master's degree     standard
    ## 2166 female group C  bachelor's degree     standard
    ## 2167   male group C        high school free/reduced
    ## 2168 female group B    master's degree free/reduced
    ## 2169 female group B        high school     standard
    ## 2170 female group C       some college free/reduced
    ## 2171   male group A        high school     standard
    ## 2172   male group E   some high school     standard
    ## 2173 female group D       some college     standard
    ## 2174 female group C associate's degree     standard
    ## 2175 female group C  bachelor's degree free/reduced
    ## 2176 female group C    master's degree     standard
    ## 2177 female group B        high school free/reduced
    ## 2178 female group C associate's degree     standard
    ## 2179 female group B    master's degree free/reduced
    ## 2180 female group D   some high school     standard
    ## 2181   male group C    master's degree free/reduced
    ## 2182 female group C       some college free/reduced
    ## 2183 female group E        high school     standard
    ## 2184 female group D associate's degree     standard
    ## 2185   male group C   some high school free/reduced
    ## 2186   male group C associate's degree free/reduced
    ## 2187   male group E        high school     standard
    ## 2188   male group D   some high school     standard
    ## 2189   male group B   some high school free/reduced
    ## 2190 female group C  bachelor's degree     standard
    ## 2191 female group E associate's degree     standard
    ## 2192   male group D       some college     standard
    ## 2193 female group B   some high school     standard
    ## 2194   male group D       some college     standard
    ## 2195 female group C    master's degree     standard
    ## 2196   male group D associate's degree     standard
    ## 2197   male group C   some high school free/reduced
    ## 2198   male group E        high school free/reduced
    ## 2199 female group B       some college free/reduced
    ## 2200 female group B  bachelor's degree free/reduced
    ## 2201 female group C associate's degree     standard
    ## 2202 female group D       some college free/reduced
    ## 2203   male group C associate's degree     standard
    ## 2204 female group B associate's degree     standard
    ## 2205   male group C       some college     standard
    ## 2206   male group D   some high school     standard
    ## 2207   male group E  bachelor's degree     standard
    ## 2208   male group E        high school     standard
    ## 2209 female group B       some college free/reduced
    ## 2210 female group B       some college free/reduced
    ## 2211   male group D   some high school free/reduced
    ## 2212   male group C       some college free/reduced
    ## 2213 female group C        high school free/reduced
    ## 2214   male group C associate's degree free/reduced
    ## 2215   male group E        high school     standard
    ## 2216   male group B   some high school     standard
    ## 2217 female group E associate's degree free/reduced
    ## 2218 female group C        high school free/reduced
    ## 2219   male group B        high school free/reduced
    ## 2220   male group B   some high school     standard
    ## 2221 female group D        high school     standard
    ## 2222   male group B associate's degree     standard
    ## 2223 female group C   some high school free/reduced
    ## 2224   male group D   some high school     standard
    ## 2225 female group B associate's degree     standard
    ## 2226 female group E    master's degree free/reduced
    ## 2227 female group C       some college     standard
    ## 2228   male group D        high school     standard
    ## 2229   male group A   some high school free/reduced
    ## 2230 female group C       some college     standard
    ## 2231   male group D       some college     standard
    ## 2232   male group C associate's degree     standard
    ## 2233 female group B  bachelor's degree     standard
    ## 2234   male group E   some high school     standard
    ## 2235   male group C  bachelor's degree     standard
    ## 2236   male group D associate's degree     standard
    ## 2237   male group D  bachelor's degree free/reduced
    ## 2238 female group D   some high school     standard
    ## 2239   male group B       some college     standard
    ## 2240   male group C associate's degree     standard
    ## 2241   male group D        high school free/reduced
    ## 2242 female group E  bachelor's degree     standard
    ## 2243 female group D        high school     standard
    ## 2244   male group E       some college     standard
    ## 2245   male group D   some high school     standard
    ## 2246   male group C associate's degree     standard
    ## 2247   male group E associate's degree     standard
    ## 2248 female group B        high school     standard
    ## 2249 female group B        high school     standard
    ## 2250   male group C        high school     standard
    ## 2251   male group A   some high school     standard
    ## 2252 female group D       some college free/reduced
    ## 2253 female group B   some high school     standard
    ## 2254   male group D    master's degree     standard
    ## 2255   male group D        high school     standard
    ## 2256 female group E       some college     standard
    ## 2257 female group C associate's degree free/reduced
    ## 2258   male group C associate's degree     standard
    ## 2259 female group B       some college     standard
    ## 2260 female group C    master's degree free/reduced
    ## 2261 female group C   some high school free/reduced
    ## 2262   male group C       some college     standard
    ## 2263 female group C   some high school free/reduced
    ## 2264 female group E        high school     standard
    ## 2265   male group D        high school     standard
    ## 2266   male group D   some high school free/reduced
    ## 2267 female group C  bachelor's degree     standard
    ## 2268 female group D        high school     standard
    ## 2269 female group D associate's degree     standard
    ## 2270 female group E       some college free/reduced
    ## 2271   male group C  bachelor's degree     standard
    ## 2272   male group C       some college     standard
    ## 2273 female group D associate's degree free/reduced
    ## 2274 female group D       some college     standard
    ## 2275   male group B       some college     standard
    ## 2276   male group C  bachelor's degree     standard
    ## 2277 female group C   some high school     standard
    ## 2278 female group E        high school     standard
    ## 2279 female group C   some high school free/reduced
    ## 2280   male group B  bachelor's degree free/reduced
    ## 2281   male group D        high school     standard
    ## 2282   male group D        high school     standard
    ## 2283 female group D  bachelor's degree free/reduced
    ## 2284 female group D       some college free/reduced
    ## 2285 female group B   some high school     standard
    ## 2286   male group B associate's degree     standard
    ## 2287   male group E associate's degree     standard
    ## 2288 female group B   some high school     standard
    ## 2289   male group B  bachelor's degree free/reduced
    ## 2290   male group E   some high school     standard
    ## 2291   male group C associate's degree     standard
    ## 2292   male group D   some high school     standard
    ## 2293   male group C   some high school     standard
    ## 2294 female group E  bachelor's degree     standard
    ## 2295   male group D        high school free/reduced
    ## 2296   male group B associate's degree free/reduced
    ## 2297   male group A   some high school     standard
    ## 2298   male group E associate's degree     standard
    ## 2299   male group C        high school free/reduced
    ## 2300   male group D associate's degree free/reduced
    ## 2301   male group A       some college free/reduced
    ## 2302   male group D   some high school free/reduced
    ## 2303 female group C associate's degree     standard
    ## 2304   male group B associate's degree     standard
    ## 2305 female group C associate's degree     standard
    ## 2306   male group A       some college     standard
    ## 2307   male group E       some college     standard
    ## 2308   male group C   some high school     standard
    ## 2309 female group B associate's degree free/reduced
    ## 2310 female group D        high school free/reduced
    ## 2311 female group B associate's degree     standard
    ## 2312   male group B  bachelor's degree     standard
    ## 2313   male group D  bachelor's degree     standard
    ## 2314 female group C associate's degree free/reduced
    ## 2315 female group C  bachelor's degree     standard
    ## 2316   male group C        high school     standard
    ## 2317 female group D    master's degree     standard
    ## 2318   male group C associate's degree     standard
    ## 2319   male group B  bachelor's degree     standard
    ## 2320 female group D associate's degree free/reduced
    ## 2321 female group C        high school free/reduced
    ## 2322 female group E        high school     standard
    ## 2323 female group C       some college     standard
    ## 2324 female group C   some high school free/reduced
    ## 2325 female group C        high school free/reduced
    ## 2326 female group C       some college     standard
    ## 2327   male group C       some college     standard
    ## 2328   male group A       some college free/reduced
    ## 2329   male group C associate's degree     standard
    ## 2330 female group B   some high school     standard
    ## 2331   male group C        high school     standard
    ## 2332   male group C associate's degree     standard
    ## 2333   male group E associate's degree     standard
    ## 2334   male group B associate's degree     standard
    ## 2335 female group C  bachelor's degree     standard
    ## 2336 female group B       some college free/reduced
    ## 2337   male group D   some high school     standard
    ## 2338   male group C associate's degree     standard
    ## 2339 female group B   some high school free/reduced
    ## 2340 female group D   some high school free/reduced
    ## 2341   male group C        high school free/reduced
    ## 2342 female group C        high school     standard
    ## 2343 female group B        high school     standard
    ## 2344   male group D associate's degree     standard
    ## 2345   male group D       some college     standard
    ## 2346 female group C        high school     standard
    ## 2347   male group B       some college     standard
    ## 2348 female group C  bachelor's degree     standard
    ## 2349   male group D        high school free/reduced
    ## 2350   male group E associate's degree     standard
    ## 2351 female group B  bachelor's degree     standard
    ## 2352   male group E       some college     standard
    ## 2353 female group C       some college     standard
    ## 2354 female group C associate's degree     standard
    ## 2355 female group C       some college     standard
    ## 2356 female group B  bachelor's degree     standard
    ## 2357   male group A associate's degree     standard
    ## 2358 female group C       some college free/reduced
    ## 2359   male group D       some college free/reduced
    ## 2360 female group D       some college     standard
    ## 2361 female group B        high school     standard
    ## 2362   male group B   some high school     standard
    ## 2363 female group C       some college     standard
    ## 2364 female group D   some high school free/reduced
    ## 2365   male group C       some college     standard
    ## 2366   male group A  bachelor's degree free/reduced
    ## 2367   male group C        high school     standard
    ## 2368   male group C  bachelor's degree free/reduced
    ## 2369 female group A   some high school free/reduced
    ## 2370 female group D   some high school     standard
    ## 2371   male group E       some college     standard
    ## 2372 female group C       some college free/reduced
    ## 2373   male group D   some high school     standard
    ## 2374 female group D       some college     standard
    ## 2375 female group D  bachelor's degree     standard
    ## 2376   male group E associate's degree free/reduced
    ## 2377 female group D   some high school     standard
    ## 2378 female group D    master's degree free/reduced
    ## 2379 female group A   some high school     standard
    ## 2380   male group A  bachelor's degree     standard
    ## 2381 female group B associate's degree     standard
    ## 2382   male group C associate's degree     standard
    ## 2383   male group C    master's degree free/reduced
    ## 2384 female group E   some high school free/reduced
    ## 2385 female group A   some high school free/reduced
    ## 2386 female group E       some college     standard
    ## 2387 female group E  bachelor's degree     standard
    ## 2388 female group C associate's degree free/reduced
    ## 2389 female group D        high school     standard
    ## 2390   male group D    master's degree     standard
    ## 2391   male group E   some high school free/reduced
    ## 2392 female group D       some college     standard
    ## 2393   male group E       some college     standard
    ## 2394   male group C associate's degree     standard
    ## 2395 female group C   some high school     standard
    ## 2396   male group A        high school free/reduced
    ## 2397 female group B        high school free/reduced
    ## 2398 female group C associate's degree     standard
    ## 2399   male group B   some high school     standard
    ## 2400   male group D   some high school     standard
    ## 2401 female group C   some high school     standard
    ## 2402   male group A       some college     standard
    ## 2403 female group A       some college free/reduced
    ## 2404 female group D        high school     standard
    ## 2405 female group C        high school     standard
    ## 2406 female group C   some high school     standard
    ## 2407   male group B associate's degree     standard
    ## 2408 female group B associate's degree     standard
    ## 2409 female group D        high school free/reduced
    ## 2410   male group D associate's degree     standard
    ## 2411 female group D    master's degree     standard
    ## 2412   male group E       some college     standard
    ## 2413   male group D associate's degree     standard
    ## 2414   male group B   some high school     standard
    ## 2415 female group C  bachelor's degree free/reduced
    ## 2416   male group E        high school     standard
    ## 2417   male group C  bachelor's degree     standard
    ## 2418   male group C associate's degree     standard
    ## 2419   male group D       some college     standard
    ## 2420   male group E        high school free/reduced
    ## 2421 female group C associate's degree free/reduced
    ## 2422 female group D        high school     standard
    ## 2423 female group D    master's degree free/reduced
    ## 2424 female group A   some high school     standard
    ## 2425   male group B       some college free/reduced
    ## 2426 female group C       some college free/reduced
    ## 2427   male group C  bachelor's degree     standard
    ## 2428   male group C   some high school free/reduced
    ## 2429   male group A   some high school free/reduced
    ## 2430   male group C   some high school free/reduced
    ## 2431   male group C associate's degree free/reduced
    ## 2432 female group C        high school     standard
    ## 2433   male group C        high school     standard
    ## 2434 female group A   some high school free/reduced
    ## 2435   male group C   some high school     standard
    ## 2436   male group C       some college free/reduced
    ## 2437   male group D associate's degree     standard
    ## 2438   male group D associate's degree free/reduced
    ## 2439   male group C        high school     standard
    ## 2440   male group D   some high school     standard
    ## 2441 female group C       some college     standard
    ## 2442 female group D        high school     standard
    ## 2443 female group A   some high school free/reduced
    ## 2444 female group B associate's degree     standard
    ## 2445   male group A   some high school free/reduced
    ## 2446 female group C   some high school     standard
    ## 2447   male group D       some college free/reduced
    ## 2448   male group C        high school     standard
    ## 2449   male group B        high school     standard
    ## 2450   male group B associate's degree     standard
    ## 2451 female group C       some college free/reduced
    ## 2452 female group E       some college     standard
    ## 2453 female group C associate's degree free/reduced
    ## 2454   male group C       some college free/reduced
    ## 2455 female group C associate's degree free/reduced
    ## 2456   male group C  bachelor's degree free/reduced
    ## 2457 female group D  bachelor's degree     standard
    ## 2458   male group D associate's degree free/reduced
    ## 2459 female group E  bachelor's degree     standard
    ## 2460   male group B        high school     standard
    ## 2461   male group C  bachelor's degree free/reduced
    ## 2462   male group B       some college free/reduced
    ## 2463 female group E       some college     standard
    ## 2464 female group C       some college free/reduced
    ## 2465   male group A  bachelor's degree     standard
    ## 2466 female group C       some college     standard
    ## 2467 female group D associate's degree free/reduced
    ## 2468   male group A        high school free/reduced
    ## 2469 female group A        high school free/reduced
    ## 2470   male group C       some college     standard
    ## 2471 female group C associate's degree     standard
    ## 2472 female group C        high school     standard
    ## 2473 female group C associate's degree     standard
    ## 2474 female group D   some high school     standard
    ## 2475 female group B associate's degree     standard
    ## 2476 female group D  bachelor's degree     standard
    ## 2477   male group E  bachelor's degree     standard
    ## 2478   male group D associate's degree     standard
    ## 2479 female group D    master's degree     standard
    ## 2480   male group E associate's degree     standard
    ## 2481   male group B        high school     standard
    ## 2482 female group D associate's degree free/reduced
    ## 2483   male group C       some college free/reduced
    ## 2484   male group A        high school     standard
    ## 2485 female group B associate's degree     standard
    ## 2486   male group C        high school     standard
    ## 2487   male group D       some college free/reduced
    ## 2488 female group C associate's degree free/reduced
    ## 2489   male group B   some high school     standard
    ## 2490   male group A associate's degree free/reduced
    ## 2491 female group A associate's degree free/reduced
    ## 2492 female group C associate's degree     standard
    ## 2493 female group C       some college     standard
    ## 2494 female group C  bachelor's degree     standard
    ## 2495 female group B        high school     standard
    ## 2496   male group D        high school     standard
    ## 2497 female group C       some college     standard
    ## 2498 female group D       some college free/reduced
    ## 2499 female group B   some high school     standard
    ## 2500   male group E       some college     standard
    ## 2501 female group D    master's degree     standard
    ## 2502 female group B associate's degree     standard
    ## 2503   male group C       some college free/reduced
    ## 2504 female group E associate's degree     standard
    ## 2505 female group D    master's degree free/reduced
    ## 2506 female group B   some high school     standard
    ## 2507   male group A        high school     standard
    ## 2508   male group B  bachelor's degree free/reduced
    ## 2509   male group C    master's degree     standard
    ## 2510 female group C  bachelor's degree     standard
    ## 2511   male group D       some college     standard
    ## 2512   male group A   some high school     standard
    ## 2513   male group D   some high school free/reduced
    ## 2514 female group B   some high school     standard
    ## 2515 female group B    master's degree free/reduced
    ## 2516 female group C   some high school     standard
    ## 2517 female group D       some college     standard
    ## 2518 female group E       some college     standard
    ## 2519 female group D   some high school     standard
    ## 2520 female group B        high school free/reduced
    ## 2521   male group D       some college     standard
    ## 2522 female group C associate's degree     standard
    ## 2523   male group D  bachelor's degree     standard
    ## 2524   male group C    master's degree free/reduced
    ## 2525   male group C        high school     standard
    ## 2526   male group E       some college     standard
    ## 2527   male group C   some high school free/reduced
    ## 2528 female group C        high school free/reduced
    ## 2529 female group D  bachelor's degree free/reduced
    ## 2530 female group C associate's degree     standard
    ## 2531 female group C associate's degree     standard
    ## 2532 female group C   some high school     standard
    ## 2533   male group E associate's degree     standard
    ## 2534 female group E associate's degree     standard
    ## 2535   male group B        high school     standard
    ## 2536 female group C  bachelor's degree free/reduced
    ## 2537   male group C associate's degree     standard
    ## 2538 female group D        high school     standard
    ## 2539   male group E  bachelor's degree     standard
    ## 2540   male group A associate's degree     standard
    ## 2541   male group C        high school     standard
    ## 2542   male group D associate's degree free/reduced
    ## 2543 female group C associate's degree     standard
    ## 2544 female group D associate's degree     standard
    ## 2545 female group D    master's degree     standard
    ## 2546   male group E   some high school free/reduced
    ## 2547 female group A   some high school     standard
    ## 2548   male group C        high school     standard
    ## 2549 female group C        high school free/reduced
    ## 2550   male group C    master's degree     standard
    ## 2551   male group C   some high school free/reduced
    ## 2552   male group B  bachelor's degree free/reduced
    ## 2553 female group B associate's degree     standard
    ## 2554   male group D       some college free/reduced
    ## 2555   male group E associate's degree     standard
    ## 2556 female group C       some college free/reduced
    ## 2557 female group C associate's degree     standard
    ## 2558   male group C    master's degree free/reduced
    ## 2559 female group B associate's degree free/reduced
    ## 2560   male group D   some high school     standard
    ## 2561 female group D       some college     standard
    ## 2562 female group C       some college     standard
    ## 2563   male group C  bachelor's degree     standard
    ## 2564 female group D       some college free/reduced
    ## 2565   male group B  bachelor's degree free/reduced
    ## 2566   male group B associate's degree     standard
    ## 2567 female group E  bachelor's degree free/reduced
    ## 2568 female group D    master's degree free/reduced
    ## 2569   male group B        high school free/reduced
    ## 2570   male group D  bachelor's degree free/reduced
    ## 2571   male group B       some college     standard
    ## 2572   male group A  bachelor's degree     standard
    ## 2573 female group C       some college     standard
    ## 2574 female group C        high school free/reduced
    ## 2575 female group E        high school     standard
    ## 2576   male group A associate's degree free/reduced
    ## 2577   male group A       some college     standard
    ## 2578 female group B        high school     standard
    ## 2579 female group B       some college free/reduced
    ## 2580 female group D    master's degree     standard
    ## 2581 female group D   some high school     standard
    ## 2582 female group E   some high school     standard
    ## 2583 female group D  bachelor's degree free/reduced
    ## 2584 female group D associate's degree     standard
    ## 2585 female group D       some college     standard
    ## 2586 female group C associate's degree     standard
    ## 2587 female group A        high school     standard
    ## 2588 female group C  bachelor's degree free/reduced
    ## 2589 female group C       some college     standard
    ## 2590 female group A   some high school     standard
    ## 2591   male group C       some college free/reduced
    ## 2592   male group A   some high school     standard
    ## 2593   male group E  bachelor's degree     standard
    ## 2594 female group E        high school     standard
    ## 2595 female group C  bachelor's degree     standard
    ## 2596 female group C  bachelor's degree     standard
    ## 2597   male group B        high school free/reduced
    ## 2598   male group A   some high school     standard
    ## 2599 female group D        high school     standard
    ## 2600 female group D   some high school     standard
    ## 2601 female group D    master's degree     standard
    ## 2602 female group C        high school     standard
    ## 2603 female group E       some college     standard
    ## 2604   male group D        high school free/reduced
    ## 2605   male group D    master's degree free/reduced
    ## 2606   male group C   some high school     standard
    ## 2607 female group C associate's degree     standard
    ## 2608 female group C    master's degree free/reduced
    ## 2609 female group E       some college     standard
    ## 2610 female group B associate's degree     standard
    ## 2611   male group D       some college free/reduced
    ## 2612 female group C       some college     standard
    ## 2613   male group C  bachelor's degree     standard
    ## 2614 female group C associate's degree     standard
    ## 2615 female group A associate's degree     standard
    ## 2616 female group C        high school     standard
    ## 2617 female group E  bachelor's degree     standard
    ## 2618   male group D  bachelor's degree     standard
    ## 2619   male group D    master's degree     standard
    ## 2620   male group C associate's degree free/reduced
    ## 2621 female group C        high school free/reduced
    ## 2622   male group B  bachelor's degree free/reduced
    ## 2623   male group C        high school free/reduced
    ## 2624   male group A       some college     standard
    ## 2625 female group E  bachelor's degree free/reduced
    ## 2626   male group D       some college     standard
    ## 2627   male group B associate's degree free/reduced
    ## 2628   male group D associate's degree     standard
    ## 2629   male group D       some college free/reduced
    ## 2630 female group C   some high school     standard
    ## 2631   male group D       some college     standard
    ## 2632   male group B        high school     standard
    ## 2633 female group B  bachelor's degree     standard
    ## 2634 female group C        high school     standard
    ## 2635   male group D   some high school     standard
    ## 2636   male group A        high school     standard
    ## 2637 female group B        high school free/reduced
    ## 2638 female group D   some high school     standard
    ## 2639   male group E       some college     standard
    ## 2640 female group D associate's degree     standard
    ## 2641   male group D        high school     standard
    ## 2642 female group D associate's degree free/reduced
    ## 2643 female group B   some high school free/reduced
    ## 2644 female group E        high school     standard
    ## 2645   male group B        high school     standard
    ## 2646 female group B  bachelor's degree     standard
    ## 2647 female group D associate's degree     standard
    ## 2648 female group E        high school free/reduced
    ## 2649 female group B        high school     standard
    ## 2650 female group D       some college     standard
    ## 2651   male group C   some high school free/reduced
    ## 2652 female group A        high school     standard
    ## 2653 female group D       some college     standard
    ## 2654 female group A associate's degree     standard
    ## 2655 female group B   some high school     standard
    ## 2656 female group B       some college     standard
    ## 2657   male group C associate's degree free/reduced
    ## 2658   male group D   some high school     standard
    ## 2659 female group D associate's degree free/reduced
    ## 2660   male group D associate's degree     standard
    ## 2661   male group C       some college free/reduced
    ## 2662   male group C   some high school     standard
    ## 2663 female group D       some college free/reduced
    ## 2664 female group C        high school     standard
    ## 2665   male group D associate's degree     standard
    ## 2666 female group C   some high school free/reduced
    ## 2667 female group C       some college free/reduced
    ## 2668 female group B  bachelor's degree free/reduced
    ## 2669   male group C       some college     standard
    ## 2670   male group D associate's degree     standard
    ## 2671 female group C        high school free/reduced
    ## 2672   male group D associate's degree free/reduced
    ## 2673 female group C       some college     standard
    ## 2674 female group C associate's degree     standard
    ## 2675 female group D        high school     standard
    ## 2676 female group B       some college     standard
    ## 2677 female group E       some college     standard
    ## 2678 female group C   some high school     standard
    ## 2679   male group D associate's degree free/reduced
    ## 2680   male group D       some college free/reduced
    ## 2681 female group D        high school     standard
    ## 2682   male group B        high school     standard
    ## 2683   male group B        high school     standard
    ## 2684 female group C   some high school free/reduced
    ## 2685   male group B       some college     standard
    ## 2686 female group E    master's degree     standard
    ## 2687   male group E       some college     standard
    ## 2688   male group D associate's degree free/reduced
    ## 2689   male group A        high school free/reduced
    ## 2690   male group E       some college free/reduced
    ## 2691 female group C associate's degree     standard
    ## 2692 female group E associate's degree free/reduced
    ## 2693 female group C  bachelor's degree free/reduced
    ## 2694 female group D associate's degree     standard
    ## 2695 female group C   some high school     standard
    ## 2696 female group D       some college free/reduced
    ## 2697 female group C associate's degree     standard
    ## 2698 female group A  bachelor's degree     standard
    ## 2699 female group D associate's degree     standard
    ## 2700   male group C        high school free/reduced
    ## 2701 female group E  bachelor's degree     standard
    ## 2702 female group B   some high school     standard
    ## 2703   male group A  bachelor's degree     standard
    ## 2704 female group D       some college     standard
    ## 2705 female group B   some high school free/reduced
    ## 2706   male group A  bachelor's degree free/reduced
    ## 2707   male group D        high school     standard
    ## 2708   male group C       some college     standard
    ## 2709   male group D        high school     standard
    ## 2710 female group D associate's degree free/reduced
    ## 2711   male group C       some college     standard
    ## 2712 female group E   some high school     standard
    ## 2713 female group D       some college     standard
    ## 2714   male group D    master's degree     standard
    ## 2715 female group B   some high school     standard
    ## 2716 female group B associate's degree free/reduced
    ## 2717   male group C associate's degree     standard
    ## 2718 female group C associate's degree     standard
    ## 2719 female group C        high school     standard
    ## 2720   male group E associate's degree free/reduced
    ## 2721 female group C       some college free/reduced
    ## 2722   male group D   some high school free/reduced
    ## 2723 female group B   some high school free/reduced
    ## 2724   male group C        high school     standard
    ## 2725   male group B       some college     standard
    ## 2726   male group E       some college     standard
    ## 2727 female group E associate's degree     standard
    ## 2728   male group E   some high school     standard
    ## 2729 female group D        high school free/reduced
    ## 2730   male group C       some college     standard
    ## 2731 female group B associate's degree free/reduced
    ## 2732   male group A   some high school free/reduced
    ## 2733 female group C       some college     standard
    ## 2734   male group D   some high school     standard
    ## 2735 female group E       some college free/reduced
    ## 2736   male group C    master's degree     standard
    ## 2737   male group C associate's degree     standard
    ## 2738 female group B       some college free/reduced
    ## 2739   male group D associate's degree     standard
    ## 2740   male group C        high school free/reduced
    ## 2741   male group D  bachelor's degree     standard
    ## 2742 female group A associate's degree free/reduced
    ## 2743 female group C        high school     standard
    ## 2744 female group C associate's degree     standard
    ## 2745   male group B       some college free/reduced
    ## 2746   male group D associate's degree     standard
    ## 2747   male group D        high school     standard
    ## 2748   male group C       some college     standard
    ## 2749 female group C  bachelor's degree free/reduced
    ## 2750   male group B       some college     standard
    ## 2751   male group D   some high school     standard
    ## 2752   male group E       some college     standard
    ## 2753   male group C    master's degree free/reduced
    ## 2754 female group C   some high school     standard
    ## 2755   male group C associate's degree free/reduced
    ## 2756 female group E associate's degree     standard
    ## 2757   male group D       some college     standard
    ## 2758   male group E  bachelor's degree free/reduced
    ## 2759 female group D       some college free/reduced
    ## 2760   male group B       some college     standard
    ## 2761 female group C        high school free/reduced
    ## 2762 female group D   some high school     standard
    ## 2763   male group D   some high school     standard
    ## 2764 female group B        high school     standard
    ## 2765   male group D       some college     standard
    ## 2766 female group B        high school     standard
    ## 2767 female group C        high school     standard
    ## 2768   male group B        high school     standard
    ## 2769 female group D   some high school     standard
    ## 2770   male group A       some college free/reduced
    ## 2771   male group B        high school     standard
    ## 2772   male group D  bachelor's degree     standard
    ## 2773 female group B   some high school free/reduced
    ## 2774 female group C  bachelor's degree free/reduced
    ## 2775   male group B       some college     standard
    ## 2776 female group B   some high school free/reduced
    ## 2777 female group B        high school     standard
    ## 2778 female group C       some college free/reduced
    ## 2779 female group A       some college     standard
    ## 2780   male group E associate's degree     standard
    ## 2781 female group D associate's degree free/reduced
    ## 2782 female group B    master's degree     standard
    ## 2783 female group B        high school free/reduced
    ## 2784 female group C associate's degree     standard
    ## 2785   male group C  bachelor's degree     standard
    ## 2786 female group B   some high school     standard
    ## 2787 female group E   some high school free/reduced
    ## 2788 female group B       some college     standard
    ## 2789   male group C associate's degree free/reduced
    ## 2790 female group C    master's degree free/reduced
    ## 2791 female group B        high school     standard
    ## 2792 female group D       some college free/reduced
    ## 2793   male group D        high school free/reduced
    ## 2794   male group E   some high school     standard
    ## 2795 female group B        high school     standard
    ## 2796 female group E associate's degree free/reduced
    ## 2797   male group D        high school     standard
    ## 2798 female group E associate's degree free/reduced
    ## 2799   male group E       some college     standard
    ## 2800 female group C associate's degree     standard
    ## 2801   male group C   some high school     standard
    ## 2802   male group C   some high school     standard
    ## 2803 female group E associate's degree     standard
    ## 2804 female group B       some college     standard
    ## 2805 female group C       some college     standard
    ## 2806   male group A       some college free/reduced
    ## 2807 female group D       some college free/reduced
    ## 2808 female group E        high school free/reduced
    ## 2809   male group C        high school     standard
    ## 2810   male group B  bachelor's degree     standard
    ## 2811   male group A   some high school     standard
    ## 2812   male group A        high school free/reduced
    ## 2813 female group C    master's degree     standard
    ## 2814   male group E   some high school     standard
    ## 2815 female group C        high school     standard
    ## 2816   male group B   some high school     standard
    ## 2817 female group A  bachelor's degree     standard
    ## 2818   male group D  bachelor's degree free/reduced
    ## 2819 female group B        high school free/reduced
    ## 2820 female group C   some high school     standard
    ## 2821 female group A   some high school     standard
    ## 2822 female group D  bachelor's degree free/reduced
    ## 2823   male group E       some college free/reduced
    ## 2824 female group B        high school free/reduced
    ## 2825 female group C   some high school free/reduced
    ## 2826   male group C        high school     standard
    ## 2827 female group C associate's degree free/reduced
    ## 2828 female group C   some high school     standard
    ## 2829 female group D   some high school free/reduced
    ## 2830   male group B   some high school     standard
    ## 2831 female group A       some college free/reduced
    ## 2832 female group C  bachelor's degree free/reduced
    ## 2833   male group A  bachelor's degree     standard
    ## 2834 female group B        high school     standard
    ## 2835   male group B       some college     standard
    ## 2836 female group C        high school     standard
    ## 2837   male group E        high school     standard
    ## 2838 female group A        high school     standard
    ## 2839   male group B associate's degree free/reduced
    ## 2840 female group C associate's degree     standard
    ## 2841 female group D        high school free/reduced
    ## 2842   male group C   some high school     standard
    ## 2843 female group B        high school free/reduced
    ## 2844   male group B       some college free/reduced
    ## 2845 female group D   some high school free/reduced
    ## 2846   male group E    master's degree     standard
    ## 2847   male group C    master's degree     standard
    ## 2848   male group D        high school     standard
    ## 2849 female group C        high school     standard
    ## 2850   male group D associate's degree     standard
    ## 2851   male group C    master's degree     standard
    ## 2852 female group A        high school     standard
    ## 2853 female group E       some college     standard
    ## 2854   male group E   some high school     standard
    ## 2855   male group C   some high school     standard
    ## 2856 female group B  bachelor's degree     standard
    ## 2857   male group B       some college free/reduced
    ## 2858 female group C  bachelor's degree     standard
    ## 2859   male group B        high school     standard
    ## 2860   male group C associate's degree free/reduced
    ## 2861 female group C associate's degree     standard
    ## 2862 female group E    master's degree free/reduced
    ## 2863   male group D  bachelor's degree free/reduced
    ## 2864 female group C       some college     standard
    ## 2865   male group C associate's degree     standard
    ## 2866   male group D       some college     standard
    ## 2867   male group C        high school free/reduced
    ## 2868   male group B associate's degree     standard
    ## 2869   male group E associate's degree free/reduced
    ## 2870   male group C associate's degree free/reduced
    ## 2871   male group B        high school     standard
    ## 2872 female group C       some college     standard
    ## 2873   male group B associate's degree     standard
    ## 2874   male group E associate's degree free/reduced
    ## 2875 female group C  bachelor's degree free/reduced
    ## 2876   male group C       some college free/reduced
    ## 2877   male group D       some college     standard
    ## 2878   male group C   some high school     standard
    ## 2879 female group D   some high school     standard
    ## 2880 female group D associate's degree     standard
    ## 2881   male group C  bachelor's degree     standard
    ## 2882 female group E  bachelor's degree     standard
    ## 2883 female group B        high school free/reduced
    ## 2884   male group D  bachelor's degree free/reduced
    ## 2885 female group E associate's degree     standard
    ## 2886 female group C associate's degree     standard
    ## 2887 female group E associate's degree     standard
    ## 2888   male group C        high school free/reduced
    ## 2889 female group D       some college free/reduced
    ## 2890   male group D        high school free/reduced
    ## 2891 female group E       some college     standard
    ## 2892 female group E associate's degree     standard
    ## 2893 female group A    master's degree free/reduced
    ## 2894   male group D   some high school     standard
    ## 2895 female group E associate's degree     standard
    ## 2896 female group E   some high school free/reduced
    ## 2897   male group B        high school free/reduced
    ## 2898 female group B   some high school free/reduced
    ## 2899   male group D associate's degree     standard
    ## 2900 female group D   some high school     standard
    ## 2901   male group D    master's degree     standard
    ## 2902 female group C    master's degree     standard
    ## 2903 female group A        high school free/reduced
    ## 2904 female group D  bachelor's degree free/reduced
    ## 2905 female group D   some high school free/reduced
    ## 2906   male group D       some college     standard
    ## 2907   male group B        high school     standard
    ## 2908 female group D       some college     standard
    ## 2909 female group C  bachelor's degree free/reduced
    ## 2910   male group E  bachelor's degree     standard
    ## 2911   male group D  bachelor's degree free/reduced
    ## 2912 female group A       some college     standard
    ## 2913 female group C  bachelor's degree     standard
    ## 2914 female group C  bachelor's degree free/reduced
    ## 2915 female group B associate's degree free/reduced
    ## 2916 female group E       some college     standard
    ## 2917   male group E  bachelor's degree     standard
    ## 2918 female group C        high school     standard
    ## 2919 female group C associate's degree     standard
    ## 2920   male group B       some college     standard
    ## 2921   male group D        high school free/reduced
    ## 2922 female group C        high school free/reduced
    ## 2923   male group D        high school     standard
    ## 2924 female group B associate's degree free/reduced
    ## 2925   male group D        high school free/reduced
    ## 2926   male group E   some high school     standard
    ## 2927   male group E associate's degree free/reduced
    ## 2928 female group D        high school free/reduced
    ## 2929   male group E associate's degree free/reduced
    ## 2930 female group C   some high school free/reduced
    ## 2931   male group C       some college free/reduced
    ## 2932   male group D       some college free/reduced
    ## 2933   male group D associate's degree free/reduced
    ## 2934   male group C  bachelor's degree free/reduced
    ## 2935   male group C associate's degree     standard
    ## 2936   male group D       some college free/reduced
    ## 2937   male group A associate's degree     standard
    ## 2938 female group E        high school free/reduced
    ## 2939   male group D       some college     standard
    ## 2940   male group D   some high school     standard
    ## 2941   male group C    master's degree free/reduced
    ## 2942 female group D    master's degree     standard
    ## 2943   male group C        high school     standard
    ## 2944   male group A   some high school free/reduced
    ## 2945 female group B        high school     standard
    ## 2946 female group C associate's degree     standard
    ## 2947   male group B        high school     standard
    ## 2948 female group D       some college free/reduced
    ## 2949   male group B   some high school free/reduced
    ## 2950 female group E        high school free/reduced
    ## 2951   male group E        high school     standard
    ## 2952 female group D       some college     standard
    ## 2953 female group E   some high school free/reduced
    ## 2954   male group C        high school     standard
    ## 2955 female group C       some college     standard
    ## 2956   male group E associate's degree     standard
    ## 2957   male group C       some college     standard
    ## 2958 female group D    master's degree     standard
    ## 2959 female group D        high school     standard
    ## 2960   male group C        high school     standard
    ## 2961 female group A       some college     standard
    ## 2962 female group D   some high school free/reduced
    ## 2963 female group E associate's degree     standard
    ## 2964 female group C   some high school free/reduced
    ## 2965   male group D       some college     standard
    ## 2966 female group D       some college     standard
    ## 2967   male group A   some high school     standard
    ## 2968   male group C       some college     standard
    ## 2969 female group E associate's degree     standard
    ## 2970 female group B  bachelor's degree     standard
    ## 2971 female group D  bachelor's degree     standard
    ## 2972   male group C   some high school     standard
    ## 2973 female group A        high school free/reduced
    ## 2974 female group D       some college free/reduced
    ## 2975 female group A       some college     standard
    ## 2976 female group C       some college     standard
    ## 2977   male group B       some college free/reduced
    ## 2978   male group C associate's degree     standard
    ## 2979   male group D        high school     standard
    ## 2980 female group C associate's degree     standard
    ## 2981 female group B        high school free/reduced
    ## 2982   male group D   some high school     standard
    ## 2983   male group B   some high school     standard
    ## 2984 female group A       some college     standard
    ## 2985 female group C   some high school     standard
    ## 2986   male group A        high school     standard
    ## 2987 female group C associate's degree     standard
    ## 2988   male group E   some high school     standard
    ## 2989 female group A   some high school free/reduced
    ## 2990 female group D       some college free/reduced
    ## 2991   male group E        high school free/reduced
    ## 2992 female group B   some high school     standard
    ## 2993 female group D associate's degree free/reduced
    ## 2994 female group D  bachelor's degree free/reduced
    ## 2995   male group A        high school     standard
    ## 2996 female group E    master's degree     standard
    ## 2997   male group C        high school free/reduced
    ## 2998 female group C        high school free/reduced
    ## 2999 female group D       some college     standard
    ## 3000 female group D       some college free/reduced
    ##      Test_preparation_course Subject Score
    ## 1                       none    math    72
    ## 2                  completed    math    69
    ## 3                       none    math    90
    ## 4                       none    math    47
    ## 5                       none    math    76
    ## 6                       none    math    71
    ## 7                  completed    math    88
    ## 8                       none    math    40
    ## 9                  completed    math    64
    ## 10                      none    math    38
    ## 11                      none    math    58
    ## 12                      none    math    40
    ## 13                      none    math    65
    ## 14                 completed    math    78
    ## 15                      none    math    50
    ## 16                      none    math    69
    ## 17                      none    math    88
    ## 18                      none    math    18
    ## 19                 completed    math    46
    ## 20                      none    math    54
    ## 21                      none    math    66
    ## 22                 completed    math    65
    ## 23                      none    math    44
    ## 24                      none    math    69
    ## 25                 completed    math    74
    ## 26                      none    math    73
    ## 27                      none    math    69
    ## 28                      none    math    67
    ## 29                      none    math    70
    ## 30                      none    math    62
    ## 31                      none    math    69
    ## 32                      none    math    63
    ## 33                      none    math    56
    ## 34                      none    math    40
    ## 35                      none    math    97
    ## 36                 completed    math    81
    ## 37                      none    math    74
    ## 38                      none    math    50
    ## 39                 completed    math    75
    ## 40                      none    math    57
    ## 41                      none    math    55
    ## 42                      none    math    58
    ## 43                      none    math    53
    ## 44                 completed    math    59
    ## 45                      none    math    50
    ## 46                      none    math    65
    ## 47                 completed    math    55
    ## 48                      none    math    66
    ## 49                 completed    math    57
    ## 50                 completed    math    82
    ## 51                      none    math    53
    ## 52                 completed    math    77
    ## 53                      none    math    53
    ## 54                      none    math    88
    ## 55                 completed    math    71
    ## 56                      none    math    33
    ## 57                 completed    math    82
    ## 58                      none    math    52
    ## 59                 completed    math    58
    ## 60                      none    math     0
    ## 61                 completed    math    79
    ## 62                      none    math    39
    ## 63                      none    math    62
    ## 64                      none    math    69
    ## 65                      none    math    59
    ## 66                      none    math    67
    ## 67                      none    math    45
    ## 68                      none    math    60
    ## 69                      none    math    61
    ## 70                      none    math    39
    ## 71                 completed    math    58
    ## 72                 completed    math    63
    ## 73                      none    math    41
    ## 74                      none    math    61
    ## 75                      none    math    49
    ## 76                      none    math    44
    ## 77                      none    math    30
    ## 78                 completed    math    80
    ## 79                 completed    math    61
    ## 80                      none    math    62
    ## 81                      none    math    47
    ## 82                      none    math    49
    ## 83                 completed    math    50
    ## 84                      none    math    72
    ## 85                      none    math    42
    ## 86                      none    math    73
    ## 87                      none    math    76
    ## 88                      none    math    71
    ## 89                      none    math    58
    ## 90                      none    math    73
    ## 91                      none    math    65
    ## 92                      none    math    27
    ## 93                      none    math    71
    ## 94                 completed    math    43
    ## 95                      none    math    79
    ## 96                 completed    math    78
    ## 97                 completed    math    65
    ## 98                 completed    math    63
    ## 99                      none    math    58
    ## 100                     none    math    65
    ## 101                     none    math    79
    ## 102                completed    math    68
    ## 103                     none    math    85
    ## 104                completed    math    60
    ## 105                completed    math    98
    ## 106                     none    math    58
    ## 107                     none    math    87
    ## 108                completed    math    66
    ## 109                     none    math    52
    ## 110                     none    math    70
    ## 111                completed    math    77
    ## 112                     none    math    62
    ## 113                     none    math    54
    ## 114                     none    math    51
    ## 115                completed    math    99
    ## 116                     none    math    84
    ## 117                     none    math    75
    ## 118                     none    math    78
    ## 119                     none    math    51
    ## 120                     none    math    55
    ## 121                completed    math    79
    ## 122                completed    math    91
    ## 123                completed    math    88
    ## 124                     none    math    63
    ## 125                     none    math    83
    ## 126                     none    math    87
    ## 127                     none    math    72
    ## 128                completed    math    65
    ## 129                     none    math    82
    ## 130                     none    math    51
    ## 131                     none    math    89
    ## 132                completed    math    53
    ## 133                completed    math    87
    ## 134                completed    math    75
    ## 135                completed    math    74
    ## 136                     none    math    58
    ## 137                completed    math    51
    ## 138                     none    math    70
    ## 139                     none    math    59
    ## 140                completed    math    71
    ## 141                     none    math    76
    ## 142                     none    math    59
    ## 143                completed    math    42
    ## 144                     none    math    57
    ## 145                     none    math    88
    ## 146                     none    math    22
    ## 147                     none    math    88
    ## 148                     none    math    73
    ## 149                completed    math    68
    ## 150                completed    math   100
    ## 151                completed    math    62
    ## 152                     none    math    77
    ## 153                completed    math    59
    ## 154                     none    math    54
    ## 155                     none    math    62
    ## 156                completed    math    70
    ## 157                completed    math    66
    ## 158                     none    math    60
    ## 159                completed    math    61
    ## 160                     none    math    66
    ## 161                completed    math    82
    ## 162                completed    math    75
    ## 163                     none    math    49
    ## 164                     none    math    52
    ## 165                     none    math    81
    ## 166                completed    math    96
    ## 167                completed    math    53
    ## 168                completed    math    58
    ## 169                completed    math    68
    ## 170                completed    math    67
    ## 171                completed    math    72
    ## 172                     none    math    94
    ## 173                     none    math    79
    ## 174                     none    math    63
    ## 175                completed    math    43
    ## 176                completed    math    81
    ## 177                completed    math    46
    ## 178                completed    math    71
    ## 179                completed    math    52
    ## 180                completed    math    97
    ## 181                completed    math    62
    ## 182                     none    math    46
    ## 183                     none    math    50
    ## 184                     none    math    65
    ## 185                completed    math    45
    ## 186                completed    math    65
    ## 187                     none    math    80
    ## 188                completed    math    62
    ## 189                     none    math    48
    ## 190                     none    math    77
    ## 191                     none    math    66
    ## 192                completed    math    76
    ## 193                     none    math    62
    ## 194                completed    math    77
    ## 195                completed    math    69
    ## 196                     none    math    61
    ## 197                completed    math    59
    ## 198                     none    math    55
    ## 199                     none    math    45
    ## 200                     none    math    78
    ## 201                completed    math    67
    ## 202                     none    math    65
    ## 203                     none    math    69
    ## 204                     none    math    57
    ## 205                     none    math    59
    ## 206                completed    math    74
    ## 207                     none    math    82
    ## 208                completed    math    81
    ## 209                     none    math    74
    ## 210                     none    math    58
    ## 211                completed    math    80
    ## 212                     none    math    35
    ## 213                     none    math    42
    ## 214                completed    math    60
    ## 215                completed    math    87
    ## 216                completed    math    84
    ## 217                completed    math    83
    ## 218                     none    math    34
    ## 219                     none    math    66
    ## 220                completed    math    61
    ## 221                completed    math    56
    ## 222                     none    math    87
    ## 223                     none    math    55
    ## 224                     none    math    86
    ## 225                completed    math    52
    ## 226                     none    math    45
    ## 227                     none    math    72
    ## 228                     none    math    57
    ## 229                     none    math    68
    ## 230                completed    math    88
    ## 231                     none    math    76
    ## 232                     none    math    46
    ## 233                     none    math    67
    ## 234                     none    math    92
    ## 235                completed    math    83
    ## 236                     none    math    80
    ## 237                     none    math    63
    ## 238                completed    math    64
    ## 239                     none    math    54
    ## 240                     none    math    84
    ## 241                completed    math    73
    ## 242                     none    math    80
    ## 243                     none    math    56
    ## 244                     none    math    59
    ## 245                     none    math    75
    ## 246                     none    math    85
    ## 247                     none    math    89
    ## 248                completed    math    58
    ## 249                     none    math    65
    ## 250                     none    math    68
    ## 251                completed    math    47
    ## 252                     none    math    71
    ## 253                completed    math    60
    ## 254                     none    math    80
    ## 255                     none    math    54
    ## 256                     none    math    62
    ## 257                     none    math    64
    ## 258                completed    math    78
    ## 259                     none    math    70
    ## 260                completed    math    65
    ## 261                completed    math    64
    ## 262                completed    math    79
    ## 263                     none    math    44
    ## 264                     none    math    99
    ## 265                     none    math    76
    ## 266                     none    math    59
    ## 267                     none    math    63
    ## 268                     none    math    69
    ## 269                completed    math    88
    ## 270                     none    math    71
    ## 271                     none    math    69
    ## 272                     none    math    58
    ## 273                     none    math    47
    ## 274                     none    math    65
    ## 275                completed    math    88
    ## 276                     none    math    83
    ## 277                completed    math    85
    ## 278                completed    math    59
    ## 279                     none    math    65
    ## 280                     none    math    73
    ## 281                     none    math    53
    ## 282                     none    math    45
    ## 283                     none    math    73
    ## 284                completed    math    70
    ## 285                     none    math    37
    ## 286                completed    math    81
    ## 287                completed    math    97
    ## 288                     none    math    67
    ## 289                     none    math    88
    ## 290                completed    math    77
    ## 291                     none    math    76
    ## 292                     none    math    86
    ## 293                completed    math    63
    ## 294                     none    math    65
    ## 295                completed    math    78
    ## 296                     none    math    67
    ## 297                completed    math    46
    ## 298                completed    math    71
    ## 299                completed    math    40
    ## 300                     none    math    90
    ## 301                completed    math    81
    ## 302                     none    math    56
    ## 303                completed    math    67
    ## 304                     none    math    80
    ## 305                completed    math    74
    ## 306                     none    math    69
    ## 307                completed    math    99
    ## 308                     none    math    51
    ## 309                     none    math    53
    ## 310                     none    math    49
    ## 311                     none    math    73
    ## 312                     none    math    66
    ## 313                completed    math    67
    ## 314                completed    math    68
    ## 315                completed    math    59
    ## 316                     none    math    71
    ## 317                completed    math    77
    ## 318                     none    math    83
    ## 319                     none    math    63
    ## 320                     none    math    56
    ## 321                completed    math    67
    ## 322                     none    math    75
    ## 323                     none    math    71
    ## 324                     none    math    43
    ## 325                     none    math    41
    ## 326                     none    math    82
    ## 327                     none    math    61
    ## 328                     none    math    28
    ## 329                completed    math    82
    ## 330                     none    math    41
    ## 331                     none    math    71
    ## 332                     none    math    47
    ## 333                completed    math    62
    ## 334                     none    math    90
    ## 335                     none    math    83
    ## 336                     none    math    61
    ## 337                completed    math    76
    ## 338                     none    math    49
    ## 339                     none    math    24
    ## 340                completed    math    35
    ## 341                     none    math    58
    ## 342                     none    math    61
    ## 343                completed    math    69
    ## 344                completed    math    67
    ## 345                     none    math    79
    ## 346                     none    math    72
    ## 347                     none    math    62
    ## 348                completed    math    77
    ## 349                     none    math    75
    ## 350                     none    math    87
    ## 351                     none    math    52
    ## 352                     none    math    66
    ## 353                completed    math    63
    ## 354                     none    math    46
    ## 355                     none    math    59
    ## 356                     none    math    61
    ## 357                     none    math    63
    ## 358                completed    math    42
    ## 359                     none    math    59
    ## 360                     none    math    80
    ## 361                     none    math    58
    ## 362                completed    math    85
    ## 363                     none    math    52
    ## 364                     none    math    27
    ## 365                     none    math    59
    ## 366                completed    math    49
    ## 367                completed    math    69
    ## 368                     none    math    61
    ## 369                     none    math    44
    ## 370                     none    math    73
    ## 371                     none    math    84
    ## 372                completed    math    45
    ## 373                     none    math    74
    ## 374                completed    math    82
    ## 375                     none    math    59
    ## 376                     none    math    46
    ## 377                     none    math    80
    ## 378                completed    math    85
    ## 379                     none    math    71
    ## 380                     none    math    66
    ## 381                     none    math    80
    ## 382                completed    math    87
    ## 383                     none    math    79
    ## 384                     none    math    38
    ## 385                     none    math    38
    ## 386                     none    math    67
    ## 387                     none    math    64
    ## 388                     none    math    57
    ## 389                     none    math    62
    ## 390                     none    math    73
    ## 391                completed    math    73
    ## 392                     none    math    77
    ## 393                     none    math    76
    ## 394                completed    math    57
    ## 395                completed    math    65
    ## 396                     none    math    48
    ## 397                     none    math    50
    ## 398                     none    math    85
    ## 399                     none    math    74
    ## 400                     none    math    60
    ## 401                completed    math    59
    ## 402                     none    math    53
    ## 403                     none    math    49
    ## 404                completed    math    88
    ## 405                     none    math    54
    ## 406                     none    math    63
    ## 407                completed    math    65
    ## 408                     none    math    82
    ## 409                completed    math    52
    ## 410                completed    math    87
    ## 411                completed    math    70
    ## 412                completed    math    84
    ## 413                     none    math    71
    ## 414                completed    math    63
    ## 415                completed    math    51
    ## 416                     none    math    84
    ## 417                completed    math    71
    ## 418                     none    math    74
    ## 419                     none    math    68
    ## 420                completed    math    57
    ## 421                completed    math    82
    ## 422                completed    math    57
    ## 423                completed    math    47
    ## 424                completed    math    59
    ## 425                     none    math    41
    ## 426                     none    math    62
    ## 427                     none    math    86
    ## 428                     none    math    69
    ## 429                     none    math    65
    ## 430                     none    math    68
    ## 431                     none    math    64
    ## 432                     none    math    61
    ## 433                     none    math    61
    ## 434                     none    math    47
    ## 435                     none    math    73
    ## 436                completed    math    50
    ## 437                     none    math    75
    ## 438                     none    math    75
    ## 439                     none    math    70
    ## 440                completed    math    89
    ## 441                completed    math    67
    ## 442                     none    math    78
    ## 443                     none    math    59
    ## 444                     none    math    73
    ## 445                     none    math    79
    ## 446                completed    math    67
    ## 447                     none    math    69
    ## 448                completed    math    86
    ## 449                     none    math    47
    ## 450                     none    math    81
    ## 451                completed    math    64
    ## 452                     none    math   100
    ## 453                     none    math    65
    ## 454                     none    math    65
    ## 455                     none    math    53
    ## 456                     none    math    37
    ## 457                     none    math    79
    ## 458                     none    math    53
    ## 459                     none    math   100
    ## 460                completed    math    72
    ## 461                     none    math    53
    ## 462                     none    math    54
    ## 463                     none    math    71
    ## 464                     none    math    77
    ## 465                completed    math    75
    ## 466                     none    math    84
    ## 467                     none    math    26
    ## 468                completed    math    72
    ## 469                completed    math    77
    ## 470                     none    math    91
    ## 471                completed    math    83
    ## 472                     none    math    63
    ## 473                completed    math    68
    ## 474                     none    math    59
    ## 475                completed    math    90
    ## 476                completed    math    71
    ## 477                completed    math    76
    ## 478                     none    math    80
    ## 479                     none    math    55
    ## 480                     none    math    76
    ## 481                completed    math    73
    ## 482                     none    math    52
    ## 483                     none    math    68
    ## 484                     none    math    59
    ## 485                     none    math    49
    ## 486                     none    math    70
    ## 487                     none    math    61
    ## 488                     none    math    60
    ## 489                completed    math    64
    ## 490                completed    math    79
    ## 491                     none    math    65
    ## 492                     none    math    64
    ## 493                     none    math    83
    ## 494                     none    math    81
    ## 495                     none    math    54
    ## 496                completed    math    68
    ## 497                     none    math    54
    ## 498                completed    math    59
    ## 499                     none    math    66
    ## 500                     none    math    76
    ## 501                     none    math    74
    ## 502                completed    math    94
    ## 503                     none    math    63
    ## 504                completed    math    95
    ## 505                     none    math    40
    ## 506                     none    math    82
    ## 507                     none    math    68
    ## 508                     none    math    55
    ## 509                     none    math    79
    ## 510                     none    math    86
    ## 511                     none    math    76
    ## 512                     none    math    64
    ## 513                     none    math    62
    ## 514                completed    math    54
    ## 515                completed    math    77
    ## 516                completed    math    76
    ## 517                     none    math    74
    ## 518                completed    math    66
    ## 519                completed    math    66
    ## 520                completed    math    67
    ## 521                     none    math    71
    ## 522                     none    math    91
    ## 523                     none    math    69
    ## 524                     none    math    54
    ## 525                completed    math    53
    ## 526                     none    math    68
    ## 527                completed    math    56
    ## 528                     none    math    36
    ## 529                     none    math    29
    ## 530                     none    math    62
    ## 531                completed    math    68
    ## 532                     none    math    47
    ## 533                completed    math    62
    ## 534                completed    math    79
    ## 535                completed    math    73
    ## 536                completed    math    66
    ## 537                completed    math    51
    ## 538                     none    math    51
    ## 539                completed    math    85
    ## 540                completed    math    97
    ## 541                completed    math    75
    ## 542                completed    math    79
    ## 543                     none    math    81
    ## 544                     none    math    82
    ## 545                     none    math    64
    ## 546                completed    math    78
    ## 547                completed    math    92
    ## 548                completed    math    72
    ## 549                     none    math    62
    ## 550                     none    math    79
    ## 551                     none    math    79
    ## 552                completed    math    87
    ## 553                     none    math    40
    ## 554                     none    math    77
    ## 555                     none    math    53
    ## 556                     none    math    32
    ## 557                completed    math    55
    ## 558                     none    math    61
    ## 559                     none    math    53
    ## 560                     none    math    73
    ## 561                completed    math    74
    ## 562                     none    math    63
    ## 563                completed    math    96
    ## 564                completed    math    63
    ## 565                     none    math    48
    ## 566                     none    math    48
    ## 567                completed    math    92
    ## 568                completed    math    61
    ## 569                     none    math    63
    ## 570                     none    math    68
    ## 571                completed    math    71
    ## 572                     none    math    91
    ## 573                     none    math    53
    ## 574                completed    math    50
    ## 575                     none    math    74
    ## 576                completed    math    40
    ## 577                completed    math    61
    ## 578                     none    math    81
    ## 579                completed    math    48
    ## 580                     none    math    53
    ## 581                     none    math    81
    ## 582                     none    math    77
    ## 583                     none    math    63
    ## 584                completed    math    73
    ## 585                     none    math    69
    ## 586                     none    math    65
    ## 587                     none    math    55
    ## 588                     none    math    44
    ## 589                     none    math    54
    ## 590                     none    math    48
    ## 591                     none    math    58
    ## 592                     none    math    71
    ## 593                     none    math    68
    ## 594                     none    math    74
    ## 595                completed    math    92
    ## 596                completed    math    56
    ## 597                     none    math    30
    ## 598                     none    math    53
    ## 599                     none    math    69
    ## 600                     none    math    65
    ## 601                     none    math    54
    ## 602                     none    math    29
    ## 603                     none    math    76
    ## 604                     none    math    60
    ## 605                completed    math    84
    ## 606                     none    math    75
    ## 607                     none    math    85
    ## 608                     none    math    40
    ## 609                     none    math    61
    ## 610                     none    math    58
    ## 611                completed    math    69
    ## 612                     none    math    58
    ## 613                completed    math    94
    ## 614                     none    math    65
    ## 615                     none    math    82
    ## 616                     none    math    60
    ## 617                     none    math    37
    ## 618                     none    math    88
    ## 619                     none    math    95
    ## 620                completed    math    65
    ## 621                     none    math    35
    ## 622                     none    math    62
    ## 623                completed    math    58
    ## 624                completed    math   100
    ## 625                     none    math    61
    ## 626                completed    math   100
    ## 627                completed    math    69
    ## 628                     none    math    61
    ## 629                     none    math    49
    ## 630                completed    math    44
    ## 631                     none    math    67
    ## 632                     none    math    79
    ## 633                completed    math    66
    ## 634                     none    math    75
    ## 635                     none    math    84
    ## 636                     none    math    71
    ## 637                completed    math    67
    ## 638                completed    math    80
    ## 639                     none    math    86
    ## 640                     none    math    76
    ## 641                     none    math    41
    ## 642                completed    math    74
    ## 643                     none    math    72
    ## 644                completed    math    74
    ## 645                     none    math    70
    ## 646                completed    math    65
    ## 647                     none    math    59
    ## 648                     none    math    64
    ## 649                     none    math    50
    ## 650                completed    math    69
    ## 651                completed    math    51
    ## 652                completed    math    68
    ## 653                completed    math    85
    ## 654                completed    math    65
    ## 655                     none    math    73
    ## 656                     none    math    62
    ## 657                     none    math    77
    ## 658                     none    math    69
    ## 659                     none    math    43
    ## 660                     none    math    90
    ## 661                     none    math    74
    ## 662                     none    math    73
    ## 663                     none    math    55
    ## 664                     none    math    65
    ## 665                     none    math    80
    ## 666                completed    math    50
    ## 667                completed    math    63
    ## 668                     none    math    77
    ## 669                     none    math    73
    ## 670                completed    math    81
    ## 671                     none    math    66
    ## 672                     none    math    52
    ## 673                     none    math    69
    ## 674                completed    math    65
    ## 675                completed    math    69
    ## 676                completed    math    50
    ## 677                completed    math    73
    ## 678                completed    math    70
    ## 679                     none    math    81
    ## 680                     none    math    63
    ## 681                     none    math    67
    ## 682                     none    math    60
    ## 683                     none    math    62
    ## 684                completed    math    29
    ## 685                completed    math    62
    ## 686                completed    math    94
    ## 687                completed    math    85
    ## 688                     none    math    77
    ## 689                     none    math    53
    ## 690                     none    math    93
    ## 691                     none    math    49
    ## 692                     none    math    73
    ## 693                completed    math    66
    ## 694                     none    math    77
    ## 695                     none    math    49
    ## 696                     none    math    79
    ## 697                completed    math    75
    ## 698                     none    math    59
    ## 699                completed    math    57
    ## 700                     none    math    66
    ## 701                completed    math    79
    ## 702                     none    math    57
    ## 703                completed    math    87
    ## 704                     none    math    63
    ## 705                completed    math    59
    ## 706                     none    math    62
    ## 707                     none    math    46
    ## 708                     none    math    66
    ## 709                     none    math    89
    ## 710                completed    math    42
    ## 711                completed    math    93
    ## 712                completed    math    80
    ## 713                     none    math    98
    ## 714                     none    math    81
    ## 715                completed    math    60
    ## 716                completed    math    76
    ## 717                completed    math    73
    ## 718                completed    math    96
    ## 719                     none    math    76
    ## 720                completed    math    91
    ## 721                     none    math    62
    ## 722                completed    math    55
    ## 723                completed    math    74
    ## 724                     none    math    50
    ## 725                     none    math    47
    ## 726                completed    math    81
    ## 727                completed    math    65
    ## 728                completed    math    68
    ## 729                     none    math    73
    ## 730                     none    math    53
    ## 731                completed    math    68
    ## 732                     none    math    55
    ## 733                completed    math    87
    ## 734                     none    math    55
    ## 735                     none    math    53
    ## 736                     none    math    67
    ## 737                     none    math    92
    ## 738                completed    math    53
    ## 739                     none    math    81
    ## 740                     none    math    61
    ## 741                     none    math    80
    ## 742                     none    math    37
    ## 743                     none    math    81
    ## 744                completed    math    59
    ## 745                     none    math    55
    ## 746                     none    math    72
    ## 747                     none    math    69
    ## 748                     none    math    69
    ## 749                     none    math    50
    ## 750                completed    math    87
    ## 751                completed    math    71
    ## 752                     none    math    68
    ## 753                completed    math    79
    ## 754                completed    math    77
    ## 755                     none    math    58
    ## 756                     none    math    84
    ## 757                     none    math    55
    ## 758                completed    math    70
    ## 759                completed    math    52
    ## 760                completed    math    69
    ## 761                     none    math    53
    ## 762                     none    math    48
    ## 763                completed    math    78
    ## 764                     none    math    62
    ## 765                     none    math    60
    ## 766                     none    math    74
    ## 767                completed    math    58
    ## 768                completed    math    76
    ## 769                     none    math    68
    ## 770                     none    math    58
    ## 771                     none    math    52
    ## 772                     none    math    75
    ## 773                completed    math    52
    ## 774                     none    math    62
    ## 775                     none    math    66
    ## 776                     none    math    49
    ## 777                     none    math    66
    ## 778                     none    math    35
    ## 779                completed    math    72
    ## 780                completed    math    94
    ## 781                     none    math    46
    ## 782                     none    math    77
    ## 783                completed    math    76
    ## 784                completed    math    52
    ## 785                completed    math    91
    ## 786                completed    math    32
    ## 787                     none    math    72
    ## 788                     none    math    19
    ## 789                     none    math    68
    ## 790                     none    math    52
    ## 791                     none    math    48
    ## 792                     none    math    60
    ## 793                     none    math    66
    ## 794                completed    math    89
    ## 795                     none    math    42
    ## 796                completed    math    57
    ## 797                     none    math    70
    ## 798                     none    math    70
    ## 799                     none    math    69
    ## 800                     none    math    52
    ## 801                completed    math    67
    ## 802                completed    math    76
    ## 803                     none    math    87
    ## 804                     none    math    82
    ## 805                     none    math    73
    ## 806                     none    math    75
    ## 807                     none    math    64
    ## 808                     none    math    41
    ## 809                     none    math    90
    ## 810                     none    math    59
    ## 811                     none    math    51
    ## 812                     none    math    45
    ## 813                completed    math    54
    ## 814                completed    math    87
    ## 815                     none    math    72
    ## 816                completed    math    94
    ## 817                     none    math    45
    ## 818                completed    math    61
    ## 819                     none    math    60
    ## 820                     none    math    77
    ## 821                completed    math    85
    ## 822                     none    math    78
    ## 823                completed    math    49
    ## 824                     none    math    71
    ## 825                     none    math    48
    ## 826                     none    math    62
    ## 827                completed    math    56
    ## 828                     none    math    65
    ## 829                completed    math    69
    ## 830                     none    math    68
    ## 831                     none    math    61
    ## 832                completed    math    74
    ## 833                     none    math    64
    ## 834                completed    math    77
    ## 835                     none    math    58
    ## 836                completed    math    60
    ## 837                     none    math    73
    ## 838                completed    math    75
    ## 839                completed    math    58
    ## 840                     none    math    66
    ## 841                     none    math    39
    ## 842                     none    math    64
    ## 843                completed    math    23
    ## 844                completed    math    74
    ## 845                completed    math    40
    ## 846                     none    math    90
    ## 847                completed    math    91
    ## 848                     none    math    64
    ## 849                     none    math    59
    ## 850                     none    math    80
    ## 851                     none    math    71
    ## 852                     none    math    61
    ## 853                     none    math    87
    ## 854                     none    math    82
    ## 855                     none    math    62
    ## 856                     none    math    97
    ## 857                     none    math    75
    ## 858                     none    math    65
    ## 859                completed    math    52
    ## 860                     none    math    87
    ## 861                     none    math    53
    ## 862                     none    math    81
    ## 863                completed    math    39
    ## 864                completed    math    71
    ## 865                     none    math    97
    ## 866                completed    math    82
    ## 867                     none    math    59
    ## 868                     none    math    61
    ## 869                completed    math    78
    ## 870                     none    math    49
    ## 871                     none    math    59
    ## 872                completed    math    70
    ## 873                completed    math    82
    ## 874                     none    math    90
    ## 875                     none    math    43
    ## 876                     none    math    80
    ## 877                     none    math    81
    ## 878                     none    math    57
    ## 879                     none    math    59
    ## 880                     none    math    64
    ## 881                completed    math    63
    ## 882                completed    math    71
    ## 883                     none    math    64
    ## 884                     none    math    55
    ## 885                     none    math    51
    ## 886                completed    math    62
    ## 887                completed    math    93
    ## 888                     none    math    54
    ## 889                     none    math    69
    ## 890                     none    math    44
    ## 891                completed    math    86
    ## 892                     none    math    85
    ## 893                     none    math    50
    ## 894                completed    math    88
    ## 895                     none    math    59
    ## 896                     none    math    32
    ## 897                     none    math    36
    ## 898                completed    math    63
    ## 899                completed    math    67
    ## 900                completed    math    65
    ## 901                     none    math    85
    ## 902                     none    math    73
    ## 903                completed    math    34
    ## 904                completed    math    93
    ## 905                     none    math    67
    ## 906                     none    math    88
    ## 907                     none    math    57
    ## 908                completed    math    79
    ## 909                     none    math    67
    ## 910                completed    math    70
    ## 911                     none    math    50
    ## 912                     none    math    69
    ## 913                completed    math    52
    ## 914                completed    math    47
    ## 915                     none    math    46
    ## 916                     none    math    68
    ## 917                completed    math   100
    ## 918                     none    math    44
    ## 919                completed    math    57
    ## 920                completed    math    91
    ## 921                     none    math    69
    ## 922                     none    math    35
    ## 923                     none    math    72
    ## 924                     none    math    54
    ## 925                     none    math    74
    ## 926                completed    math    74
    ## 927                     none    math    64
    ## 928                completed    math    65
    ## 929                completed    math    46
    ## 930                     none    math    48
    ## 931                completed    math    67
    ## 932                     none    math    62
    ## 933                completed    math    61
    ## 934                completed    math    70
    ## 935                completed    math    98
    ## 936                     none    math    70
    ## 937                     none    math    67
    ## 938                     none    math    57
    ## 939                completed    math    85
    ## 940                completed    math    77
    ## 941                completed    math    72
    ## 942                     none    math    78
    ## 943                     none    math    81
    ## 944                completed    math    61
    ## 945                     none    math    58
    ## 946                     none    math    54
    ## 947                     none    math    82
    ## 948                     none    math    49
    ## 949                completed    math    49
    ## 950                completed    math    57
    ## 951                     none    math    94
    ## 952                completed    math    75
    ## 953                     none    math    74
    ## 954                completed    math    58
    ## 955                     none    math    62
    ## 956                     none    math    72
    ## 957                     none    math    84
    ## 958                     none    math    92
    ## 959                     none    math    45
    ## 960                     none    math    75
    ## 961                     none    math    56
    ## 962                     none    math    48
    ## 963                     none    math   100
    ## 964                completed    math    65
    ## 965                     none    math    72
    ## 966                     none    math    62
    ## 967                completed    math    66
    ## 968                     none    math    63
    ## 969                     none    math    68
    ## 970                     none    math    75
    ## 971                     none    math    89
    ## 972                completed    math    78
    ## 973                completed    math    53
    ## 974                     none    math    49
    ## 975                     none    math    54
    ## 976                completed    math    64
    ## 977                completed    math    60
    ## 978                     none    math    62
    ## 979                completed    math    55
    ## 980                     none    math    91
    ## 981                     none    math     8
    ## 982                     none    math    81
    ## 983                completed    math    79
    ## 984                completed    math    78
    ## 985                     none    math    74
    ## 986                     none    math    57
    ## 987                     none    math    40
    ## 988                completed    math    81
    ## 989                     none    math    44
    ## 990                completed    math    67
    ## 991                completed    math    86
    ## 992                completed    math    65
    ## 993                     none    math    55
    ## 994                     none    math    62
    ## 995                     none    math    63
    ## 996                completed    math    88
    ## 997                     none    math    62
    ## 998                completed    math    59
    ## 999                completed    math    68
    ## 1000                    none    math    77
    ## 1001                    none reading    72
    ## 1002               completed reading    90
    ## 1003                    none reading    95
    ## 1004                    none reading    57
    ## 1005                    none reading    78
    ## 1006                    none reading    83
    ## 1007               completed reading    95
    ## 1008                    none reading    43
    ## 1009               completed reading    64
    ## 1010                    none reading    60
    ## 1011                    none reading    54
    ## 1012                    none reading    52
    ## 1013                    none reading    81
    ## 1014               completed reading    72
    ## 1015                    none reading    53
    ## 1016                    none reading    75
    ## 1017                    none reading    89
    ## 1018                    none reading    32
    ## 1019               completed reading    42
    ## 1020                    none reading    58
    ## 1021                    none reading    69
    ## 1022               completed reading    75
    ## 1023                    none reading    54
    ## 1024                    none reading    73
    ## 1025               completed reading    71
    ## 1026                    none reading    74
    ## 1027                    none reading    54
    ## 1028                    none reading    69
    ## 1029                    none reading    70
    ## 1030                    none reading    70
    ## 1031                    none reading    74
    ## 1032                    none reading    65
    ## 1033                    none reading    72
    ## 1034                    none reading    42
    ## 1035                    none reading    87
    ## 1036               completed reading    81
    ## 1037                    none reading    81
    ## 1038                    none reading    64
    ## 1039               completed reading    90
    ## 1040                    none reading    56
    ## 1041                    none reading    61
    ## 1042                    none reading    73
    ## 1043                    none reading    58
    ## 1044               completed reading    65
    ## 1045                    none reading    56
    ## 1046                    none reading    54
    ## 1047               completed reading    65
    ## 1048                    none reading    71
    ## 1049               completed reading    74
    ## 1050               completed reading    84
    ## 1051                    none reading    55
    ## 1052               completed reading    69
    ## 1053                    none reading    44
    ## 1054                    none reading    78
    ## 1055               completed reading    84
    ## 1056                    none reading    41
    ## 1057               completed reading    85
    ## 1058                    none reading    55
    ## 1059               completed reading    59
    ## 1060                    none reading    17
    ## 1061               completed reading    74
    ## 1062                    none reading    39
    ## 1063                    none reading    61
    ## 1064                    none reading    80
    ## 1065                    none reading    58
    ## 1066                    none reading    64
    ## 1067                    none reading    37
    ## 1068                    none reading    72
    ## 1069                    none reading    58
    ## 1070                    none reading    64
    ## 1071               completed reading    63
    ## 1072               completed reading    55
    ## 1073                    none reading    51
    ## 1074                    none reading    57
    ## 1075                    none reading    49
    ## 1076                    none reading    41
    ## 1077                    none reading    26
    ## 1078               completed reading    78
    ## 1079               completed reading    74
    ## 1080                    none reading    68
    ## 1081                    none reading    49
    ## 1082                    none reading    45
    ## 1083               completed reading    47
    ## 1084                    none reading    64
    ## 1085                    none reading    39
    ## 1086                    none reading    80
    ## 1087                    none reading    83
    ## 1088                    none reading    71
    ## 1089                    none reading    70
    ## 1090                    none reading    86
    ## 1091                    none reading    72
    ## 1092                    none reading    34
    ## 1093                    none reading    79
    ## 1094               completed reading    45
    ## 1095                    none reading    86
    ## 1096               completed reading    81
    ## 1097               completed reading    66
    ## 1098               completed reading    72
    ## 1099                    none reading    67
    ## 1100                    none reading    67
    ## 1101                    none reading    67
    ## 1102               completed reading    74
    ## 1103                    none reading    91
    ## 1104               completed reading    44
    ## 1105               completed reading    86
    ## 1106                    none reading    67
    ## 1107                    none reading   100
    ## 1108               completed reading    63
    ## 1109                    none reading    76
    ## 1110                    none reading    64
    ## 1111               completed reading    89
    ## 1112                    none reading    55
    ## 1113                    none reading    53
    ## 1114                    none reading    58
    ## 1115               completed reading   100
    ## 1116                    none reading    77
    ## 1117                    none reading    85
    ## 1118                    none reading    82
    ## 1119                    none reading    63
    ## 1120                    none reading    69
    ## 1121               completed reading    92
    ## 1122               completed reading    89
    ## 1123               completed reading    93
    ## 1124                    none reading    57
    ## 1125                    none reading    80
    ## 1126                    none reading    95
    ## 1127                    none reading    68
    ## 1128               completed reading    77
    ## 1129                    none reading    82
    ## 1130                    none reading    49
    ## 1131                    none reading    84
    ## 1132               completed reading    37
    ## 1133               completed reading    74
    ## 1134               completed reading    81
    ## 1135               completed reading    79
    ## 1136                    none reading    55
    ## 1137               completed reading    54
    ## 1138                    none reading    55
    ## 1139                    none reading    66
    ## 1140               completed reading    61
    ## 1141                    none reading    72
    ## 1142                    none reading    62
    ## 1143               completed reading    55
    ## 1144                    none reading    43
    ## 1145                    none reading    73
    ## 1146                    none reading    39
    ## 1147                    none reading    84
    ## 1148                    none reading    68
    ## 1149               completed reading    75
    ## 1150               completed reading   100
    ## 1151               completed reading    67
    ## 1152                    none reading    67
    ## 1153               completed reading    70
    ## 1154                    none reading    49
    ## 1155                    none reading    67
    ## 1156               completed reading    89
    ## 1157               completed reading    74
    ## 1158                    none reading    60
    ## 1159               completed reading    86
    ## 1160                    none reading    62
    ## 1161               completed reading    78
    ## 1162               completed reading    88
    ## 1163                    none reading    53
    ## 1164                    none reading    53
    ## 1165                    none reading    92
    ## 1166               completed reading   100
    ## 1167               completed reading    51
    ## 1168               completed reading    76
    ## 1169               completed reading    83
    ## 1170               completed reading    75
    ## 1171               completed reading    73
    ## 1172                    none reading    88
    ## 1173                    none reading    86
    ## 1174                    none reading    67
    ## 1175               completed reading    51
    ## 1176               completed reading    91
    ## 1177               completed reading    54
    ## 1178               completed reading    77
    ## 1179               completed reading    70
    ## 1180               completed reading   100
    ## 1181               completed reading    68
    ## 1182                    none reading    64
    ## 1183                    none reading    50
    ## 1184                    none reading    69
    ## 1185               completed reading    52
    ## 1186               completed reading    67
    ## 1187                    none reading    76
    ## 1188               completed reading    66
    ## 1189                    none reading    52
    ## 1190                    none reading    88
    ## 1191                    none reading    65
    ## 1192               completed reading    83
    ## 1193                    none reading    64
    ## 1194               completed reading    62
    ## 1195               completed reading    84
    ## 1196                    none reading    55
    ## 1197               completed reading    69
    ## 1198                    none reading    56
    ## 1199                    none reading    53
    ## 1200                    none reading    79
    ## 1201               completed reading    84
    ## 1202                    none reading    81
    ## 1203                    none reading    77
    ## 1204                    none reading    69
    ## 1205                    none reading    41
    ## 1206               completed reading    71
    ## 1207                    none reading    62
    ## 1208               completed reading    80
    ## 1209                    none reading    81
    ## 1210                    none reading    61
    ## 1211               completed reading    79
    ## 1212                    none reading    28
    ## 1213                    none reading    62
    ## 1214               completed reading    51
    ## 1215               completed reading    91
    ## 1216               completed reading    83
    ## 1217               completed reading    86
    ## 1218                    none reading    42
    ## 1219                    none reading    77
    ## 1220               completed reading    56
    ## 1221               completed reading    68
    ## 1222                    none reading    85
    ## 1223                    none reading    65
    ## 1224                    none reading    80
    ## 1225               completed reading    66
    ## 1226                    none reading    56
    ## 1227                    none reading    72
    ## 1228                    none reading    50
    ## 1229                    none reading    72
    ## 1230               completed reading    95
    ## 1231                    none reading    64
    ## 1232                    none reading    43
    ## 1233                    none reading    86
    ## 1234                    none reading    87
    ## 1235               completed reading    82
    ## 1236                    none reading    75
    ## 1237                    none reading    66
    ## 1238               completed reading    60
    ## 1239                    none reading    52
    ## 1240                    none reading    80
    ## 1241               completed reading    68
    ## 1242                    none reading    83
    ## 1243                    none reading    52
    ## 1244                    none reading    51
    ## 1245                    none reading    74
    ## 1246                    none reading    76
    ## 1247                    none reading    76
    ## 1248               completed reading    70
    ## 1249                    none reading    64
    ## 1250                    none reading    60
    ## 1251               completed reading    49
    ## 1252                    none reading    83
    ## 1253               completed reading    70
    ## 1254                    none reading    80
    ## 1255                    none reading    52
    ## 1256                    none reading    73
    ## 1257                    none reading    73
    ## 1258               completed reading    77
    ## 1259                    none reading    75
    ## 1260               completed reading    81
    ## 1261               completed reading    79
    ## 1262               completed reading    79
    ## 1263                    none reading    50
    ## 1264                    none reading    93
    ## 1265                    none reading    73
    ## 1266                    none reading    42
    ## 1267                    none reading    75
    ## 1268                    none reading    72
    ## 1269               completed reading    92
    ## 1270                    none reading    76
    ## 1271                    none reading    63
    ## 1272                    none reading    49
    ## 1273                    none reading    53
    ## 1274                    none reading    70
    ## 1275               completed reading    85
    ## 1276                    none reading    78
    ## 1277               completed reading    92
    ## 1278               completed reading    63
    ## 1279                    none reading    86
    ## 1280                    none reading    56
    ## 1281                    none reading    52
    ## 1282                    none reading    48
    ## 1283                    none reading    79
    ## 1284               completed reading    78
    ## 1285                    none reading    46
    ## 1286               completed reading    82
    ## 1287               completed reading    82
    ## 1288                    none reading    89
    ## 1289                    none reading    75
    ## 1290               completed reading    76
    ## 1291                    none reading    70
    ## 1292                    none reading    73
    ## 1293               completed reading    60
    ## 1294                    none reading    73
    ## 1295               completed reading    77
    ## 1296                    none reading    62
    ## 1297               completed reading    41
    ## 1298               completed reading    74
    ## 1299               completed reading    46
    ## 1300                    none reading    87
    ## 1301               completed reading    78
    ## 1302                    none reading    54
    ## 1303               completed reading    84
    ## 1304                    none reading    76
    ## 1305               completed reading    75
    ## 1306                    none reading    67
    ## 1307               completed reading    87
    ## 1308                    none reading    52
    ## 1309                    none reading    71
    ## 1310                    none reading    57
    ## 1311                    none reading    76
    ## 1312                    none reading    60
    ## 1313               completed reading    61
    ## 1314               completed reading    67
    ## 1315               completed reading    64
    ## 1316                    none reading    66
    ## 1317               completed reading    82
    ## 1318                    none reading    72
    ## 1319                    none reading    71
    ## 1320                    none reading    65
    ## 1321               completed reading    79
    ## 1322                    none reading    86
    ## 1323                    none reading    81
    ## 1324                    none reading    53
    ## 1325                    none reading    46
    ## 1326                    none reading    90
    ## 1327                    none reading    61
    ## 1328                    none reading    23
    ## 1329               completed reading    75
    ## 1330                    none reading    55
    ## 1331                    none reading    60
    ## 1332                    none reading    37
    ## 1333               completed reading    56
    ## 1334                    none reading    78
    ## 1335                    none reading    93
    ## 1336                    none reading    68
    ## 1337               completed reading    70
    ## 1338                    none reading    51
    ## 1339                    none reading    38
    ## 1340               completed reading    55
    ## 1341                    none reading    61
    ## 1342                    none reading    73
    ## 1343               completed reading    76
    ## 1344               completed reading    72
    ## 1345                    none reading    73
    ## 1346                    none reading    80
    ## 1347                    none reading    61
    ## 1348               completed reading    94
    ## 1349                    none reading    74
    ## 1350                    none reading    74
    ## 1351                    none reading    65
    ## 1352                    none reading    57
    ## 1353               completed reading    78
    ## 1354                    none reading    58
    ## 1355                    none reading    71
    ## 1356                    none reading    72
    ## 1357                    none reading    61
    ## 1358               completed reading    66
    ## 1359                    none reading    62
    ## 1360                    none reading    90
    ## 1361                    none reading    62
    ## 1362               completed reading    84
    ## 1363                    none reading    58
    ## 1364                    none reading    34
    ## 1365                    none reading    60
    ## 1366               completed reading    58
    ## 1367               completed reading    58
    ## 1368                    none reading    66
    ## 1369                    none reading    64
    ## 1370                    none reading    84
    ## 1371                    none reading    77
    ## 1372               completed reading    73
    ## 1373                    none reading    74
    ## 1374               completed reading    97
    ## 1375                    none reading    70
    ## 1376                    none reading    43
    ## 1377                    none reading    90
    ## 1378               completed reading    95
    ## 1379                    none reading    83
    ## 1380                    none reading    64
    ## 1381                    none reading    86
    ## 1382               completed reading   100
    ## 1383                    none reading    81
    ## 1384                    none reading    49
    ## 1385                    none reading    43
    ## 1386                    none reading    76
    ## 1387                    none reading    73
    ## 1388                    none reading    78
    ## 1389                    none reading    64
    ## 1390                    none reading    70
    ## 1391               completed reading    67
    ## 1392                    none reading    68
    ## 1393                    none reading    67
    ## 1394               completed reading    54
    ## 1395               completed reading    74
    ## 1396                    none reading    45
    ## 1397                    none reading    67
    ## 1398                    none reading    89
    ## 1399                    none reading    63
    ## 1400                    none reading    59
    ## 1401               completed reading    54
    ## 1402                    none reading    43
    ## 1403                    none reading    65
    ## 1404               completed reading    99
    ## 1405                    none reading    59
    ## 1406                    none reading    73
    ## 1407               completed reading    65
    ## 1408                    none reading    80
    ## 1409               completed reading    57
    ## 1410               completed reading    84
    ## 1411               completed reading    71
    ## 1412               completed reading    83
    ## 1413                    none reading    66
    ## 1414               completed reading    67
    ## 1415               completed reading    72
    ## 1416                    none reading    73
    ## 1417               completed reading    74
    ## 1418                    none reading    73
    ## 1419                    none reading    59
    ## 1420               completed reading    56
    ## 1421               completed reading    93
    ## 1422               completed reading    58
    ## 1423               completed reading    58
    ## 1424               completed reading    85
    ## 1425                    none reading    39
    ## 1426                    none reading    67
    ## 1427                    none reading    83
    ## 1428                    none reading    71
    ## 1429                    none reading    59
    ## 1430                    none reading    63
    ## 1431                    none reading    66
    ## 1432                    none reading    72
    ## 1433                    none reading    56
    ## 1434                    none reading    59
    ## 1435                    none reading    66
    ## 1436               completed reading    48
    ## 1437                    none reading    68
    ## 1438                    none reading    66
    ## 1439                    none reading    56
    ## 1440               completed reading    88
    ## 1441               completed reading    81
    ## 1442                    none reading    81
    ## 1443                    none reading    73
    ## 1444                    none reading    83
    ## 1445                    none reading    82
    ## 1446               completed reading    74
    ## 1447                    none reading    66
    ## 1448               completed reading    81
    ## 1449                    none reading    46
    ## 1450                    none reading    73
    ## 1451               completed reading    85
    ## 1452                    none reading    92
    ## 1453                    none reading    77
    ## 1454                    none reading    58
    ## 1455                    none reading    61
    ## 1456                    none reading    56
    ## 1457                    none reading    89
    ## 1458                    none reading    54
    ## 1459                    none reading   100
    ## 1460               completed reading    65
    ## 1461                    none reading    58
    ## 1462                    none reading    54
    ## 1463                    none reading    70
    ## 1464                    none reading    90
    ## 1465               completed reading    58
    ## 1466                    none reading    87
    ## 1467                    none reading    31
    ## 1468               completed reading    67
    ## 1469               completed reading    88
    ## 1470                    none reading    74
    ## 1471               completed reading    85
    ## 1472                    none reading    69
    ## 1473               completed reading    86
    ## 1474                    none reading    67
    ## 1475               completed reading    90
    ## 1476               completed reading    76
    ## 1477               completed reading    62
    ## 1478                    none reading    68
    ## 1479                    none reading    64
    ## 1480                    none reading    71
    ## 1481               completed reading    71
    ## 1482                    none reading    59
    ## 1483                    none reading    68
    ## 1484                    none reading    52
    ## 1485                    none reading    52
    ## 1486                    none reading    74
    ## 1487                    none reading    47
    ## 1488                    none reading    75
    ## 1489               completed reading    53
    ## 1490               completed reading    82
    ## 1491                    none reading    85
    ## 1492                    none reading    64
    ## 1493                    none reading    83
    ## 1494                    none reading    88
    ## 1495                    none reading    64
    ## 1496               completed reading    64
    ## 1497                    none reading    48
    ## 1498               completed reading    78
    ## 1499                    none reading    69
    ## 1500                    none reading    71
    ## 1501                    none reading    79
    ## 1502               completed reading    87
    ## 1503                    none reading    61
    ## 1504               completed reading    89
    ## 1505                    none reading    59
    ## 1506                    none reading    82
    ## 1507                    none reading    70
    ## 1508                    none reading    59
    ## 1509                    none reading    78
    ## 1510                    none reading    92
    ## 1511                    none reading    71
    ## 1512                    none reading    50
    ## 1513                    none reading    49
    ## 1514               completed reading    61
    ## 1515               completed reading    97
    ## 1516               completed reading    87
    ## 1517                    none reading    89
    ## 1518               completed reading    74
    ## 1519               completed reading    78
    ## 1520               completed reading    78
    ## 1521                    none reading    49
    ## 1522                    none reading    86
    ## 1523                    none reading    58
    ## 1524                    none reading    59
    ## 1525               completed reading    52
    ## 1526                    none reading    60
    ## 1527               completed reading    61
    ## 1528                    none reading    53
    ## 1529                    none reading    41
    ## 1530                    none reading    74
    ## 1531               completed reading    67
    ## 1532                    none reading    54
    ## 1533               completed reading    61
    ## 1534               completed reading    88
    ## 1535               completed reading    69
    ## 1536               completed reading    83
    ## 1537               completed reading    60
    ## 1538                    none reading    66
    ## 1539               completed reading    66
    ## 1540               completed reading    92
    ## 1541               completed reading    69
    ## 1542               completed reading    82
    ## 1543                    none reading    77
    ## 1544                    none reading    95
    ## 1545                    none reading    63
    ## 1546               completed reading    83
    ## 1547               completed reading   100
    ## 1548               completed reading    67
    ## 1549                    none reading    67
    ## 1550                    none reading    72
    ## 1551                    none reading    76
    ## 1552               completed reading    90
    ## 1553                    none reading    48
    ## 1554                    none reading    62
    ## 1555                    none reading    45
    ## 1556                    none reading    39
    ## 1557               completed reading    72
    ## 1558                    none reading    67
    ## 1559                    none reading    70
    ## 1560                    none reading    66
    ## 1561               completed reading    75
    ## 1562                    none reading    74
    ## 1563               completed reading    90
    ## 1564               completed reading    80
    ## 1565                    none reading    51
    ## 1566                    none reading    43
    ## 1567               completed reading   100
    ## 1568               completed reading    71
    ## 1569                    none reading    48
    ## 1570                    none reading    68
    ## 1571               completed reading    75
    ## 1572                    none reading    96
    ## 1573                    none reading    62
    ## 1574               completed reading    66
    ## 1575                    none reading    81
    ## 1576               completed reading    55
    ## 1577               completed reading    51
    ## 1578                    none reading    91
    ## 1579               completed reading    56
    ## 1580                    none reading    61
    ## 1581                    none reading    97
    ## 1582                    none reading    79
    ## 1583                    none reading    73
    ## 1584               completed reading    75
    ## 1585                    none reading    77
    ## 1586                    none reading    76
    ## 1587                    none reading    73
    ## 1588                    none reading    63
    ## 1589                    none reading    64
    ## 1590                    none reading    66
    ## 1591                    none reading    57
    ## 1592                    none reading    62
    ## 1593                    none reading    68
    ## 1594                    none reading    76
    ## 1595               completed reading   100
    ## 1596               completed reading    79
    ## 1597                    none reading    24
    ## 1598                    none reading    54
    ## 1599                    none reading    77
    ## 1600                    none reading    82
    ## 1601                    none reading    60
    ## 1602                    none reading    29
    ## 1603                    none reading    78
    ## 1604                    none reading    57
    ## 1605               completed reading    89
    ## 1606                    none reading    72
    ## 1607                    none reading    84
    ## 1608                    none reading    58
    ## 1609                    none reading    64
    ## 1610                    none reading    63
    ## 1611               completed reading    60
    ## 1612                    none reading    59
    ## 1613               completed reading    90
    ## 1614                    none reading    77
    ## 1615                    none reading    93
    ## 1616                    none reading    68
    ## 1617                    none reading    45
    ## 1618                    none reading    78
    ## 1619                    none reading    81
    ## 1620               completed reading    73
    ## 1621                    none reading    61
    ## 1622                    none reading    63
    ## 1623               completed reading    51
    ## 1624               completed reading    96
    ## 1625                    none reading    58
    ## 1626               completed reading    97
    ## 1627               completed reading    70
    ## 1628                    none reading    48
    ## 1629                    none reading    57
    ## 1630               completed reading    51
    ## 1631                    none reading    64
    ## 1632                    none reading    60
    ## 1633               completed reading    74
    ## 1634                    none reading    88
    ## 1635                    none reading    84
    ## 1636                    none reading    74
    ## 1637               completed reading    80
    ## 1638               completed reading    92
    ## 1639                    none reading    76
    ## 1640                    none reading    74
    ## 1641                    none reading    52
    ## 1642               completed reading    88
    ## 1643                    none reading    81
    ## 1644               completed reading    79
    ## 1645                    none reading    65
    ## 1646               completed reading    81
    ## 1647                    none reading    70
    ## 1648                    none reading    62
    ## 1649                    none reading    53
    ## 1650               completed reading    79
    ## 1651               completed reading    56
    ## 1652               completed reading    80
    ## 1653               completed reading    86
    ## 1654               completed reading    70
    ## 1655                    none reading    79
    ## 1656                    none reading    67
    ## 1657                    none reading    67
    ## 1658                    none reading    66
    ## 1659                    none reading    60
    ## 1660                    none reading    87
    ## 1661                    none reading    77
    ## 1662                    none reading    66
    ## 1663                    none reading    71
    ## 1664                    none reading    69
    ## 1665                    none reading    63
    ## 1666               completed reading    60
    ## 1667               completed reading    73
    ## 1668                    none reading    85
    ## 1669                    none reading    74
    ## 1670               completed reading    72
    ## 1671                    none reading    76
    ## 1672                    none reading    57
    ## 1673                    none reading    78
    ## 1674               completed reading    84
    ## 1675               completed reading    77
    ## 1676               completed reading    64
    ## 1677               completed reading    78
    ## 1678               completed reading    82
    ## 1679                    none reading    75
    ## 1680                    none reading    61
    ## 1681                    none reading    72
    ## 1682                    none reading    68
    ## 1683                    none reading    55
    ## 1684               completed reading    40
    ## 1685               completed reading    66
    ## 1686               completed reading    99
    ## 1687               completed reading    75
    ## 1688                    none reading    78
    ## 1689                    none reading    58
    ## 1690                    none reading    90
    ## 1691                    none reading    53
    ## 1692                    none reading    76
    ## 1693               completed reading    74
    ## 1694                    none reading    77
    ## 1695                    none reading    63
    ## 1696                    none reading    89
    ## 1697               completed reading    82
    ## 1698                    none reading    72
    ## 1699               completed reading    78
    ## 1700                    none reading    66
    ## 1701               completed reading    81
    ## 1702                    none reading    67
    ## 1703               completed reading    84
    ## 1704                    none reading    64
    ## 1705               completed reading    63
    ## 1706                    none reading    72
    ## 1707                    none reading    34
    ## 1708                    none reading    59
    ## 1709                    none reading    87
    ## 1710               completed reading    61
    ## 1711               completed reading    84
    ## 1712               completed reading    85
    ## 1713                    none reading   100
    ## 1714                    none reading    81
    ## 1715               completed reading    70
    ## 1716               completed reading    94
    ## 1717               completed reading    78
    ## 1718               completed reading    96
    ## 1719                    none reading    76
    ## 1720               completed reading    73
    ## 1721                    none reading    72
    ## 1722               completed reading    59
    ## 1723               completed reading    90
    ## 1724                    none reading    48
    ## 1725                    none reading    43
    ## 1726               completed reading    74
    ## 1727               completed reading    75
    ## 1728               completed reading    51
    ## 1729                    none reading    92
    ## 1730                    none reading    39
    ## 1731               completed reading    77
    ## 1732                    none reading    46
    ## 1733               completed reading    89
    ## 1734                    none reading    47
    ## 1735                    none reading    58
    ## 1736                    none reading    57
    ## 1737                    none reading    79
    ## 1738               completed reading    66
    ## 1739                    none reading    71
    ## 1740                    none reading    60
    ## 1741                    none reading    73
    ## 1742                    none reading    57
    ## 1743                    none reading    84
    ## 1744               completed reading    73
    ## 1745                    none reading    55
    ## 1746                    none reading    79
    ## 1747                    none reading    75
    ## 1748                    none reading    64
    ## 1749                    none reading    60
    ## 1750               completed reading    84
    ## 1751               completed reading    69
    ## 1752                    none reading    72
    ## 1753               completed reading    77
    ## 1754               completed reading    90
    ## 1755                    none reading    55
    ## 1756                    none reading    95
    ## 1757                    none reading    58
    ## 1758               completed reading    68
    ## 1759               completed reading    59
    ## 1760               completed reading    77
    ## 1761                    none reading    72
    ## 1762                    none reading    58
    ## 1763               completed reading    81
    ## 1764                    none reading    62
    ## 1765                    none reading    63
    ## 1766                    none reading    72
    ## 1767               completed reading    75
    ## 1768               completed reading    62
    ## 1769                    none reading    71
    ## 1770                    none reading    60
    ## 1771                    none reading    48
    ## 1772                    none reading    73
    ## 1773               completed reading    67
    ## 1774                    none reading    78
    ## 1775                    none reading    65
    ## 1776                    none reading    58
    ## 1777                    none reading    72
    ## 1778                    none reading    44
    ## 1779               completed reading    79
    ## 1780               completed reading    85
    ## 1781                    none reading    56
    ## 1782                    none reading    90
    ## 1783               completed reading    85
    ## 1784               completed reading    59
    ## 1785               completed reading    81
    ## 1786               completed reading    51
    ## 1787                    none reading    79
    ## 1788                    none reading    38
    ## 1789                    none reading    65
    ## 1790                    none reading    65
    ## 1791                    none reading    62
    ## 1792                    none reading    66
    ## 1793                    none reading    74
    ## 1794               completed reading    84
    ## 1795                    none reading    52
    ## 1796               completed reading    68
    ## 1797                    none reading    70
    ## 1798                    none reading    84
    ## 1799                    none reading    60
    ## 1800                    none reading    55
    ## 1801               completed reading    73
    ## 1802               completed reading    80
    ## 1803                    none reading    94
    ## 1804                    none reading    85
    ## 1805                    none reading    76
    ## 1806                    none reading    81
    ## 1807                    none reading    74
    ## 1808                    none reading    45
    ## 1809                    none reading    75
    ## 1810                    none reading    54
    ## 1811                    none reading    31
    ## 1812                    none reading    47
    ## 1813               completed reading    64
    ## 1814               completed reading    84
    ## 1815                    none reading    80
    ## 1816               completed reading    86
    ## 1817                    none reading    59
    ## 1818               completed reading    70
    ## 1819                    none reading    72
    ## 1820                    none reading    91
    ## 1821               completed reading    90
    ## 1822                    none reading    90
    ## 1823               completed reading    52
    ## 1824                    none reading    87
    ## 1825                    none reading    58
    ## 1826                    none reading    67
    ## 1827               completed reading    68
    ## 1828                    none reading    69
    ## 1829               completed reading    86
    ## 1830                    none reading    54
    ## 1831                    none reading    60
    ## 1832               completed reading    86
    ## 1833                    none reading    60
    ## 1834               completed reading    82
    ## 1835                    none reading    50
    ## 1836               completed reading    64
    ## 1837                    none reading    64
    ## 1838               completed reading    82
    ## 1839               completed reading    57
    ## 1840                    none reading    77
    ## 1841                    none reading    52
    ## 1842                    none reading    58
    ## 1843               completed reading    44
    ## 1844               completed reading    77
    ## 1845               completed reading    65
    ## 1846                    none reading    85
    ## 1847               completed reading    85
    ## 1848                    none reading    54
    ## 1849                    none reading    72
    ## 1850                    none reading    75
    ## 1851                    none reading    67
    ## 1852                    none reading    68
    ## 1853                    none reading    85
    ## 1854                    none reading    67
    ## 1855                    none reading    64
    ## 1856                    none reading    97
    ## 1857                    none reading    68
    ## 1858                    none reading    79
    ## 1859               completed reading    49
    ## 1860                    none reading    73
    ## 1861                    none reading    62
    ## 1862                    none reading    86
    ## 1863               completed reading    42
    ## 1864               completed reading    71
    ## 1865                    none reading    93
    ## 1866               completed reading    82
    ## 1867                    none reading    53
    ## 1868                    none reading    42
    ## 1869               completed reading    74
    ## 1870                    none reading    51
    ## 1871                    none reading    58
    ## 1872               completed reading    72
    ## 1873               completed reading    84
    ## 1874                    none reading    90
    ## 1875                    none reading    62
    ## 1876                    none reading    64
    ## 1877                    none reading    82
    ## 1878                    none reading    61
    ## 1879                    none reading    72
    ## 1880                    none reading    76
    ## 1881               completed reading    64
    ## 1882               completed reading    70
    ## 1883                    none reading    73
    ## 1884                    none reading    46
    ## 1885                    none reading    51
    ## 1886               completed reading    76
    ## 1887               completed reading   100
    ## 1888                    none reading    72
    ## 1889                    none reading    65
    ## 1890                    none reading    51
    ## 1891               completed reading    85
    ## 1892                    none reading    92
    ## 1893                    none reading    67
    ## 1894               completed reading    74
    ## 1895                    none reading    62
    ## 1896                    none reading    34
    ## 1897                    none reading    29
    ## 1898               completed reading    78
    ## 1899               completed reading    54
    ## 1900               completed reading    78
    ## 1901                    none reading    84
    ## 1902                    none reading    78
    ## 1903               completed reading    48
    ## 1904               completed reading   100
    ## 1905                    none reading    84
    ## 1906                    none reading    77
    ## 1907                    none reading    48
    ## 1908               completed reading    84
    ## 1909                    none reading    75
    ## 1910               completed reading    64
    ## 1911                    none reading    42
    ## 1912                    none reading    84
    ## 1913               completed reading    61
    ## 1914               completed reading    62
    ## 1915                    none reading    61
    ## 1916                    none reading    70
    ## 1917               completed reading   100
    ## 1918                    none reading    61
    ## 1919               completed reading    77
    ## 1920               completed reading    96
    ## 1921                    none reading    70
    ## 1922                    none reading    53
    ## 1923                    none reading    66
    ## 1924                    none reading    65
    ## 1925                    none reading    70
    ## 1926               completed reading    64
    ## 1927                    none reading    56
    ## 1928               completed reading    61
    ## 1929               completed reading    43
    ## 1930                    none reading    56
    ## 1931               completed reading    74
    ## 1932                    none reading    57
    ## 1933               completed reading    71
    ## 1934               completed reading    75
    ## 1935               completed reading    87
    ## 1936                    none reading    63
    ## 1937                    none reading    57
    ## 1938                    none reading    58
    ## 1939               completed reading    81
    ## 1940               completed reading    68
    ## 1941               completed reading    66
    ## 1942                    none reading    91
    ## 1943                    none reading    66
    ## 1944               completed reading    62
    ## 1945                    none reading    68
    ## 1946                    none reading    61
    ## 1947                    none reading    82
    ## 1948                    none reading    58
    ## 1949               completed reading    50
    ## 1950               completed reading    75
    ## 1951                    none reading    73
    ## 1952               completed reading    77
    ## 1953                    none reading    74
    ## 1954               completed reading    52
    ## 1955                    none reading    69
    ## 1956                    none reading    57
    ## 1957                    none reading    87
    ## 1958                    none reading   100
    ## 1959                    none reading    63
    ## 1960                    none reading    81
    ## 1961                    none reading    58
    ## 1962                    none reading    54
    ## 1963                    none reading   100
    ## 1964               completed reading    76
    ## 1965                    none reading    57
    ## 1966                    none reading    70
    ## 1967               completed reading    68
    ## 1968                    none reading    63
    ## 1969                    none reading    76
    ## 1970                    none reading    84
    ## 1971                    none reading   100
    ## 1972               completed reading    72
    ## 1973               completed reading    50
    ## 1974                    none reading    65
    ## 1975                    none reading    63
    ## 1976               completed reading    82
    ## 1977               completed reading    62
    ## 1978                    none reading    65
    ## 1979               completed reading    41
    ## 1980                    none reading    95
    ## 1981                    none reading    24
    ## 1982                    none reading    78
    ## 1983               completed reading    85
    ## 1984               completed reading    87
    ## 1985                    none reading    75
    ## 1986                    none reading    51
    ## 1987                    none reading    59
    ## 1988               completed reading    75
    ## 1989                    none reading    45
    ## 1990               completed reading    86
    ## 1991               completed reading    81
    ## 1992               completed reading    82
    ## 1993                    none reading    76
    ## 1994                    none reading    72
    ## 1995                    none reading    63
    ## 1996               completed reading    99
    ## 1997                    none reading    55
    ## 1998               completed reading    71
    ## 1999               completed reading    78
    ## 2000                    none reading    86
    ## 2001                    none writing    74
    ## 2002               completed writing    88
    ## 2003                    none writing    93
    ## 2004                    none writing    44
    ## 2005                    none writing    75
    ## 2006                    none writing    78
    ## 2007               completed writing    92
    ## 2008                    none writing    39
    ## 2009               completed writing    67
    ## 2010                    none writing    50
    ## 2011                    none writing    52
    ## 2012                    none writing    43
    ## 2013                    none writing    73
    ## 2014               completed writing    70
    ## 2015                    none writing    58
    ## 2016                    none writing    78
    ## 2017                    none writing    86
    ## 2018                    none writing    28
    ## 2019               completed writing    46
    ## 2020                    none writing    61
    ## 2021                    none writing    63
    ## 2022               completed writing    70
    ## 2023                    none writing    53
    ## 2024                    none writing    73
    ## 2025               completed writing    80
    ## 2026                    none writing    72
    ## 2027                    none writing    55
    ## 2028                    none writing    75
    ## 2029                    none writing    65
    ## 2030                    none writing    75
    ## 2031                    none writing    74
    ## 2032                    none writing    61
    ## 2033                    none writing    65
    ## 2034                    none writing    38
    ## 2035                    none writing    82
    ## 2036               completed writing    79
    ## 2037                    none writing    83
    ## 2038                    none writing    59
    ## 2039               completed writing    88
    ## 2040                    none writing    57
    ## 2041                    none writing    54
    ## 2042                    none writing    68
    ## 2043                    none writing    65
    ## 2044               completed writing    66
    ## 2045                    none writing    54
    ## 2046                    none writing    57
    ## 2047               completed writing    62
    ## 2048                    none writing    76
    ## 2049               completed writing    76
    ## 2050               completed writing    82
    ## 2051                    none writing    48
    ## 2052               completed writing    68
    ## 2053                    none writing    42
    ## 2054                    none writing    75
    ## 2055               completed writing    87
    ## 2056                    none writing    43
    ## 2057               completed writing    86
    ## 2058                    none writing    49
    ## 2059               completed writing    58
    ## 2060                    none writing    10
    ## 2061               completed writing    72
    ## 2062                    none writing    34
    ## 2063                    none writing    55
    ## 2064                    none writing    71
    ## 2065                    none writing    59
    ## 2066                    none writing    61
    ## 2067                    none writing    37
    ## 2068                    none writing    74
    ## 2069                    none writing    56
    ## 2070                    none writing    57
    ## 2071               completed writing    73
    ## 2072               completed writing    63
    ## 2073                    none writing    48
    ## 2074                    none writing    56
    ## 2075                    none writing    41
    ## 2076                    none writing    38
    ## 2077                    none writing    22
    ## 2078               completed writing    81
    ## 2079               completed writing    72
    ## 2080                    none writing    68
    ## 2081                    none writing    50
    ## 2082                    none writing    45
    ## 2083               completed writing    54
    ## 2084                    none writing    63
    ## 2085                    none writing    34
    ## 2086                    none writing    82
    ## 2087                    none writing    88
    ## 2088                    none writing    74
    ## 2089                    none writing    67
    ## 2090                    none writing    82
    ## 2091                    none writing    74
    ## 2092                    none writing    36
    ## 2093                    none writing    71
    ## 2094               completed writing    50
    ## 2095                    none writing    92
    ## 2096               completed writing    82
    ## 2097               completed writing    62
    ## 2098               completed writing    70
    ## 2099                    none writing    62
    ## 2100                    none writing    62
    ## 2101                    none writing    67
    ## 2102               completed writing    74
    ## 2103                    none writing    89
    ## 2104               completed writing    47
    ## 2105               completed writing    90
    ## 2106                    none writing    72
    ## 2107                    none writing   100
    ## 2108               completed writing    64
    ## 2109                    none writing    70
    ## 2110                    none writing    72
    ## 2111               completed writing    98
    ## 2112                    none writing    49
    ## 2113                    none writing    47
    ## 2114                    none writing    54
    ## 2115               completed writing   100
    ## 2116                    none writing    74
    ## 2117                    none writing    82
    ## 2118                    none writing    79
    ## 2119                    none writing    61
    ## 2120                    none writing    65
    ## 2121               completed writing    89
    ## 2122               completed writing    92
    ## 2123               completed writing    93
    ## 2124                    none writing    56
    ## 2125                    none writing    73
    ## 2126                    none writing    86
    ## 2127                    none writing    67
    ## 2128               completed writing    74
    ## 2129                    none writing    74
    ## 2130                    none writing    51
    ## 2131                    none writing    82
    ## 2132               completed writing    40
    ## 2133               completed writing    70
    ## 2134               completed writing    84
    ## 2135               completed writing    75
    ## 2136                    none writing    48
    ## 2137               completed writing    41
    ## 2138                    none writing    56
    ## 2139                    none writing    67
    ## 2140               completed writing    69
    ## 2141                    none writing    71
    ## 2142                    none writing    64
    ## 2143               completed writing    54
    ## 2144                    none writing    47
    ## 2145                    none writing    78
    ## 2146                    none writing    33
    ## 2147                    none writing    75
    ## 2148                    none writing    66
    ## 2149               completed writing    81
    ## 2150               completed writing    93
    ## 2151               completed writing    69
    ## 2152                    none writing    68
    ## 2153               completed writing    66
    ## 2154                    none writing    47
    ## 2155                    none writing    61
    ## 2156               completed writing    88
    ## 2157               completed writing    78
    ## 2158                    none writing    60
    ## 2159               completed writing    87
    ## 2160                    none writing    64
    ## 2161               completed writing    74
    ## 2162               completed writing    85
    ## 2163                    none writing    52
    ## 2164                    none writing    49
    ## 2165                    none writing    91
    ## 2166               completed writing   100
    ## 2167               completed writing    51
    ## 2168               completed writing    78
    ## 2169               completed writing    78
    ## 2170               completed writing    70
    ## 2171               completed writing    74
    ## 2172                    none writing    78
    ## 2173                    none writing    81
    ## 2174                    none writing    70
    ## 2175               completed writing    54
    ## 2176               completed writing    87
    ## 2177               completed writing    58
    ## 2178               completed writing    77
    ## 2179               completed writing    62
    ## 2180               completed writing   100
    ## 2181               completed writing    75
    ## 2182                    none writing    66
    ## 2183                    none writing    47
    ## 2184                    none writing    70
    ## 2185               completed writing    49
    ## 2186               completed writing    65
    ## 2187                    none writing    65
    ## 2188               completed writing    68
    ## 2189                    none writing    45
    ## 2190                    none writing    87
    ## 2191                    none writing    69
    ## 2192               completed writing    79
    ## 2193                    none writing    66
    ## 2194               completed writing    62
    ## 2195               completed writing    85
    ## 2196                    none writing    52
    ## 2197               completed writing    65
    ## 2198                    none writing    51
    ## 2199                    none writing    55
    ## 2200                    none writing    76
    ## 2201               completed writing    86
    ## 2202                    none writing    77
    ## 2203                    none writing    69
    ## 2204                    none writing    68
    ## 2205                    none writing    42
    ## 2206               completed writing    78
    ## 2207                    none writing    62
    ## 2208               completed writing    76
    ## 2209                    none writing    76
    ## 2210                    none writing    66
    ## 2211               completed writing    79
    ## 2212                    none writing    27
    ## 2213                    none writing    60
    ## 2214               completed writing    56
    ## 2215               completed writing    81
    ## 2216               completed writing    75
    ## 2217               completed writing    88
    ## 2218                    none writing    39
    ## 2219                    none writing    70
    ## 2220               completed writing    56
    ## 2221               completed writing    74
    ## 2222                    none writing    73
    ## 2223                    none writing    62
    ## 2224                    none writing    75
    ## 2225               completed writing    73
    ## 2226                    none writing    54
    ## 2227                    none writing    71
    ## 2228                    none writing    54
    ## 2229                    none writing    64
    ## 2230               completed writing    94
    ## 2231                    none writing    66
    ## 2232                    none writing    42
    ## 2233                    none writing    83
    ## 2234                    none writing    78
    ## 2235               completed writing    84
    ## 2236                    none writing    77
    ## 2237                    none writing    67
    ## 2238               completed writing    74
    ## 2239                    none writing    51
    ## 2240                    none writing    80
    ## 2241               completed writing    66
    ## 2242                    none writing    83
    ## 2243                    none writing    55
    ## 2244                    none writing    43
    ## 2245                    none writing    69
    ## 2246                    none writing    71
    ## 2247                    none writing    74
    ## 2248               completed writing    68
    ## 2249                    none writing    62
    ## 2250                    none writing    53
    ## 2251               completed writing    49
    ## 2252                    none writing    83
    ## 2253               completed writing    70
    ## 2254                    none writing    72
    ## 2255                    none writing    52
    ## 2256                    none writing    70
    ## 2257                    none writing    68
    ## 2258               completed writing    77
    ## 2259                    none writing    78
    ## 2260               completed writing    81
    ## 2261               completed writing    77
    ## 2262               completed writing    78
    ## 2263                    none writing    51
    ## 2264                    none writing    90
    ## 2265                    none writing    68
    ## 2266                    none writing    41
    ## 2267                    none writing    81
    ## 2268                    none writing    77
    ## 2269               completed writing    95
    ## 2270                    none writing    70
    ## 2271                    none writing    61
    ## 2272                    none writing    42
    ## 2273                    none writing    58
    ## 2274                    none writing    71
    ## 2275               completed writing    76
    ## 2276                    none writing    73
    ## 2277               completed writing    93
    ## 2278               completed writing    75
    ## 2279                    none writing    80
    ## 2280                    none writing    57
    ## 2281                    none writing    42
    ## 2282                    none writing    46
    ## 2283                    none writing    84
    ## 2284               completed writing    78
    ## 2285                    none writing    46
    ## 2286               completed writing    82
    ## 2287               completed writing    88
    ## 2288                    none writing    82
    ## 2289                    none writing    76
    ## 2290               completed writing    77
    ## 2291                    none writing    68
    ## 2292                    none writing    70
    ## 2293               completed writing    57
    ## 2294                    none writing    75
    ## 2295               completed writing    80
    ## 2296                    none writing    60
    ## 2297               completed writing    43
    ## 2298               completed writing    68
    ## 2299               completed writing    50
    ## 2300                    none writing    75
    ## 2301               completed writing    81
    ## 2302                    none writing    52
    ## 2303               completed writing    81
    ## 2304                    none writing    64
    ## 2305               completed writing    83
    ## 2306                    none writing    69
    ## 2307               completed writing    81
    ## 2308                    none writing    44
    ## 2309                    none writing    67
    ## 2310                    none writing    52
    ## 2311                    none writing    80
    ## 2312                    none writing    57
    ## 2313               completed writing    68
    ## 2314               completed writing    69
    ## 2315               completed writing    75
    ## 2316                    none writing    65
    ## 2317               completed writing    91
    ## 2318                    none writing    78
    ## 2319                    none writing    69
    ## 2320                    none writing    63
    ## 2321               completed writing    84
    ## 2322                    none writing    79
    ## 2323                    none writing    80
    ## 2324                    none writing    53
    ## 2325                    none writing    43
    ## 2326                    none writing    94
    ## 2327                    none writing    62
    ## 2328                    none writing    19
    ## 2329               completed writing    77
    ## 2330                    none writing    51
    ## 2331                    none writing    61
    ## 2332                    none writing    35
    ## 2333               completed writing    53
    ## 2334                    none writing    81
    ## 2335                    none writing    95
    ## 2336                    none writing    66
    ## 2337               completed writing    69
    ## 2338                    none writing    43
    ## 2339                    none writing    27
    ## 2340               completed writing    60
    ## 2341                    none writing    52
    ## 2342                    none writing    63
    ## 2343               completed writing    74
    ## 2344               completed writing    67
    ## 2345                    none writing    67
    ## 2346                    none writing    75
    ## 2347                    none writing    57
    ## 2348               completed writing    95
    ## 2349                    none writing    66
    ## 2350                    none writing    76
    ## 2351                    none writing    69
    ## 2352                    none writing    52
    ## 2353               completed writing    80
    ## 2354                    none writing    57
    ## 2355                    none writing    70
    ## 2356                    none writing    70
    ## 2357                    none writing    61
    ## 2358               completed writing    69
    ## 2359                    none writing    61
    ## 2360                    none writing    89
    ## 2361                    none writing    59
    ## 2362               completed writing    78
    ## 2363                    none writing    58
    ## 2364                    none writing    32
    ## 2365                    none writing    58
    ## 2366               completed writing    60
    ## 2367               completed writing    53
    ## 2368                    none writing    61
    ## 2369                    none writing    58
    ## 2370                    none writing    85
    ## 2371                    none writing    71
    ## 2372               completed writing    70
    ## 2373                    none writing    72
    ## 2374               completed writing    96
    ## 2375                    none writing    73
    ## 2376                    none writing    41
    ## 2377                    none writing    82
    ## 2378               completed writing   100
    ## 2379                    none writing    77
    ## 2380                    none writing    62
    ## 2381                    none writing    83
    ## 2382               completed writing    95
    ## 2383                    none writing    71
    ## 2384                    none writing    45
    ## 2385                    none writing    43
    ## 2386                    none writing    75
    ## 2387                    none writing    70
    ## 2388                    none writing    67
    ## 2389                    none writing    64
    ## 2390                    none writing    75
    ## 2391               completed writing    59
    ## 2392                    none writing    77
    ## 2393                    none writing    67
    ## 2394               completed writing    56
    ## 2395               completed writing    77
    ## 2396                    none writing    41
    ## 2397                    none writing    63
    ## 2398                    none writing    95
    ## 2399                    none writing    57
    ## 2400                    none writing    54
    ## 2401               completed writing    67
    ## 2402                    none writing    43
    ## 2403                    none writing    55
    ## 2404               completed writing   100
    ## 2405                    none writing    62
    ## 2406                    none writing    68
    ## 2407               completed writing    63
    ## 2408                    none writing    77
    ## 2409               completed writing    56
    ## 2410               completed writing    85
    ## 2411               completed writing    74
    ## 2412               completed writing    78
    ## 2413                    none writing    60
    ## 2414               completed writing    67
    ## 2415               completed writing    79
    ## 2416                    none writing    69
    ## 2417               completed writing    68
    ## 2418                    none writing    67
    ## 2419                    none writing    62
    ## 2420               completed writing    54
    ## 2421               completed writing    93
    ## 2422               completed writing    64
    ## 2423               completed writing    67
    ## 2424               completed writing    80
    ## 2425                    none writing    34
    ## 2426                    none writing    62
    ## 2427                    none writing    86
    ## 2428                    none writing    65
    ## 2429                    none writing    53
    ## 2430                    none writing    54
    ## 2431                    none writing    59
    ## 2432                    none writing    70
    ## 2433                    none writing    55
    ## 2434                    none writing    50
    ## 2435                    none writing    66
    ## 2436               completed writing    53
    ## 2437                    none writing    64
    ## 2438                    none writing    73
    ## 2439                    none writing    51
    ## 2440               completed writing    82
    ## 2441               completed writing    79
    ## 2442                    none writing    80
    ## 2443                    none writing    69
    ## 2444                    none writing    76
    ## 2445                    none writing    73
    ## 2446               completed writing    77
    ## 2447                    none writing    60
    ## 2448               completed writing    80
    ## 2449                    none writing    42
    ## 2450                    none writing    72
    ## 2451               completed writing    85
    ## 2452                    none writing    97
    ## 2453                    none writing    74
    ## 2454                    none writing    49
    ## 2455                    none writing    62
    ## 2456                    none writing    47
    ## 2457                    none writing    89
    ## 2458                    none writing    48
    ## 2459                    none writing   100
    ## 2460               completed writing    68
    ## 2461                    none writing    55
    ## 2462                    none writing    45
    ## 2463                    none writing    76
    ## 2464                    none writing    91
    ## 2465               completed writing    62
    ## 2466                    none writing    91
    ## 2467                    none writing    38
    ## 2468               completed writing    65
    ## 2469               completed writing    85
    ## 2470                    none writing    76
    ## 2471               completed writing    90
    ## 2472                    none writing    74
    ## 2473               completed writing    84
    ## 2474                    none writing    61
    ## 2475               completed writing    91
    ## 2476               completed writing    83
    ## 2477               completed writing    66
    ## 2478                    none writing    72
    ## 2479                    none writing    70
    ## 2480                    none writing    67
    ## 2481               completed writing    68
    ## 2482                    none writing    56
    ## 2483                    none writing    61
    ## 2484                    none writing    46
    ## 2485                    none writing    54
    ## 2486                    none writing    71
    ## 2487                    none writing    56
    ## 2488                    none writing    74
    ## 2489               completed writing    57
    ## 2490               completed writing    82
    ## 2491                    none writing    76
    ## 2492                    none writing    70
    ## 2493                    none writing    90
    ## 2494                    none writing    90
    ## 2495                    none writing    68
    ## 2496               completed writing    66
    ## 2497                    none writing    52
    ## 2498               completed writing    76
    ## 2499                    none writing    68
    ## 2500                    none writing    72
    ## 2501                    none writing    82
    ## 2502               completed writing    92
    ## 2503                    none writing    54
    ## 2504               completed writing    92
    ## 2505                    none writing    54
    ## 2506                    none writing    80
    ## 2507                    none writing    66
    ## 2508                    none writing    54
    ## 2509                    none writing    77
    ## 2510                    none writing    87
    ## 2511                    none writing    73
    ## 2512                    none writing    43
    ## 2513                    none writing    52
    ## 2514               completed writing    62
    ## 2515               completed writing    94
    ## 2516               completed writing    85
    ## 2517                    none writing    84
    ## 2518               completed writing    73
    ## 2519               completed writing    78
    ## 2520               completed writing    79
    ## 2521                    none writing    52
    ## 2522                    none writing    84
    ## 2523                    none writing    57
    ## 2524                    none writing    50
    ## 2525               completed writing    49
    ## 2526                    none writing    59
    ## 2527               completed writing    60
    ## 2528                    none writing    43
    ## 2529                    none writing    47
    ## 2530                    none writing    70
    ## 2531               completed writing    73
    ## 2532                    none writing    53
    ## 2533               completed writing    58
    ## 2534               completed writing    94
    ## 2535               completed writing    68
    ## 2536               completed writing    83
    ## 2537               completed writing    58
    ## 2538                    none writing    62
    ## 2539               completed writing    71
    ## 2540               completed writing    86
    ## 2541               completed writing    68
    ## 2542               completed writing    80
    ## 2543                    none writing    79
    ## 2544                    none writing    89
    ## 2545                    none writing    66
    ## 2546               completed writing    80
    ## 2547               completed writing    97
    ## 2548               completed writing    64
    ## 2549                    none writing    64
    ## 2550                    none writing    69
    ## 2551                    none writing    65
    ## 2552               completed writing    88
    ## 2553                    none writing    50
    ## 2554                    none writing    64
    ## 2555                    none writing    40
    ## 2556                    none writing    33
    ## 2557               completed writing    79
    ## 2558                    none writing    66
    ## 2559                    none writing    70
    ## 2560                    none writing    62
    ## 2561               completed writing    79
    ## 2562                    none writing    74
    ## 2563               completed writing    92
    ## 2564               completed writing    80
    ## 2565                    none writing    46
    ## 2566                    none writing    45
    ## 2567               completed writing   100
    ## 2568               completed writing    78
    ## 2569                    none writing    47
    ## 2570                    none writing    67
    ## 2571               completed writing    70
    ## 2572                    none writing    92
    ## 2573                    none writing    56
    ## 2574               completed writing    64
    ## 2575                    none writing    71
    ## 2576               completed writing    53
    ## 2577               completed writing    52
    ## 2578                    none writing    89
    ## 2579               completed writing    58
    ## 2580                    none writing    68
    ## 2581                    none writing    96
    ## 2582                    none writing    80
    ## 2583                    none writing    78
    ## 2584               completed writing    80
    ## 2585                    none writing    77
    ## 2586                    none writing    76
    ## 2587                    none writing    73
    ## 2588                    none writing    62
    ## 2589                    none writing    65
    ## 2590                    none writing    65
    ## 2591                    none writing    54
    ## 2592                    none writing    50
    ## 2593                    none writing    64
    ## 2594                    none writing    73
    ## 2595               completed writing    99
    ## 2596               completed writing    72
    ## 2597                    none writing    15
    ## 2598                    none writing    48
    ## 2599                    none writing    73
    ## 2600                    none writing    81
    ## 2601                    none writing    63
    ## 2602                    none writing    30
    ## 2603                    none writing    80
    ## 2604                    none writing    51
    ## 2605               completed writing    90
    ## 2606                    none writing    62
    ## 2607                    none writing    82
    ## 2608                    none writing    54
    ## 2609                    none writing    62
    ## 2610                    none writing    65
    ## 2611               completed writing    63
    ## 2612                    none writing    66
    ## 2613               completed writing    91
    ## 2614                    none writing    74
    ## 2615                    none writing    93
    ## 2616                    none writing    72
    ## 2617                    none writing    38
    ## 2618                    none writing    83
    ## 2619                    none writing    84
    ## 2620               completed writing    68
    ## 2621                    none writing    54
    ## 2622                    none writing    56
    ## 2623               completed writing    52
    ## 2624               completed writing    86
    ## 2625                    none writing    62
    ## 2626               completed writing    99
    ## 2627               completed writing    63
    ## 2628                    none writing    46
    ## 2629                    none writing    46
    ## 2630               completed writing    55
    ## 2631                    none writing    70
    ## 2632                    none writing    65
    ## 2633               completed writing    81
    ## 2634                    none writing    85
    ## 2635                    none writing    80
    ## 2636                    none writing    64
    ## 2637               completed writing    81
    ## 2638               completed writing    88
    ## 2639                    none writing    74
    ## 2640                    none writing    73
    ## 2641                    none writing    51
    ## 2642               completed writing    90
    ## 2643                    none writing    79
    ## 2644               completed writing    80
    ## 2645                    none writing    60
    ## 2646               completed writing    81
    ## 2647                    none writing    65
    ## 2648                    none writing    68
    ## 2649                    none writing    55
    ## 2650               completed writing    81
    ## 2651               completed writing    53
    ## 2652               completed writing    76
    ## 2653               completed writing    98
    ## 2654               completed writing    74
    ## 2655                    none writing    79
    ## 2656                    none writing    67
    ## 2657                    none writing    64
    ## 2658                    none writing    61
    ## 2659                    none writing    58
    ## 2660                    none writing    85
    ## 2661                    none writing    73
    ## 2662                    none writing    63
    ## 2663                    none writing    69
    ## 2664                    none writing    67
    ## 2665                    none writing    63
    ## 2666               completed writing    60
    ## 2667               completed writing    71
    ## 2668                    none writing    87
    ## 2669                    none writing    61
    ## 2670               completed writing    77
    ## 2671                    none writing    68
    ## 2672                    none writing    50
    ## 2673                    none writing    76
    ## 2674               completed writing    84
    ## 2675               completed writing    78
    ## 2676               completed writing    66
    ## 2677               completed writing    76
    ## 2678               completed writing    76
    ## 2679                    none writing    78
    ## 2680                    none writing    60
    ## 2681                    none writing    74
    ## 2682                    none writing    60
    ## 2683                    none writing    54
    ## 2684               completed writing    44
    ## 2685               completed writing    68
    ## 2686               completed writing   100
    ## 2687               completed writing    68
    ## 2688                    none writing    73
    ## 2689                    none writing    44
    ## 2690                    none writing    83
    ## 2691                    none writing    53
    ## 2692                    none writing    78
    ## 2693               completed writing    81
    ## 2694                    none writing    73
    ## 2695                    none writing    56
    ## 2696                    none writing    86
    ## 2697               completed writing    90
    ## 2698                    none writing    70
    ## 2699               completed writing    79
    ## 2700                    none writing    59
    ## 2701               completed writing    82
    ## 2702                    none writing    72
    ## 2703               completed writing    87
    ## 2704                    none writing    67
    ## 2705               completed writing    64
    ## 2706                    none writing    65
    ## 2707                    none writing    36
    ## 2708                    none writing    52
    ## 2709                    none writing    79
    ## 2710               completed writing    58
    ## 2711               completed writing    90
    ## 2712               completed writing    85
    ## 2713                    none writing    99
    ## 2714                    none writing    84
    ## 2715               completed writing    74
    ## 2716               completed writing    87
    ## 2717               completed writing    72
    ## 2718               completed writing    99
    ## 2719                    none writing    74
    ## 2720               completed writing    80
    ## 2721                    none writing    70
    ## 2722               completed writing    59
    ## 2723               completed writing    88
    ## 2724                    none writing    42
    ## 2725                    none writing    41
    ## 2726               completed writing    71
    ## 2727               completed writing    77
    ## 2728               completed writing    57
    ## 2729                    none writing    84
    ## 2730                    none writing    37
    ## 2731               completed writing    80
    ## 2732                    none writing    43
    ## 2733               completed writing    94
    ## 2734                    none writing    44
    ## 2735                    none writing    57
    ## 2736                    none writing    59
    ## 2737                    none writing    84
    ## 2738               completed writing    73
    ## 2739                    none writing    73
    ## 2740                    none writing    55
    ## 2741                    none writing    72
    ## 2742                    none writing    56
    ## 2743                    none writing    82
    ## 2744               completed writing    72
    ## 2745                    none writing    47
    ## 2746                    none writing    74
    ## 2747                    none writing    71
    ## 2748                    none writing    68
    ## 2749                    none writing    59
    ## 2750               completed writing    86
    ## 2751               completed writing    68
    ## 2752                    none writing    65
    ## 2753               completed writing    75
    ## 2754               completed writing    85
    ## 2755                    none writing    53
    ## 2756                    none writing    92
    ## 2757                    none writing    52
    ## 2758               completed writing    72
    ## 2759               completed writing    65
    ## 2760               completed writing    77
    ## 2761                    none writing    64
    ## 2762                    none writing    54
    ## 2763               completed writing    86
    ## 2764                    none writing    63
    ## 2765                    none writing    59
    ## 2766                    none writing    72
    ## 2767               completed writing    77
    ## 2768               completed writing    60
    ## 2769                    none writing    75
    ## 2770                    none writing    57
    ## 2771                    none writing    49
    ## 2772                    none writing    74
    ## 2773               completed writing    72
    ## 2774                    none writing    79
    ## 2775                    none writing    60
    ## 2776                    none writing    55
    ## 2777                    none writing    70
    ## 2778                    none writing    43
    ## 2779               completed writing    82
    ## 2780               completed writing    82
    ## 2781                    none writing    57
    ## 2782                    none writing    84
    ## 2783               completed writing    82
    ## 2784               completed writing    62
    ## 2785               completed writing    79
    ## 2786               completed writing    44
    ## 2787                    none writing    77
    ## 2788                    none writing    32
    ## 2789                    none writing    61
    ## 2790                    none writing    61
    ## 2791                    none writing    60
    ## 2792                    none writing    70
    ## 2793                    none writing    69
    ## 2794               completed writing    77
    ## 2795                    none writing    51
    ## 2796               completed writing    73
    ## 2797                    none writing    70
    ## 2798                    none writing    81
    ## 2799                    none writing    54
    ## 2800                    none writing    57
    ## 2801               completed writing    68
    ## 2802               completed writing    73
    ## 2803                    none writing    95
    ## 2804                    none writing    87
    ## 2805                    none writing    78
    ## 2806                    none writing    74
    ## 2807                    none writing    75
    ## 2808                    none writing    40
    ## 2809                    none writing    69
    ## 2810                    none writing    51
    ## 2811                    none writing    36
    ## 2812                    none writing    49
    ## 2813               completed writing    67
    ## 2814               completed writing    76
    ## 2815                    none writing    83
    ## 2816               completed writing    87
    ## 2817                    none writing    64
    ## 2818               completed writing    76
    ## 2819                    none writing    68
    ## 2820                    none writing    88
    ## 2821               completed writing    92
    ## 2822                    none writing    93
    ## 2823               completed writing    51
    ## 2824                    none writing    82
    ## 2825                    none writing    52
    ## 2826                    none writing    58
    ## 2827               completed writing    70
    ## 2828                    none writing    76
    ## 2829               completed writing    81
    ## 2830                    none writing    53
    ## 2831                    none writing    57
    ## 2832               completed writing    89
    ## 2833                    none writing    58
    ## 2834               completed writing    89
    ## 2835                    none writing    45
    ## 2836               completed writing    74
    ## 2837                    none writing    57
    ## 2838               completed writing    79
    ## 2839               completed writing    53
    ## 2840                    none writing    73
    ## 2841                    none writing    46
    ## 2842                    none writing    51
    ## 2843               completed writing    36
    ## 2844               completed writing    76
    ## 2845               completed writing    64
    ## 2846                    none writing    84
    ## 2847               completed writing    85
    ## 2848                    none writing    50
    ## 2849                    none writing    68
    ## 2850                    none writing    69
    ## 2851                    none writing    67
    ## 2852                    none writing    63
    ## 2853                    none writing    93
    ## 2854                    none writing    61
    ## 2855                    none writing    55
    ## 2856                    none writing    96
    ## 2857                    none writing    65
    ## 2858                    none writing    81
    ## 2859               completed writing    46
    ## 2860                    none writing    72
    ## 2861                    none writing    53
    ## 2862                    none writing    87
    ## 2863               completed writing    38
    ## 2864               completed writing    80
    ## 2865                    none writing    91
    ## 2866               completed writing    88
    ## 2867                    none writing    52
    ## 2868                    none writing    41
    ## 2869               completed writing    72
    ## 2870                    none writing    51
    ## 2871                    none writing    47
    ## 2872               completed writing    76
    ## 2873               completed writing    78
    ## 2874                    none writing    82
    ## 2875                    none writing    61
    ## 2876                    none writing    66
    ## 2877                    none writing    84
    ## 2878                    none writing    54
    ## 2879                    none writing    80
    ## 2880                    none writing    74
    ## 2881               completed writing    66
    ## 2882               completed writing    70
    ## 2883                    none writing    71
    ## 2884                    none writing    44
    ## 2885                    none writing    54
    ## 2886               completed writing    80
    ## 2887               completed writing    95
    ## 2888                    none writing    59
    ## 2889                    none writing    74
    ## 2890                    none writing    48
    ## 2891               completed writing    91
    ## 2892                    none writing    85
    ## 2893                    none writing    73
    ## 2894               completed writing    75
    ## 2895                    none writing    69
    ## 2896                    none writing    38
    ## 2897                    none writing    27
    ## 2898               completed writing    79
    ## 2899               completed writing    63
    ## 2900               completed writing    82
    ## 2901                    none writing    89
    ## 2902                    none writing    74
    ## 2903               completed writing    41
    ## 2904               completed writing   100
    ## 2905                    none writing    84
    ## 2906                    none writing    77
    ## 2907                    none writing    51
    ## 2908               completed writing    91
    ## 2909                    none writing    72
    ## 2910               completed writing    70
    ## 2911                    none writing    48
    ## 2912                    none writing    82
    ## 2913               completed writing    66
    ## 2914               completed writing    66
    ## 2915                    none writing    55
    ## 2916                    none writing    66
    ## 2917               completed writing   100
    ## 2918                    none writing    52
    ## 2919               completed writing    80
    ## 2920               completed writing    91
    ## 2921                    none writing    67
    ## 2922                    none writing    46
    ## 2923                    none writing    66
    ## 2924                    none writing    65
    ## 2925                    none writing    69
    ## 2926               completed writing    60
    ## 2927                    none writing    52
    ## 2928               completed writing    71
    ## 2929               completed writing    44
    ## 2930                    none writing    51
    ## 2931               completed writing    70
    ## 2932                    none writing    62
    ## 2933               completed writing    73
    ## 2934               completed writing    74
    ## 2935               completed writing    90
    ## 2936                    none writing    58
    ## 2937                    none writing    53
    ## 2938                    none writing    57
    ## 2939               completed writing    85
    ## 2940               completed writing    69
    ## 2941               completed writing    72
    ## 2942                    none writing    96
    ## 2943                    none writing    64
    ## 2944               completed writing    61
    ## 2945                    none writing    61
    ## 2946                    none writing    58
    ## 2947                    none writing    80
    ## 2948                    none writing    60
    ## 2949               completed writing    52
    ## 2950               completed writing    73
    ## 2951                    none writing    71
    ## 2952               completed writing    83
    ## 2953                    none writing    72
    ## 2954               completed writing    54
    ## 2955                    none writing    69
    ## 2956                    none writing    62
    ## 2957                    none writing    81
    ## 2958                    none writing   100
    ## 2959                    none writing    59
    ## 2960                    none writing    71
    ## 2961                    none writing    64
    ## 2962                    none writing    53
    ## 2963                    none writing   100
    ## 2964               completed writing    75
    ## 2965                    none writing    58
    ## 2966                    none writing    72
    ## 2967               completed writing    64
    ## 2968                    none writing    60
    ## 2969                    none writing    67
    ## 2970                    none writing    80
    ## 2971                    none writing   100
    ## 2972               completed writing    69
    ## 2973               completed writing    60
    ## 2974                    none writing    61
    ## 2975                    none writing    67
    ## 2976               completed writing    77
    ## 2977               completed writing    60
    ## 2978                    none writing    58
    ## 2979               completed writing    48
    ## 2980                    none writing    94
    ## 2981                    none writing    23
    ## 2982                    none writing    78
    ## 2983               completed writing    86
    ## 2984               completed writing    91
    ## 2985                    none writing    82
    ## 2986                    none writing    54
    ## 2987                    none writing    51
    ## 2988               completed writing    76
    ## 2989                    none writing    45
    ## 2990               completed writing    83
    ## 2991               completed writing    75
    ## 2992               completed writing    78
    ## 2993                    none writing    76
    ## 2994                    none writing    74
    ## 2995                    none writing    62
    ## 2996               completed writing    95
    ## 2997                    none writing    55
    ## 2998               completed writing    65
    ## 2999               completed writing    77
    ## 3000                    none writing    86

dplyr
-----

dplyr is a grammar of data manipulation, providing a consistent set of
verbs that help you solve the most common data manipulation challenges

**filter（）：Use filter() find rows/cases where conditions are true. **

We use filter to show the result of math.

``` r
Math_Score<-filter(Students,Subject=="math")
Math_Score
```

    ##      Gender    Race    Parent_Eduction        Lunch
    ## 1    female group B  bachelor's degree     standard
    ## 2    female group C       some college     standard
    ## 3    female group B    master's degree     standard
    ## 4      male group A associate's degree free/reduced
    ## 5      male group C       some college     standard
    ## 6    female group B associate's degree     standard
    ## 7    female group B       some college     standard
    ## 8      male group B       some college free/reduced
    ## 9      male group D        high school free/reduced
    ## 10   female group B        high school free/reduced
    ## 11     male group C associate's degree     standard
    ## 12     male group D associate's degree     standard
    ## 13   female group B        high school     standard
    ## 14     male group A       some college     standard
    ## 15   female group A    master's degree     standard
    ## 16   female group C   some high school     standard
    ## 17     male group C        high school     standard
    ## 18   female group B   some high school free/reduced
    ## 19     male group C    master's degree free/reduced
    ## 20   female group C associate's degree free/reduced
    ## 21     male group D        high school     standard
    ## 22   female group B       some college free/reduced
    ## 23     male group D       some college     standard
    ## 24   female group C   some high school     standard
    ## 25     male group D  bachelor's degree free/reduced
    ## 26     male group A    master's degree free/reduced
    ## 27     male group B       some college     standard
    ## 28   female group C  bachelor's degree     standard
    ## 29     male group C        high school     standard
    ## 30   female group D    master's degree     standard
    ## 31   female group D       some college     standard
    ## 32   female group B       some college     standard
    ## 33   female group E    master's degree free/reduced
    ## 34     male group D       some college     standard
    ## 35     male group E       some college     standard
    ## 36     male group E associate's degree     standard
    ## 37   female group D associate's degree     standard
    ## 38   female group D   some high school free/reduced
    ## 39   female group D associate's degree free/reduced
    ## 40     male group B associate's degree free/reduced
    ## 41     male group C associate's degree free/reduced
    ## 42   female group C associate's degree     standard
    ## 43   female group B associate's degree     standard
    ## 44     male group B       some college free/reduced
    ## 45   female group E associate's degree free/reduced
    ## 46     male group B associate's degree     standard
    ## 47   female group A associate's degree     standard
    ## 48   female group C        high school     standard
    ## 49   female group D associate's degree free/reduced
    ## 50     male group C        high school     standard
    ## 51     male group E       some college     standard
    ## 52     male group E associate's degree free/reduced
    ## 53     male group C       some college     standard
    ## 54     male group D        high school     standard
    ## 55   female group C   some high school free/reduced
    ## 56   female group C        high school free/reduced
    ## 57   female group E associate's degree     standard
    ## 58     male group D associate's degree     standard
    ## 59     male group D       some college     standard
    ## 60   female group C   some high school free/reduced
    ## 61     male group E  bachelor's degree free/reduced
    ## 62     male group A   some high school free/reduced
    ## 63     male group A associate's degree free/reduced
    ## 64   female group C associate's degree     standard
    ## 65   female group D   some high school     standard
    ## 66     male group B   some high school     standard
    ## 67     male group D   some high school free/reduced
    ## 68   female group C       some college     standard
    ## 69     male group B associate's degree free/reduced
    ## 70   female group C associate's degree     standard
    ## 71   female group D       some college free/reduced
    ## 72     male group D       some college     standard
    ## 73   female group A associate's degree free/reduced
    ## 74     male group C   some high school free/reduced
    ## 75     male group C   some high school     standard
    ## 76     male group B associate's degree free/reduced
    ## 77     male group E   some high school     standard
    ## 78     male group A  bachelor's degree     standard
    ## 79   female group D   some high school     standard
    ## 80   female group E    master's degree     standard
    ## 81   female group B associate's degree     standard
    ## 82     male group B        high school free/reduced
    ## 83     male group A       some college free/reduced
    ## 84     male group E associate's degree     standard
    ## 85     male group D        high school free/reduced
    ## 86   female group C       some college     standard
    ## 87   female group C       some college free/reduced
    ## 88   female group D associate's degree     standard
    ## 89   female group A       some college     standard
    ## 90   female group D   some high school     standard
    ## 91   female group C  bachelor's degree     standard
    ## 92     male group C        high school free/reduced
    ## 93     male group C        high school     standard
    ## 94     male group C associate's degree free/reduced
    ## 95   female group B       some college     standard
    ## 96     male group C associate's degree free/reduced
    ## 97     male group B   some high school     standard
    ## 98   female group E       some college     standard
    ## 99   female group D       some college free/reduced
    ## 100  female group D  bachelor's degree     standard
    ## 101    male group B       some college     standard
    ## 102    male group D  bachelor's degree     standard
    ## 103  female group D associate's degree     standard
    ## 104    male group B        high school     standard
    ## 105    male group C       some college     standard
    ## 106  female group C       some college     standard
    ## 107  female group D    master's degree     standard
    ## 108    male group E associate's degree     standard
    ## 109  female group B associate's degree free/reduced
    ## 110  female group B   some high school     standard
    ## 111  female group D associate's degree free/reduced
    ## 112    male group C        high school     standard
    ## 113    male group A associate's degree     standard
    ## 114  female group D       some college     standard
    ## 115  female group E  bachelor's degree     standard
    ## 116    male group C        high school     standard
    ## 117  female group B  bachelor's degree free/reduced
    ## 118  female group D  bachelor's degree     standard
    ## 119  female group D   some high school     standard
    ## 120  female group C       some college     standard
    ## 121  female group C  bachelor's degree     standard
    ## 122    male group B associate's degree     standard
    ## 123  female group C       some college     standard
    ## 124    male group D        high school free/reduced
    ## 125    male group E       some college     standard
    ## 126  female group B        high school     standard
    ## 127    male group B   some high school     standard
    ## 128    male group D       some college     standard
    ## 129    male group D    master's degree     standard
    ## 130  female group A  bachelor's degree     standard
    ## 131    male group D    master's degree     standard
    ## 132    male group C   some high school free/reduced
    ## 133    male group E       some college free/reduced
    ## 134  female group C       some college     standard
    ## 135    male group D  bachelor's degree free/reduced
    ## 136    male group C  bachelor's degree     standard
    ## 137    male group B   some high school     standard
    ## 138    male group E        high school     standard
    ## 139  female group C associate's degree     standard
    ## 140    male group D       some college     standard
    ## 141  female group D   some high school     standard
    ## 142  female group C       some college free/reduced
    ## 143  female group E       some college free/reduced
    ## 144    male group A        high school     standard
    ## 145    male group D       some college     standard
    ## 146  female group C       some college free/reduced
    ## 147    male group B   some high school     standard
    ## 148    male group C associate's degree free/reduced
    ## 149  female group D  bachelor's degree     standard
    ## 150    male group E associate's degree free/reduced
    ## 151    male group A   some high school     standard
    ## 152    male group A  bachelor's degree     standard
    ## 153  female group B associate's degree     standard
    ## 154    male group D  bachelor's degree     standard
    ## 155    male group D   some high school     standard
    ## 156  female group C       some college     standard
    ## 157  female group E        high school free/reduced
    ## 158    male group B       some college free/reduced
    ## 159  female group B associate's degree     standard
    ## 160    male group D associate's degree free/reduced
    ## 161    male group B associate's degree free/reduced
    ## 162  female group E       some college free/reduced
    ## 163    male group B    master's degree free/reduced
    ## 164    male group C        high school     standard
    ## 165  female group E    master's degree     standard
    ## 166  female group C  bachelor's degree     standard
    ## 167    male group C        high school free/reduced
    ## 168  female group B    master's degree free/reduced
    ## 169  female group B        high school     standard
    ## 170  female group C       some college free/reduced
    ## 171    male group A        high school     standard
    ## 172    male group E   some high school     standard
    ## 173  female group D       some college     standard
    ## 174  female group C associate's degree     standard
    ## 175  female group C  bachelor's degree free/reduced
    ## 176  female group C    master's degree     standard
    ## 177  female group B        high school free/reduced
    ## 178  female group C associate's degree     standard
    ## 179  female group B    master's degree free/reduced
    ## 180  female group D   some high school     standard
    ## 181    male group C    master's degree free/reduced
    ## 182  female group C       some college free/reduced
    ## 183  female group E        high school     standard
    ## 184  female group D associate's degree     standard
    ## 185    male group C   some high school free/reduced
    ## 186    male group C associate's degree free/reduced
    ## 187    male group E        high school     standard
    ## 188    male group D   some high school     standard
    ## 189    male group B   some high school free/reduced
    ## 190  female group C  bachelor's degree     standard
    ## 191  female group E associate's degree     standard
    ## 192    male group D       some college     standard
    ## 193  female group B   some high school     standard
    ## 194    male group D       some college     standard
    ## 195  female group C    master's degree     standard
    ## 196    male group D associate's degree     standard
    ## 197    male group C   some high school free/reduced
    ## 198    male group E        high school free/reduced
    ## 199  female group B       some college free/reduced
    ## 200  female group B  bachelor's degree free/reduced
    ## 201  female group C associate's degree     standard
    ## 202  female group D       some college free/reduced
    ## 203    male group C associate's degree     standard
    ## 204  female group B associate's degree     standard
    ## 205    male group C       some college     standard
    ## 206    male group D   some high school     standard
    ## 207    male group E  bachelor's degree     standard
    ## 208    male group E        high school     standard
    ## 209  female group B       some college free/reduced
    ## 210  female group B       some college free/reduced
    ## 211    male group D   some high school free/reduced
    ## 212    male group C       some college free/reduced
    ## 213  female group C        high school free/reduced
    ## 214    male group C associate's degree free/reduced
    ## 215    male group E        high school     standard
    ## 216    male group B   some high school     standard
    ## 217  female group E associate's degree free/reduced
    ## 218  female group C        high school free/reduced
    ## 219    male group B        high school free/reduced
    ## 220    male group B   some high school     standard
    ## 221  female group D        high school     standard
    ## 222    male group B associate's degree     standard
    ## 223  female group C   some high school free/reduced
    ## 224    male group D   some high school     standard
    ## 225  female group B associate's degree     standard
    ## 226  female group E    master's degree free/reduced
    ## 227  female group C       some college     standard
    ## 228    male group D        high school     standard
    ## 229    male group A   some high school free/reduced
    ## 230  female group C       some college     standard
    ## 231    male group D       some college     standard
    ## 232    male group C associate's degree     standard
    ## 233  female group B  bachelor's degree     standard
    ## 234    male group E   some high school     standard
    ## 235    male group C  bachelor's degree     standard
    ## 236    male group D associate's degree     standard
    ## 237    male group D  bachelor's degree free/reduced
    ## 238  female group D   some high school     standard
    ## 239    male group B       some college     standard
    ## 240    male group C associate's degree     standard
    ## 241    male group D        high school free/reduced
    ## 242  female group E  bachelor's degree     standard
    ## 243  female group D        high school     standard
    ## 244    male group E       some college     standard
    ## 245    male group D   some high school     standard
    ## 246    male group C associate's degree     standard
    ## 247    male group E associate's degree     standard
    ## 248  female group B        high school     standard
    ## 249  female group B        high school     standard
    ## 250    male group C        high school     standard
    ## 251    male group A   some high school     standard
    ## 252  female group D       some college free/reduced
    ## 253  female group B   some high school     standard
    ## 254    male group D    master's degree     standard
    ## 255    male group D        high school     standard
    ## 256  female group E       some college     standard
    ## 257  female group C associate's degree free/reduced
    ## 258    male group C associate's degree     standard
    ## 259  female group B       some college     standard
    ## 260  female group C    master's degree free/reduced
    ## 261  female group C   some high school free/reduced
    ## 262    male group C       some college     standard
    ## 263  female group C   some high school free/reduced
    ## 264  female group E        high school     standard
    ## 265    male group D        high school     standard
    ## 266    male group D   some high school free/reduced
    ## 267  female group C  bachelor's degree     standard
    ## 268  female group D        high school     standard
    ## 269  female group D associate's degree     standard
    ## 270  female group E       some college free/reduced
    ## 271    male group C  bachelor's degree     standard
    ## 272    male group C       some college     standard
    ## 273  female group D associate's degree free/reduced
    ## 274  female group D       some college     standard
    ## 275    male group B       some college     standard
    ## 276    male group C  bachelor's degree     standard
    ## 277  female group C   some high school     standard
    ## 278  female group E        high school     standard
    ## 279  female group C   some high school free/reduced
    ## 280    male group B  bachelor's degree free/reduced
    ## 281    male group D        high school     standard
    ## 282    male group D        high school     standard
    ## 283  female group D  bachelor's degree free/reduced
    ## 284  female group D       some college free/reduced
    ## 285  female group B   some high school     standard
    ## 286    male group B associate's degree     standard
    ## 287    male group E associate's degree     standard
    ## 288  female group B   some high school     standard
    ## 289    male group B  bachelor's degree free/reduced
    ## 290    male group E   some high school     standard
    ## 291    male group C associate's degree     standard
    ## 292    male group D   some high school     standard
    ## 293    male group C   some high school     standard
    ## 294  female group E  bachelor's degree     standard
    ## 295    male group D        high school free/reduced
    ## 296    male group B associate's degree free/reduced
    ## 297    male group A   some high school     standard
    ## 298    male group E associate's degree     standard
    ## 299    male group C        high school free/reduced
    ## 300    male group D associate's degree free/reduced
    ## 301    male group A       some college free/reduced
    ## 302    male group D   some high school free/reduced
    ## 303  female group C associate's degree     standard
    ## 304    male group B associate's degree     standard
    ## 305  female group C associate's degree     standard
    ## 306    male group A       some college     standard
    ## 307    male group E       some college     standard
    ## 308    male group C   some high school     standard
    ## 309  female group B associate's degree free/reduced
    ## 310  female group D        high school free/reduced
    ## 311  female group B associate's degree     standard
    ## 312    male group B  bachelor's degree     standard
    ## 313    male group D  bachelor's degree     standard
    ## 314  female group C associate's degree free/reduced
    ## 315  female group C  bachelor's degree     standard
    ## 316    male group C        high school     standard
    ## 317  female group D    master's degree     standard
    ## 318    male group C associate's degree     standard
    ## 319    male group B  bachelor's degree     standard
    ## 320  female group D associate's degree free/reduced
    ## 321  female group C        high school free/reduced
    ## 322  female group E        high school     standard
    ## 323  female group C       some college     standard
    ## 324  female group C   some high school free/reduced
    ## 325  female group C        high school free/reduced
    ## 326  female group C       some college     standard
    ## 327    male group C       some college     standard
    ## 328    male group A       some college free/reduced
    ## 329    male group C associate's degree     standard
    ## 330  female group B   some high school     standard
    ## 331    male group C        high school     standard
    ## 332    male group C associate's degree     standard
    ## 333    male group E associate's degree     standard
    ## 334    male group B associate's degree     standard
    ## 335  female group C  bachelor's degree     standard
    ## 336  female group B       some college free/reduced
    ## 337    male group D   some high school     standard
    ## 338    male group C associate's degree     standard
    ## 339  female group B   some high school free/reduced
    ## 340  female group D   some high school free/reduced
    ## 341    male group C        high school free/reduced
    ## 342  female group C        high school     standard
    ## 343  female group B        high school     standard
    ## 344    male group D associate's degree     standard
    ## 345    male group D       some college     standard
    ## 346  female group C        high school     standard
    ## 347    male group B       some college     standard
    ## 348  female group C  bachelor's degree     standard
    ## 349    male group D        high school free/reduced
    ## 350    male group E associate's degree     standard
    ## 351  female group B  bachelor's degree     standard
    ## 352    male group E       some college     standard
    ## 353  female group C       some college     standard
    ## 354  female group C associate's degree     standard
    ## 355  female group C       some college     standard
    ## 356  female group B  bachelor's degree     standard
    ## 357    male group A associate's degree     standard
    ## 358  female group C       some college free/reduced
    ## 359    male group D       some college free/reduced
    ## 360  female group D       some college     standard
    ## 361  female group B        high school     standard
    ## 362    male group B   some high school     standard
    ## 363  female group C       some college     standard
    ## 364  female group D   some high school free/reduced
    ## 365    male group C       some college     standard
    ## 366    male group A  bachelor's degree free/reduced
    ## 367    male group C        high school     standard
    ## 368    male group C  bachelor's degree free/reduced
    ## 369  female group A   some high school free/reduced
    ## 370  female group D   some high school     standard
    ## 371    male group E       some college     standard
    ## 372  female group C       some college free/reduced
    ## 373    male group D   some high school     standard
    ## 374  female group D       some college     standard
    ## 375  female group D  bachelor's degree     standard
    ## 376    male group E associate's degree free/reduced
    ## 377  female group D   some high school     standard
    ## 378  female group D    master's degree free/reduced
    ## 379  female group A   some high school     standard
    ## 380    male group A  bachelor's degree     standard
    ## 381  female group B associate's degree     standard
    ## 382    male group C associate's degree     standard
    ## 383    male group C    master's degree free/reduced
    ## 384  female group E   some high school free/reduced
    ## 385  female group A   some high school free/reduced
    ## 386  female group E       some college     standard
    ## 387  female group E  bachelor's degree     standard
    ## 388  female group C associate's degree free/reduced
    ## 389  female group D        high school     standard
    ## 390    male group D    master's degree     standard
    ## 391    male group E   some high school free/reduced
    ## 392  female group D       some college     standard
    ## 393    male group E       some college     standard
    ## 394    male group C associate's degree     standard
    ## 395  female group C   some high school     standard
    ## 396    male group A        high school free/reduced
    ## 397  female group B        high school free/reduced
    ## 398  female group C associate's degree     standard
    ## 399    male group B   some high school     standard
    ## 400    male group D   some high school     standard
    ## 401  female group C   some high school     standard
    ## 402    male group A       some college     standard
    ## 403  female group A       some college free/reduced
    ## 404  female group D        high school     standard
    ## 405  female group C        high school     standard
    ## 406  female group C   some high school     standard
    ## 407    male group B associate's degree     standard
    ## 408  female group B associate's degree     standard
    ## 409  female group D        high school free/reduced
    ## 410    male group D associate's degree     standard
    ## 411  female group D    master's degree     standard
    ## 412    male group E       some college     standard
    ## 413    male group D associate's degree     standard
    ## 414    male group B   some high school     standard
    ## 415  female group C  bachelor's degree free/reduced
    ## 416    male group E        high school     standard
    ## 417    male group C  bachelor's degree     standard
    ## 418    male group C associate's degree     standard
    ## 419    male group D       some college     standard
    ## 420    male group E        high school free/reduced
    ## 421  female group C associate's degree free/reduced
    ## 422  female group D        high school     standard
    ## 423  female group D    master's degree free/reduced
    ## 424  female group A   some high school     standard
    ## 425    male group B       some college free/reduced
    ## 426  female group C       some college free/reduced
    ## 427    male group C  bachelor's degree     standard
    ## 428    male group C   some high school free/reduced
    ## 429    male group A   some high school free/reduced
    ## 430    male group C   some high school free/reduced
    ## 431    male group C associate's degree free/reduced
    ## 432  female group C        high school     standard
    ## 433    male group C        high school     standard
    ## 434  female group A   some high school free/reduced
    ## 435    male group C   some high school     standard
    ## 436    male group C       some college free/reduced
    ## 437    male group D associate's degree     standard
    ## 438    male group D associate's degree free/reduced
    ## 439    male group C        high school     standard
    ## 440    male group D   some high school     standard
    ## 441  female group C       some college     standard
    ## 442  female group D        high school     standard
    ## 443  female group A   some high school free/reduced
    ## 444  female group B associate's degree     standard
    ## 445    male group A   some high school free/reduced
    ## 446  female group C   some high school     standard
    ## 447    male group D       some college free/reduced
    ## 448    male group C        high school     standard
    ## 449    male group B        high school     standard
    ## 450    male group B associate's degree     standard
    ## 451  female group C       some college free/reduced
    ## 452  female group E       some college     standard
    ## 453  female group C associate's degree free/reduced
    ## 454    male group C       some college free/reduced
    ## 455  female group C associate's degree free/reduced
    ## 456    male group C  bachelor's degree free/reduced
    ## 457  female group D  bachelor's degree     standard
    ## 458    male group D associate's degree free/reduced
    ## 459  female group E  bachelor's degree     standard
    ## 460    male group B        high school     standard
    ## 461    male group C  bachelor's degree free/reduced
    ## 462    male group B       some college free/reduced
    ## 463  female group E       some college     standard
    ## 464  female group C       some college free/reduced
    ## 465    male group A  bachelor's degree     standard
    ## 466  female group C       some college     standard
    ## 467  female group D associate's degree free/reduced
    ## 468    male group A        high school free/reduced
    ## 469  female group A        high school free/reduced
    ## 470    male group C       some college     standard
    ## 471  female group C associate's degree     standard
    ## 472  female group C        high school     standard
    ## 473  female group C associate's degree     standard
    ## 474  female group D   some high school     standard
    ## 475  female group B associate's degree     standard
    ## 476  female group D  bachelor's degree     standard
    ## 477    male group E  bachelor's degree     standard
    ## 478    male group D associate's degree     standard
    ## 479  female group D    master's degree     standard
    ## 480    male group E associate's degree     standard
    ## 481    male group B        high school     standard
    ## 482  female group D associate's degree free/reduced
    ## 483    male group C       some college free/reduced
    ## 484    male group A        high school     standard
    ## 485  female group B associate's degree     standard
    ## 486    male group C        high school     standard
    ## 487    male group D       some college free/reduced
    ## 488  female group C associate's degree free/reduced
    ## 489    male group B   some high school     standard
    ## 490    male group A associate's degree free/reduced
    ## 491  female group A associate's degree free/reduced
    ## 492  female group C associate's degree     standard
    ## 493  female group C       some college     standard
    ## 494  female group C  bachelor's degree     standard
    ## 495  female group B        high school     standard
    ## 496    male group D        high school     standard
    ## 497  female group C       some college     standard
    ## 498  female group D       some college free/reduced
    ## 499  female group B   some high school     standard
    ## 500    male group E       some college     standard
    ## 501  female group D    master's degree     standard
    ## 502  female group B associate's degree     standard
    ## 503    male group C       some college free/reduced
    ## 504  female group E associate's degree     standard
    ## 505  female group D    master's degree free/reduced
    ## 506  female group B   some high school     standard
    ## 507    male group A        high school     standard
    ## 508    male group B  bachelor's degree free/reduced
    ## 509    male group C    master's degree     standard
    ## 510  female group C  bachelor's degree     standard
    ## 511    male group D       some college     standard
    ## 512    male group A   some high school     standard
    ## 513    male group D   some high school free/reduced
    ## 514  female group B   some high school     standard
    ## 515  female group B    master's degree free/reduced
    ## 516  female group C   some high school     standard
    ## 517  female group D       some college     standard
    ## 518  female group E       some college     standard
    ## 519  female group D   some high school     standard
    ## 520  female group B        high school free/reduced
    ## 521    male group D       some college     standard
    ## 522  female group C associate's degree     standard
    ## 523    male group D  bachelor's degree     standard
    ## 524    male group C    master's degree free/reduced
    ## 525    male group C        high school     standard
    ## 526    male group E       some college     standard
    ## 527    male group C   some high school free/reduced
    ## 528  female group C        high school free/reduced
    ## 529  female group D  bachelor's degree free/reduced
    ## 530  female group C associate's degree     standard
    ## 531  female group C associate's degree     standard
    ## 532  female group C   some high school     standard
    ## 533    male group E associate's degree     standard
    ## 534  female group E associate's degree     standard
    ## 535    male group B        high school     standard
    ## 536  female group C  bachelor's degree free/reduced
    ## 537    male group C associate's degree     standard
    ## 538  female group D        high school     standard
    ## 539    male group E  bachelor's degree     standard
    ## 540    male group A associate's degree     standard
    ## 541    male group C        high school     standard
    ## 542    male group D associate's degree free/reduced
    ## 543  female group C associate's degree     standard
    ## 544  female group D associate's degree     standard
    ## 545  female group D    master's degree     standard
    ## 546    male group E   some high school free/reduced
    ## 547  female group A   some high school     standard
    ## 548    male group C        high school     standard
    ## 549  female group C        high school free/reduced
    ## 550    male group C    master's degree     standard
    ## 551    male group C   some high school free/reduced
    ## 552    male group B  bachelor's degree free/reduced
    ## 553  female group B associate's degree     standard
    ## 554    male group D       some college free/reduced
    ## 555    male group E associate's degree     standard
    ## 556  female group C       some college free/reduced
    ## 557  female group C associate's degree     standard
    ## 558    male group C    master's degree free/reduced
    ## 559  female group B associate's degree free/reduced
    ## 560    male group D   some high school     standard
    ## 561  female group D       some college     standard
    ## 562  female group C       some college     standard
    ## 563    male group C  bachelor's degree     standard
    ## 564  female group D       some college free/reduced
    ## 565    male group B  bachelor's degree free/reduced
    ## 566    male group B associate's degree     standard
    ## 567  female group E  bachelor's degree free/reduced
    ## 568  female group D    master's degree free/reduced
    ## 569    male group B        high school free/reduced
    ## 570    male group D  bachelor's degree free/reduced
    ## 571    male group B       some college     standard
    ## 572    male group A  bachelor's degree     standard
    ## 573  female group C       some college     standard
    ## 574  female group C        high school free/reduced
    ## 575  female group E        high school     standard
    ## 576    male group A associate's degree free/reduced
    ## 577    male group A       some college     standard
    ## 578  female group B        high school     standard
    ## 579  female group B       some college free/reduced
    ## 580  female group D    master's degree     standard
    ## 581  female group D   some high school     standard
    ## 582  female group E   some high school     standard
    ## 583  female group D  bachelor's degree free/reduced
    ## 584  female group D associate's degree     standard
    ## 585  female group D       some college     standard
    ## 586  female group C associate's degree     standard
    ## 587  female group A        high school     standard
    ## 588  female group C  bachelor's degree free/reduced
    ## 589  female group C       some college     standard
    ## 590  female group A   some high school     standard
    ## 591    male group C       some college free/reduced
    ## 592    male group A   some high school     standard
    ## 593    male group E  bachelor's degree     standard
    ## 594  female group E        high school     standard
    ## 595  female group C  bachelor's degree     standard
    ## 596  female group C  bachelor's degree     standard
    ## 597    male group B        high school free/reduced
    ## 598    male group A   some high school     standard
    ## 599  female group D        high school     standard
    ## 600  female group D   some high school     standard
    ## 601  female group D    master's degree     standard
    ## 602  female group C        high school     standard
    ## 603  female group E       some college     standard
    ## 604    male group D        high school free/reduced
    ## 605    male group D    master's degree free/reduced
    ## 606    male group C   some high school     standard
    ## 607  female group C associate's degree     standard
    ## 608  female group C    master's degree free/reduced
    ## 609  female group E       some college     standard
    ## 610  female group B associate's degree     standard
    ## 611    male group D       some college free/reduced
    ## 612  female group C       some college     standard
    ## 613    male group C  bachelor's degree     standard
    ## 614  female group C associate's degree     standard
    ## 615  female group A associate's degree     standard
    ## 616  female group C        high school     standard
    ## 617  female group E  bachelor's degree     standard
    ## 618    male group D  bachelor's degree     standard
    ## 619    male group D    master's degree     standard
    ## 620    male group C associate's degree free/reduced
    ## 621  female group C        high school free/reduced
    ## 622    male group B  bachelor's degree free/reduced
    ## 623    male group C        high school free/reduced
    ## 624    male group A       some college     standard
    ## 625  female group E  bachelor's degree free/reduced
    ## 626    male group D       some college     standard
    ## 627    male group B associate's degree free/reduced
    ## 628    male group D associate's degree     standard
    ## 629    male group D       some college free/reduced
    ## 630  female group C   some high school     standard
    ## 631    male group D       some college     standard
    ## 632    male group B        high school     standard
    ## 633  female group B  bachelor's degree     standard
    ## 634  female group C        high school     standard
    ## 635    male group D   some high school     standard
    ## 636    male group A        high school     standard
    ## 637  female group B        high school free/reduced
    ## 638  female group D   some high school     standard
    ## 639    male group E       some college     standard
    ## 640  female group D associate's degree     standard
    ## 641    male group D        high school     standard
    ## 642  female group D associate's degree free/reduced
    ## 643  female group B   some high school free/reduced
    ## 644  female group E        high school     standard
    ## 645    male group B        high school     standard
    ## 646  female group B  bachelor's degree     standard
    ## 647  female group D associate's degree     standard
    ## 648  female group E        high school free/reduced
    ## 649  female group B        high school     standard
    ## 650  female group D       some college     standard
    ## 651    male group C   some high school free/reduced
    ## 652  female group A        high school     standard
    ## 653  female group D       some college     standard
    ## 654  female group A associate's degree     standard
    ## 655  female group B   some high school     standard
    ## 656  female group B       some college     standard
    ## 657    male group C associate's degree free/reduced
    ## 658    male group D   some high school     standard
    ## 659  female group D associate's degree free/reduced
    ## 660    male group D associate's degree     standard
    ## 661    male group C       some college free/reduced
    ## 662    male group C   some high school     standard
    ## 663  female group D       some college free/reduced
    ## 664  female group C        high school     standard
    ## 665    male group D associate's degree     standard
    ## 666  female group C   some high school free/reduced
    ## 667  female group C       some college free/reduced
    ## 668  female group B  bachelor's degree free/reduced
    ## 669    male group C       some college     standard
    ## 670    male group D associate's degree     standard
    ## 671  female group C        high school free/reduced
    ## 672    male group D associate's degree free/reduced
    ## 673  female group C       some college     standard
    ## 674  female group C associate's degree     standard
    ## 675  female group D        high school     standard
    ## 676  female group B       some college     standard
    ## 677  female group E       some college     standard
    ## 678  female group C   some high school     standard
    ## 679    male group D associate's degree free/reduced
    ## 680    male group D       some college free/reduced
    ## 681  female group D        high school     standard
    ## 682    male group B        high school     standard
    ## 683    male group B        high school     standard
    ## 684  female group C   some high school free/reduced
    ## 685    male group B       some college     standard
    ## 686  female group E    master's degree     standard
    ## 687    male group E       some college     standard
    ## 688    male group D associate's degree free/reduced
    ## 689    male group A        high school free/reduced
    ## 690    male group E       some college free/reduced
    ## 691  female group C associate's degree     standard
    ## 692  female group E associate's degree free/reduced
    ## 693  female group C  bachelor's degree free/reduced
    ## 694  female group D associate's degree     standard
    ## 695  female group C   some high school     standard
    ## 696  female group D       some college free/reduced
    ## 697  female group C associate's degree     standard
    ## 698  female group A  bachelor's degree     standard
    ## 699  female group D associate's degree     standard
    ## 700    male group C        high school free/reduced
    ## 701  female group E  bachelor's degree     standard
    ## 702  female group B   some high school     standard
    ## 703    male group A  bachelor's degree     standard
    ## 704  female group D       some college     standard
    ## 705  female group B   some high school free/reduced
    ## 706    male group A  bachelor's degree free/reduced
    ## 707    male group D        high school     standard
    ## 708    male group C       some college     standard
    ## 709    male group D        high school     standard
    ## 710  female group D associate's degree free/reduced
    ## 711    male group C       some college     standard
    ## 712  female group E   some high school     standard
    ## 713  female group D       some college     standard
    ## 714    male group D    master's degree     standard
    ## 715  female group B   some high school     standard
    ## 716  female group B associate's degree free/reduced
    ## 717    male group C associate's degree     standard
    ## 718  female group C associate's degree     standard
    ## 719  female group C        high school     standard
    ## 720    male group E associate's degree free/reduced
    ## 721  female group C       some college free/reduced
    ## 722    male group D   some high school free/reduced
    ## 723  female group B   some high school free/reduced
    ## 724    male group C        high school     standard
    ## 725    male group B       some college     standard
    ## 726    male group E       some college     standard
    ## 727  female group E associate's degree     standard
    ## 728    male group E   some high school     standard
    ## 729  female group D        high school free/reduced
    ## 730    male group C       some college     standard
    ## 731  female group B associate's degree free/reduced
    ## 732    male group A   some high school free/reduced
    ## 733  female group C       some college     standard
    ## 734    male group D   some high school     standard
    ## 735  female group E       some college free/reduced
    ## 736    male group C    master's degree     standard
    ## 737    male group C associate's degree     standard
    ## 738  female group B       some college free/reduced
    ## 739    male group D associate's degree     standard
    ## 740    male group C        high school free/reduced
    ## 741    male group D  bachelor's degree     standard
    ## 742  female group A associate's degree free/reduced
    ## 743  female group C        high school     standard
    ## 744  female group C associate's degree     standard
    ## 745    male group B       some college free/reduced
    ## 746    male group D associate's degree     standard
    ## 747    male group D        high school     standard
    ## 748    male group C       some college     standard
    ## 749  female group C  bachelor's degree free/reduced
    ## 750    male group B       some college     standard
    ## 751    male group D   some high school     standard
    ## 752    male group E       some college     standard
    ## 753    male group C    master's degree free/reduced
    ## 754  female group C   some high school     standard
    ## 755    male group C associate's degree free/reduced
    ## 756  female group E associate's degree     standard
    ## 757    male group D       some college     standard
    ## 758    male group E  bachelor's degree free/reduced
    ## 759  female group D       some college free/reduced
    ## 760    male group B       some college     standard
    ## 761  female group C        high school free/reduced
    ## 762  female group D   some high school     standard
    ## 763    male group D   some high school     standard
    ## 764  female group B        high school     standard
    ## 765    male group D       some college     standard
    ## 766  female group B        high school     standard
    ## 767  female group C        high school     standard
    ## 768    male group B        high school     standard
    ## 769  female group D   some high school     standard
    ## 770    male group A       some college free/reduced
    ## 771    male group B        high school     standard
    ## 772    male group D  bachelor's degree     standard
    ## 773  female group B   some high school free/reduced
    ## 774  female group C  bachelor's degree free/reduced
    ## 775    male group B       some college     standard
    ## 776  female group B   some high school free/reduced
    ## 777  female group B        high school     standard
    ## 778  female group C       some college free/reduced
    ## 779  female group A       some college     standard
    ## 780    male group E associate's degree     standard
    ## 781  female group D associate's degree free/reduced
    ## 782  female group B    master's degree     standard
    ## 783  female group B        high school free/reduced
    ## 784  female group C associate's degree     standard
    ## 785    male group C  bachelor's degree     standard
    ## 786  female group B   some high school     standard
    ## 787  female group E   some high school free/reduced
    ## 788  female group B       some college     standard
    ## 789    male group C associate's degree free/reduced
    ## 790  female group C    master's degree free/reduced
    ## 791  female group B        high school     standard
    ## 792  female group D       some college free/reduced
    ## 793    male group D        high school free/reduced
    ## 794    male group E   some high school     standard
    ## 795  female group B        high school     standard
    ## 796  female group E associate's degree free/reduced
    ## 797    male group D        high school     standard
    ## 798  female group E associate's degree free/reduced
    ## 799    male group E       some college     standard
    ## 800  female group C associate's degree     standard
    ## 801    male group C   some high school     standard
    ## 802    male group C   some high school     standard
    ## 803  female group E associate's degree     standard
    ## 804  female group B       some college     standard
    ## 805  female group C       some college     standard
    ## 806    male group A       some college free/reduced
    ## 807  female group D       some college free/reduced
    ## 808  female group E        high school free/reduced
    ## 809    male group C        high school     standard
    ## 810    male group B  bachelor's degree     standard
    ## 811    male group A   some high school     standard
    ## 812    male group A        high school free/reduced
    ## 813  female group C    master's degree     standard
    ## 814    male group E   some high school     standard
    ## 815  female group C        high school     standard
    ## 816    male group B   some high school     standard
    ## 817  female group A  bachelor's degree     standard
    ## 818    male group D  bachelor's degree free/reduced
    ## 819  female group B        high school free/reduced
    ## 820  female group C   some high school     standard
    ## 821  female group A   some high school     standard
    ## 822  female group D  bachelor's degree free/reduced
    ## 823    male group E       some college free/reduced
    ## 824  female group B        high school free/reduced
    ## 825  female group C   some high school free/reduced
    ## 826    male group C        high school     standard
    ## 827  female group C associate's degree free/reduced
    ## 828  female group C   some high school     standard
    ## 829  female group D   some high school free/reduced
    ## 830    male group B   some high school     standard
    ## 831  female group A       some college free/reduced
    ## 832  female group C  bachelor's degree free/reduced
    ## 833    male group A  bachelor's degree     standard
    ## 834  female group B        high school     standard
    ## 835    male group B       some college     standard
    ## 836  female group C        high school     standard
    ## 837    male group E        high school     standard
    ## 838  female group A        high school     standard
    ## 839    male group B associate's degree free/reduced
    ## 840  female group C associate's degree     standard
    ## 841  female group D        high school free/reduced
    ## 842    male group C   some high school     standard
    ## 843  female group B        high school free/reduced
    ## 844    male group B       some college free/reduced
    ## 845  female group D   some high school free/reduced
    ## 846    male group E    master's degree     standard
    ## 847    male group C    master's degree     standard
    ## 848    male group D        high school     standard
    ## 849  female group C        high school     standard
    ## 850    male group D associate's degree     standard
    ## 851    male group C    master's degree     standard
    ## 852  female group A        high school     standard
    ## 853  female group E       some college     standard
    ## 854    male group E   some high school     standard
    ## 855    male group C   some high school     standard
    ## 856  female group B  bachelor's degree     standard
    ## 857    male group B       some college free/reduced
    ## 858  female group C  bachelor's degree     standard
    ## 859    male group B        high school     standard
    ## 860    male group C associate's degree free/reduced
    ## 861  female group C associate's degree     standard
    ## 862  female group E    master's degree free/reduced
    ## 863    male group D  bachelor's degree free/reduced
    ## 864  female group C       some college     standard
    ## 865    male group C associate's degree     standard
    ## 866    male group D       some college     standard
    ## 867    male group C        high school free/reduced
    ## 868    male group B associate's degree     standard
    ## 869    male group E associate's degree free/reduced
    ## 870    male group C associate's degree free/reduced
    ## 871    male group B        high school     standard
    ## 872  female group C       some college     standard
    ## 873    male group B associate's degree     standard
    ## 874    male group E associate's degree free/reduced
    ## 875  female group C  bachelor's degree free/reduced
    ## 876    male group C       some college free/reduced
    ## 877    male group D       some college     standard
    ## 878    male group C   some high school     standard
    ## 879  female group D   some high school     standard
    ## 880  female group D associate's degree     standard
    ## 881    male group C  bachelor's degree     standard
    ## 882  female group E  bachelor's degree     standard
    ## 883  female group B        high school free/reduced
    ## 884    male group D  bachelor's degree free/reduced
    ## 885  female group E associate's degree     standard
    ## 886  female group C associate's degree     standard
    ## 887  female group E associate's degree     standard
    ## 888    male group C        high school free/reduced
    ## 889  female group D       some college free/reduced
    ## 890    male group D        high school free/reduced
    ## 891  female group E       some college     standard
    ## 892  female group E associate's degree     standard
    ## 893  female group A    master's degree free/reduced
    ## 894    male group D   some high school     standard
    ## 895  female group E associate's degree     standard
    ## 896  female group E   some high school free/reduced
    ## 897    male group B        high school free/reduced
    ## 898  female group B   some high school free/reduced
    ## 899    male group D associate's degree     standard
    ## 900  female group D   some high school     standard
    ## 901    male group D    master's degree     standard
    ## 902  female group C    master's degree     standard
    ## 903  female group A        high school free/reduced
    ## 904  female group D  bachelor's degree free/reduced
    ## 905  female group D   some high school free/reduced
    ## 906    male group D       some college     standard
    ## 907    male group B        high school     standard
    ## 908  female group D       some college     standard
    ## 909  female group C  bachelor's degree free/reduced
    ## 910    male group E  bachelor's degree     standard
    ## 911    male group D  bachelor's degree free/reduced
    ## 912  female group A       some college     standard
    ## 913  female group C  bachelor's degree     standard
    ## 914  female group C  bachelor's degree free/reduced
    ## 915  female group B associate's degree free/reduced
    ## 916  female group E       some college     standard
    ## 917    male group E  bachelor's degree     standard
    ## 918  female group C        high school     standard
    ## 919  female group C associate's degree     standard
    ## 920    male group B       some college     standard
    ## 921    male group D        high school free/reduced
    ## 922  female group C        high school free/reduced
    ## 923    male group D        high school     standard
    ## 924  female group B associate's degree free/reduced
    ## 925    male group D        high school free/reduced
    ## 926    male group E   some high school     standard
    ## 927    male group E associate's degree free/reduced
    ## 928  female group D        high school free/reduced
    ## 929    male group E associate's degree free/reduced
    ## 930  female group C   some high school free/reduced
    ## 931    male group C       some college free/reduced
    ## 932    male group D       some college free/reduced
    ## 933    male group D associate's degree free/reduced
    ## 934    male group C  bachelor's degree free/reduced
    ## 935    male group C associate's degree     standard
    ## 936    male group D       some college free/reduced
    ## 937    male group A associate's degree     standard
    ## 938  female group E        high school free/reduced
    ## 939    male group D       some college     standard
    ## 940    male group D   some high school     standard
    ## 941    male group C    master's degree free/reduced
    ## 942  female group D    master's degree     standard
    ## 943    male group C        high school     standard
    ## 944    male group A   some high school free/reduced
    ## 945  female group B        high school     standard
    ## 946  female group C associate's degree     standard
    ## 947    male group B        high school     standard
    ## 948  female group D       some college free/reduced
    ## 949    male group B   some high school free/reduced
    ## 950  female group E        high school free/reduced
    ## 951    male group E        high school     standard
    ## 952  female group D       some college     standard
    ## 953  female group E   some high school free/reduced
    ## 954    male group C        high school     standard
    ## 955  female group C       some college     standard
    ## 956    male group E associate's degree     standard
    ## 957    male group C       some college     standard
    ## 958  female group D    master's degree     standard
    ## 959  female group D        high school     standard
    ## 960    male group C        high school     standard
    ## 961  female group A       some college     standard
    ## 962  female group D   some high school free/reduced
    ## 963  female group E associate's degree     standard
    ## 964  female group C   some high school free/reduced
    ## 965    male group D       some college     standard
    ## 966  female group D       some college     standard
    ## 967    male group A   some high school     standard
    ## 968    male group C       some college     standard
    ## 969  female group E associate's degree     standard
    ## 970  female group B  bachelor's degree     standard
    ## 971  female group D  bachelor's degree     standard
    ## 972    male group C   some high school     standard
    ## 973  female group A        high school free/reduced
    ## 974  female group D       some college free/reduced
    ## 975  female group A       some college     standard
    ## 976  female group C       some college     standard
    ## 977    male group B       some college free/reduced
    ## 978    male group C associate's degree     standard
    ## 979    male group D        high school     standard
    ## 980  female group C associate's degree     standard
    ## 981  female group B        high school free/reduced
    ## 982    male group D   some high school     standard
    ## 983    male group B   some high school     standard
    ## 984  female group A       some college     standard
    ## 985  female group C   some high school     standard
    ## 986    male group A        high school     standard
    ## 987  female group C associate's degree     standard
    ## 988    male group E   some high school     standard
    ## 989  female group A   some high school free/reduced
    ## 990  female group D       some college free/reduced
    ## 991    male group E        high school free/reduced
    ## 992  female group B   some high school     standard
    ## 993  female group D associate's degree free/reduced
    ## 994  female group D  bachelor's degree free/reduced
    ## 995    male group A        high school     standard
    ## 996  female group E    master's degree     standard
    ## 997    male group C        high school free/reduced
    ## 998  female group C        high school free/reduced
    ## 999  female group D       some college     standard
    ## 1000 female group D       some college free/reduced
    ##      Test_preparation_course Subject Score
    ## 1                       none    math    72
    ## 2                  completed    math    69
    ## 3                       none    math    90
    ## 4                       none    math    47
    ## 5                       none    math    76
    ## 6                       none    math    71
    ## 7                  completed    math    88
    ## 8                       none    math    40
    ## 9                  completed    math    64
    ## 10                      none    math    38
    ## 11                      none    math    58
    ## 12                      none    math    40
    ## 13                      none    math    65
    ## 14                 completed    math    78
    ## 15                      none    math    50
    ## 16                      none    math    69
    ## 17                      none    math    88
    ## 18                      none    math    18
    ## 19                 completed    math    46
    ## 20                      none    math    54
    ## 21                      none    math    66
    ## 22                 completed    math    65
    ## 23                      none    math    44
    ## 24                      none    math    69
    ## 25                 completed    math    74
    ## 26                      none    math    73
    ## 27                      none    math    69
    ## 28                      none    math    67
    ## 29                      none    math    70
    ## 30                      none    math    62
    ## 31                      none    math    69
    ## 32                      none    math    63
    ## 33                      none    math    56
    ## 34                      none    math    40
    ## 35                      none    math    97
    ## 36                 completed    math    81
    ## 37                      none    math    74
    ## 38                      none    math    50
    ## 39                 completed    math    75
    ## 40                      none    math    57
    ## 41                      none    math    55
    ## 42                      none    math    58
    ## 43                      none    math    53
    ## 44                 completed    math    59
    ## 45                      none    math    50
    ## 46                      none    math    65
    ## 47                 completed    math    55
    ## 48                      none    math    66
    ## 49                 completed    math    57
    ## 50                 completed    math    82
    ## 51                      none    math    53
    ## 52                 completed    math    77
    ## 53                      none    math    53
    ## 54                      none    math    88
    ## 55                 completed    math    71
    ## 56                      none    math    33
    ## 57                 completed    math    82
    ## 58                      none    math    52
    ## 59                 completed    math    58
    ## 60                      none    math     0
    ## 61                 completed    math    79
    ## 62                      none    math    39
    ## 63                      none    math    62
    ## 64                      none    math    69
    ## 65                      none    math    59
    ## 66                      none    math    67
    ## 67                      none    math    45
    ## 68                      none    math    60
    ## 69                      none    math    61
    ## 70                      none    math    39
    ## 71                 completed    math    58
    ## 72                 completed    math    63
    ## 73                      none    math    41
    ## 74                      none    math    61
    ## 75                      none    math    49
    ## 76                      none    math    44
    ## 77                      none    math    30
    ## 78                 completed    math    80
    ## 79                 completed    math    61
    ## 80                      none    math    62
    ## 81                      none    math    47
    ## 82                      none    math    49
    ## 83                 completed    math    50
    ## 84                      none    math    72
    ## 85                      none    math    42
    ## 86                      none    math    73
    ## 87                      none    math    76
    ## 88                      none    math    71
    ## 89                      none    math    58
    ## 90                      none    math    73
    ## 91                      none    math    65
    ## 92                      none    math    27
    ## 93                      none    math    71
    ## 94                 completed    math    43
    ## 95                      none    math    79
    ## 96                 completed    math    78
    ## 97                 completed    math    65
    ## 98                 completed    math    63
    ## 99                      none    math    58
    ## 100                     none    math    65
    ## 101                     none    math    79
    ## 102                completed    math    68
    ## 103                     none    math    85
    ## 104                completed    math    60
    ## 105                completed    math    98
    ## 106                     none    math    58
    ## 107                     none    math    87
    ## 108                completed    math    66
    ## 109                     none    math    52
    ## 110                     none    math    70
    ## 111                completed    math    77
    ## 112                     none    math    62
    ## 113                     none    math    54
    ## 114                     none    math    51
    ## 115                completed    math    99
    ## 116                     none    math    84
    ## 117                     none    math    75
    ## 118                     none    math    78
    ## 119                     none    math    51
    ## 120                     none    math    55
    ## 121                completed    math    79
    ## 122                completed    math    91
    ## 123                completed    math    88
    ## 124                     none    math    63
    ## 125                     none    math    83
    ## 126                     none    math    87
    ## 127                     none    math    72
    ## 128                completed    math    65
    ## 129                     none    math    82
    ## 130                     none    math    51
    ## 131                     none    math    89
    ## 132                completed    math    53
    ## 133                completed    math    87
    ## 134                completed    math    75
    ## 135                completed    math    74
    ## 136                     none    math    58
    ## 137                completed    math    51
    ## 138                     none    math    70
    ## 139                     none    math    59
    ## 140                completed    math    71
    ## 141                     none    math    76
    ## 142                     none    math    59
    ## 143                completed    math    42
    ## 144                     none    math    57
    ## 145                     none    math    88
    ## 146                     none    math    22
    ## 147                     none    math    88
    ## 148                     none    math    73
    ## 149                completed    math    68
    ## 150                completed    math   100
    ## 151                completed    math    62
    ## 152                     none    math    77
    ## 153                completed    math    59
    ## 154                     none    math    54
    ## 155                     none    math    62
    ## 156                completed    math    70
    ## 157                completed    math    66
    ## 158                     none    math    60
    ## 159                completed    math    61
    ## 160                     none    math    66
    ## 161                completed    math    82
    ## 162                completed    math    75
    ## 163                     none    math    49
    ## 164                     none    math    52
    ## 165                     none    math    81
    ## 166                completed    math    96
    ## 167                completed    math    53
    ## 168                completed    math    58
    ## 169                completed    math    68
    ## 170                completed    math    67
    ## 171                completed    math    72
    ## 172                     none    math    94
    ## 173                     none    math    79
    ## 174                     none    math    63
    ## 175                completed    math    43
    ## 176                completed    math    81
    ## 177                completed    math    46
    ## 178                completed    math    71
    ## 179                completed    math    52
    ## 180                completed    math    97
    ## 181                completed    math    62
    ## 182                     none    math    46
    ## 183                     none    math    50
    ## 184                     none    math    65
    ## 185                completed    math    45
    ## 186                completed    math    65
    ## 187                     none    math    80
    ## 188                completed    math    62
    ## 189                     none    math    48
    ## 190                     none    math    77
    ## 191                     none    math    66
    ## 192                completed    math    76
    ## 193                     none    math    62
    ## 194                completed    math    77
    ## 195                completed    math    69
    ## 196                     none    math    61
    ## 197                completed    math    59
    ## 198                     none    math    55
    ## 199                     none    math    45
    ## 200                     none    math    78
    ## 201                completed    math    67
    ## 202                     none    math    65
    ## 203                     none    math    69
    ## 204                     none    math    57
    ## 205                     none    math    59
    ## 206                completed    math    74
    ## 207                     none    math    82
    ## 208                completed    math    81
    ## 209                     none    math    74
    ## 210                     none    math    58
    ## 211                completed    math    80
    ## 212                     none    math    35
    ## 213                     none    math    42
    ## 214                completed    math    60
    ## 215                completed    math    87
    ## 216                completed    math    84
    ## 217                completed    math    83
    ## 218                     none    math    34
    ## 219                     none    math    66
    ## 220                completed    math    61
    ## 221                completed    math    56
    ## 222                     none    math    87
    ## 223                     none    math    55
    ## 224                     none    math    86
    ## 225                completed    math    52
    ## 226                     none    math    45
    ## 227                     none    math    72
    ## 228                     none    math    57
    ## 229                     none    math    68
    ## 230                completed    math    88
    ## 231                     none    math    76
    ## 232                     none    math    46
    ## 233                     none    math    67
    ## 234                     none    math    92
    ## 235                completed    math    83
    ## 236                     none    math    80
    ## 237                     none    math    63
    ## 238                completed    math    64
    ## 239                     none    math    54
    ## 240                     none    math    84
    ## 241                completed    math    73
    ## 242                     none    math    80
    ## 243                     none    math    56
    ## 244                     none    math    59
    ## 245                     none    math    75
    ## 246                     none    math    85
    ## 247                     none    math    89
    ## 248                completed    math    58
    ## 249                     none    math    65
    ## 250                     none    math    68
    ## 251                completed    math    47
    ## 252                     none    math    71
    ## 253                completed    math    60
    ## 254                     none    math    80
    ## 255                     none    math    54
    ## 256                     none    math    62
    ## 257                     none    math    64
    ## 258                completed    math    78
    ## 259                     none    math    70
    ## 260                completed    math    65
    ## 261                completed    math    64
    ## 262                completed    math    79
    ## 263                     none    math    44
    ## 264                     none    math    99
    ## 265                     none    math    76
    ## 266                     none    math    59
    ## 267                     none    math    63
    ## 268                     none    math    69
    ## 269                completed    math    88
    ## 270                     none    math    71
    ## 271                     none    math    69
    ## 272                     none    math    58
    ## 273                     none    math    47
    ## 274                     none    math    65
    ## 275                completed    math    88
    ## 276                     none    math    83
    ## 277                completed    math    85
    ## 278                completed    math    59
    ## 279                     none    math    65
    ## 280                     none    math    73
    ## 281                     none    math    53
    ## 282                     none    math    45
    ## 283                     none    math    73
    ## 284                completed    math    70
    ## 285                     none    math    37
    ## 286                completed    math    81
    ## 287                completed    math    97
    ## 288                     none    math    67
    ## 289                     none    math    88
    ## 290                completed    math    77
    ## 291                     none    math    76
    ## 292                     none    math    86
    ## 293                completed    math    63
    ## 294                     none    math    65
    ## 295                completed    math    78
    ## 296                     none    math    67
    ## 297                completed    math    46
    ## 298                completed    math    71
    ## 299                completed    math    40
    ## 300                     none    math    90
    ## 301                completed    math    81
    ## 302                     none    math    56
    ## 303                completed    math    67
    ## 304                     none    math    80
    ## 305                completed    math    74
    ## 306                     none    math    69
    ## 307                completed    math    99
    ## 308                     none    math    51
    ## 309                     none    math    53
    ## 310                     none    math    49
    ## 311                     none    math    73
    ## 312                     none    math    66
    ## 313                completed    math    67
    ## 314                completed    math    68
    ## 315                completed    math    59
    ## 316                     none    math    71
    ## 317                completed    math    77
    ## 318                     none    math    83
    ## 319                     none    math    63
    ## 320                     none    math    56
    ## 321                completed    math    67
    ## 322                     none    math    75
    ## 323                     none    math    71
    ## 324                     none    math    43
    ## 325                     none    math    41
    ## 326                     none    math    82
    ## 327                     none    math    61
    ## 328                     none    math    28
    ## 329                completed    math    82
    ## 330                     none    math    41
    ## 331                     none    math    71
    ## 332                     none    math    47
    ## 333                completed    math    62
    ## 334                     none    math    90
    ## 335                     none    math    83
    ## 336                     none    math    61
    ## 337                completed    math    76
    ## 338                     none    math    49
    ## 339                     none    math    24
    ## 340                completed    math    35
    ## 341                     none    math    58
    ## 342                     none    math    61
    ## 343                completed    math    69
    ## 344                completed    math    67
    ## 345                     none    math    79
    ## 346                     none    math    72
    ## 347                     none    math    62
    ## 348                completed    math    77
    ## 349                     none    math    75
    ## 350                     none    math    87
    ## 351                     none    math    52
    ## 352                     none    math    66
    ## 353                completed    math    63
    ## 354                     none    math    46
    ## 355                     none    math    59
    ## 356                     none    math    61
    ## 357                     none    math    63
    ## 358                completed    math    42
    ## 359                     none    math    59
    ## 360                     none    math    80
    ## 361                     none    math    58
    ## 362                completed    math    85
    ## 363                     none    math    52
    ## 364                     none    math    27
    ## 365                     none    math    59
    ## 366                completed    math    49
    ## 367                completed    math    69
    ## 368                     none    math    61
    ## 369                     none    math    44
    ## 370                     none    math    73
    ## 371                     none    math    84
    ## 372                completed    math    45
    ## 373                     none    math    74
    ## 374                completed    math    82
    ## 375                     none    math    59
    ## 376                     none    math    46
    ## 377                     none    math    80
    ## 378                completed    math    85
    ## 379                     none    math    71
    ## 380                     none    math    66
    ## 381                     none    math    80
    ## 382                completed    math    87
    ## 383                     none    math    79
    ## 384                     none    math    38
    ## 385                     none    math    38
    ## 386                     none    math    67
    ## 387                     none    math    64
    ## 388                     none    math    57
    ## 389                     none    math    62
    ## 390                     none    math    73
    ## 391                completed    math    73
    ## 392                     none    math    77
    ## 393                     none    math    76
    ## 394                completed    math    57
    ## 395                completed    math    65
    ## 396                     none    math    48
    ## 397                     none    math    50
    ## 398                     none    math    85
    ## 399                     none    math    74
    ## 400                     none    math    60
    ## 401                completed    math    59
    ## 402                     none    math    53
    ## 403                     none    math    49
    ## 404                completed    math    88
    ## 405                     none    math    54
    ## 406                     none    math    63
    ## 407                completed    math    65
    ## 408                     none    math    82
    ## 409                completed    math    52
    ## 410                completed    math    87
    ## 411                completed    math    70
    ## 412                completed    math    84
    ## 413                     none    math    71
    ## 414                completed    math    63
    ## 415                completed    math    51
    ## 416                     none    math    84
    ## 417                completed    math    71
    ## 418                     none    math    74
    ## 419                     none    math    68
    ## 420                completed    math    57
    ## 421                completed    math    82
    ## 422                completed    math    57
    ## 423                completed    math    47
    ## 424                completed    math    59
    ## 425                     none    math    41
    ## 426                     none    math    62
    ## 427                     none    math    86
    ## 428                     none    math    69
    ## 429                     none    math    65
    ## 430                     none    math    68
    ## 431                     none    math    64
    ## 432                     none    math    61
    ## 433                     none    math    61
    ## 434                     none    math    47
    ## 435                     none    math    73
    ## 436                completed    math    50
    ## 437                     none    math    75
    ## 438                     none    math    75
    ## 439                     none    math    70
    ## 440                completed    math    89
    ## 441                completed    math    67
    ## 442                     none    math    78
    ## 443                     none    math    59
    ## 444                     none    math    73
    ## 445                     none    math    79
    ## 446                completed    math    67
    ## 447                     none    math    69
    ## 448                completed    math    86
    ## 449                     none    math    47
    ## 450                     none    math    81
    ## 451                completed    math    64
    ## 452                     none    math   100
    ## 453                     none    math    65
    ## 454                     none    math    65
    ## 455                     none    math    53
    ## 456                     none    math    37
    ## 457                     none    math    79
    ## 458                     none    math    53
    ## 459                     none    math   100
    ## 460                completed    math    72
    ## 461                     none    math    53
    ## 462                     none    math    54
    ## 463                     none    math    71
    ## 464                     none    math    77
    ## 465                completed    math    75
    ## 466                     none    math    84
    ## 467                     none    math    26
    ## 468                completed    math    72
    ## 469                completed    math    77
    ## 470                     none    math    91
    ## 471                completed    math    83
    ## 472                     none    math    63
    ## 473                completed    math    68
    ## 474                     none    math    59
    ## 475                completed    math    90
    ## 476                completed    math    71
    ## 477                completed    math    76
    ## 478                     none    math    80
    ## 479                     none    math    55
    ## 480                     none    math    76
    ## 481                completed    math    73
    ## 482                     none    math    52
    ## 483                     none    math    68
    ## 484                     none    math    59
    ## 485                     none    math    49
    ## 486                     none    math    70
    ## 487                     none    math    61
    ## 488                     none    math    60
    ## 489                completed    math    64
    ## 490                completed    math    79
    ## 491                     none    math    65
    ## 492                     none    math    64
    ## 493                     none    math    83
    ## 494                     none    math    81
    ## 495                     none    math    54
    ## 496                completed    math    68
    ## 497                     none    math    54
    ## 498                completed    math    59
    ## 499                     none    math    66
    ## 500                     none    math    76
    ## 501                     none    math    74
    ## 502                completed    math    94
    ## 503                     none    math    63
    ## 504                completed    math    95
    ## 505                     none    math    40
    ## 506                     none    math    82
    ## 507                     none    math    68
    ## 508                     none    math    55
    ## 509                     none    math    79
    ## 510                     none    math    86
    ## 511                     none    math    76
    ## 512                     none    math    64
    ## 513                     none    math    62
    ## 514                completed    math    54
    ## 515                completed    math    77
    ## 516                completed    math    76
    ## 517                     none    math    74
    ## 518                completed    math    66
    ## 519                completed    math    66
    ## 520                completed    math    67
    ## 521                     none    math    71
    ## 522                     none    math    91
    ## 523                     none    math    69
    ## 524                     none    math    54
    ## 525                completed    math    53
    ## 526                     none    math    68
    ## 527                completed    math    56
    ## 528                     none    math    36
    ## 529                     none    math    29
    ## 530                     none    math    62
    ## 531                completed    math    68
    ## 532                     none    math    47
    ## 533                completed    math    62
    ## 534                completed    math    79
    ## 535                completed    math    73
    ## 536                completed    math    66
    ## 537                completed    math    51
    ## 538                     none    math    51
    ## 539                completed    math    85
    ## 540                completed    math    97
    ## 541                completed    math    75
    ## 542                completed    math    79
    ## 543                     none    math    81
    ## 544                     none    math    82
    ## 545                     none    math    64
    ## 546                completed    math    78
    ## 547                completed    math    92
    ## 548                completed    math    72
    ## 549                     none    math    62
    ## 550                     none    math    79
    ## 551                     none    math    79
    ## 552                completed    math    87
    ## 553                     none    math    40
    ## 554                     none    math    77
    ## 555                     none    math    53
    ## 556                     none    math    32
    ## 557                completed    math    55
    ## 558                     none    math    61
    ## 559                     none    math    53
    ## 560                     none    math    73
    ## 561                completed    math    74
    ## 562                     none    math    63
    ## 563                completed    math    96
    ## 564                completed    math    63
    ## 565                     none    math    48
    ## 566                     none    math    48
    ## 567                completed    math    92
    ## 568                completed    math    61
    ## 569                     none    math    63
    ## 570                     none    math    68
    ## 571                completed    math    71
    ## 572                     none    math    91
    ## 573                     none    math    53
    ## 574                completed    math    50
    ## 575                     none    math    74
    ## 576                completed    math    40
    ## 577                completed    math    61
    ## 578                     none    math    81
    ## 579                completed    math    48
    ## 580                     none    math    53
    ## 581                     none    math    81
    ## 582                     none    math    77
    ## 583                     none    math    63
    ## 584                completed    math    73
    ## 585                     none    math    69
    ## 586                     none    math    65
    ## 587                     none    math    55
    ## 588                     none    math    44
    ## 589                     none    math    54
    ## 590                     none    math    48
    ## 591                     none    math    58
    ## 592                     none    math    71
    ## 593                     none    math    68
    ## 594                     none    math    74
    ## 595                completed    math    92
    ## 596                completed    math    56
    ## 597                     none    math    30
    ## 598                     none    math    53
    ## 599                     none    math    69
    ## 600                     none    math    65
    ## 601                     none    math    54
    ## 602                     none    math    29
    ## 603                     none    math    76
    ## 604                     none    math    60
    ## 605                completed    math    84
    ## 606                     none    math    75
    ## 607                     none    math    85
    ## 608                     none    math    40
    ## 609                     none    math    61
    ## 610                     none    math    58
    ## 611                completed    math    69
    ## 612                     none    math    58
    ## 613                completed    math    94
    ## 614                     none    math    65
    ## 615                     none    math    82
    ## 616                     none    math    60
    ## 617                     none    math    37
    ## 618                     none    math    88
    ## 619                     none    math    95
    ## 620                completed    math    65
    ## 621                     none    math    35
    ## 622                     none    math    62
    ## 623                completed    math    58
    ## 624                completed    math   100
    ## 625                     none    math    61
    ## 626                completed    math   100
    ## 627                completed    math    69
    ## 628                     none    math    61
    ## 629                     none    math    49
    ## 630                completed    math    44
    ## 631                     none    math    67
    ## 632                     none    math    79
    ## 633                completed    math    66
    ## 634                     none    math    75
    ## 635                     none    math    84
    ## 636                     none    math    71
    ## 637                completed    math    67
    ## 638                completed    math    80
    ## 639                     none    math    86
    ## 640                     none    math    76
    ## 641                     none    math    41
    ## 642                completed    math    74
    ## 643                     none    math    72
    ## 644                completed    math    74
    ## 645                     none    math    70
    ## 646                completed    math    65
    ## 647                     none    math    59
    ## 648                     none    math    64
    ## 649                     none    math    50
    ## 650                completed    math    69
    ## 651                completed    math    51
    ## 652                completed    math    68
    ## 653                completed    math    85
    ## 654                completed    math    65
    ## 655                     none    math    73
    ## 656                     none    math    62
    ## 657                     none    math    77
    ## 658                     none    math    69
    ## 659                     none    math    43
    ## 660                     none    math    90
    ## 661                     none    math    74
    ## 662                     none    math    73
    ## 663                     none    math    55
    ## 664                     none    math    65
    ## 665                     none    math    80
    ## 666                completed    math    50
    ## 667                completed    math    63
    ## 668                     none    math    77
    ## 669                     none    math    73
    ## 670                completed    math    81
    ## 671                     none    math    66
    ## 672                     none    math    52
    ## 673                     none    math    69
    ## 674                completed    math    65
    ## 675                completed    math    69
    ## 676                completed    math    50
    ## 677                completed    math    73
    ## 678                completed    math    70
    ## 679                     none    math    81
    ## 680                     none    math    63
    ## 681                     none    math    67
    ## 682                     none    math    60
    ## 683                     none    math    62
    ## 684                completed    math    29
    ## 685                completed    math    62
    ## 686                completed    math    94
    ## 687                completed    math    85
    ## 688                     none    math    77
    ## 689                     none    math    53
    ## 690                     none    math    93
    ## 691                     none    math    49
    ## 692                     none    math    73
    ## 693                completed    math    66
    ## 694                     none    math    77
    ## 695                     none    math    49
    ## 696                     none    math    79
    ## 697                completed    math    75
    ## 698                     none    math    59
    ## 699                completed    math    57
    ## 700                     none    math    66
    ## 701                completed    math    79
    ## 702                     none    math    57
    ## 703                completed    math    87
    ## 704                     none    math    63
    ## 705                completed    math    59
    ## 706                     none    math    62
    ## 707                     none    math    46
    ## 708                     none    math    66
    ## 709                     none    math    89
    ## 710                completed    math    42
    ## 711                completed    math    93
    ## 712                completed    math    80
    ## 713                     none    math    98
    ## 714                     none    math    81
    ## 715                completed    math    60
    ## 716                completed    math    76
    ## 717                completed    math    73
    ## 718                completed    math    96
    ## 719                     none    math    76
    ## 720                completed    math    91
    ## 721                     none    math    62
    ## 722                completed    math    55
    ## 723                completed    math    74
    ## 724                     none    math    50
    ## 725                     none    math    47
    ## 726                completed    math    81
    ## 727                completed    math    65
    ## 728                completed    math    68
    ## 729                     none    math    73
    ## 730                     none    math    53
    ## 731                completed    math    68
    ## 732                     none    math    55
    ## 733                completed    math    87
    ## 734                     none    math    55
    ## 735                     none    math    53
    ## 736                     none    math    67
    ## 737                     none    math    92
    ## 738                completed    math    53
    ## 739                     none    math    81
    ## 740                     none    math    61
    ## 741                     none    math    80
    ## 742                     none    math    37
    ## 743                     none    math    81
    ## 744                completed    math    59
    ## 745                     none    math    55
    ## 746                     none    math    72
    ## 747                     none    math    69
    ## 748                     none    math    69
    ## 749                     none    math    50
    ## 750                completed    math    87
    ## 751                completed    math    71
    ## 752                     none    math    68
    ## 753                completed    math    79
    ## 754                completed    math    77
    ## 755                     none    math    58
    ## 756                     none    math    84
    ## 757                     none    math    55
    ## 758                completed    math    70
    ## 759                completed    math    52
    ## 760                completed    math    69
    ## 761                     none    math    53
    ## 762                     none    math    48
    ## 763                completed    math    78
    ## 764                     none    math    62
    ## 765                     none    math    60
    ## 766                     none    math    74
    ## 767                completed    math    58
    ## 768                completed    math    76
    ## 769                     none    math    68
    ## 770                     none    math    58
    ## 771                     none    math    52
    ## 772                     none    math    75
    ## 773                completed    math    52
    ## 774                     none    math    62
    ## 775                     none    math    66
    ## 776                     none    math    49
    ## 777                     none    math    66
    ## 778                     none    math    35
    ## 779                completed    math    72
    ## 780                completed    math    94
    ## 781                     none    math    46
    ## 782                     none    math    77
    ## 783                completed    math    76
    ## 784                completed    math    52
    ## 785                completed    math    91
    ## 786                completed    math    32
    ## 787                     none    math    72
    ## 788                     none    math    19
    ## 789                     none    math    68
    ## 790                     none    math    52
    ## 791                     none    math    48
    ## 792                     none    math    60
    ## 793                     none    math    66
    ## 794                completed    math    89
    ## 795                     none    math    42
    ## 796                completed    math    57
    ## 797                     none    math    70
    ## 798                     none    math    70
    ## 799                     none    math    69
    ## 800                     none    math    52
    ## 801                completed    math    67
    ## 802                completed    math    76
    ## 803                     none    math    87
    ## 804                     none    math    82
    ## 805                     none    math    73
    ## 806                     none    math    75
    ## 807                     none    math    64
    ## 808                     none    math    41
    ## 809                     none    math    90
    ## 810                     none    math    59
    ## 811                     none    math    51
    ## 812                     none    math    45
    ## 813                completed    math    54
    ## 814                completed    math    87
    ## 815                     none    math    72
    ## 816                completed    math    94
    ## 817                     none    math    45
    ## 818                completed    math    61
    ## 819                     none    math    60
    ## 820                     none    math    77
    ## 821                completed    math    85
    ## 822                     none    math    78
    ## 823                completed    math    49
    ## 824                     none    math    71
    ## 825                     none    math    48
    ## 826                     none    math    62
    ## 827                completed    math    56
    ## 828                     none    math    65
    ## 829                completed    math    69
    ## 830                     none    math    68
    ## 831                     none    math    61
    ## 832                completed    math    74
    ## 833                     none    math    64
    ## 834                completed    math    77
    ## 835                     none    math    58
    ## 836                completed    math    60
    ## 837                     none    math    73
    ## 838                completed    math    75
    ## 839                completed    math    58
    ## 840                     none    math    66
    ## 841                     none    math    39
    ## 842                     none    math    64
    ## 843                completed    math    23
    ## 844                completed    math    74
    ## 845                completed    math    40
    ## 846                     none    math    90
    ## 847                completed    math    91
    ## 848                     none    math    64
    ## 849                     none    math    59
    ## 850                     none    math    80
    ## 851                     none    math    71
    ## 852                     none    math    61
    ## 853                     none    math    87
    ## 854                     none    math    82
    ## 855                     none    math    62
    ## 856                     none    math    97
    ## 857                     none    math    75
    ## 858                     none    math    65
    ## 859                completed    math    52
    ## 860                     none    math    87
    ## 861                     none    math    53
    ## 862                     none    math    81
    ## 863                completed    math    39
    ## 864                completed    math    71
    ## 865                     none    math    97
    ## 866                completed    math    82
    ## 867                     none    math    59
    ## 868                     none    math    61
    ## 869                completed    math    78
    ## 870                     none    math    49
    ## 871                     none    math    59
    ## 872                completed    math    70
    ## 873                completed    math    82
    ## 874                     none    math    90
    ## 875                     none    math    43
    ## 876                     none    math    80
    ## 877                     none    math    81
    ## 878                     none    math    57
    ## 879                     none    math    59
    ## 880                     none    math    64
    ## 881                completed    math    63
    ## 882                completed    math    71
    ## 883                     none    math    64
    ## 884                     none    math    55
    ## 885                     none    math    51
    ## 886                completed    math    62
    ## 887                completed    math    93
    ## 888                     none    math    54
    ## 889                     none    math    69
    ## 890                     none    math    44
    ## 891                completed    math    86
    ## 892                     none    math    85
    ## 893                     none    math    50
    ## 894                completed    math    88
    ## 895                     none    math    59
    ## 896                     none    math    32
    ## 897                     none    math    36
    ## 898                completed    math    63
    ## 899                completed    math    67
    ## 900                completed    math    65
    ## 901                     none    math    85
    ## 902                     none    math    73
    ## 903                completed    math    34
    ## 904                completed    math    93
    ## 905                     none    math    67
    ## 906                     none    math    88
    ## 907                     none    math    57
    ## 908                completed    math    79
    ## 909                     none    math    67
    ## 910                completed    math    70
    ## 911                     none    math    50
    ## 912                     none    math    69
    ## 913                completed    math    52
    ## 914                completed    math    47
    ## 915                     none    math    46
    ## 916                     none    math    68
    ## 917                completed    math   100
    ## 918                     none    math    44
    ## 919                completed    math    57
    ## 920                completed    math    91
    ## 921                     none    math    69
    ## 922                     none    math    35
    ## 923                     none    math    72
    ## 924                     none    math    54
    ## 925                     none    math    74
    ## 926                completed    math    74
    ## 927                     none    math    64
    ## 928                completed    math    65
    ## 929                completed    math    46
    ## 930                     none    math    48
    ## 931                completed    math    67
    ## 932                     none    math    62
    ## 933                completed    math    61
    ## 934                completed    math    70
    ## 935                completed    math    98
    ## 936                     none    math    70
    ## 937                     none    math    67
    ## 938                     none    math    57
    ## 939                completed    math    85
    ## 940                completed    math    77
    ## 941                completed    math    72
    ## 942                     none    math    78
    ## 943                     none    math    81
    ## 944                completed    math    61
    ## 945                     none    math    58
    ## 946                     none    math    54
    ## 947                     none    math    82
    ## 948                     none    math    49
    ## 949                completed    math    49
    ## 950                completed    math    57
    ## 951                     none    math    94
    ## 952                completed    math    75
    ## 953                     none    math    74
    ## 954                completed    math    58
    ## 955                     none    math    62
    ## 956                     none    math    72
    ## 957                     none    math    84
    ## 958                     none    math    92
    ## 959                     none    math    45
    ## 960                     none    math    75
    ## 961                     none    math    56
    ## 962                     none    math    48
    ## 963                     none    math   100
    ## 964                completed    math    65
    ## 965                     none    math    72
    ## 966                     none    math    62
    ## 967                completed    math    66
    ## 968                     none    math    63
    ## 969                     none    math    68
    ## 970                     none    math    75
    ## 971                     none    math    89
    ## 972                completed    math    78
    ## 973                completed    math    53
    ## 974                     none    math    49
    ## 975                     none    math    54
    ## 976                completed    math    64
    ## 977                completed    math    60
    ## 978                     none    math    62
    ## 979                completed    math    55
    ## 980                     none    math    91
    ## 981                     none    math     8
    ## 982                     none    math    81
    ## 983                completed    math    79
    ## 984                completed    math    78
    ## 985                     none    math    74
    ## 986                     none    math    57
    ## 987                     none    math    40
    ## 988                completed    math    81
    ## 989                     none    math    44
    ## 990                completed    math    67
    ## 991                completed    math    86
    ## 992                completed    math    65
    ## 993                     none    math    55
    ## 994                     none    math    62
    ## 995                     none    math    63
    ## 996                completed    math    88
    ## 997                     none    math    62
    ## 998                completed    math    59
    ## 999                completed    math    68
    ## 1000                    none    math    77

**mutate（）：Add new variables and preserves existing; transmute drops
existing variables.**

``` r
Students2<-Students%>%
 
  group_by(Parent_Eduction)%>%
  mutate(mean=mean(Score))%>%
  arrange(mean)
  Students2
```

    ## # A tibble: 3,000 x 8
    ## # Groups:   Parent_Eduction [6]
    ##    Gender Race   Parent_Eduction Lunch Test_preparatio~ Subject Score  mean
    ##    <fct>  <fct>  <fct>           <fct> <fct>            <chr>   <int> <dbl>
    ##  1 male   group~ high school     free~ completed        math       64  63.1
    ##  2 female group~ high school     free~ none             math       38  63.1
    ##  3 female group~ high school     stan~ none             math       65  63.1
    ##  4 male   group~ high school     stan~ none             math       88  63.1
    ##  5 male   group~ high school     stan~ none             math       66  63.1
    ##  6 male   group~ high school     stan~ none             math       70  63.1
    ##  7 female group~ high school     stan~ none             math       66  63.1
    ##  8 male   group~ high school     stan~ completed        math       82  63.1
    ##  9 male   group~ high school     stan~ none             math       88  63.1
    ## 10 female group~ high school     free~ none             math       33  63.1
    ## # ... with 2,990 more rows

**summarise():It is typically used on grouped data created by
group\_by(). The output will have one row for each group.**

``` r
Students3<-Students%>%
 
  group_by(Gender,Subject)%>%
  summarise(mean=round(mean(Score),3))%>%
  arrange(Gender)
  Students3
```

    ## # A tibble: 6 x 3
    ## # Groups:   Gender [2]
    ##   Gender Subject  mean
    ##   <fct>  <chr>   <dbl>
    ## 1 female math     63.6
    ## 2 female reading  72.6
    ## 3 female writing  72.5
    ## 4 male   math     68.7
    ## 5 male   reading  65.5
    ## 6 male   writing  63.3

Data visualization
==================

ggplot2 is a system for declaratively creating graphics, based on The
Grammar of Graphics. You provide the data, tell ggplot2 how to map
variables to aesthetics, what graphical primitives to use, and it takes
care of the details.

``` r
 ggplot(Students2, aes(reorder(Parent_Eduction,mean), y=mean, fill=Parent_Eduction)) +
    geom_bar(stat="identity", position=position_dodge(), colour="black", width = 0.5) +
    coord_flip() + 
    ggtitle("Parent Eduction and Math Score") +
    xlab("Eduction") + ylab("Mean") 
```

![](data607_tidyverse_files/figure-markdown_github/unnamed-chunk-8-1.png)

``` r
ggplot(data = Students3, aes(x=Subject,y=mean))+
  geom_bar(stat = 'identity',aes(fill=Subject))+
  geom_text(aes(x = Subject, y = mean, 
                label = paste(mean),
                group = Subject,
                vjust = -0.01)) +
  labs(title = "Different Subjects with Mean Scores", 
       x = "Subject", 
       y = "Mean Score") +
  facet_wrap(~Gender, ncol = 8)+
  theme_bw()
```

![](data607_tidyverse_files/figure-markdown_github/unnamed-chunk-9-1.png)

Section II
==========

Extend an Existing Example. Using one of your classmate’s examples (as
created above), extend his or her example with additional annotated
code.

I extend the example of Amber Ferger.

gitHub:
<a href="https://github.com/acatlin/FALL2019TIDYVERSE/blob/master/Data%20607%20TidyVerse%20Assignment%20Part%201.Rmd" class="uri">https://github.com/acatlin/FALL2019TIDYVERSE/blob/master/Data%20607%20TidyVerse%20Assignment%20Part%201.Rmd</a>

Load data
---------

Load data from gitHub.

``` r
dat <- as_tibble(read.csv('https://raw.githubusercontent.com/amberferger/DATA607_Masculinity/master/raw-responses.csv'))
dat
```

    ## # A tibble: 1,615 x 98
    ##        X StartDate EndDate q0001 q0002 q0004_0001 q0004_0002 q0004_0003
    ##    <int> <fct>     <fct>   <fct> <fct> <fct>      <fct>      <fct>     
    ##  1     1 5/10/18 ~ 5/10/1~ Some~ Some~ Not selec~ Not selec~ Not selec~
    ##  2     2 5/10/18 ~ 5/10/1~ Some~ Some~ Father or~ Not selec~ Not selec~
    ##  3     3 5/10/18 ~ 5/10/1~ Very~ Not ~ Father or~ Not selec~ Not selec~
    ##  4     4 5/10/18 ~ 5/10/1~ Very~ Not ~ Father or~ Mother or~ Other fam~
    ##  5     5 5/10/18 ~ 5/10/1~ Very~ Very~ Not selec~ Not selec~ Other fam~
    ##  6     6 5/10/18 ~ 5/10/1~ Very~ Some~ Father or~ Not selec~ Not selec~
    ##  7     7 5/10/18 ~ 5/10/1~ Some~ Not ~ Father or~ Mother or~ Other fam~
    ##  8     8 5/10/18 ~ 5/10/1~ Some~ Some~ Father or~ Not selec~ Not selec~
    ##  9     9 5/10/18 ~ 5/10/1~ Very~ Not ~ Father or~ Not selec~ Not selec~
    ## 10    10 5/11/18 ~ 5/11/1~ Some~ Some~ Father or~ Not selec~ Not selec~
    ## # ... with 1,605 more rows, and 90 more variables: q0004_0004 <fct>,
    ## #   q0004_0005 <fct>, q0004_0006 <fct>, q0005 <fct>, q0007_0001 <fct>,
    ## #   q0007_0002 <fct>, q0007_0003 <fct>, q0007_0004 <fct>,
    ## #   q0007_0005 <fct>, q0007_0006 <fct>, q0007_0007 <fct>,
    ## #   q0007_0008 <fct>, q0007_0009 <fct>, q0007_0010 <fct>,
    ## #   q0007_0011 <fct>, q0008_0001 <fct>, q0008_0002 <fct>,
    ## #   q0008_0003 <fct>, q0008_0004 <fct>, q0008_0005 <fct>,
    ## #   q0008_0006 <fct>, q0008_0007 <fct>, q0008_0008 <fct>,
    ## #   q0008_0009 <fct>, q0008_0010 <fct>, q0008_0011 <fct>,
    ## #   q0008_0012 <fct>, q0009 <fct>, q0010_0001 <fct>, q0010_0002 <fct>,
    ## #   q0010_0003 <fct>, q0010_0004 <fct>, q0010_0005 <fct>,
    ## #   q0010_0006 <fct>, q0010_0007 <fct>, q0010_0008 <fct>,
    ## #   q0011_0001 <fct>, q0011_0002 <fct>, q0011_0003 <fct>,
    ## #   q0011_0004 <fct>, q0011_0005 <fct>, q0012_0001 <fct>,
    ## #   q0012_0002 <fct>, q0012_0003 <fct>, q0012_0004 <fct>,
    ## #   q0012_0005 <fct>, q0012_0006 <fct>, q0012_0007 <fct>, q0013 <fct>,
    ## #   q0014 <fct>, q0015 <fct>, q0017 <fct>, q0018 <fct>, q0019_0001 <fct>,
    ## #   q0019_0002 <fct>, q0019_0003 <fct>, q0019_0004 <fct>,
    ## #   q0019_0005 <fct>, q0019_0006 <fct>, q0019_0007 <fct>,
    ## #   q0020_0001 <fct>, q0020_0002 <fct>, q0020_0003 <fct>,
    ## #   q0020_0004 <fct>, q0020_0005 <fct>, q0020_0006 <fct>,
    ## #   q0021_0001 <fct>, q0021_0002 <fct>, q0021_0003 <fct>,
    ## #   q0021_0004 <fct>, q0022 <fct>, q0024 <fct>, q0025_0001 <fct>,
    ## #   q0025_0002 <fct>, q0025_0003 <fct>, q0026 <fct>, q0028 <fct>,
    ## #   q0029 <fct>, q0030 <fct>, q0034 <fct>, q0035 <fct>, q0036 <fct>,
    ## #   race2 <fct>, racethn4 <fct>, educ3 <fct>, educ4 <fct>, age3 <fct>,
    ## #   kids <fct>, orientation <fct>, weight <dbl>

Data Wrangling
--------------

Select the data we need and rename the column.

``` r
dat2<-dat%>%
  select(q0018,q0030,q0034,race2,educ3)

name<-c("Pay_On_A_Date","State","Salary","Race","Education")
colnames(dat2)<-name
dat2
```

    ## # A tibble: 1,615 x 5
    ##    Pay_On_A_Date State      Salary            Race      Education      
    ##    <fct>         <fct>      <fct>             <fct>     <fct>          
    ##  1 Sometimes     New York   $0-$9,999         Non-white College or more
    ##  2 Rarely        Ohio       $50,000-$74,999   White     Some college   
    ##  3 Sometimes     Michigan   $50,000-$74,999   White     College or more
    ##  4 Always        Indiana    $50,000-$74,999   White     Some college   
    ##  5 Always        Ohio       $50,000-$74,999   White     College or more
    ##  6 Always        Indiana    $200,000+         White     College or more
    ##  7 Sometimes     Hawaii     $25,000-$49,999   Non-white College or more
    ##  8 Often         New York   $150,000-$174,999 White     College or more
    ##  9 Always        California $100,000-$124,999 Non-white Some college   
    ## 10 Always        Oregon     $150,000-$174,999 White     College or more
    ## # ... with 1,605 more rows

Filter the NA and choose the pay status as always.

``` r
dat3<-dat2%>%
  group_by(Pay_On_A_Date,Salary)%>%
  filter(Pay_On_A_Date=="Always"& Salary!="NA")%>%
  count %>%
  arrange(desc(n))
```

    ## Warning: Factor `Salary` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

``` r
dat3
```

    ## # A tibble: 11 x 3
    ## # Groups:   Pay_On_A_Date, Salary [11]
    ##    Pay_On_A_Date Salary                   n
    ##    <fct>         <fct>                <int>
    ##  1 Always        $50,000-$74,999        121
    ##  2 Always        $75,000-$99,999        119
    ##  3 Always        $25,000-$49,999        112
    ##  4 Always        Prefer not to answer   100
    ##  5 Always        $100,000-$124,999       84
    ##  6 Always        $200,000+               80
    ##  7 Always        $10,000-$24,999         46
    ##  8 Always        $125,000-$149,999       44
    ##  9 Always        $150,000-$174,999       35
    ## 10 Always        $0-$9,999               27
    ## 11 Always        $175,000-$199,999       25

Data visualization
------------------

``` r
ggplot(dat3, aes(reorder(Salary,n), y=n, fill=Salary)) +
    geom_bar(stat="identity", position=position_dodge(), colour="black", width = 0.5) +
    coord_flip() + 
    ggtitle("Salary Distribution about Men who always pay for their Date") +
    xlab("Salary") + ylab("Number") 
```

![](data607_tidyverse_files/figure-markdown_github/unnamed-chunk-13-1.png)
