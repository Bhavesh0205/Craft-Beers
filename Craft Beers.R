library(ggplot2)
getwd()
setwd("C:/Data/Prep/R_study/projects/Craft Beers")
beers<-read.csv("beers.csv")
breweries<-read.csv("breweries.csv")
beer<-read.csv("beers")
beer_data<-merge.data.frame(beers,breweries,by.x = "brewery_id",by.y = "brewery_id")


##Removing NA values
beer_data<-beer_data[complete.cases(beer_data$abv),]
beer_data<-beer_data[complete.cases(beer_data$ibu),]


##adjusting Abv unit 
#shifting by 2 decimals therefore by abv %
beer_data$abv<-beer_data$abv * 100

##Determining relationship between the ABV and IBU of the beer
summary(beer_data[3:4]) #mean abv - 5.991

#dividing the set into 2 parts i.e high alcohol beer and low alohol beer
low_alcohol<-beer_data[beer_data$abv<=5.991,]
high_alcohol<-beer_data[beer_data$abv>5.991,]
#checking stats
summary(low_alcohol[2:4])
#avg abv for low alcohol beers - 5.062% and avg ibu - 27.99
#it is evident that for beers with low alcohol the average ibu
#is at the lower side

#checking stats for high alcohol beers
summary(high_alcohol[2:4])
#avg abv- 7.23% and avg ibu - 62.41 which is evidently higher
#

#drawing a scatterplot for observing the relation between ABV an IBU
qplot(low_alcohol$abv,low_alcohol$ibu)
qplot(high_alcohol$abv,high_alcohol$ibu,xlab)

#Drawing a scatterplot for displaying relation between IBU and ABV
plot<-ggplot(beer_data,mapping = aes(x=abv,y=ibu)) +geom_point() +geom_smooth(fill=NA)
plot+ylab("International Bittering Unit (IBU)") +xlab("Alcohol by Volume")


