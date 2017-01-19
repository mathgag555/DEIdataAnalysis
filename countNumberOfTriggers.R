#Data Frame containing all data
inputFile = "C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/outputDebitmetre.csv"
outputFile = "C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/output_nbTriggers.csv"

allData = read.csv(inputFile)

#Vector containing all EXP names
expList <- c('EXP18', 'EXP21', 'EXP22', 'EXP23', 'EXP24', 'EXP25', 'EXP26', 'EXP27', 'EXP28', 'EXP29', 'EXPDTA16', 'EXPDTA17',
             'EXPDTA18', 'EXPDTA19', 'EXPDTA20', 'EXPMCI16', 'EXPMCI17', 'EXPMCI18', 'EXPMCI19', 'EXPMCI20', 'EXPMCI21',
             'EXPMCI23', 'EXPMCI24', 'EXPMCI25', 'EXPMCI26')

#Declare endData, a data frame containing final exit data (nb trigger of all sensors for all EXPs)
endData <- data.frame(matrix(ncol = length(allData[1,]), nrow = length(expList)))
colnames(endData) = colnames(allData)

#Loop over all EXPs
for (i in 1:length(expList)){  
  #Extract data for the current EXP
  expData = allData[grep(expList[i], allData$No_Test),]
  
  #List that keeps track of the values for the current EXP
  counterList <- vector(mode = "character", length = length(endData))
  counterList[1] <- expList[i]
  
  sensorList = colnames(expData[,2:length(expData[1,])])
  
  #Loop over all sensors
  for (sensor in sensorList){

    #Initialize previous to the value of the sensor at the start of the EXP
    previous = expData[[sensor]][1]
    
    counter = 0
    
    for (value in expData[[sensor]]){
      if (value != previous) {counter = counter + 1}
      previous = value
    }
    
    counterList[grep(sensor, sensorList) + 1] <- counter
  }
  
  #print(counterList)
  
  #Copy counterList into endData for all EXPs
  endData[i,] <- counterList
  
  #Output in csv format
  write.csv(endData, file = outputFile, row.names = FALSE )

}