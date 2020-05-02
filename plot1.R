##Loading libraries
library(data.table)
library(dplyr)

#if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds"))
#    unzip("exdata_data_NEI_data.zip")

##Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sub <- aggregate(x = NEI$Emissions, by = list(NEI$year), FUN = sum)

##Plotting to png Graphic Device
png(filename = "plot1.png")
plot(sub, type = "l", xlab = "Years", ylab = "Emissions", main  = "Emissions over the Years")
dev.off()
