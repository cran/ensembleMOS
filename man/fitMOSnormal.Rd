\name{fitMOSnormal}
\alias{fitMOSnormal}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Gaussian (normal) EMOS model fit to a training set
}
\description{
  %%  ~~ A concise (1-5 lines) description of what the function does. ~~
  Fits a Gaussian (normal) EMOS model to a given training set.
}
\usage{
fitMOSnormal(ensembleData, control = controlMOSnormal(),
             exchangeable = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ensembleData}{
    %%     ~~Describe \code{ensembleData} here~~
     An \code{ensembleData} object including ensemble forecasts and
     verification observations.
     Missing values (indicated by \code{NA}) are allowed. Dates are ignored
     if they are included.  This is the training set for the model.
}
  \item{control}{
    %%     ~~Describe \code{control} here~~
    A list of control values for the fitting functions. The defaults are
    given by the function \code{controlMOSnormal}.
}
  \item{exchangeable}{
    %%     ~~Describe \code{exchangeable} here~~
    An optional numeric or character vector or factor indicating groups of
    ensemble members that are exchangeable (indistinguishable).
    The models have equal EMOS coefficients within each group.
    If supplied, this argument will override any specification of
    exchangeability in \code{ensembleData}.
}
}
\details{
  %%  ~~ If necessary, more details than the description above ~~
  Given an ensemble forecast of size \eqn{m}: \eqn{X_1, \ldots , X_m},  the
  following Gaussian predictive distribution is fit by
  \code{fitMOSnormal}

  \deqn{ Y \sim \mathcal{N}
    \left( a + b_1X_1 + \cdots + b_mX_m , c + dS^2 \right)}

  \code{B} is a vector of fitted regression coefficients: \eqn{b_1,
    \ldots ,b_m}.  Specifically, \eqn{a,b_1,\ldots , b_m, c,d} are
    fitted to optimize
    \code{control$scoringRule} over the specified training set using
    \code{optim} with \code{method = "BFGS"}.
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
    The fitted variance parameters, see details.
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

  \code{\link{controlMOSnormal}},
  \code{\link{ensembleMOSnormal}},
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
                             date = "2008010100")

  tempTrainFit <- fitMOSnormal( tempTrain)

## equivalent to
##    tempTrainFit <- fitMOS( tempTrain, model = "normal")

}
\keyword{models}

