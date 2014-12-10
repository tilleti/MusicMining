#This script compares the artists within cluster 1 and its
#sub clusters and sees if it matchines with a proposed similar 
#artist from within that cluster. 
# Only compares artist to the most similar artist of another song
count1_1 <- 0
#iterate over the artists to find similar artists
for(i in 1:dim(c1_1)[1]){
	i_n <- c1_1$artist_id[i]
	for (j in 1:dim(c1_1)[1]){
		j_n <- c1_1$similar_artists[j]
		if ( as.character(c1_1$artist_id[i]) == as.character(c1_1$similar_artists[j])  ) {
			count1_1 <- count1_1+1		
		}
	}
}


#c1_2
count1_2 <- 0
#iterate over the artists to find similar artists
for(i in 1:dim(c1_2)[1]){
        i_n <- c1_2$artist_id[i]
        for (j in 1:dim(c1_2)[1]){
                j_n <- c1_2$similar_artists[j]
                if ( as.character(c1_2$artist_id[i]) == as.character(c1_2$similar_artists[j])  ) {
                        count1_2 <- count1_2+1
                }
        }
}

#c1_3
count1_3 <- 0
#iterate over the artists to find similar artists
for(i in 1:dim(c1_3)[1]){
        i_n <- c1_3$artist_id[i]
        for (j in 1:dim(c1_3)[1]){
                j_n <- c1_3$similar_artists[j]
                if ( as.character(c1_3$artist_id[i]) == as.character(c1_3$similar_artists[j])  ) {
                        count1_3 <- count1_3+1
                }
        }
}

#c1_4
count1_4 <- 0
#iterate over the artists to find similar artists
for(i in 1:dim(c1_4)[1]){
        i_n <- c1_4$artist_id[i]
        for (j in 1:dim(c1_4)[1]){
                j_n <- c1_4$similar_artists[j]
                if ( as.character(c1_4$artist_id[i]) == as.character(c1_4$similar_artists[j])  ) {
                        count1_4 <- count1_4+1
                }
        }
}

#print results
print("Cluster 1 results: Matches with Artist linking to a song's similar artist")
print(paste("c1_1: ",count1_1," matches out of ",dim(c1_1)[1]))
print(paste("c1_2: ",count1_2," matches out of ",dim(c1_2)[1]))
print(paste("c1_3: ",count1_3," matches out of ",dim(c1_3)[1]))
print(paste("c1_4: ",count1_4," matches out of ",dim(c1_4)[1]))

print(paste("Total c1: ",count1_1+count1_2+count1_3+count1_4," out of ",dim(c1)[1]) )
