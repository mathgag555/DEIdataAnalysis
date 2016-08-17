#Data Frame containing all data
allData = read.csv("C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/7. Sans ID ni T_base.csv")
expList <- c('EXP18', 'EXP21', 'EXP22', 'EXP23', 'EXP24', 'EXP25', 'EXP26', 'EXP27', 'EXP28', 'EXP29', 'EXPDTA16', 'EXPDTA17', 'EXPDTA18', 'EXPDTA19', 'EXPDTA20', 'EXPMCI16', 'EXPMCI17', 'EXPMCI18', 'EXPMCI19', 'EXPMCI20', 'EXPMCI21', 'EXPMCI23', 'EXPMCI24', 'EXPMCI25', 'EXPMCI26')
expData = allData[grep(expList[5], allData$No_Test),]

dbSensorList = grep("DB", colnames(expData[,2:length(expData[1,])]), value = TRUE)

for (dbSensor in dbSensorList){
  print(dbSensor)
  for (i in 1:length(expData[[dbSensor]])){
    if (expData[[dbSensor]][i] >= 10) {expData[[dbSensor]][i] <- 1}
  }
}

#pour test
expData$DB4

#réécrire dans le fichier
