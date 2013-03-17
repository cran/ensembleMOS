\name{cdf}
\alias{cdf}
\alias{cdf.ensembleMOSnormal}
%\alias{cdf.ensembleMOStruncnormal}
\alias{cdf.fitMOSnormal}
%\alias{cdf.fitMOStruncnormal}
\title{
   Cummulative Distribution Function for ensemble forcasting models
}
\description{
   Computes the cumulative distribution function (CDF)
   of an ensemble forecasting model at observation locations.
}
\usage{
cdf(fit, ensembleData, values, dates = NULL, \dots)
}
\arguments{
   \item{fit}{
     A model fit to ensemble forecasting data, obtained using
     \code{\link{fitMOS}} or \cr \code{\link{ensembleMOS}}.
  }
  \item{ensembleData}{
     An \code{ensembleData} object that includes ensemble forecasts,
     verification observations and possibly dates.
     Missing values (indicated by \code{NA}) are allowed.
     This need not be the data used for the model \code{fit},
     although it must include the same ensemble members.
  }
  \item{values}{
    The vector of desired values at which the CDF of the ensemble
    forecasting model is to be evaluated.
  }
 \item{dates}{
     The dates for which the CDF will be computed.
     These dates must be consistent with \code{fit} and \code{ensembleData}.
     The default is to use all of the dates in \code{fit}.
     The dates are ignored if \code{fit} originates from \code{fitMOS},
     which also ignores date information.
  }
 \item{\dots}{
     Included for generic function compatibility.
 }
}
\value{
  A matrix of probabilities corresponding to the CDF at the desired values.
  Useful for determining propability of freezing, precipitation, etc.
}
\details{
   This method is generic, and can be applied to any ensemble forecasting
   model. \cr
   Note the model may have been applied to a power transformation of the
   data, but that information is included in the input \code{fit}, and
   the output is transformed appropriately.
}
\seealso{
  \code{\link{ensembleMOS}},
  \code{\link{fitMOS}},
  \code{\link{quantileForecast}}
}
\references{
T. Gneiting, A. E. Raftery, A. H. Westveld and T. Goldman,
Calibrated probabilistic forecasting using ensemble model output
statistics and minimum CRPS estimation.
\emph{Monthly Weather Review} 133:1098--1118, 2005.
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


  tempTestForc <- quantileForecast( tempTestFit, tempTestData)
  range(tempTestForc)

  tempTestCDF <- cdf( tempTestFit, tempTestData,
                      values = seq(from=277, to=282, by = 1))

  tempTestCDF
}
\keyword{models}
