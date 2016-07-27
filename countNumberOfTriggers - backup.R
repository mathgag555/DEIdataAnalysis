allData = read.csv("C:/Users/gagm2737/Documents/SpiderOak Hive/DONNEES_FILAIRES/WORKINPROGRESS/5capteurs.csv")

counter = 0
#expNumber = 24
expName = 'EXP21'

exp21data = allData[grep(expName, allData$No_Test),]
prec = exp21data$CA6[1]

for (num in exp21data$CA6){
  if (num != prec) {counter = counter + 1}
  prec = num
}

counter

#ça marche!!
