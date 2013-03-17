\name{controlMOSnormal}
\alias{controlMOSnormal}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Control parameters for Gaussian (normal) EMOS models
}
\description{
  %%  ~~ A concise (1-5 lines) description of what the function does. ~~
  Specifies a list of values controling the Gaussian (normal) EMOS fit
  of ensemble forecasts.
}
\usage{
controlMOSnormal(scoringRule = c("crps", "log"),
                 coefRule = c("square", "none", "positive"),
                 varRule = c("square", "none"),
                 start = list(a = NULL, B = NULL,
                              c = NULL, d = NULL),
                 maxIter = Inf)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{scoringRule}{
    %%     ~~Describe \code{scoringRule} here~~
    The scoring rule to be used in optimum score estimation.  Options
    are "crps" for the continuous ranked probability score and "log" for
    the logarithmic score.
}
  \item{coefRule}{
    %%     ~~Describe \code{coefRule} here~~
    Method to control non-negativity of regression
    estimates. Options are:
    \itemize{
      \item \code{``square''} -  The EMOS coefficients are
      parameterized as squares and thus gauranteed to be non-negative.
      \item \code{``positive''} finds non-negative coefficents
      iteratively by setting negative estimates at the current iteration
      to zero. 
      \item \code{``none''} no restriction on the coefficient
      estimates.
    }
}
  \item{varRule}{
    %%     ~~Describe \code{varRule} here~~
    Method to control non-negativity of the variance parameters.
    Options \code{``square''} and \code{``none''} are the same as in
    \code{coefRule}.
}
  \item{start}{
    %%     ~~Describe \code{start} here~~
    A list of starting parameters, \code{a}, \code{B}, \code{c} and
    \code{d} specifying initial values for the intercept coefficient
    and variance parameters supplied to \code{optim}.   See details.
}
  \item{maxIter}{
    %%     ~~Describe \code{maxIter} here~~
    An integer specifying the upper limit of the number of iterations
    used to fit the model.
}
}
\details{

  Given an ensemble of size \eqn{m}: \eqn{X_1, \ldots , X_m},  the
  following Gaussian model is fit by \cr \code{ensembleMOSnormal}

  \deqn{ Y_t \sim \mathcal{N}
    \left( a + b_1X_1 + \cdots + b_mX_m , c + dS^2 \right)}

  \code{B} is the array of fitted regression coefficients \eqn{b_1,
    \ldots ,b_m} for each date.  See \link{ensembleMOSnormal}.
}
\value{
  A list whose components are the input arguments and their assigned
  values.
}

\references{
T. Gneiting, A. E. Raftery, A. H. Westveld and T. Goldman,
calibrated probabilistic forecasting using ensemble model output
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
  \code{\link{ensembleMOSnormal}},
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

  tempTestFit1 <- ensembleMOSnormal(tempTestData, trainingDays = 30,
                           control = controlMOSnormal(maxIter = as.integer(100),
                           coefRule= "positive", varRule = "square"))
}
\keyword{models}
% docclass is function