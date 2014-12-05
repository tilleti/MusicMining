import hdf5_import_threading
import hdf5_import
import sys

FIELDS = [
"artist_familiarity",
"artist_hotttnesss",
"artist_id",
"artist_mbid",
"artist_playmeid",
"artist_7digitalid",
"artist_latitude",
"artist_longitude",
"artist_location",
"artist_name",
"release",
"release_7digitalid",
"song_id",
"song_hotttnesss",
"title",
"track_7digitalid",
"similar_artists",
"artist_terms",
"artist_terms_freq",
"artist_terms_weight",
"analysis_sample_rate",
"audio_md5",
"danceability",
"duration",
"end_of_fade_in",
"energy",
"key",
"key_confidence",
"loudness",
"mode",
"mode_confidence",
"start_of_fade_out",
"tempo",
"time_signature",
"time_signature_confidence",
"track_id",
"segments_start",
"segments_confidence",
#"segments_pitches",
#"segments_timbre",
"segments_loudness_max",
"segments_loudness_max_time",
"segments_loudness_start",
"sections_start",
"sections_confidence",
"beats_start",
"beats_confidence",
"bars_start",
"bars_confidence",
"tatums_start",
"tatums_confidence",
"artist_mbtags",
"artist_mbtags_count",
"year"
]

ROW_FORMAT = '"{' + '}","{'.join(FIELDS) + '}"' + "\n"

CSV_HEADER = ",".join(FIELDS) + "\n"


def csv_worker(h5data_queue,file):
	while True:
		h5data = h5data_queue.get()
		rows = hdf5_import.get_fields_data(h5data,FIELDS)
		#print (h5data)
		for row in rows:
			#print (row)
			file.write(ROW_FORMAT.format(**row))

		h5data_queue.task_done()


def main():

	if(len(sys.argv)<2):
		sys.stderr.write("ERROR: No data path specified.\n")
		return

	args = sys.argv[1:]
	path = args[0]
	start = int(args[1]) if len(args)>1 else 0
	end = int(args[2]) if len(args)>2 else None



	f = open("db.csv",'w')
	f.write(CSV_HEADER)

	hdf5_import_threading.start(path,thread=dict(target=csv_worker,kwargs={"file":f}),start=start,end=end)
	f.close()

main()