# 
# GetData   - read uzipped data from ./data/household_power_consumption.txt, convert Date and Time fields into singl field "DT", and 
#             call the target function MakePlot4
# 
# MakePlot3 - make 3 drowings of distinct colors in one plot with legend
# 
# 
GetData<-function(){
  library(data.table)
  library(sqldf)
  
  dd<-read.csv.sql("./data/household_power_consumption.txt", sql= "select * from file where Date in ('1/2/2007','2/2/2007')", header=TRUE, sep=";")
  dd<-data.table(dd)
  dd[,DT:=paste(as.Date(Date,"%d/%m/%Y"),Time)]

  par(mfrow=c(1,1))
  png(file="plot3.png")
  MakePlot3(dd)  
  dev.off()
  
}
# MakePlot3   - make datetime type vector from received string type field data$DT
#               make 3 drowings of distinct colors in one plot with legend
#               
#   parameter - data
#
MakePlot3<-function(data){
  dt<-strptime(data$DT,"%Y-%m-%d %H:%M:%S")
  
  plot(dt,data$Sub_metering_1, type="l", col="black", ylab="Energy Sub metering", xlab="")
  points(dt,data$Sub_metering_2, type="l", col="red")
  points(dt,data$Sub_metering_3, type="l", col="blue")
  leg <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
  clrs <- c("black", "red", "blue")
  legend("topright", legend=leg, col=clrs, lty=c(1,1,1), merge=TRUE)
}

################################################################################################

GetData()

################################################################################################

