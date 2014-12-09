# Performs kmeans on numerical attributes of music dataset, k=5
# When R is ran in the same directory as the single attrib data file
# named here as singleAtt.csv, created from p3_h5tocsv.py
# > source("musickmeans.r") 

#set seed 
set.seed(42)

musicDS <- new.env()

library(rattle)

#music <- read.csv("singleAtt.csv",header=TRUE)
#music <- read.csv("tModified.csv",header=TRUE)
music <- read.csv("db_modified.csv",header=TRUE)

#ridding of NA values
music$artist_terms_freq[is.na(music$artist_terms_freq)] <- 0
music$artist_familiarity[is.na(music$artist_familiarity)] <- 0
#convert wrongly assigned types
music$artist_terms_weight <- as.numeric(music$artist_terms_weight)
music$analysis_sample_rate <- as.numeric(music$analysis_sample_rate)
music$end_of_fade_in <- as.numeric(music$end_of_fade_in)
music$artist_hotttnesss<- as.numeric(music$artist_hotttnesss)
music$segments_loudness_max<- as.numeric(music$segments_loudness_max)
music$song_hotttnesss <- as.numeric(music$song_hotttnesss)

evalq({
	data <-music
	nobs <-nrow(data)
}, musicDS)

vars <- colnames(music)

musicKMEANS <- new.env(parent=musicDS)

#only numerical attributes
#vars <- c(vars[1:4],vars[6],vars[8],vars[11],vars[14:15],vars[17:21],vars[26:29],vars[31],vars[33])
#vars <- c(vars[1:2],vars[5:8],vars[19:21],vars[24:25],vars[27:31],vars[32:35],vars[52])
#removed long & lat for sparse data is given
#####vars <- c(vars[1:2],vars[5:6],vars[19:21],vars[24:25],vars[27:31],vars[32:35],vars[52])
##GOODish vars <- c(vars[1:2],vars[5:6],vars[19:21],vars[24:25],vars[27:31],vars[32:35],vars[52])

#all num, minus ident, minus long & lat
#vars <- c(vars[1:2],vars[14],vars[21],vars[23:35],vars[37:49],vars[52])

#all num, minus ident, minus long & lat, minus confidence and weights
#vars <- c(vars[1:2],vars[14],vars[21],vars[23:27],vars[29:30],vars[32:34],vars[37],vars[39:42],vars[44],vars[46],vars[48],vars[52])

#most correlated
vars <- c(vars[1:2],vars[24],vars[32],vars[39:40],vars[43],vars[48])


music1 <- music[,vars]

musicKMEANS <- new.env(parent=musicDS)

evalq({
	model <- kmeans(x=na.omit(data[,vars]),centers=5)
	}, musicKMEANS)


######separate clusters
#get cluster vector (seems to only do a subset of data...3742 rows)
musicClusters <- musicKMEANS$model$cluster

##music2 < music[na.omit(music),]
#separate rows into their cluster
c1 <- music[musicClusters == 1,]
c2 <- music[musicClusters == 2,]
c3 <- music[musicClusters == 3,]
c4 <- music[musicClusters == 4,]
c5 <- music[musicClusters == 5,]


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~For further partitioning~~~~
#check for best clusters in Rattle
#c1_test <- c1[,vars] #4
#c2_test <- c2[,vars] #5
#c3_test <- c3[,vars] #4
#c4_test <- c4[,vars] #6
#c5_test <- c5[,vars] #5

##split again c1
c1k <- kmeans(x=na.omit(c1[,vars]),centers=4)
musicClusters1 <-c1k$cluster
#split c1 data
c1_1 <- c1[musicClusters1 == 1,]
c1_2 <- c1[musicClusters1 == 2,]
c1_3 <- c1[musicClusters1 == 3,]
c1_4 <- c1[musicClusters1 == 4,]

#write out data
#write.csv(c1_1,"clust1_1.csv")

##split again c2
c2k <- kmeans(x=na.omit(c2[,vars]),centers=5)
musicClusters2 <-c2k$cluster

#split c2 data
c2_1 <- c2[musicClusters2 == 1,]
c2_2 <- c2[musicClusters2 == 2,]
c2_3 <- c2[musicClusters2 == 3,]
c2_4 <- c2[musicClusters2 == 4,]
c2_5 <- c2[musicClusters2 == 5,]

##split again c3
c3k <- kmeans(x=na.omit(c3[,vars]),centers=9)
musicClusters3 <-c3k$cluster

#split c3 data
c3_1 <- c3[musicClusters3 == 1,]
c3_2 <- c3[musicClusters3 == 2,]
c3_3 <- c3[musicClusters3 == 3,]
c3_4 <- c3[musicClusters3 == 4,]

##split agian c4
c4k <- kmeans(x=na.omit(c4[,vars]),centers=6)
musicClusters4 <-c4k$cluster

#split c4 data
c4_1 <- c4[musicClusters4 == 1,]
c4_2 <- c4[musicClusters4 == 2,]
c4_3 <- c4[musicClusters4 == 3,]
c4_4 <- c4[musicClusters4 == 4,]
c4_5 <- c4[musicClusters4 == 5,]
c4_6 <- c4[musicClusters4 == 6,]

#split again c5
c5k <- kmeans(x=na.omit(c5[,vars]),centers=5)
musicClusters5 <-c5k$cluster

#split c5 data
c5_1 <- c5[musicClusters5 == 1,]
c5_2 <- c5[musicClusters5 == 2,]
c5_3 <- c5[musicClusters5 == 3,]
c5_4 <- c5[musicClusters5 == 4,]
c5_5 <- c5[musicClusters5 == 5,]

#~~~~~~~~~~~~~~~~~~~~3rd partition pass~~~~~~~~
#all from c1
#c1_1
#c1_1k <- kmeans(x=na.omit(c1_1[,vars]),centers=5)
#musicClusters1_1 <-c1_1k$cluster

#c1_1_1 <- c1_1[musicClusters1_1 == 1,]
#c1_1_2 <- c1_1[musicClusters1_1 == 2,]
#c1_1_3 <- c1_1[musicClusters1_1 == 3,]
#c1_1_4 <- c1_1[musicClusters1_1 == 4,]
#c1_1_5 <- c1_1[musicClusters1_1 == 5,]
#c1_2
