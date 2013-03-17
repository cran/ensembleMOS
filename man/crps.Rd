\name{crps}
\alias{crps}
\alias{crps.ensembleMOSnormal}
%\alias{crps.ensembleMOStruncnormal}
\alias{crps.fitMOSnormal}
%\alias{crps.fitMOStruncnormal}
\title{
   Continuous Ranked Probability Score
}
\description{
   Computes the continuous ranked probability score (CRPS)
   for univariate ensemble forecasting models.
}
\usage{
crps(fit, ensembleData, dates=NULL, nSamples=NULL, seed=NULL, \dots)
%CRPS( fit, ensembleData, dates=NULL, nSamples=NULL, seed=NULL, \dots)
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
  \item{nSamples}{
     The number of simulation samples for CRPS via simulation.
  }
  \item{seed}{
     Argument to \code{set.seed} for random number generation in simulation.
  }
  \item{dates}{
     The dates for which the CRPS will be computed.
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
  \code{crps} is a vector giving the CRPS for each instance in the
  data. \cr
  %\code{CRPS} is a vector giving the mean of the CRPS over all
  %instances for the raw ensemble and the median probabilistic forecast.
}
\details{
   These methods are generic, and can be applied to all ensemble
   forecasting models. %\cr
   %For \code{gamma0} model for precipitation and the \code{gamma} model
   %for wind speed the CRPS is only available through simulation.
   %The default number of simulation samples is 10,000. \cr
   %Note that the \code{gamma0} model for precipitation and the
   %\code{gamma} model for wind speed may have been applied to a power
   %transformation of the data. \cr
   For Gaussian (normal) models for temperature and pressure,
   calculation of the CRPS via simulation is not used and analytic
   computation is the only option.

   %CRPS will be computed via simulation for
   %normal models only if \code{nSamples} is set to a positive value. \cr
   %For the bivariate normal model for wind speed and direction, the
   %CRPS is computed for the marginal wind speed distribution.
}
\seealso{
  \code{\link{ensembleMOS}},
  \code{\link{fitMOS}}
}
\references{
T. Gneiting and A. E. Raftery,
Strictly proper scoring rules, prediction and estimation,
\emph{Journal of the American Statistical Association} 102:359--378 2007.
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

  crpsValues <- crps( tempTestFit, tempTestData)
  mean(crpsValues)

}
\keyword{models}
% docclass is function