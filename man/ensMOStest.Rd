\name{ensMOStest}
\alias{ensMOStest}
\alias{temp}
\docType{data}
\title{Ensemble MOS Test Data Set}
\description{
  This data set gives 48-hour ahead forecasts for 2-m temperature over the
  last 24 hours at SeaTac (KSEA) and Portland (PDX) airports in 2007/2008
  initialized at 00 hours UTC using a 12km grid. The forecasts are based
  on an 8 member version of the University of Washington mesoscale
  ensemble (Grimit and Mass 2002; Eckel and Mass 2005). \cr
}
\format{
A data frame with 66 rows and 16 columns: \cr
\code{idate} the initialization date of each forecast/observation,
		format YYYYMMDDHH (categorical). \cr
\code{vdate} the validation date of each forecast/observation,
		format YYYYMMDDHH (categorical). \cr
\code{latitude}  the latitude of each forecast/observation (numeric). \cr
\code{longitude}  the longitude of each forecast/observation (numeric). \cr
\code{elevation}  the elevation (in meters) above sea level (numeric). \cr
\code{station} weather station identifier (categorical). \cr
\code{network} weather network identifier (categorical).
\code{gfs,cmcg,eta,gasp,jma,ngps,tcwb}
forecasts from the 8 members of the ensemble (numeric).
\code{obs} observed values for the weather parameters.
}
\details{
  Temperature is given in degrees Kelvin. \cr
  This is a small dataset provided for the purposes of testing.
  Typically forecasting would be performed on much larger datasets.
}
\references{
F. A. Eckel and C. F. Mass,
Effective mesoscale, short-range ensemble forecasting,
\emph{Weather and Forecasting} 20:328--350, 2005.

E. P. Grimit and C. F. Mass,
Initial results of a mesoscale short-range ensemble forecasting system over
the Pacific Northwest,
\emph{Weather and Forecasting} 17:192--205, 2002.
}
\examples{

  data(ensMOStest)

  ensMemNames <- c("gfs","cmcg","eta","gasp","jma","ngps","tcwb","ukmo")

  tempTestData <- ensembleData( forecasts = ensMOStest[,ensMemNames],
                                dates = ensMOStest[,"vdate"],
                                observations = ensMOStest[,"obs"],
                                station = ensMOStest[,"station"],
                                forecastHour = 48,
                                initializationTime = "00")

  tempTestFit <- ensembleMOSnormal( tempTestData, trainingDays = 30)

}
\keyword{datasets}
