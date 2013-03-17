\name{ensembleMOSnormal}
\alias{ensembleMOSnormal}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Gaussian (normal) EMOS modeling
}
\description{
  %%  ~~ A concise (1-5 lines) description of what the function does. ~~
  Fits a Gaussian (normal) EMOS model to ensemble forecasts for
  specified dates.
}
\usage{
  ensembleMOSnormal(ensembleData, trainingDays, consecutive = FALSE,
                    dates = NULL, control = controlMOSnormal(),
                    warmStart = FALSE, exchangeable = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ensembleData}{
    An \code{ensembleData} object including ensemble forecasts with
    the corresponding verifying observations and their dates.
    Missing values (indicated by \code{NA}) are allowed.
  }
  \item{trainingDays}{
    An integer giving the number of time steps (e.g. days)
    in the training period. There is no default.
  }
  \item{consecutive}{
    If \code{TRUE} then the sequence of dates in the training set are
    treated as consecutive, i.e. date gaps are ignored.
  }
  \item{dates}{
    The dates for which EMOS forecasting models are desired.
    By default, this will be all dates in \code{ensembleData}
    for which modeling is allowed given the training rule.
}
  \item{control}{
    A list of control values for the fitting functions. The defaults are
    given by the function \link{controlMOSnormal}.
  }
  \item{warmStart}{
    If \code{TRUE}, then starting values for parameters in optimization
    are set to the estimates of the preceding date's fit.
  }
  \item{exchangeable}{
    A numeric or character vector or factor indicating groups of
    ensemble members that are exchangeable (indistinguishable).
    The modeling will have equal parameters within each group.
    The default determines exchangeability from \code{ensembleData}.
  }
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
    Vectors of the fitted variance parameters for each date, see details.
  }
}

\details{
  %%  ~~ If necessary, more details than the description above ~~
  Given an ensemble forecast of size \eqn{m}: \eqn{X_1, \ldots , X_m},  the
  following Gaussian predictive distribution is fit by
  \code{ensembleMOSnormal}

  \deqn{ Y \sim \mathcal{N}
    \left( a + b_1X_1 + \cdots + b_mX_m , c + dS^2 \right)}

  \code{B} is a vector of fitted regression coefficients: \eqn{b_1,
    \ldots ,b_m}.  Specifically, \eqn{a,b_1,\ldots , b_m, c,d} are
    fitted to optimize
    \code{control$scoringRule} over the specified training period using
    \code{optim} with \code{method = "BFGS"}.
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
  %% ~~objects to See Also as \code{\link{help}}, ~~~
  \code{\link{controlMOSnormal}},
  \code{\link{fitMOSnormal}}
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

\keyword{models}

