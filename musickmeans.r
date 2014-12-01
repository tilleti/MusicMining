# Performs kmeans on numerical attributes of music dataset, k=10
# When R is ran in the same directory as the single attrib data file
# named here as singleAtt.csv, created from p3_h5tocsv.py
# > source("musickmeans.r") 
musicDS <- new.env()

library(rattle)

music <- read.csv("singleAtt.csv",header=TRUE)

evalq({
	data <-music
	nobs <-nrow(data)
}, musicDS)

vars <- colnames(music)

musicKMEANS <- new.env(parent=musicDS)

#only numerical attributes
vars <- c(vars[1:4],vars[6],vars[8],vars[11],vars[14:15],vars[17:21],vars[26:29],vars[31],vars[33])

musicKMEANS <- new.env(parent=musicDS)

evalq({
	model <- kmeans(x=na.omit(data[,vars]),centers=10)
	}, musicKMEANS)


######separate clusters
#get cluster vector (seems to only do a subset of data...3742 rows)
musicClusters <- musicKMEANS$model$cluster

#separate rows into their cluster
c1 <- music[musicClusters == 1,]
c2 <- music[musicClusters == 2,]
c3 <- music[musicClusters == 3,]
c4 <- music[musicClusters == 4,]
c5 <- music[musicClusters == 5,]
c6 <- music[musicClusters == 6,]
c7 <- music[musicClusters == 7,]
c8 <- music[musicClusters == 8,]
c9 <- music[musicClusters == 9,]
c10 <- music[musicClusters == 10,]
#clusters seem to add up to 10,000 regardless...

