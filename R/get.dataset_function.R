#' Get the selected dataset
#'
#' @description
#' Retrieving a dataset with study-level aggregate clinical and
#' methodological characteristics (that may act as effect modifiers) extracted
#' from the selected systematic review of the database.
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
#' \code{get.dataset} returns the following:
#' \item{Dataset}{A data-frame (tibble style) with rows referring to the
#'   studies and columns to the study-level aggregate characteristics as
#'   extracted from the report of the corresponding systematic review.}
#' \item{Characteristics_index}{A data-frame (tibble style) with the rows
#'   referring to the extracted characteristics (abbreviated name) and columns
#'   to the their full name (if \code{show.index = TRUE}), their type and
#'   subtype (if \code{show.type = TRUE}).}
#'
#' @details
#' The selected dataset refers to a connected network for a specific outcome
#' studied in the corresponding systematic review. Each characteristic occupies
#' one column in the dataset.
#' Characteristics pertaining to intervention features occupied one column for
#' the experimental and another for the control treatment in the corresponding
#' comparison.
#'
#' @author {Loukia M. Spineli}
#'
#' @examples
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
