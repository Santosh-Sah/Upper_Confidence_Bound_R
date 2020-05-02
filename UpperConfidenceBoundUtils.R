importUpperConfidenceBoundDataset <- function(upperConfidenceBoundDatasetFileName) {
  
  #getting UpperConfidenceBound dataset
  upperConfidenceBoundDataset = read.csv(upperConfidenceBoundDatasetFileName)
  
  return (upperConfidenceBoundDataset)
  
}

#Save UpperConfidenceBound advertisement selection
saveUpperConfidenceBoundAdvertisementSeleted <- function(upperConfidenceBoundAdvertisementSeleted) {
  
  saveRDS(upperConfidenceBoundAdvertisementSeleted, file = "UpperConfidenceBoundAdvertisementSeleted.RDS")
}