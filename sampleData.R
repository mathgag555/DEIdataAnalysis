nbDivisions = 10

allData = read.csv("AllEXPs_RemovedUseless-TC-AN-MCR-LD.csv")

#1) ***** Découper une EXP en 'nbDivisions' segments égaux *****#
expNumber = 20 #faire 18 à la place
expData <- subset(allData, No_Test %in% grep(paste(".*EXP", toString(expNumber), ".*", sep = ""),
                                            allData[,2], perl=TRUE, value=TRUE))
#remove 3 first rows
#expData <- expData[,4:length(expData[1,])]

#initialize variables
divisionLenght <- length(expData[,1]) %/% nbDivisions
x <- 1
y <- divisionLenght
mylist <- list(expData[x:y,])

#generate samples and create CSV files for each sample
for (i in 1:nbDivisions ) {
  x <- x + divisionLenght
  y <- y + divisionLenght
  mylist <- c(mylist, list(expData[x:y,]))
  write.table(mylist[[i]], file = paste("dataSample", toString(i), "_sur_", toString(nbDivisions), ".csv", sep = ""), 
            quote = FALSE, sep = ",", row.names = FALSE, qmethod = "double")
}

#2) ***** Continuer pour toutes les EXP *****#

#loop for "sujets sains"
for (n in 21:29){
  createSamples(n, "")
}

#loop for MCI
for (n in 16:26){
  createSamples(n, "MCI")
}

#loop for DTA
for (n in 16:20){
  createSamples(n, "DTA")
}

# *** Function : createSamples ***
# *** Generate samples and create CSV files for each sample ***
createSamples <- function(n, expType){
  expNumber = n
  
  #skip EXPMCI23, because it doesn't exist
  if (n == 23 & expType == "MCI"){
      return ()
  }
  
  expData <- subset(allData, No_Test %in% grep(paste(".*EXP", expType, toString(expNumber), ".*", sep = ""),
                                               allData[,2], perl=TRUE, value=TRUE))
  #remove 3 first rows
  #expData <- expData[,4:length(expData[1,])]
  
  #initialize variables
  divisionLenght <- length(expData[,1]) %/% nbDivisions
  x <- 1
  y <- divisionLenght
  mylist <- list(expData[x:y,])
  
  for (i in 1:nbDivisions ) {
    x <- x + divisionLenght
    y <- y + divisionLenght
    mylist <- c(mylist, list(expData[x:y,]))
    
    #avec append = TRUE, col.names = FALSE
    write.table(mylist[[i]], file = paste("dataSample", toString(i), "_sur_", toString(nbDivisions), ".csv", sep = ""), 
                append = TRUE, quote = FALSE, sep = ",", row.names = FALSE, col.names = FALSE, qmethod = "double")
  }
  
  return (0)
}


#backup
#length(expData[,1]) %% nbDivisions        # = 4