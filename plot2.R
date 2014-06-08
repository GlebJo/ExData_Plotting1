# 
# GetData   - read uzipped data from ./data/household_power_consumption.txt, convert Date and Time fields into singl field "DT", and 
#             call the target function MakePlot4
# 
# MakePlot2 - make single line type plot from received data
# 
# 
GetData<-function(){
  library(data.table)
  library(sqldf)
  
  dd<-read.csv.sql("./data/household_power_consumption.txt", sql= "select * from file where Date in ('1/2/2007','2/2/2007')", header=TRUE, sep=";")
  dd<-data.table(dd)
  dd[,DT:=paste(as.Date(Date,"%d/%m/%Y"),Time)]

  par(mfrow=c(1,1))
  png(file="plot2.png")
  MakePlot2(dd)
  dev.off()
  
}
# MakePlot2   - make datetime type vector from received string type field data$DT
#               make single line type plot from received data
#               
#   parameter - data
#
MakePlot2<-function(data){
  dt<-strptime(data$DT,"%Y-%m-%d %H:%M:%S")
  
  plot(dt,data$Global_active_power, type="l", ylab="Global active power (kilowatts)", xlab="")
  
}

################################################################################################

GetData()

################################################################################################
