#' Convert European Environment Agency (EEA) data
#'
#' Read-in European Environment Agency (EEA) data on ETS emissions as magclass object
#'
#' @param x MAgPIE object to be converted
#' @param subtype data subtype. Either "ETS", "historical", "projections", or "projections-detailed"
#' @return magpie object of European Environment Agency (EEA) ETS emissions (GtCO2)
#' @author Renato Rodrigues
#' @seealso \code{\link{readSource}}
#' @examples
#' \dontrun{
#' a <- readSource(type = "EEA_EuropeanEnvironmentAgency", subtype = "ETS")
#' }
#'
#' @importFrom countrycode countrycode
#' @importFrom magclass as.magpie
#' @importFrom madrat toolCountry2isocode
#'

convertEEA_EuropeanEnvironmentAgency <- function(x, subtype) {
  if (subtype %in% c("ETS", "ESR")) {
    # fill up zero countries
    x <- toolCountryFill(x)
    # remove NAs
    x[is.na(x)] <- 0
  } else if (subtype == "total") {
    x <- toolCountryFill(x)
  } else if (subtype == "sectoral") {
    x <- toolCountryFill(x, no_remove_warning = "EUR")
  } else if (subtype %in% c("projections", "projections-detailed")) {
    getItems(x, dim = 1) <- countrycode(getItems(x, dim = 1), "iso2c", "iso3c", warn = FALSE, )
    x <- toolCountryFill(x, verbosity = 2, no_remove_warning = NA)
  }
  return(x)
}
