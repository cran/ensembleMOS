\name{quantileForecast}
\alias{quantileForecast}
\alias{quantileForecast.ensembleMOSnormal}
%\alias{quantileForecast.ensembleMOStruncnormal}
\alias{quantileForecast.fitMOSnormal}
%\alias{quantileForecast.fitMOStruncnormal}
%\alias{matchEnsembleMembers.ensembleMOSnormal}
%\alias{matchEnsembleMembers.ensembleMOStruncnormal}
%\alias{matchEnsembleMembers.fitMOSnormal}
%\alias{matchEnsembleMembersfitMOStruncnormal}
\title{
   Quantile forecasts at observation locations
}
\description{
   Computes quantiles for the probability distribution function
   (PDF) for ensemble forecasting models.
}
\usage{
quantileForecast(fit, ensembleData, quantiles = 0.5, dates = NULL, \dots)
}
\arguments{
  \item{fit}{
    A model fit to ensemble forecasting data.
  }
  \item{ensembleData}{
     An \code{ensembleData} object that includes ensemble
     forecasts, verification observations and possibly dates.
     Missing values (indicated by \code{NA}) are allowed. \\
     This need not be the data used for the model \code{fit},
     although it must include the same ensemble members.
  }
  \item{quantiles}{
     The vector of desired quantiles for the PDF of the EMOS model.
  }
 \item{dates}{
     The dates for which the quantile forecasts will be computed.
     These dates must be consistent with \code{fit} and
     \code{ensembleData}.
     The default is to use all of the dates in \code{fit}.
     If \code{ensembleData} does not include dates, they will
     be inferred from \code{fit} and \code{dates}.
  }
 \item{\dots}{
     Included for generic function compatibility.
 }
}
\value{
A matrix of forecasts corresponding to the desired quantiles.
}
\details{
   This method is generic, and can be applied to any ensemble forecasting
   model. \cr
   Note the model may have been applied to a power transformation of the
   data, but that information is included in the input \code{fit}, and
   the output is transformed appropriately. \cr
   This can be used to compute prediction intervals for the PDF.  \cr
}
\seealso{
  \code{\link{ensembleMOS}},
  \code{\link{fitMOS}},
  \code{\link{cdf}}
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


\dontrun{ # R check

  data(srft)

  labels <- c("CMCG","ETA","GASP","GFS","JMA","NGPS","TCWB","UKMO")

  srftData <- ensembleData( forecasts = srft[ ,labels],
                            dates = srft$date,
                            observations = srft$obs,
                            latitude = srft$lat,
                            longitude = srft$lon,
                            forecastHour = 48,
                            initializationTime = "00")

  srftFit <- ensembleMOSnormal(srftData, date = "2004012900",
                               trainingDays = 25)

  data(srftGrid)

  srftGridData <- ensembleData(forecasts = srftGrid[ ,labels],
                               latitude = srftGrid$lat,
                               longitude = srftGrid$lon,
                               forecastHour = 48,
                               initializationTime = "00")

  srftGridForc <- quantileForecast( srftFit, srftGridData,
                     date = "2004012900")
}}
\keyword{models}
% docclass is function