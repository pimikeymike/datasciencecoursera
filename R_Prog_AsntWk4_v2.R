##R_Programming assignment 3 week 4 ##
library(plyr)
library(dplyr)
fileURL <- "~/data_toolbox/R_Program/rprogProgAssignment3-data/outcome-of-care-measures.csv"
fileURL2 <- "~/data_toolbox/R_Program/rprogProgAssignment3-data/hospital-data.csv"
fileURL <- "/Users/michaelgarcia/CloudStation/data_toolbox/R_Program/rprogProgAssignment3-data/outcome-of-care-measures.csv"
####PC
fileURL <- "T:/DataScienceDirectory/data_toolbox/R_Program/rprogProgAssignment3-data/outcome-of-care-measures.csv"
fileURL2 <- "T:/DataScienceDirectory/data_toolbox/R_Program/rprogProgAssignment3-data/hospital-data.csv"
outcome <- read.csv(fileURL)
hd <- read.csv(fileURL2)


#### best function ####
best <- function(state, outcome) {
  ## Read outcome data
  a <- read.csv(fileURL)
  aa <- a[c(2,7,11,17,23)]
  ab <- plyr::rename(aa,c("Hospital.Name"="hospital name"
                          ,"State" = "state"
                          , "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" = "heart attack"
                          ,"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure" = "heart failure"
                          , "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" = "pneumonia"
  )
  )
  x=state
  y=outcome
  
  ## Check that state and outcome are valid
  
  if (missing(y))
    stop("missing state")
  if (missing(x))
    stop("missing outcome")
  if ((x %in% ab$state) == FALSE)
    stop("invalid state")
  if((y %in% c("heart attack", "heart failure" , "pneumonia")) == FALSE)
    stop("invalid outcome")
  
  c <- if(y == "heart attack")
              {subset(ab, ab$state == x, select = c("hospital name", "heart attack"))}
       if(y == "heart failure")
              {subset(ab, ab$state == x, select = c("hospital name", "heart failure"))}
       if(y == "pneumonia")
              {subset(ab, ab$state == x, select = c("hospital name", "pneumonia"))}
  
  
  
  
  myOutput <- subset(c, c[2]!= "Not Available")
  
  
  
  ## Return hospital name in that state with lowest 30-day death rate'
  hospital <- as.character(dplyr::first(myOutput$`hospital name`,order_by = as.numeric(as.character(myOutput[2]))))
  return(hospital)
  
}

#### question 1 ####
best("SC", "heart attack")

#### ques 2 ####

best("NY", "pneumonia")

