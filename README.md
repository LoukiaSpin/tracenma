# tracenma: Database for Developing Transitivity Methodology in Network Meta-Analysis   <img src="man/figures/logo.png" align="right" width="200" />    

Official Git repository of `tracenma` R package

<!-- badges: start -->
[![R-CMD-check](https://github.com/LoukiaSpin/tracenma/actions/workflows/R-CMD-check.yaml/badge.svg?branch=main)](https://github.com/LoukiaSpin/tracenma/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Website

The [website](https://loukiaspin.github.io/tracenma/) of `tracenma` currently includes a structured reference list to facilitate access to the documentation of the functions available in the package.

## Description 

The `tracenma` R package contains a database with extracted aggregate 
study-level characteristics (that may act as effect modifiers) from 217 
systematic reviews with network meta-analysis published from 2004 to 2015. 
`tracenma` also contains functions to access the catalogue with the available 
systematic reviews and the datasets with the extracted characteristics, 
comprising the database.

The package is built upon the R package 
[nmadb](https://CRAN.R-project.org/package=nmadb) (version 1.2.0) to define the 
eligible connected networks to extract the available characteristics from the 
corresponding systematic reviews. Currently, `tracenma` includes a subset of the 
systematic reviews available in 
[nmadb](https://CRAN.R-project.org/package=nmadb).

👉 The `tracenma` R package should **only** be used to develop and appraise the 
methodology to assess the transitivity assumption quantitatively.

👎 The `tracenma` R package should **not** be used, for instance, to map the 
characteristics reported in specific healthcare fields of the database.

## Getting started

Run the following code to install and load the package from CRAN:

    install.packages("tracenma")
    library(tracenma)

or run the following code to install and load the development version of the package:

    install.packages("devtools")
    devtools::install_github("LoukiaSpin/tracenma")
    library(tracenma)

## Example

### Access the catalogue of the database

To access the complete catalogue with all 217 systematic reviews with their 
characteristics, type `index`. 

``` r
head(index[, 1:5])
#>   nmadb.ID PMID      First.Author Year    Journal.Name 
#> 1   501330 15147585         Mason 2004   BMC Fam Pract
#> 2   479574 15820294 Biondi-Zoccai 2005   Int J Cardiol
#> 5   501268 15968013  Gafter-Gvili 2005  Ann Intern Med
#> 4   481193 16354303         Moore 2005        BMC Urol
#> 3   479688 16442888          Zhou 2005      Am Heart J
#> 6   501211 16239897        Berner 2006 Int J Impot Res
```

### Access the index of specific dataset(s)

Use the function `get.dataset.index` to get one or more  systematic reviews and 
their characteristics. For instance, let us access the available systematic 
reviews publish in 2007:

``` r
get.dataset.index(pmid = NULL, year = 2007)
#>    nmadb.ID     PMID  First.Author Year          Journal.Name   Outcome.Type
#> 11   480655 16951908   Vestergaard 2007        Osteoporos Int      Objective
#> 14   501355 17478472         Nixon 2007          Rheumatology     Subjective
#> 13   501336 17651658        McLeod 2007 Health Technol Assess     Subjective
#> 15   501395 17903393 Soares-Weiser 2007 Health Technol Assess Semi-objective
#> 12   501309 17932160           Lam 2007                   BMJ      Objective
                                                                                                                                                    
#>    Intervention.Comparison.Type Includes.ToC.where                      Source.ToC
#> 11   pharmacological vs placebo          Main text                         Table 1
#> 14   pharmacological vs placebo          Main text                         Table 1
#> 13   pharmacological vs placebo          Main text                    Table 2 to 4
#> 15   pharmacological vs placebo          Both      Tables 1 & 2, Appendix Tables 5
#> 12   non-pharmacological vs any          Main text                         Table 1
```

Now, let us access the systematic reviews with PMID numbers 16951908 and 17932160:

``` r
get.dataset.index(pmid = c(16951908, 17932160))
#>    nmadb.ID     PMID  First.Author Year    Journal.Name  Outcome.Type
#> 11   480655 16951908   Vestergaard 2007  Osteoporos Int     Objective
#> 12   501309 17932160           Lam 2007             BMJ     Objective
                                                                                                                                                    
#>    Intervention.Comparison.Type Includes.ToC.where Source.ToC
#> 11   pharmacological vs placebo          Main text    Table 1
#> 12   non-pharmacological vs any          Main text    Table 1
```

### Access a specific dataset

Use the function `get.dataset` to get the dataset with the extracted 
characteristics of a specific systematic review. For instance, let us access the 
dataset of the systematic review with PMID number 16951908:

``` r
get.dataset(pmid = 16951908)
#> # A tibble: 25 × 12
#>    `trial (reference)`   treat1 treat2    arm1    arm2    sex sample.size h.rPTH   calcium vitamin.D duration quality
#>    <chr>                  <dbl>  <dbl>   <chr>   <chr>  <chr>       <dbl>  <chr>     <dbl>     <dbl>    <dbl>   <dbl>
#>  1 Finkelstein 1998 (26)      1      2 control  PTH 40 female          43   1-34        NA        NA       12       2
#>  2 Lane 1998 (42)             1      3 control  PTH 25 female          51   1-34      1500       800       12       3
#>  3 Kurland 2000 (33)          1      4 control  PTH 32   male          23   1-34      1500       400       18       3
#>  4 Cosman 2001 (24)           1      3 control  PTH 25 female          52   1-34      1500       800       36       3
#>  5 Neer 2001 (5)              1      2 control  PTH 40 female         882   1-34      1000       400       21       3
#>  6 Neer 2001 (5)              1      5 control  PTH 20 female         892   1-34      1000       400       21       3
#>  7 Neer 2001 (5)              2      5  PTH 40  PTH 20 female         878   1-34      1000       400       21       3
#>  8 Body 2002 (43)             1      2 control  PTH 40 female         146   1-34      1000       400       12       4
#>  9 Finkelstein 2003 (28)      1      2 control  PTH 40   male          48   1-34      1000       400       30       3
#> 10 Finkelstein 2003 (28)      1      6 control PTH+ALN   male          53   1-34      1000       400       30       3
#> # ℹ 15 more rows
#> # ℹ Use `print(n = ...)` to see more rows
``` 

That's it for the moment! 😎 ☕

## Funding source

The development of the `tracenma` R package is funded by the **German Research Foundation** (Deutsche Forschungsgemeinschaft) (grant no. [SP 1664/2-1](https://gepris.dfg.de/gepris/projekt/462260733)) <div style="text-align: right"> <img src="man/figures/dfg_logo_schriftzug_blau_foerderung_en.png" width="280" height="100" align="right"></div>
