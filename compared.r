
count <- 0
count1 <- 0
#iterate over the artists to find similar artists
for(i in 1:dim(c1_1)[1]){
	i_n <- c1_1$artist_id[i]
	for (j in 1:dim(c1_1)[1]){
		j_n <- c1_1$similar_artists[j]
		if ( as.character(c1_1$artist_id[i]) == as.character(c1_1$similar_artists[j])  ) {
			count <- count+1		
		}else {
			count1 <- count1+1
		}
	}
}


#c1_1_2
#count <- 0
#count1 <- 0
#iterate over the artists to find similar artists
for(i in 1:dim(c1_2)[1]){
        i_n <- c1_2$artist_id[i]
        for (j in 1:dim(c1_2)[1]){
                j_n <- c1_2$similar_artists[j]
                if ( as.character(c1_2$artist_id[i]) == as.character(c1_2$similar_artists[j])  ) {
                        count <- count+1
                }else {
                        count1 <- count1+1
                }
        }
}
#c1_1_3
#count <- 0
#count1 <- 0
#iterate over the artists to find similar artists
for(i in 1:dim(c1_3)[1]){
        i_n <- c1_3$artist_id[i]
        for (j in 1:dim(c1_3)[1]){
                j_n <- c1_3$similar_artists[j]
                if ( as.character(c1_3$artist_id[i]) == as.character(c1_3$similar_artists[j])  ) {
                        count <- count+1
                }else {
                        count1 <- count1+1
                }
        }
}

#c1_1_4
#count <- 0
#count1 <- 0
#iterate over the artists to find similar artists
for(i in 1:dim(c1_4)[1]){
        i_n <- c1_4$artist_id[i]
        for (j in 1:dim(c1_4)[1]){
                j_n <- c1_4$similar_artists[j]
                if ( as.character(c1_4$artist_id[i]) == as.character(c1_4$similar_artists[j])  ) {
                        count <- count+1
                }else {
                        count1 <- count1+1
                }
        }
}

#c1_1_5
#count <- 0
#count1 <- 0
#iterate over the artists to find similar artists
for(i in 1:dim(c1_5)[1]){
        i_n <- c1_5$artist_id[i]
        for (j in 1:dim(c1_5)[1]){
                j_n <- c1_5$similar_artists[j]
                if ( as.character(c1_5$artist_id[i]) == as.character(c1_5$similar_artists[j])  ) {
                        count <- count+1
                }else {
                        count1 <- count1+1
                }
        }
}
