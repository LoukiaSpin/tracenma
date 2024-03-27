#' Get the index of specific dataset(s)
#'
#' @description
#'   A function to retrieve the characteristics of one of more systematic
#'   reviews found in the database using their PMID number or year of
#'   publication.
#'
#' @param pmid A scalar or vector with the PMID number(s) of the systematic
#'   reviews found in the database.
#' @param year A scalar to define the year of publication.
#'   \code{get.dataset.index} will return all systematic reviews found in the
#'   database under this year.
#' @param show.title Logical to indicate whether to show the title of the
#'   selected systematic review(s). The default is \code{FALSE} (do not show).
#' @param show.comment Logical to indicate whether to show the comment referring
#'   to extraction notes about the selected systematic review(s). The default is
#'   \code{FALSE} (do not show).
#'
#' @return
#'   \code{get.dataset.index} returns a vector (when \code{pmid} is scalar) or a
#'   data-frame (when \code{pmid} is a vector) with the following
#'   characteristics (column names):
#'   \item{nmadb.ID}{The ID number as provided in the R package
#'    \href{https://CRAN.R-project.org/package=nmadb}{nmadb}.}
#'   \item{PMID}{The PMID number.}
#'   \item{First.Author}{The name of the first author.}
#'   \item{Year}{The year of publication.}
#'   \item{Journal.Name}{The abbreviated name of the journal.}
#'   \item{Title}{The title of the systematic review.}
#'   \item{Outcome.Type}{The outcome type as suggested by Turner et al.
#'    (2012) and distinguished into objective, semi-objective and subjective.}
#'   \item{Intervention.Comparison.Type}{The treatment-comparator type
#'    as suggested by Turner et al. (2012) and distinguished into
#'    pharmacological versus placebo, pharmacological versus pharmacological,
#'    and non-pharmacological versus any.}
#'   \item{Includes.ToC.where}{Whether the extracted study-level
#'    aggregate characteristics were found in the main article, Appendix or
#'    both.}
#'   \item{Source.ToC}{The exact location in the systematic review
#'    where the extracted study-level aggregate characteristics were found, such
#'    as Table(s) in the main article, and/ or Appendix.}
#'   \item{Comment}{Notes related to the extraction for the selected systematic
#'    review(s).}
#'
#' @details
#'   When \code{year} is specified, the argument \code{pmid} should be NULL.
#'   Then, \code{get.dataset.index} returns all systematic reviews found in the
#'   database under this year.
#'
#'   Except for \strong{PMID}, \strong{Includes.ToC.where}, and
#'   \strong{Source.ToC}, all other characteristics were retrieved from the R
#'   package \href{https://CRAN.R-project.org/package=nmadb}{nmadb} using the
#'   function \code{\link[nmadb:getNMADB]{getNMADB}} and subsetting to those
#'   systematic reviews with available data
#'   (i.e., \code{Data.available == "True"} when using the function
#'   \code{\link[nmadb:getNMADB]{getNMADB}}). The database was reduced further
#'   during extraction, for instance, due to the reporting issues and data
#'   unavailability of the systematic review relating to the extraction
#'   process.
#'
#' @author {Loukia M. Spineli}
#'
#' @seealso \code{\link[nmadb:getNMADB]{getNMADB}}
#'
#' @references
#' Turner RM, Davey J, Clarke MJ, Thompson SG, Higgins JP. Predicting the extent
#' of heterogeneity in meta-analysis, using empirical data from the Cochrane
#' Database of Systematic Reviews.
#' \emph{Int J Epidemiol} 2012;\bold{41}(3):818--27. doi: 10.1093/ije/dys041.
#'
#' @examples
#' # For one systematic review with PMID number 25626481.
#' get.dataset.index(pmid = 25626481)
#'
#' # For two systematic reviews with PMID numbers 25626481 and 15147585,
#' # respectively.
#' #get.dataset.index(pmid = c(25626481, 15147585))
#'
#' # For systematic reviews published during 2010. The argument 'pmid' does not
#' # need to be specified.
#' get.dataset.index(pmid = NULL, year = 2010)
#'
#' @export
get.dataset.index <- function (pmid,
                               year = NULL,
                               show.title = FALSE,
                               show.comment = FALSE) {

  index <- readRDS(system.file("extdata/index.rds", package = "tracenma"))

  ## Default arguments
  # 'pmid'
  pmid_new <- if (!is.null(pmid) & !is.null(year)) {
    stop("Only argument 'pmid' or 'year' must be specified, not both.",
         call. = FALSE)
  } else if (any(unique(!is.element(pmid, index[, 2])) == TRUE |
                 length(unique(!is.element(pmid, index[, 2]))) > 1)) {
    stop("This PMID value does not exist. Check 'index'.", call. = FALSE)
  } else {
    pmid
  }

  # 'year'
  if (!is.null(year)) {
    year_new <- if (!is.null(pmid)) {
    stop("Only argument 'pmid' or 'year' must be specified, not both.",
         call. = FALSE)
    } else if (length(year) > 1) {
      stop("Argument 'year' is scalar.", call. = FALSE)
    } else if (!is.element(year, index[, 4])) {
      stop("This Year does not exist. Check 'index'.", call. = FALSE)
    } else {
      year
    }
  }

  ## If year is provided, all corresponding systematic reviews are shown.
  index.sr <- if (is.null(year)) {
    subset(index, is.element(index$PMID, pmid_new))
  } else {
    subset(index, index$Year == year_new)
  }

  ## Collect results
  Title <- Comment <- NA
  results <- if (show.title == FALSE & show.comment == FALSE) {
    subset(index.sr, select = -c(Title, Comment))
  } else if (show.title == TRUE & show.comment == FALSE) {
    subset(index.sr, select = -Comment)
  } else if (show.title == FALSE & show.comment == TRUE) {
    subset(index.sr, select = -Title)
  } else {
    index.sr
  }

  return(results)
}
