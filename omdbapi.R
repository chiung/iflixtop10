devtools::install_github("hrbrmstr/omdbapi")
library(omdbapi)
library(dplyr)
library(pbapply)
library(plyr)
library(caret)
library(ggplot2)
library(shiny)
top200tv<-read.csv(file="Top200tviflix.csv",head=TRUE,sep=",")
top200movie<-read.csv(file="Top200movieiflix.csv",head=TRUE,sep=",")
colnames(top200movie)<-c("Title")
colnames(top200tv)<-c("Title")
top200movie <- data.frame(lapply(top200movie, as.character), stringsAsFactors=FALSE)
top200tv <- data.frame(lapply(top200tv, as.character), stringsAsFactors=FALSE)
x<-find_by_title(top200movie$Title[1])
x2<-find_by_title(top200movie$Title[2])
x3<-rbind(x,x2)
for(i in 3:200)
  {
  x3<-rbind(x3,find_by_title(top200movie$Title[i]))
  }
splitdat<-do.call("rbind", strsplit(x3$Genre, ","))
splitdat<-data.frame(apply(splitdat, 2, as.character))
movies<-cbind(x3,splitdat)
names(movies)[names(movies)=="X1"] <- "Genre_1"
names(movies)[names(movies)=="X2"] <- "Genre_2"
names(movies)[names(movies)=="X3"] <- "Genre_3"
mymovie<-movies[!duplicated(movies), ]
top10imdb <- mymovie[ mymovie$imdbRating >= mymovie$imdbRating[order(mymovie$imdbRating, decreasing=TRUE)][10] , ]
top10imdb<-na.omit(top10imdb)
top10imdb$Rated[2]<-"PG"
top10imdb$Runtime[2]<-"98 min"
top10imdb$Director[2]<-"Chris Sanders"
top10imdb$Metascore[2]<-"74"
top10imdb[,15] <- sapply(top10imdb[, 15], as.numeric)
avg_imdbVotes <- mean(top10imdb$imdbVotes)
avg_Metascore <- mean(top10imdb$Metascore)
avg_imdbRating <- mean(top10imdb$imdbRating)
qplot(Title, weight = imdbRating, data =top10imdb, geom = "bar", ylab = "imdb Rating")
qplot(Title, weight = Metascore, data =top10imdb, geom = "bar", ylab = "imdb Rating")
qplot(Title, weight = imdbVotes, data =top10imdb, geom = "bar", ylab = "imdb Rating")
qplot(Genre_1, weight = imdbVotes, data =top10imdb, geom = "bar", ylab = "imdb Rating")
