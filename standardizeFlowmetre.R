#Data Frame containing all data
inputFile = "C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/05. APRÈS filtres/AllEXPs-27janv2017-apresFiltres.csv"
outputFile = "C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/06. DEBITMETRES BINARISES/outputDebitmetre30janv2017.csv"

allData = read.csv(inputFile)
expList <- c('EXP18', 'EXP21', 'EXP22', 'EXP23', 'EXP24', 'EXP25', 'EXP26', 'EXP27', 'EXP28', 'EXP29', 'EXPDTA16', 'EXPDTA17',
             'EXPDTA18', 'EXPDTA19', 'EXPDTA20', 'EXPMCI16', 'EXPMCI17', 'EXPMCI18', 'EXPMCI19', 'EXPMCI20', 'EXPMCI21', 
             'EXPMCI23', 'EXPMCI24', 'EXPMCI25', 'EXPMCI26')


###Ajouter une premiere ligne qui contient les titres des colonnes
write(colnames(expData), 
      file = outputFile,
      ncolumns = length(colnames(expData)),
      sep = ",")

#Loop over all EXPs
for (i in 1:length(expList)){  
  #Extract data for the current EXP
  expData = allData[grep(expList[i], allData$No_Test),]
  dbSensorList = grep("DB", colnames(expData[,2:length(expData[1,])]), value = TRUE)
  mvSensorList = grep("MV", colnames(expData[,2:length(expData[1,])]), value = TRUE)
  ccSensorList = grep("C", colnames(expData[,2:length(expData[1,])]), value = TRUE)
  
#code original fonctionnel pour dbSensor
  # for (dbSensor in dbSensorList){
  #   for (j in 1:length(expData[[dbSensor]])){
  #     if (expData[[dbSensor]][j] >= 10) {expData[[dbSensor]][j] <- 1}
  #   }
  # }
  
  #for all lines of data in the EXP
  for (j in 1:length(expData[,1])){
    for (dbSensor in dbSensorList){
      if (expData[[dbSensor]][j] >= 10) {expData[[dbSensor]][j] <- 1}
    }
    
    #invert values of movement sensors
    for (mvSensor in mvSensorList){
      if (expData[[mvSensor]][j] == 1) {
        expData[[mvSensor]][j] <- 0
      } else{
        expData[[mvSensor]][j] <- 1
      }
    }
    
    #invert values of contact sensors
    for (ccSensor in ccSensorList){
      if (expData[[ccSensor]][j] == 1) {
        expData[[ccSensor]][j] <- 0
      } else{
        expData[[ccSensor]][j] <- 1
      }
    }
    
  }

  #écrire dans fichier
  write.table(expData, file = outputFile, 
              row.names = FALSE, col.names = FALSE, append = TRUE, qmethod = "double", dec = ".", sep = "," )
}