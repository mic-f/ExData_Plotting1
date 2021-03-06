### I used the wc -l command on the console
N <- 2075260

setwd("D:/COURSEA/ExploratoryDataAnalysis")
library(data.table)

### Because of size of our data, I read just the first column to determine, which rows have proper
### date 1-Feb-2007 or 2-Feb-2007
Dates <- fread("household_power_consumption.txt",header=TRUE,sep=";",select=1)
which_rows <- which(Dates == "1/2/2007" | Dates == "2/2/2007")
begin <- range(which_rows)[1]
end <- range(which_rows)[2]

### This part of data is small enough to use data.frame instead of data.table
DF <- read.table("household_power_consumption.txt",sep=";",nrows=end-begin+1,skip = begin, header=FALSE,stringsAsFactors=FALSE)
### Changing columns' names
names(DF) <-names(fread("household_power_consumption.txt",sep=";",nrows=0,header=TRUE))
### Converting character to Date
DF[,10]<-paste(as.Date(DF[,1],"%d/%m/%Y"),DF[,2],sep=" ")
DF[,10] <- as.POSIXct(DF[,10])  ###, "%Y-%m-%d %H:%M:%S"

Sys.setlocale("LC_ALL","C")

png(filename = "plot3.png", width=480, height=480)

with(DF,plot(V10,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(DF,points(V10,Sub_metering_1,type="l"))
with(DF,points(V10,Sub_metering_2,type="l",col="red"))
with(DF,points(V10,Sub_metering_3,type="l",col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=rep(1,3), cex=0.75, xjust=1,yjust=1)

dev.off()
