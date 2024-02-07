# tracenma: Database for Transitivity Methodology in Network Meta-Analysis  

Official Git repository of `tracenma` R package

<!-- badges: start -->
[![R-CMD-check](https://github.com/LoukiaSpin/tracenma/actions/workflows/R-CMD-check.yaml/badge.svg?branch=main)](https://github.com/LoukiaSpin/tracenma/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Description 

The `tracenma` R package contains a database with extracted aggregate 
study-level characteristics (that may act as effect modifiers) from 217 
systematic reviews with network meta-analysis published from 2004 to 2015. 
`tracenma` also contains functions to access the catalogue with the available 
systematic reviews and the datasets with the extracted characteristics, 
comprising the database.

The `tracenma` R package should **only** be used to develop and appraise the 
methodology to assess the transitivity assumption quantitatively.

## Getting started

Run the following code to install and load the package from CRAN:

    install.packages("tracenma")
    library(tracenma)

or run the following code to install the development version of the package:

    install.packages("devtools")
    devtools::install_github("LoukiaSpin/tracenma")

## Example

### Access the catalogue of the database

To access the complete catalogue with all 217 systematic reviews and their 
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
#>    nmadb.ID     PMID  First.Author Year          Journal.Name Title
#> 11   480655 16951908   Vestergaard 2007        Osteoporos Int ...
#> 14   501355 17478472         Nixon 2007          Rheumatology ...
#> 13   501336 17651658        McLeod 2007 Health Technol Assess ...
#> 15   501395 17903393 Soares-Weiser 2007 Health Technol Assess ...
#> 12   501309 17932160           Lam 2007                   BMJ ...
                                                                                                                                                    
#>      Outcome.Type Intervention.Comparison.Type Includes.ToC.where            Source.ToC
#> 11      Objective   pharmacological vs placebo          Main text               Table 1
#> 14     Subjective   pharmacological vs placebo          Main text               Table 1
#> 13     Subjective   pharmacological vs placebo          Main text          Table 2 to 4
#> 15 Semi-objective   pharmacological vs placebo Supplementary file Appendix Tables 5 & 6
#> 12      Objective   non-pharmacological vs any          Main text               Table 1
```

Now, let us access the systematic reviews with PMID numbers 16951908 and 17932160:

``` r
get.dataset.index(pmid = c(16951908, 17932160))
#>    nmadb.ID     PMID  First.Author Year    Journal.Name Title
#> 11   480655 16951908   Vestergaard 2007  Osteoporos Int ...
#> 12   501309 17932160           Lam 2007             BMJ ...
                                                                                                                                                    
#>      Outcome.Type Intervention.Comparison.Type Includes.ToC.where Source.ToC
#> 11      Objective   pharmacological vs placebo          Main text    Table 1
#> 12      Objective   non-pharmacological vs any          Main text    Table 1
```

### Access a specific dataset

Use the function `get.dataset` to get the dataset with the extracted 
characteristics of a specific systematic review. For instance, let us access the 
dataset of the systematic review with PMID number 16951908:

``` r
get.dataset(pmid = 16951908)
#> # A tibble: 25 × 12
#>    `trial (reference)`   treat1 treat2 arm1    arm2    sample.size sex    h.rPTH calcium vitamin.D duration quality
#>    <chr>                  <dbl>  <dbl> <chr>   <chr>         <dbl> <chr>  <chr>    <dbl>     <dbl>    <dbl>   <dbl>
#>  1 Finkelstein 1998 (26)      1      2 control PTH 40           43 female 1-34        NA        NA       12       2
#>  2 Lane 1998 (42)             1      3 control PTH 25           51 female 1-34      1500       800       12       3
#>  3 Kurland 2000 (33)          1      4 control PTH 32           23 male   1-34      1500       400       18       3
#>  4 Cosman 2001 (24)           1      3 control PTH 25           52 female 1-34      1500       800       36       3
#>  5 Neer 2001 (5)              1      2 control PTH 40          882 female 1-34      1000       400       21       3
#>  6 Neer 2001 (5)              1      5 control PTH 20          492 female 1-34      1000       400       21       3
#>  7 Neer 2001 (5)              2      5 PTH 40  PTH 20          878 female 1-34      1000       400       21       3
#>  8 Body 2002 (43)             1      2 control PTH 40          146 female 1-34      1000       400       12       4
#>  9 Finkelstein 2003 (28)      1      2 control PTH 40           48 male   1-34      1000       400       30       3
#> 10 Finkelstein 2003 (28)      1      6 control PTH+ALN          53 male   1-34      1000       400       30       3
#> # ℹ 15 more rows
#> # ℹ Use `print(n = ...)` to see more rows
``` 

## Funding source

The development of the `tracenma` R package is funded by the **German Research Foundation** (Deutsche Forschungsgemeinschaft) (grant no. [SP 1664/2-1](https://gepris.dfg.de/gepris/projekt/462260733)) <div style="text-align: right"> <img src="man/figures/dfg_logo_schriftzug_blau_foerderung_en.png" width="280" height="100" align="right"></div>
