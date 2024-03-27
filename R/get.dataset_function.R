#' Get the selected dataset
#'
#' @description
#'   Function to retrieve a dataset with aggregate study-level clinical and
#'   methodological characteristics (that may act as effect modifiers) extracted
#'   from the selected systematic review of the database.
#'
#' @param pmid A scalar with the PMID number of the systematic review found in
#'   the database.
#' @param show.index Logical to indicate whether to return a data-frame with the
#'   full name of the abbreviated characteristics. The default is
#'   \code{FALSE} (do not report).
#' @param show.type Logical to indicate whether to return a data-frame with the
#'   type (Demographic, Clinical, Methodological) and subtype (Age, Ethnicity,
#'   Intervention, Outcome, Participant, Risk of bias, Sex, Study design, Study
#'   setting, Withdrawals) of the characteristics. The default is \code{FALSE}
#'   (do not report).
#'
#' @return
#'   \code{get.dataset} returns the following:
#'    \item{Dataset}{A data-frame (tibble style) with rows referring to the
#'    studies and columns to the aggregate study-level characteristics as
#'    extracted from the report of the corresponding systematic review.}
#'    \item{Characteristics_index}{A data-frame (tibble style) with the rows
#'    referring to the extracted characteristics (abbreviated name) and columns
#'    to the their full name (if \code{show.index = TRUE}), their type and
#'    subtype (if \code{show.type = TRUE}).}
#'
#' @details
#'   The selected dataset refers to a connected network for a specific outcome
#'   studied in the corresponding systematic review.
#'   The R package \href{https://CRAN.R-project.org/package=nmadb}{nmadb} was
#'   used to retrieve the corresponding dataset. Specifically, the function
#'   \code{\link[nmadb:readByID]{readByID}} was employed to download the dataset
#'   in the long format. Then, the function
#'   \code{\link[netmeta:pairwise]{pairwise}} of the R package
#'   \href{https://CRAN.R-project.org/package=netmeta}{netmeta} was implemented
#'   to convert the dataset into wide format with each row repeated as many
#'   times as the number of possible comparisons made in the corresponding
#'   study. The study names (or references) and treatment comparisons, as
#'   returned by \code{\link[nmadb:readByID]{readByID}}, were used to locate the
#'   studies in the corresponding report of the systematic review (and Appendix,
#'   if available) and extract the characteristics available in the relevant
#'   table(s). Each characteristic occupies one column in the dataset.
#'   Characteristics pertaining to intervention features occupied one column for
#'   the experimental and another for the control treatment in the corresponding
#'   comparison.
#'
#' @author {Loukia M. Spineli}
#'
#' @seealso \code{\link[nmadb:getNMADB]{getNMADB}},
#'   \code{\link[netmeta:pairwise]{pairwise}}
#'
#' @examples
#' # Get dataset for systematic review with PMID number 25626481
#' get.dataset(pmid = 25626481)
#'
#' @export
get.dataset <- function(pmid,
                        show.index = FALSE,
                        show.type = FALSE) {

  ## Get the data-frame will all listed systematic reviews
  index <- readRDS(system.file("extdata/index.rds", package = "tracenma"))

  ## Default arguments
  # 'pmid' argument
  pmid <- if (missing(pmid)) {
    stop("'pmid' must be specified.", call. = FALSE)
  } else if (any(unique(!is.element(pmid, index[, 2])) == TRUE |
                 length(unique(!is.element(pmid, index[, 2]))) > 1)) {
    stop("This PMID value does not exist. Check 'index'.", call. = FALSE)
  } else {
    pmid
  }

  ## Get the dataset that corresponds to selected 'pmid'
  get.dataset <-
    readRDS(system.file(paste0("extdata/", pmid, ".rds"), package = "tracenma"))

  ## Get the index with the characteristics that corresponds to selected 'pmid'
  get.chars.index <-
    readRDS(system.file(paste0("extdata/", pmid, "_Chars.rds"), package = "tracenma"))

  ## Collect results
  results <- if (show.index == FALSE & show.type == FALSE) {
    list(Dataset = get.dataset)
  } else if (show.index == TRUE & show.type == FALSE) {
    list(Dataset = get.dataset,
         Characteristics_index = get.chars.index[, 1:2])
  } else if (show.index == FALSE & show.type == TRUE) {
    list(Dataset = get.dataset,
         Characteristics_index = get.chars.index[, c(1, 3:4)])
  } else {
    list(Dataset = get.dataset,
         Characteristics_index = get.chars.index)
  }

  return(results)
}
