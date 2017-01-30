#Data Frame containing all data
inputFile = "C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/outputDebitmetre.csv"
outputFile = "C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/output_convertedToEventBased.csv"

allData = read.csv(inputFile)

#Vector containing all EXP names
expList <- c('EXP18', 'EXP21', 'EXP22', 'EXP23', 'EXP24', 'EXP25', 'EXP26', 'EXP27', 'EXP28', 'EXP29', 'EXPDTA16', 'EXPDTA17',
             'EXPDTA18', 'EXPDTA19', 'EXPDTA20', 'EXPMCI16', 'EXPMCI17', 'EXPMCI18', 'EXPMCI19', 'EXPMCI20', 'EXPMCI21',
             'EXPMCI23', 'EXPMCI24', 'EXPMCI25', 'EXPMCI26')

#Declare endData, a data frame containing final exit data (nb trigger of all sensors for all EXPs)
endData <- data.frame(matrix(ncol = 4, nrow = length(expList)))
colnames(endData) <- c('No_Test', 'sensor', 'statut', 'heure')

previous = 0
current = 0

counter = 1

#Loop over all EXPs
for (indexExp in 1:length(expList)){
  #Extract data for the current EXP
  expData = allData[grep(expList[indexExp], allData$No_Test),]
  
  #for each sensors (excluding first column (No_Test))
  for (indexSensor in 2:length(expData[1,])){

    #for each entry, starting at second line (previous will have the 1rst line value)
    for (indexLine in 2:length(expData[,1])){
      previous <- expData[indexLine - 1, indexSensor]
      current <- expData[indexLine, indexSensor]

      #instead, write info in new data
      if (current != previous){
        #print(c("AAAAAAAAAAAAAAAAAAA ", indexSensor, indexLine))

        tuple <- c(expList[indexExp],
                   colnames(expData)[indexSensor],
                   current,
                   indexLine
                   )

        endData[counter,] <- tuple
        counter = counter + 1

      }
    }
  }
  
}