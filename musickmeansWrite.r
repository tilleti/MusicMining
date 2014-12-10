# Run after musickmeans.r is ran
# This script writes out the partitions made in musickmeans.r

setwd("Partitions")

#c1 writeout
write.csv(c1_1,"clust1_1.csv")
write.csv(c1_2,"clust1_2.csv")
write.csv(c1_3,"clust1_3.csv")
write.csv(c1_4,"clust1_4.csv")

#c2 writeout
write.csv(c2_1,"clust2_1.csv")
write.csv(c2_2,"clust2_2.csv")
write.csv(c2_3,"clust2_3.csv")
write.csv(c2_4,"clust2_4.csv")
write.csv(c2_5,"clust2_5.csv")

#c3 writeout
write.csv(c3_1,"clust3_1.csv")
write.csv(c3_2,"clust3_2.csv")
write.csv(c3_3,"clust3_3.csv")
write.csv(c3_4,"clust3_4.csv")
write.csv(c3_5,"clust3_5.csv")
write.csv(c3_6,"clust3_6.csv")
write.csv(c3_7,"clust3_7.csv")
write.csv(c3_8,"clust3_8.csv")
write.csv(c3_9,"clust3_9.csv")

#c4 writeout
write.csv(c4_1,"clust4_1.csv")
write.csv(c4_2,"clust4_2.csv")
write.csv(c4_3,"clust4_3.csv")
write.csv(c4_4,"clust4_4.csv")
write.csv(c4_5,"clust4_5.csv")
write.csv(c4_6,"clust4_6.csv")

#c5 writeout
write.csv(c5_1,"clust5_1.csv")
write.csv(c5_2,"clust5_2.csv")
write.csv(c5_3,"clust5_3.csv")
write.csv(c5_4,"clust5_4.csv")
write.csv(c5_5,"clust5_5.csv")

#go back to main directory
setwd("..")
