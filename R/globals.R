#' @importFrom utils packageDescription

.onAttach <- function (libname, pkgname) {
  usage <- paste0("Loading 'tracenma', version",
                  " ", packageDescription("tracenma")$Version,
                  ". Use only for developing methods to assess transitivity!")
  packageStartupMessage(usage)
}
