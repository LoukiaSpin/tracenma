#' @importFrom utils packageDescription

.onAttach <- function (libname, pkgname) {
  usage <- paste0("Loading 'tracenma', version",
                  " ", packageDescription("tracenma")$Version,
                  ". Used only for developing methods to assess transitivity!")
  packageStartupMessage(usage)
}
