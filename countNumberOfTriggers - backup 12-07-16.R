#Data Frame containing all data
allData = read.csv("C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/5capteurs.csv")

#Vector containing all EXP names
expList = read.table("C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/EXPlist.csv", sep = ",", 
                   comment.char = "")

#Declare endData, a data frame containing final exit data (nb trigger of all sensors for all EXPs)
#########################################
##rownames(endData) = expList
##colnames(endData) = colnames(allData)
endData <- data.frame(matrix(ncol = length(allData[1,]), nrow = length(expList)))
colnames(endData) = colnames(allData)

#Loop over all EXPs
for (exp in expList){
  #Extract data for the current EXP
  expData = allData[grep(exp, allData$No_Test),]
  
  #//temp//
  print(exp)
  
  #Initialize counterMap
  ######################
  counterMap <- new.env(hash=T, parent=emptyenv())
  ##
  ##counterList <- vector(mode = "expression", length = length(endData))
  
  
  #Loop over all sensors
  sensorList = colnames(expData[,2:length(expData[1,])])
  
  for (sensor in sensorList){

    #Initialize previous to the value of the sensor at the start of the EXP
    previous = expData[[sensor]][1]
    
    counter = 0
    key <- toString(sensor)
    
    for (value in expData[[sensor]]){
      if (value != previous) {counter = counter + 1}
      previous = value
    }
    
    #Copy into counterMap
    #####################
    counterMap[[key]] = counter
    #print(counterMap[[key]])
    
  }
  
  #Copy counterMap into Matrix for all EXPs
  #
  temp <- c(toString(exp))
  for (v in ls(counterMap)) {
      temp <- c(temp, counterMap[[v]])
      print(counterMap[[v]])
  }
  
  ###CALICE DE MARDE C'EST DONT BIN COMPLIQUÉ CALICE D'OSTI D'MARDE
  
}