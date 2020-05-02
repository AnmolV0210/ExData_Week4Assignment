##Loading libraries
library(data.table)
library(dplyr)
library("ggplot2")

if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds"))
    unzip("exdata_data_NEI_data.zip")

##Reading data
NEI <- readRDS("summarySCC_PM25.rds")

##Removing NA values and subsetting Baltimore and Los Angeles City
data <- na.omit(NEI)
data <- subset(NEI, NEI$fips == "24510" | NEI$fips == "06037")

##Subsetting motor vehicles and calculating emissions for each year
sub <- subset(data, data$type == "ON-ROAD")
sub <- aggregate(x = sub$Emissions, by = list(sub$year,sub$fips), sum)
names(sub) <- c("Year","City","Motor")

##Changin fips to City name
sub[1:4,2] <- "Los Angeles"
sub[5:8,2] <- "Baltimore"

##Plotting using png device
png("plot6.png")

print({ggplot(data = sub, aes(Year,Motor,colour = City)) + geom_line(lwd = 1,alpha = 1/2) + facet_grid(. ~ City) +
    labs(title = "Emission comparison of Baltimore and Los Angeles County", x = "Years", y = "Motor Emissions")})
dev.off()