plot2<-function(){
        #reads in data
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        #subsets data for the Baltiomore City
        BaltNEI<-NEI[NEI$fips==24510,]
        
        #calculates total emission for every year for the Baltimore City
        b<-tapply(BaltNEI$Emissions, BaltNEI$year, sum)
        
        #opens the png file "plot2", plots the variable b, closes the file
        png("plot2.png")
        barplot(b, ylim=c(0,4000), xlab="Year", ylab="PM2.5 emissions (tons)", main="Total emissions from PM2.5 in the Baltimore Ciy")
        dev.off()
}