\name{fitMOS}
\alias{fitMOS}

\title{
    EMOS model fit to a training set
}
\description{
   Fits Ensemble Model Output Statistics to a given training set.
}
\usage{
fitMOS(ensembleData, control = NULL, model = NULL,
       exchangeable = NULL)
}

\arguments{
  \item{ensembleData}{
     An \code{ensembleData} object including ensemble forecasts and
     verification observations.
     Missing values (indicated by \code{NA}) are allowed. Dates are ignored
     if they are included.  This is the training set for the model.
}
  \item{control}{
     A list of control values for the fitting functions.
     The default is \cr \code{controlMOSnormal()} for Gaussian (normal)
     models. 
     %%and \code{controlMOSnormal0()} for truncated normal models.
}
  \item{model}{
      A character string describing the EMOS model to be fit.
      Current choices are \code{"normal"}, typically used for temperature
      or pressure data. %% and \code{"normal0"},
      %%typically used for windspeed data.
      For specific details on model fitting see \link{fitMOSnormal}
      %%or \link{ensembleMOSnormal0}.
}
  \item{exchangeable}{
     A numeric or character vector or factor indicating groups of
     ensemble members that are exchangeable (indistinguishable).
     The model fit will have equal weights and parameters
     within each group.
     The default determines exchangeability from \code{ensembleData}.
}
}

\value{
A list with the following output components:
  \item{a}{
    The fitted intercept.
  }
  \item{B}{
    The fitted EMOS coefficients.
  }
  \item{c,d}{
    The fitted variance parameters for each date, see details.
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

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \link{fitMOSnormal}
  \link{controlMOSnormal}
}
\examples{
  data(ensMOStest)

  ensNames <- c("gfs","cmcg","eta","gasp","jma","ngps","tcwb","ukmo")

  tempTestData <- ensembleData( forecasts = ensMOStest[,ensNames],
                                observations = ensMOStest[,"obs"],
                                station = ensMOStest[,"station"],
                                dates = ensMOStest[,"vdate"],
                                forecastHour = 48,
                                initializationTime = "00")

  tempTrain <- trainingData( tempTestData, trainingDays = 30,
                             date  = "2008010100")

  tempTrainFit <- fitMOS( tempTrain, model = "normal")

## equivalent to
##    tempTrainFit <- fitMOSnormal( tempTrain)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{models}

