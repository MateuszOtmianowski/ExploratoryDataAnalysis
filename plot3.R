plot3<-function(){
        #loads ggplot2 library
        library(ggplot2)
        
        #reads in data
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        #subsets data for Baltiomore City
        BaltNEI<-NEI[NEI$fips==24510,]
        
        #calculates total emission for every type and every year 
        x<-aggregate(BaltNEI$Emissions, by=list(BaltNEI$year, BaltNEI$type), sum)
    
        #opens png file "plot3", plots variable x, saves it into "plot3" variable
        plot3<-qplot(as.character(Group.1),x,data=x, facets=.~Group.2, color=Group.2, geom="bar", stat="identity", fill=Group.2, ylab="PM2.5 emissions", xlab="Year", main="PM2.5 emissions in the Baltimore City by type", guide_legend(title=NULL))+theme(legend.position = "none")+geom_text(aes(label = round(x, 0), size = 1, hjust = 0.5, vjust = -1))
        
        #saves "plot3" into "plot3.png"
        ggsave(filename="plot3.png", plot3)
}