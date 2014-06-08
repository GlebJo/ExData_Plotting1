# 
# GetData   - read uzipped data from ./data/household_power_consumption.txt, convert Date and Time fields into singl field "DT", and 
#             call the target function MakePlot4
# 
# MakePlot1 - make single histogram from received data
# 
# 
GetData<-function(){
  library(data.table)
  library(sqldf)
  
  dd<-read.csv.sql("./data/household_power_consumption.txt", sql= "select * from file where Date in ('1/2/2007','2/2/2007')", header=TRUE, sep=";")
  dd<-data.table(dd)
  dd[,DT:=paste(as.Date(Date,"%d/%m/%Y"),Time)]
  par(mfrow=c(1,1))
  png(file="plot1.png")
  MakePlot1(dd)
  dev.off()
}
# MakePlot1   - make datetime type vector from received string type field data$DT
#               make single histogram from received data
#               
#   parameter - data
#
MakePlot1<-function(data){
  hist(data$Global_active_power,xlab="Global active power (kilowatts)", main="Global active power",col="Red")
  
}

################################################################################################

GetData()

################################################################################################

