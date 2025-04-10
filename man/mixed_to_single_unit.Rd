% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/process_unit.r
\name{mixed_to_single_unit}
\alias{mixed_to_single_unit}
\title{Convert mixed units to a specific unit}
\usage{
mixed_to_single_unit(x, target_unit)
}
\arguments{
\item{x}{A mixed units object (\code{units::mixed_units()}) to be converted
to the \code{target_unit}}

\item{target_unit}{A \code{character} string representing the target
unit}
}
\value{
Returns a units object (\code{?units::units}). Values with units
that cannot be converted to the \code{target_unit} is returned as \code{NA}.
}
\description{
Converts a list of mixed units to a specific unit, using the \code{units}
package.
}
\examples{
mishmash <- as_unit_ecotox(c("mg/L", "ppt w/v", "\% w/v", "mmol/L"))

## Note that 'mmol/L' cannot be converted to 'ug/L'
## without a molar mass. It is returned as `NA`
mixed_to_single_unit(mishmash, "ug/L")

mishmash <- as_unit_ecotox(c("h", "sec", "mi", "dph"))

mixed_to_single_unit(mishmash, "h")
}
\seealso{
Other ecotox-sanitisers: 
\code{\link{as_date_ecotox}()},
\code{\link{as_numeric_ecotox}()},
\code{\link{as_unit_ecotox}()},
\code{\link{process_ecotox_dates}()},
\code{\link{process_ecotox_numerics}()},
\code{\link{process_ecotox_units}()}
}
\author{
Pepijn de Vries
}
\concept{ecotox-sanitisers}
