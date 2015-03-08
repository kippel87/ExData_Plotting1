
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
old_par<-par(bg="transparent",
             mfrow = c(2, 2),
             cex=0.8)

# Make graph
## Subplot 1
plot(data$DateTime, data$Global_active_power,type="l",
     xlab="",ylab="Global Active Power")

## Subplot 2
plot(data$DateTime, data$Voltage,type="l",
     xlab="datetime",ylab="Voltage")

## Subplot 3
plot(data$DateTime, data$Sub_metering_1,type ="l", col="black",
     ylab="Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_2,type ="l",col="red")
lines(data$DateTime, data$Sub_metering_3,type ="l",col="blue")
legend("topright",col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n",lty=1,cex=0.7)

## Subplot 4
plot(data$DateTime, data$Global_reactive_power,type="l",
     xlab="datetime",ylab="Global_reactive_power")

#Save image
dev.copy(png, file="plot4.png",width=480,height=480,bg="transparent")
dev.off()

# Back to original parameters
par(old_par)