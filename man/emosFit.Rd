\name{emosFit}
\alias{emosFit}
\docType{data}
\title{
  EMOS model fit.
}
\description{
  A Gaussian (normal) EMOS model fitted to sampe data.
}
\usage{data(emosFit)}
\format{
  An \code{\link{ensembleMOSnormal}} object fitted to the data set
  \code{\link[ensembleBMA:srft]{srft}} for forcast date \code{2004012900}.
}

\examples{
\dontrun{# R check
  data(srft)

  labels <- c("CMCG","ETA","GASP","GFS","JMA","NGPS","TCWB","UKMO")

  srftData <- ensembleData(forecasts = srft[,labels],
                         dates = srft$date, observations = srft$obs,
                         latitude = srft$lat, longitude = srft$lon,
                         forecastHour = 48, initializationTime = "00")
  emosFit <- ensembleMOS(srftData, date = "2004012900", trainingDays = 25,
                         model = "normal")

  data(emosFit)

  emosForc <- quantileForecast(emosFit, srftData, date = "2004012900",
                               quantiles = c(.1, .5, .9))

  data(srftGrid)

  memberLabels <- c("CMCG","ETA","GASP","GFS","JMA","NGPS","TCWB","UKMO")
  srftGridData <- ensembleData(forecasts = srftGrid[,memberLabels],
                             latitude = srftGrid[,"latitude"],
                             longitude = srftGrid[,"longitude"],
                             forecastHour = 48, initializationTime = "00")

  gridForc <- quantileForecast(emosFit, srftGridData, date = "2004012900",
                             quantiles = c( .1, .5, .9))

  library(fields)

  plotProbcast(gridForc[,"0.5"],lon=srftGridData$lon,
             lat=srftGridData$lat, type="image",
             col=rev(rainbow(100,start=0,end=0.85)))
  title("Median Grid Forecast for Surface Temperature", cex = 0.5)

  probFreeze <- cdf(emosFit, srftGridData,  date = "2004012900",
                  value = 273.15)

  plotProbcast(probFreeze, lon=srftGridData$lon, lat=srftGridData$lat,
             type="image",col=gray((32:0)/32))
  title("Probability of Freezing", cex = 0.5)

}
}
\keyword{datasets}
