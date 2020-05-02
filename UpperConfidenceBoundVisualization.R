source("UpperConfidenceBoundUtils.R")
library(ggplot2)

#reading UpperConfidenceBound advertisement selected
upperConfidenceBoundAdvertisementSeleted <- readRDS("UpperConfidenceBoundAdvertisementSeleted.RDS")

#create histogram plot for the adertisment selected matrix which we get from upper confidence bound algorithms
histogramOfUpperConfidenceBoundAdvertisementSeleted <- function(upperConfidenceBoundAdvertisementSeleted){
  
  png("UpperConfidenceBoundAdvertisementSeleted.png")
  
  hist(upperConfidenceBoundAdvertisementSeleted,
       col = 'blue',
       main = 'Histogram of ads selections',
       xlab = 'Ads',
       ylab = 'Number of times each ad was selected')
  
  
  dev.off()
  
}

histogramOfUpperConfidenceBoundAdvertisementSeleted(upperConfidenceBoundAdvertisementSeleted)