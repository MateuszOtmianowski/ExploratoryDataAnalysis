plot6<-function(){
        #loads ggplot2 library
        library(ggplot2)
        
        #reads in data
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        #subsets data for the Baltiomore City and Los Angeles
        BaltLANEI<-subset(NEI, NEI$fips %in% c("24510","06037"))
        
        #subsets the SCC data for "vehicle" related sources 
        #this subset is inclusive and incorporates not only road vehicles, but unique types two (ex. ones used in construction sector)
        N<-grep("Vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
        SCCN<-SCC[N,]
        
        #        #merges two above mentioned data sets to get PM2.5 emission in the Baltimore City and Los Angeles from the vehicle related sources
        merged <- merge(x = BaltLANEI, y = SCCN, by = 'SCC')
        
        #calculates total emission for every every year, saes it into "z" variable
        z<-aggregate(merged$Emissions, by=list(merged$year, merged$fips), sum)
        
        #converts fips into location names
        z$Group.2[z$Group.2=="06037"]<-"Los Angeles County"
        z$Group.2[z$Group.2=="24510"]<-"Baltimore City"
        
        #plots "z", saves it into "plot6", which is later saved into "plot6.png"
        plot6<-qplot(as.character(Group.1),x,data=z, facets=.~Group.2, color=Group.2, geom="bar", stat="identity", fill=Group.2, ylab="PM2.5 emissions (tons)", xlab="Year", main="Total PM2.5 emissions from vehicle related sources in the Baltiomore City and Los Angeles County", guide_legend(title=NULL))+theme(legend.position = "none")+geom_text(aes(label = round(x, 0), size = 1, hjust = 0.5, vjust = -1))
        ggsave(filename="plot6.png", plot6)
}