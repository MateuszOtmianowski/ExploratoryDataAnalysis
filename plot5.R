plot5<-function(){
        #loads ggplot2 library
        library(ggplot2)
        
        #reads in data
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        #subsets the NEI data for the Baltiomore City
        BaltNEI<-NEI[NEI$fips==24510,]
        
        #subsets the SCC data for "vehicle" related sources 
        #this subset is inclusive and incorporates not only road vehicles, but unique types two (ex. ones used in construction sector)
        N<-grep("Vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
        SCCN<-SCC[N,]
        
        #merges two above mentioned data sets to get PM2.5 emission in the Baltimore City from the vehicle related sources
        merged <- merge(x = BaltNEI, y = SCCN, by = 'SCC')
        
        #calculates total emission for every every year, saves it into "v" variable 
        v<-aggregate(merged$Emissions, by=list(merged$year), sum)
        
        #plots "v", saves it into "plot5", which is later saved into "plot5.png"
        plot5<-qplot(as.character(Group.1),x,data=v, fill=Group.1, geom="bar", stat="identity", ylab="PM2.5 emission (tons)", main="Total PM2.5 emissions from vehicle related sources in the Baltiomore City", xlab="Year")+theme(legend.position = "none")+geom_text(aes(label = round(x, 0), size = 1, hjust = 0.5, vjust = -1))
        ggsave(filename="plot5.png", plot5)
}