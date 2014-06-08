# 
# GetData   - read uzipped data from ./data/household_power_consumption.txt, convert Date and Time fields into singl field "DT", and 
#             call the target function MakePlot4
# 
# MakePlot4 - make four plots from received data
# 
# 
GetData<-function(){
  library(data.table)
  library(sqldf)
  
  dd<-read.csv.sql("./data/household_power_consumption.txt", sql= "select * from file where Date in ('1/2/2007','2/2/2007')", header=TRUE, sep=";")
  dd<-data.table(dd)
  dd[,DT:=paste(as.Date(Date,"%d/%m/%Y"),Time)]
  
  par(mfrow=c(2,2))
  png(file="plot4.png")
  MakePlot4(dd)  
  dev.off()
  
}

# MakePlot2   - - make single line type plot from data
#   parameter - data data.table
#
MakePlot2<-function(data){
  dt<-strptime(data$DT,"%Y-%m-%d %H:%M:%S")
  
  plot(dt,data$Global_active_power, type="l", ylab="Global active power (kilowatts)", xlab="")
  
}

# MakePlot3   - make 3 drowings of distinct colors in one plot with legend
#   parameter - data data.table
#
MakePlot3<-function(data){
  dt<-strptime(data$DT,"%Y-%m-%d %H:%M:%S")
  
  plot(dt,data$Sub_metering_1, type="l", col="black", ylab="Energy Sub metering", xlab="")
  points(dt,data$Sub_metering_2, type="l", col="red")
  points(dt,data$Sub_metering_3, type="l", col="blue")
  leg <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
  cl <- c("black", "red", "blue")
  legend("topright", legend=leg, col=cl, lty=c(1,1,1), merge=TRUE)
}

# MakePlot4   - make datetime type vector from received string type field data$DT
#               make 4 distinct plots on one sheet.
#               
#   parameter - data
#
#   uses:
#         MakePlot2, MakePlot3
#
MakePlot4<-function(data){
  dt<-strptime(data$DT,"%Y-%m-%d %H:%M:%S")

  par(mfrow=c(2,2))
  MakePlot2(data)
  plot(dt,data$Voltage, type="l", ylab="Voltage", xlab="datetime")
  MakePlot3(data)
  plot(dt,data$Global_reactive_power, type="l", ylab="Global reactive power", xlab="datetime")
}

################################################################################################

GetData()

################################################################################################


