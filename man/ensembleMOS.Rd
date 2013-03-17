\name{ensembleMOS}
\alias{ensembleMOS}
\alias{ensembleObsLabels}
\alias{ensembleSize}
\alias{ensembleNobs}
\alias{ensembleValidDates}
\alias{ensembleVerifObs}
\alias{ensembleObsLabels.ensembleData}
\alias{ensembleSize.ensembleData}
\alias{ensembleNobs.ensembleData}
\alias{ensembleValidDates.ensembleData}
\alias{ensembleVerifObs.ensembleData}
\alias{matchEnsembleMembers}
\alias{matchEnsembleMembers.ensembleMOSnormal}
\alias{matchEnsembleMembers.fitMOSnormal}
\alias{ensembleMemberLabels}
\alias{ensembleMemberLabels.ensembleData}
\alias{matchITandFH.default}\alias{matchITandFH}
\alias{getExchangeable}
\alias{getHH}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  EMOS modeling
}
\description{
  Fits a EMOS model to ensemble forecasts.
   Allows specification of a model, training rule, and forecasting dates.
}
\usage{
ensembleMOS(ensembleData, trainingDays, consecutive = FALSE,
            dates = NULL, control = NULL, warmStart = FALSE,
            model = NULL, exchangeable = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ensembleData}{
     An \code{ensembleData} object including ensemble forecasts with the
     corresponding verifying observations and their dates.
     Missing values (indicated by \code{NA}) are allowed.
}
  \item{trainingDays}{
    An integer giving the number of time steps (e.g. days)
    in the training period. There is no default.
}
  \item{consecutive}{
    If \code{TRUE} then the sequence of dates in the training set are
    treated as consecutive, i.e. date gaps are ignored
}
  \item{dates}{
    The dates for which EMOS forecasting models are desired.
    By default, this will be all dates in \code{ensembleData}
    for which modeling is allowed given the training rule.
}
  \item{control}{
     A list of control values for the fitting functions.
     The default is \code{controlMOSnormal()} for Gaussian (normal) models.
     %%and \code{controlMOSnormal0()} for truncated normal models.

}
  \item{warmStart}{
    If \code{TRUE}, then starting values for parameters in optimization
    are set to the estimates of the preceding date's fit.
}
  \item{model}{
      A character string describing the EMOS model to be fit.
      Current choices are \code{"normal"}, typically used for temperature
      or pressure data. %% and \code{"normal0"},
      %%typically used for windspeed data.
      For specific details on model fitting see \link{ensembleMOSnormal}
      %%or \link{ensembleMOSnormal0}.
}
  \item{exchangeable}{
     A numeric or character vector or factor indicating groups of
     ensemble members that are exchangeable (indistinguishable).
     The model fit will have equal weights and parameters within each
     group.
     The default determines exchangeability from \code{ensembleData}.
}
}
\details{
   If dates are specified in \code{dates} that cannot be forecast
   with the training rule, the corresponding EMOS model parameter
   outputs will be missing (\code{NA}) but not \code{NULL}. \cr
   The training rule uses the number of days corresponding to its
   \code{length} regardless of whether or not the dates are consecutive.
   \cr

}
\value{
 A list with the following output components:
  \item{training}{
    A list containing information on the training length and lag and
    the number of instances used for training for each modeling date.
  }
  \item{a}{
    A vector of fitted EMOS intercept parameters for each date.
  }
  \item{B}{
    A matrix of fitted EMOS coefficients for each date.
  }
  \item{c,d}{
    Vectors of the fitted variance parameters for each date, see
    \link{ensembleMOSnormal} %%or \link{ensembleMOSnormal0}
    for details.
  }
}
\references{
T. Gneiting, A. E. Raftery, A. H. Westveld and T. Goldman,
Calibrated probabilistic forecasting using ensemble model output
statistics and minimum CRPS estimation.
\emph{Monthly Weather Review} 133:1098--1118, 2005.
}

%%\author{
%%  ~~who you are~~
%%}
%%\note{
%%  ~~further notes~~
%%}



\seealso{
  \code{\link{trainingData}},
  \code{\link{ensembleMOSnormal}},
  %%\code{\link{ensembleMOSnormal0}},
  %%\code{\link{cdf}},
  %%\code{\link{quantileForecast}},
  %%\code{\link{modelParameters}},
  %%\code{\link{brierScore}},
  %%\code{\link{crps}},
  %%\code{\link{MAE}},
  \code{\link{controlMOSnormal}},
  %%\code{\link{controlMOSnormal0}}
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

  tempTestFit <- ensembleMOS( tempTestData, trainingDays = 30,
                               model = "normal")

 ## Same as
 ## tempTestFit <- ensembleMOSnormal( tempTestData, trainingDays = 30)

}


\keyword{models}

