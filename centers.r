# Run after musickmeans.r is ran
# This script writes out the partitions centers made in musickmeans.r
# hardcoded labels, from partitions created in musickmeans.r
setwd("Centers")

#first cluster
write.csv(musicKMEANS$model$centers,"clustcenters.csv")

#one table
centerTable <- c1k$centers
r_names <- c("1_1","1_2","1_3","1_4")
rownames(centerTable) <- r_names

cenT <- c2k$centers
r_names <- c("2_1","2_2","2_3","2_4","2_5")
rownames(cenT) <- r_names
centerTable <- rbind(centerTable,cenT)

cenT <- c3k$centers
r_names <- c("3_1","3_2","3_3","3_4","3_5","3_6","3_7","3_8","3_9")
rownames(cenT) <- r_names
centerTable <- rbind(centerTable,cenT)

cenT <- c4k$centers
r_names <- c("4_1","4_2","4_3","4_4","4_5","4_6")
rownames(cenT) <- r_names
centerTable <- rbind(centerTable,cenT)

cenT <- c5k$centers
r_names <- c("5_1","5_2","5_3","5_4","5_5") 
rownames(cenT) <- r_names
centerTable <- rbind(centerTable,cenT)

write.csv(centerTable,"centers.csv")

#c1 writeout
write.csv(c1k$centers,"clust1centers.csv")

#c2 writeout
write.csv(c2k$centers,"clust2centers.csv")

#c3 writeout
write.csv(c3k$centers,"clust3centers.csv")

#c4 writeout
write.csv(c4k$centers,"clust4centers.csv")

#c5 writeout
write.csv(c5$centers,"clust5centers.csv")

#go back to main directory
setwd("..")
