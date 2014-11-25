import hdf5_import_threading
import hdf5_import
import sys



def csv_worker(h5data_queue,file):

	fields = ["track_id","artist_familiarity","artist_terms","artist_hotttnesss","artist_terms_weight"]
	row_format = '"{' + '}","{'.join(fields) + '}"' + "\n"


	while True:
		h5data = h5data_queue.get()
		rows = hdf5_import.get_fields_data(h5data,fields)
		for row in rows:
			file.write(row_format.format(**row))

		h5data_queue.task_done()


def main():

	if(len(sys.argv)<2):
		sys.stderr.write("ERROR: No data path specified.\n")
		return

	args = sys.argv[1:]
	path = args[0]

	f = open("db.csv",'w')
	hdf5_import_threading.start(path,thread=dict(target=csv_worker,kwargs={"file":f}))
	f.close()

main()