plot1<-function(){
        #reads in data
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        #calculates total emission for every year, saves it into "p" 
        p<-tapply(NEI$Emissions, NEI$year, sum)
        
        #opens the png file "plot1", plots variable p, closes the file
        png("plot1.png")
        barplot(p/1000000, ylim=c(0,8), xlab="Year", ylab="PM2.5 emissions (M tons)", main="Total emissions from PM2.5 in the United States")
        dev.off()
}