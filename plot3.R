##Loading libraries
library(data.table)
library(dplyr)
library("ggplot2")

#if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds"))
#    unzip("exdata_data_NEI_data.zip")

##Reading data
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

##Subsetting required fields
data <- subset(NEI, NEI$fips == "24510")

##Converting "type' variable to factor
data <- data %>% mutate(type = as.factor(type))

##Calculating emissions for each year
sub <- aggregate(x = data$Emissions, by = list(data$year,data$type), FUN = sum)
names(sub) <- c("year","type","Emissions")

##Plotting usnig png device
png("plot3.png")
print({ggplot(data = sub, aes(x = year,y = Emissions,colour = type)) + geom_line(lwd = 1,alpha = 1/2) + 
         facet_grid(.~type) + 
         labs(title = "Emissions over the Years factored based on various Types", x = "Years", y = "Emissions")})
dev.off()
