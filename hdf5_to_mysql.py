import mysql_helper
import sys
import hdf5_import
import hdf5_import_threading

SCHEMA = [
	("artist",{  
		"artistId":"artist_id",
		"name":"artist_name" ,
		"latitude":"artist_latitude" ,
		"longitude":"artist_longitude" ,
		"location":"artist_location" ,
		"familiarity":"artist_familiarity" ,
		"hotness":"artist_hotttnesss" ,
		"mbId":"artist_mbid" ,
		"playmeId":"artist_playmeid" ,
		"7digitalId":"artist_7digitalid" 
	}),
	("song",{
		"songId":"song_id",
		"title":"title",
		"hotness":"song_hotttnesss",
		"track_7digitalId":"track_7digitalid",
		"danceability":"danceability",
		"loudness":"loudness",
		"tempo":"tempo",
		"trackId":"track_id",
		"duration":"duration",
		"year":"year"
	}),
	("artist_song",{
		"artistId":"artist_id",
		"songId":"song_id"
	}),
	("artist_term",{
		"artistId":"artist_id",
  		"termId":"artist_terms"
	})
]

def mysql_worker(h5data_queue,cnx):
	while True:
		h5data = h5data_queue.get()
		for c in SCHEMA:
			table = c[0]
			mapping = c[1]
			data = hdf5_import.get_fields_data_product(h5data,mapping.values())
			mysql_helper.insert_many(cnx,table,data,mapping)
		
		h5data_queue.task_done()


def main():

	if(len(sys.argv)<2):
		sys.stderr.write("ERROR: No data path specified.\n")
		return

	args = sys.argv[1:]
	path = args[0]
	start = int(args[1]) if len(args)>1 else 0
	end = int(args[2]) if len(args)>2 else None


	cnx = mysql_helper.read_conf("conf.ini")

	hdf5_import_threading.start(path,thread=dict(target=mysql_worker,kwargs={"cnx":cnx}),start=start,end=end)
	
	cnx.close()

main()