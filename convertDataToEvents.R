#Data Frame containing all data
inputFile = "C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/06. DEBITMETRES BINARISES/outputDebitmetre30janv2017.csv"
outputFile = "C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/output_convertedToEventBased30janv2017.csv"

allData <- read.csv(inputFile)

#Vector containing all EXP names
expList <- c('EXP18', 'EXP21', 'EXP22', 'EXP23', 'EXP24', 'EXP25', 'EXP26', 'EXP27', 'EXP28', 'EXP29', 'EXPDTA16', 'EXPDTA17',
             'EXPDTA18', 'EXPDTA19', 'EXPDTA20', 'EXPMCI16', 'EXPMCI17', 'EXPMCI18', 'EXPMCI19', 'EXPMCI20', 'EXPMCI21',
             'EXPMCI23', 'EXPMCI24', 'EXPMCI25', 'EXPMCI26')

#Declare endData, a data frame containing final output data
endData <- data.frame(matrix(ncol = 7, nrow = length(expList)))
colnames(endData) <- c('No_Test', 'sensor', 'status', 'elapsed', 'hours', 'minutes', 'seconds')

#sensor value 
previous = 0
current = 0

#variables for the time
hours = 0
minutes = 0
seconds = 0

counter = 1

#Loop over all EXPs
for (indexExp in 1:length(expList)){
  #Extract data for the current EXP
  expData <- allData[grep(expList[indexExp], allData$No_Test),]
  
  #for each sensors (excluding first column (No_Test))
  for (indexSensor in 2:length(expData[1,])){

    #for each entry, starting at second line (previous will have the 1rst line value)
    for (indexLine in 2:length(expData[,1])){
      previous <- expData[indexLine - 1, indexSensor]
      current <- expData[indexLine, indexSensor]

      #check if an event (change of value) has occured
      if (current != previous){

        #convert elapsed time into hours, minutes and seconds
        #reminder : indexLine represents the number of seconds elapsed
        hours = trunc(indexLine / 3600)
        minutes = trunc(indexLine / 60) - (hours*60)
        seconds = indexLine - (minutes*60) - (hours*3600)

        sensorName = colnames(expData)[indexSensor]
        
        tuple <- c(expList[indexExp],
                   sensorName,
                   current,
                   indexLine,
                   hours,
                   minutes,
                   seconds)

        endData[counter,] <- tuple
        counter = counter + 1

      }
    }
  }
  
}

#Output in csv format
write.csv(endData, file = outputFile, row.names = FALSE )