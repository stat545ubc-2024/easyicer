\name{easyicer_data}
\alias{easyicer_data}
\docType{data}
\title{
Health and Economic Data from a Microsimulation Modeling Study of Revised Colorectal Cancer Screening Guidelines in Canada
}
\description{
This dataset is borrowed from the author's personal research project in a modified format. The data was generated from a microsimulation model comparing various colorectal cancer screening strategies to assess the health benefits and economic burden of improving screening outomes.
}
\usage{data("easyicer_data")}
\format{
  A data frame with 828 observations on the following 8 variables.
  \describe{
    \item{\code{cohort}}{a numeric vector}
    \item{\code{scr_age}}{a numeric vector}
    \item{\code{ppt_rate}}{a numeric vector}
    \item{\code{scr_mod}}{a character vector}
    \item{\code{year}}{a numeric vector}
    \item{\code{Cost_of_screen_x_reen_positives}}{a numeric vector}
    \item{\code{Cost_of_clinic_x_ow_up_protocol}}{a numeric vector}
    \item{\code{Health_adjusted_person_years}}{a numeric vector}
  }
}
\source{
This dataset is not publicly available. The modified dataset is contained in a .csv in the GitHub repository.
}
\examples{
data(easyicer_data)
## e.g., str(easyicer_data) ; colnames(easyicer_data) ...
}
\keyword{datasets}
