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
	model <- kmeans(x=na.omit(data[,vars]),centers=30)
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
c11 <- music[musicClusters == 11,]
c12 <- music[musicClusters == 12,]
c13 <- music[musicClusters == 13,]
c14 <- music[musicClusters == 14,]
c15 <- music[musicClusters == 15,]
c16 <- music[musicClusters == 16,]
c17 <- music[musicClusters == 17,]
c18 <- music[musicClusters == 18,]
c19 <- music[musicClusters == 19,]
c20 <- music[musicClusters == 20,]


c21 <- music[musicClusters == 21,]
c22 <- music[musicClusters == 22,]
c23 <- music[musicClusters == 23,]
c24 <- music[musicClusters == 24,]
c25 <- music[musicClusters == 25,]
c26 <- music[musicClusters == 26,]
c27 <- music[musicClusters == 27,]
c28 <- music[musicClusters == 28,]
c29 <- music[musicClusters == 29,]
c30 <- music[musicClusters == 30,]
