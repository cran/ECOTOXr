% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/database_access.r
\name{check_ecotox_version}
\alias{check_ecotox_version}
\title{Check if the locally build database is up to date}
\usage{
check_ecotox_version(path = get_ecotox_path(), version, verbose = TRUE)
}
\arguments{
\item{path}{When you have a copy of the database somewhere other than the default
directory (\code{\link[=get_ecotox_path]{get_ecotox_path()}}), you can provide the path here.}

\item{version}{A \code{character} string referring to the release version of the database you wish to locate.
It should have the same format as the date in the EPA download link, which is month, day, year, separated by
underscores ("\%m_\%d_\%Y"). When missing, the most recent available copy is selected automatically.}

\item{verbose}{A \code{logical} value. If true messages are shown on the console reporting
on the check.}
}
\value{
Returns a \code{logical} value invisibly indicating whether the locally build
is up to date with the latest release by the EPA.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#stable}{\figure{lifecycle-stable.svg}{options: alt='[Stable]'}}}{\strong{[Stable]}} Checks the version of the database available on-line
from the EPA against the specified version (latest by default) of the database build
locally. Returns \code{TRUE} when they are the same.
}
\examples{
\dontrun{
check_ecotox_version()
}
}
\author{
Pepijn de Vries
}
