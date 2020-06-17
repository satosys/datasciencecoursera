##How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


library("data.table")
library("ggplot2")

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

# Load the NEI & SCC data frames.
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

## Subset data by Maryland
Maryland <- NEI[NEI$fips == "24510", ]

## Get motor vehicle sources in SCC
onroad <- subset(SCC,Data.Category == "Onroad")
motorCodes <- onroad$SCC

## Subset Data with the code
MarylandData <- subset(Maryland, SCC %in% motorCodes)

## Extract data by calculating the sum of Emissions
MarylandMotor <- aggregate(Emissions~year, MarylandData, sum)

png("plot5.png")
## Plot
with(MarylandMotor, plot(year, Emissions,
                         , xlab = "Year", ylab = "Total Emissions", type="l"
                         , main="Total Emissions for motor vehicle 
                         sources changed in Baltimore City"))

#dev.copy(png, file = "plot 5.png") ## Copy my plot to a PNG file
dev.off() ## Close the PNG device!