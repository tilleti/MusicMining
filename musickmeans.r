# Performs kmeans on numerical attributes of music dataset, k=10
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



