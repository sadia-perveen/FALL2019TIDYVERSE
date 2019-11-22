---
title: "DTM in Tidyverse"
author: "Jai Jeffryes"
date: "11/21/2019"
output:
  html_document:
    highlight: pygments
    theme: flatly
    toc: yes
    toc_float: yes
    keep_md: yes
---




```r
library(readr)
library(stringr)
library(tibble)
library(tidytext)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(ggplot2)
library(tm)
```

```
## Loading required package: NLP
```

```
## 
## Attaching package: 'NLP'
```

```
## The following object is masked from 'package:ggplot2':
## 
##     annotate
```
## Data
The data for this vignette comes from fivethirtyeight. [Candidate Emails](https://github.com/fivethirtyeight/candidate-emails) contains emails received from subscribed email lists of 2020 Democratic campaign candidates.

## Document term matrix
A document term matrix (DTM) is a data structure that can serve as the input to machine learning models. Tidyverse tools can create this structure.

*Reference*: [Text Mining with R: A Tidy Approach](https://www.tidytextmining.com).

## Objective
The candidate emails are formatted as HTML files. They reside in directories named after the candidate. We will employ Tidy tools to produce a DTM that classifies terms by candidate.

## Build corpus
### Tidy tools
- `readr::read_file()`
- `stringr::str_extract()`
- `tibble::tibble()`

### Comments
- Read the emails in each candidate's directory and build a corpus.
- The filename of each email document is a unique identifier. `str_extract()` uses a regular expression to match the identifier.
- The candidate's name is the class for each email document is be the candidate's name.
- The corpus variables are: `email_id`, `class`, and `email`. I initialize an empty `tibble`, a form of data frame with some extra conveniences. One of them is that in order for a character column to be created as a factor, it must be coded explicitly. Character data is not converted to factors by default. We will need factors for grouping in `dplyr`, so the corpus variable `class` is initialized as a factor.


```r
email_dir <- "candidate-emails/emails"
candidates <- list.dirs(email_dir, full.names = FALSE)
is_candidate_empty <- candidates == ""
candidates <- candidates[!is_candidate_empty]

# Function for creating the corpus.
get_email_df <- function(class) {
    file_names <- list.files(file.path(email_dir, class), full.names = FALSE)
    file_paths <- list.files(file.path(email_dir, class), full.names = TRUE)
    raw_email <- sapply(file_paths, function(x) read_file(x))
    
	# Pick off key value on end of file names
	email_id <- str_extract(file_names, "^\\w*")
	# Corpus in tidy format. Each row is a document.
	email_df <- tibble(email_id = email_id,
	                  class = as.factor(class),
	                  email = raw_email)
	return(email_df)
}

email_df <- tibble(email_id = as.character(),
                   class_id = as.factor(as.character()),
                   email = as.character())

for (candidate in candidates) {
    candidate_email_df <- get_email_df(candidate)
    email_df <- rbind(email_df, candidate_email_df)
}
```

## Data cleaning
This would be a suitable place for cleaning data. For example, removal of HTML tags from the emails may be appropriate, but is omitted from this illustration.

## Tokenize
### Tidy tools
- `tidytext::unnest_tokens()`
- `tidytext::stop_words`

This approach creates a tidy dataframe (namely tall and narrow) of text tokens.

### Comments
- The `unnest_tokens()` function provides some data cleaning.
  - Removes punctuation
  - Converts to lower case
  - Removes white space
- The package `tidytext` provides a set of stop words and `dplyr::anti_join()` executes an outer join so stop words can be removed.


```r
# Tokenize all emails
email_tokens_df <- email_df %>% 
	unnest_tokens(word, email) %>% 
	anti_join(stop_words)
```

```
## Joining, by = "word"
```

## TF–IDF
### Tidy tools
- `dplyr::count()`
- `dplyr::ungroup()`
- `tidytext::bind_tf_idf()`

We calculate term frequency and inverse document frequency (TD-IDF) to enable producing a DTM.

### Comments
- We count words by class, which we define as the candidate in this illustration.
- `bind_tf_idf()` creates a TD-IDF data structure, which contains a variable for each word and which is a prerequisite for a DTM.


```r
email_tf_idf <- email_tokens_df %>% 
  count(class, word, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(word, class, n)
```

## Cast to DTM
### Tidy tools
- `tidytext::cast_dtm()`

This is the first departure from Tidy formats to a format readily utilizable by machine learning models.

### Comments
- We take counts and cast them to a DTM.


```r
# Word counts
word_counts <- email_tokens_df %>%
  count(email_id, word, sort = TRUE) %>%
  ungroup()

# Cast to a document term matrix
email_dtm <- word_counts %>% 
	cast_dtm(email_id, word, n)
```

## Interoperability
The DTM produced with Tidy tools is usable by other, non-Tidyverse packages, such as `tm`. This is illustrated by examining the DTM and then reducing its sparseness.

### Comments
- We print the DTM and then use `tm::inspect()` to examine it. Note that `inspect()` examines only a few elements of the matrix, so its measure of sparseness differs from that of the matrix as a whole.
- We use `tm::removeSparseTerms()` to reduce sparseness.


```r
# Print
dim(email_dtm)
```

```
## [1]   830 23163
```

```r
email_dtm
```

```
## <<DocumentTermMatrix (documents: 830, terms: 23163)>>
## Non-/sparse entries: 301152/18924138
## Sparsity           : 98%
## Maximal term length: 364
## Weighting          : term frequency (tf)
```

```r
inspect(email_dtm[101:105, 101:105])
```

```
## <<DocumentTermMatrix (documents: 5, terms: 5)>>
## Non-/sparse entries: 4/21
## Sparsity           : 84%
## Maximal term length: 19
## Weighting          : term frequency (tf)
## Sample             :
##                   Terms
## Docs               20190614_em_fnth b2_fdr_full_na go.stevebullock.com
##   16b3f176c7f95fe1                0              0                  24
##   16b532b215ac5de4                0              0                  25
##   16b5c5997e023dba                0              0                  25
##   16b6b66ad0e5f5e8                0              0                  29
##   16b899d93c4d207d                0              0                   0
##                   Terms
## Docs               mcntextcontent recap
##   16b3f176c7f95fe1              0     0
##   16b532b215ac5de4              0     0
##   16b5c5997e023dba              0     0
##   16b6b66ad0e5f5e8              0     0
##   16b899d93c4d207d              0     0
```

```r
# Remove some sparse terms and review again
email_dtm_rm_sparse <- removeSparseTerms(email_dtm, 0.8)
dim(email_dtm_rm_sparse)
```

```
## [1] 830 402
```

```r
email_dtm_rm_sparse
```

```
## <<DocumentTermMatrix (documents: 830, terms: 402)>>
## Non-/sparse entries: 164465/169195
## Sparsity           : 51%
## Maximal term length: 24
## Weighting          : term frequency (tf)
```

```r
inspect(email_dtm_rm_sparse[101:105, 101:105])
```

```
## <<DocumentTermMatrix (documents: 5, terms: 5)>>
## Non-/sparse entries: 19/6
## Sparsity           : 24%
## Maximal term length: 7
## Weighting          : term frequency (tf)
## Sample             :
##                   Terms
## Docs               1em 280px 8px amount bgcolor
##   16b3f176c7f95fe1   0    12   8     10       9
##   16b532b215ac5de4   0    12   8     11       9
##   16b5c5997e023dba   0    12   8     11       9
##   16b6b66ad0e5f5e8   0     0   8     14      10
##   16b899d93c4d207d   0    13   4     18      18
```

## Conclusion
The Tidyverse is a powerful resource for preparation of text data in a text mining workflow.
