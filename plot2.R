##Loading libraries
library(data.table)
library(dplyr)

if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds"))
    unzip("exdata_data_NEI_data.zip")

##Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subsetting required fields
data <- subset(NEI, NEI$fips == "24510")

##Arranging Emissions sum paired with the corresponding years
sub <- aggregate(x = data$Emissions, by = list(data$year), FUN = sum)

##Plotting using png graphic device
png("plot2.png")
plot(sub, type = "l", xlab = "Years", ylab = "Emissions", main = "Emissions over the years in Baltimore City")
dev.off()