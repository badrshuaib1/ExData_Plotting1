url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

zippedfile <- download.file (url1, destfile ="~/datasciencecoursera/zippedfile" , method = "curl")

data_file<- unzip("~/datasciencecoursera/zippedfile.zip", list =TRUE)
pathtofile <- file.path("~/datasciencecoursera", data_file[1])

dftemp <- read.table(pathtofile, sep = ";", skip= grep("1/2/2007", 
                                                       readLines(pathtofile))-1, nrows = (2881), na.strings="?")

colnames(df1)<- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")


dftemp$DateTime<- strptime(paste(dftemp$Date, dftemp$Time), format="%d/%m/%Y %H:%M:%S")

png(filename = "plot3.png", width = 480, height = 480)

with(dftemp,{ 
        plot(DateTime, Sub_metering_1,  type = "l",lty= 1) 
        lines(DateTime, Sub_metering_2,lty= 1, col= "red") 
        lines(DateTime, Sub_metering_3,lty= 1, col= "blue") 
        legend("topright",  lty=1, lwd=2.5, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()
