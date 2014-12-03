import mysql_helper
import sys
import hdf5_import
import hdf5_import_threading

SCHEMA = {
	"songs":[
		"track_id",
		"artist_familiarity"
		],
	"artist_terms":[
		"track_id",
		"artist_terms"
		]
}

def mysql_worker(h5data_queue,cnx):
	while True:
		h5data = h5data_queue.get()
		for table in SCHEMA:
			data = hdf5_import.get_fields_data(h5data,SCHEMA[table])
			mysql_helper.insert_many(cnx,table,data)
		
		h5data_queue.task_done()


def main():

	if(len(sys.argv)<2):
		sys.stderr.write("ERROR: No data path specified.\n")
		return

	args = sys.argv[1:]
	path = args[0]
	start = int(args[1]) if len(args)>1 else 0
	end = int(args[2]) if len(args)>2 else None


	cnx = mysql_helper.connect(user="root",database="musicmining")

	hdf5_import_threading.start(path,thread=dict(target=mysql_worker,kwargs={"cnx":cnx}),start=start,end=end)
	
	cnx.close()

main()