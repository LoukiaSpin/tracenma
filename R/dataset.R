#' Dataset catalogue
#'
#' @description A database with 217 systematic reviews with network
#'   meta-analysis (NMA) published from 2004 to April 14, 2015. The collected
#'   systematic reviews were retrieved from the R package
#'   \href{https://CRAN.R-project.org/package=nmadb}{nmadb} and pertain to
#'   those with available data in the R package
#'   \href{https://CRAN.R-project.org/package=nmadb}{nmadb}.
#'
#' @format A data-frame with 217 rows and 10 columns referring to the analysed
#'   systematic reviews with NMA and their characteristics, respectively.
#'
#' @details The characteristics of the systematic reviews comprise:
#'   \tabular{ll}{
#'    \strong{nmadb.ID} \tab The ID number as provided in the R package
#'    \href{https://CRAN.R-project.org/package=nmadb}{nmadb}.\cr
#'    \tab \cr
#'    \strong{PMID} \tab The PMID number.\cr
#'    \tab \cr
#'    \strong{First.Author} \tab The name of the first author.\cr
#'    \tab \cr
#'    \strong{Year} \tab The year of publication.\cr
#'    \tab \cr
#'    \strong{Journal.Name} \tab The abbreviated name of the journal.\cr
#'    \tab \cr
#'    \strong{Title} \tab The title of the systematic review.\cr
#'    \tab \cr
#'    \strong{Outcome.Type} \tab The outcome type as suggested by Turner et al.
#'    (2012) and distinguished into objective, semi-objective and subjective.\cr
#'    \tab \cr
#'    \strong{Intervention.Comparison.Type} \tab The treatment-comparator type
#'    as suggested by Turner et al. (2012) and distinguished into
#'    pharmacological versus placebo, pharmacological versus pharmacological,
#'    and non-pharmacological versus any.\cr
#'    \tab \cr
#'    \strong{Includes.ToC.where} \tab Whether the extracted study-level
#'    aggregate characteristics were found in the main article, Appendix or
#'    both.\cr
#'    \tab \cr
#'    \strong{Source.ToC} \tab The exact location in the systematic review
#'    where the extracted study-level aggregate characteristics were found, such
#'    as Table X in the main article, and/ or Appendix.\cr
#'    \tab \cr
#'    }
#'
#'  Except for \strong{PMID}, \strong{Includes.ToC.where}, and
#'  \strong{Source.ToC}, all other characteristics were retrieved from the R
#'  package \href{https://CRAN.R-project.org/package=nmadb}{nmadb} using the
#'  function \code{\link[nmadb:getNMADB]{getNMADB}} and subsetting to those
#'  systematic reviews with available data
#'  (i.e., \code{Data.available == "True"} when using the function
#'  \code{\link[nmadb:getNMADB]{getNMADB}}). The database was reduced further
#'  during extraction, for instance, due to the reporting quality and data of
#'  the systematic review relating to the extraction process.
#'
#' @seealso \code{\link[nmadb:getNMADB]{getNMADB}}
#'
#' @docType data
#' @keywords dataset
#' @name index
#' @usage data(index)
#' @source
#' Turner RM, Davey J, Clarke MJ, Thompson SG, Higgins JP. Predicting the extent
#' of heterogeneity in meta-analysis, using empirical data from the Cochrane
#' Database of Systematic Reviews.
#' \emph{Int J Epidemiol} 2012;\bold{41}(3):818--27. doi: 10.1093/ije/dys041.
NULL
