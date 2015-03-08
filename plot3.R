
#Read Data
#source("read_data.R") 
read_data <- function() {
  
  data<-read.csv('household_power_consumption.txt',header=TRUE,sep=";",
                 na.strings="?")
  data$DateTime<-as.POSIXct(paste(data$Date,data$Time),
                            format="%d/%m/%Y %H:%M:%S")
  
  data<-na.omit(data[data$DateTime>=as.POSIXct("2007-02-01",format="%Y-%m-%d")
                     & data$DateTime<as.POSIXct("2007-02-03",format="%Y-%m-%d"), ])
  
  return(data)
  
}

data<-read_data()

#Set parameters
Sys.setlocale("LC_TIME", "English")
old_par<-par(bg="transparent",cex=0.8)

# Make graph
plot(data$DateTime, data$Sub_metering_1,type ="l", col="black",
     ylab="Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_2,type ="l",col="red")
lines(data$DateTime, data$Sub_metering_3,type ="l",col="blue")
legend("topright",col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1)

#Save image
dev.copy(png, file="plot3.png",width=480,height=480,bg="transparent")
dev.off()

# Back to original parameters
par(old_par)