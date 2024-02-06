#' Get the index of specific datasets
#'
#' @description
#'   Creates the enhanced balloon plot for the summary effect size and
#'   between-trial standard deviation, \emph{tau}, under different scenarios
#'   about the missingness parameter for a pair of interventions.
#'   \code{balloon_plot} uses the scenarios considered in
#'   \code{\link{run_sensitivity}}.
#'
#' @param pmid An object of S3 class \code{\link{run_sensitivity}}.
#'   See 'Value' in \code{\link{run_sensitivity}}.
#' @param year A character vector with two elements indicating the pairwise
#'   comparison of interest. The first element refers to the 'experimental'
#'   and the second element to the 'control' intervention of the comparison.
#'
#' @return
#'   \code{balloon_plot} returns two enhanced balloon plots for one
#'   comparison (see 'Details'):
#'   \item{plot_effect_size}{The enhanced balloon plot for the
#'   summary effect size (according to the argument \code{measure} inherited
#'   by \code{\link{run_sensitivity}}) for one pairwise comparison.}
#'   \item{plot_tau}{The enhanced balloon plot for \emph{tau}. When the
#'   fixed-effect model has been performed in \code{\link{run_sensitivity}},
#'   the function will not return the \code{plot_tau}.}
#'
#' @details
#'   For the \code{plot_effect_size} of the selected pairwise comparison,
#'   the different colours and sizes of the bubbles reflect the
#'   posterior standard deviation and the posterior mean, respectively.
#'   A colour key appears below the plot. The size of the bubble is proportional
#'   to the corresponding posterior mean.
#'   Crossed bubbles indicate scenarios with conclusive evidence (the
#'   95\% credible interval excludes the null value), and filled bubbles
#'   indicate scenarios with inconclusive evidence (the 95\% credible interval
#'   includes the null value). The missing-at-random assumption (primary
#'   analysis) is labeled in a white frame.
#'   Both axes illustrate the scenarios as specified in the argument
#'   \code{mean_scenarios} of the \code{\link{run_sensitivity}}:
#'   the x-axis refers to the 'experimental' intervention, and the y-axis refers
#'   to the 'control' intervention.
#'
#'   The same enhanced balloon plot is created for \emph{tau} (\code{plot_tau}).

#'
#' @author {Loukia M. Spineli}
#'
#' @references
#' Spineli LM, Kalyvas C, Papadimitropoulou K. Quantifying the robustness of
#' primary analysis results: A case study on missing outcome data in pairwise
#' and network meta-analysis. \emph{Res Synth Methods}
#' 2021;\bold{12}(4):475--490. doi: https://doi.org/10.1002/jrsm.1478
#'
#' @examples
#' data("pma.taylor2004")
#'
#' # Read results from 'run_sensitivity' (using the default arguments)
#' res_sens <- readRDS(system.file('extdata/res_sens_taylor.rds',
#'                     package = 'rnmamod'))
#'
#' # The names of the interventions in the order they appear in the dataset
#' interv_names <- c("placebo", "inositol")
#'
#' # Create the enhanced balloon plot for 'inositol versus placebo'
#' balloon_plot(sens = res_sens,
#'              compar = c("inositol", "placebo"),
#'              drug_names = interv_names)
#'
#' @export
get.dataset.index <- function (pmid,
                               year = NULL) {


  ## Default arguments
  # 'pmid' argument
  pmid <- if (missing(pmid)) {
    stop("'pmid' must be specified.", call. = FALSE)
  } else if (any(unique(!is.element(pmid, readRDS(file = "./30_Preparing functions/RDS data/index.rds")[, 2])) == TRUE |
                 length(unique(!is.element(pmid, readRDS(file = "./30_Preparing functions/RDS data/index.rds")[, 2]))) > 1)) {
    stop("This PMID value does not exist. Check 'index'.", call. = FALSE)
  } else {
    pmid
  }

  # 'year' argument
  year <- if (any(!is.null(year) & length(year) > 1)) {
    stp("'year' is scalar.", call. = FALSE)
  } else if (any(!is.null(year) & !is.element(year, readRDS(file = "./30_Preparing functions/RDS data/index.rds")[, 4]))) {
    stop("This Year does not exist. Check 'index'.", call. = FALSE)
  } else if (any(!is.null(year) & (length(year) == 1 | is.element(year, readRDS(file = "./30_Preparing functions/RDS data/index.rds")[, 4])))) {
    year
  } else {
    NULL
  }


  ## If year is provided, all corresponding SRs are shown.
  index.sr <- if (is.null(year)) {
    subset(readRDS(file = "./30_Preparing functions/RDS data/index.rds"),
           is.element(PMID, pmid))
  } else {
    subset(readRDS(file = "./30_Preparing functions/RDS data/index.rds"),
           Year == year)
  }

  return(index.sr)
}

