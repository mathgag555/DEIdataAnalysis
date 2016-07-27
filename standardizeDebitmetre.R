#Data Frame containing all data
allData = read.csv("C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/7. Sans ID ni T_base.csv")

expData = allData[grep(expList[i], allData$No_Test),]