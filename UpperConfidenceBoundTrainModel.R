source("UpperConfidenceBoundUtils.R")

#reading dataset 
upperConfidenceBoundDataset = importUpperConfidenceBoundDataset("Ads_CTR_Optimisation.csv")

set.seed(1234)

# Fitting UpperConfidenceBound to dataset
trainUpperConfidenceBound <- function(upperConfidenceBoundDataset){
  
  #number of times the different advertisement shown to the users on the social media.
  N = 10000
  
  #number of version of the advertisement
  d = 10
  
  #different versions of advertisements selected
  advertisementsSelected = integer(0)
  
  #there are three steps present in the training of trainUpperConfidenceBound.
  #We are creating a model which used to select the best advertisement of a company.
  #step 1
  #at each round of n we consider two number for each ad i.
  #first is the number of times the ad i was selected up to round n
  #second is sum of rewards of the ad i up to round n
  numberOfSelections = integer(d)
  sumOfRewards = integer(d)
  totalRewards = 0
  
  #step 2
  #from these two numbers we compute two things.
  #the average of rewards of ad i up to round n
  #confidence interval at round n
  for (n in 1:N) {
    
    advertisementWithMaxUpperBound = 0
    
    maximumUpperBound = 0
    
    for (i in 1:d) {
      
      #choose the advertisement at first 10 round. initially we do not have any information about all these things.
      #we need to select advertisement in first 10 round without any strategy. We have define the startegy here 
      #but we will implement these strategy after 10 rounds when we have some information available.
      #for first 10 round what we will do at round 1 select advertisment 1 and up to round 10 select ad 10.
      if (numberOfSelections[i] > 0){
        
        averageReward = sumOfRewards[i] / numberOfSelections[i]
        
        delta_i = sqrt(3/2 * log(n) / numberOfSelections[i])
        
        upperBound = averageReward + delta_i
        
      }else{
          
          #whey we are assigned upper bound such a huge number. for the first round 0 we will go the 10 version of the ad.
          #for the first 10 round no ad will be selected. It will make sure that the first 10 round respective 10 ad will be selected.
          upperBound = 1e400
        }
        
        
        #step 3
        #select the ad i that has the maximum upper confidence bound
        if (upperBound > maximumUpperBound){
          
          maximumUpperBound = upperBound
          
          advertisementWithMaxUpperBound = i
          
        }
    }
    
    advertisementsSelected = append(advertisementsSelected, advertisementWithMaxUpperBound)
        
    #update numberOfSelections
    numberOfSelections[advertisementWithMaxUpperBound]  = numberOfSelections[advertisementWithMaxUpperBound] + 1
        
    #update sumOfRewards
    rewards = upperConfidenceBoundDataset[n, advertisementWithMaxUpperBound]
    sumOfRewards[advertisementWithMaxUpperBound] =sumOfRewards[advertisementWithMaxUpperBound] + rewards
        
    totalRewards = totalRewards + rewards
      
  }
  
  returnList <- list(advertisementsSelected, totalRewards)
  
  return(returnList)
}

advertisementsSelected = trainUpperConfidenceBound(upperConfidenceBoundDataset)[[1]]
totalRewards = trainUpperConfidenceBound(upperConfidenceBoundDataset)[[2]] #total rewards is 2178

#saving advertisement selected 
saveUpperConfidenceBoundAdvertisementSeleted(advertisementsSelected)

# sink("advertisementsSelected.csv")
# print(advertisementsSelected)
# sink()