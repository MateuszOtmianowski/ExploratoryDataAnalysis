plot4<-function(){
        #loads ggplot2 library
        library(ggplot2)
        
        #reads in data
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        #subsets the SCC data frame for Coal related sources, ignore.case is set to false to choose only stand alone words "coal" (ex. not "%coal%")
        #subsetting result stored as "SCCcoal"
        coal<-grep("Coal", SCC$Short.Name, ignore.case=FALSE, value=FALSE)
        SCCcoal<-SCC[coal,]
        
        #"SCCcoal" is further subsetted by filtering for combustion ("Comb"), to include in the end only coal combustion
        #resulting data set stored as "SCCcoalcomb"
        comb<-grep("Comb", SCCcoal$Short.Name, ignore.case=FALSE, value=FALSE)
        SCCcoalcomb<-SCCcoal[comb,]
        
        #SCCcoalcomb merged with NEI to get PM2.5 emission data related only to "coal combustion"
        merged <- merge(x = NEI, y = SCCcoalcomb, by = 'SCC')
        
        #merged PM2.5 emission data is then summarised by year, data is stored into "v" variable
        v<-aggregate(merged$Emissions, by=list(merged$year), sum)
        
        #plots "v", saves it into "plot4", which is later saved into "plot5.png"
        plot4<-qplot(as.character(Group.1),x/1000,data=v, fill=Group.1, geom="bar", stat="identity", ylab="PM2.5 emissions (k tons)", main="Total emissions from PM2.5 from coal combustion in the USA", xlab="Year")+theme(legend.position = "none")+geom_text(aes(label = round(x/1000, 0), size = 1, hjust = 0.5, vjust = -1))
        ggsave(filename="plot4.png", plot4)
        
}