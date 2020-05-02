##Loading libraries
library(data.table)
library(dplyr)
library("ggplot2")

if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds"))
    unzip("exdata_data_NEI_data.zip")

##Reading data
NEI <- readRDS("summarySCC_PM25.rds")

##Removing NA values and subsetting Baltimore City
data <- na.omit(NEI)
data <- subset(NEI, NEI$fips == "24510")

##Subsetting motor vehicles and calculating emissions for each year
sub <- subset(data, data$type == "ON-ROAD")
sub <- aggregate(x = sub$Emissions, by = list(sub$year), sum)
names(sub) <- c("year","Motor")

##Plotting using png device
png("plot5.png")

print({ggplot(data = sub, aes(year,Motor, colour = year)) + geom_line(alpha = 1/2, lwd = 1) + 
    labs(title = "Emissions due to Motor vehicles over the Years", y = "Motor Vehicle Emissions", x = "Years")})

dev.off()