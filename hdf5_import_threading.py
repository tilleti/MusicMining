import sys
import hdf5_import
from queue import Queue
from threading import Thread
from time import sleep

def worker(queue,h5data_queue):
	while True:
		h5file = queue.get()
		for h5data in hdf5_import.h5file_data(h5file):
			h5data_queue.put(h5data)

		queue.task_done()

def output_worker(queue,total):
	while True:
		if queue.qsize() > 0:
			percent = ((total-queue.qsize())/total) * 100
		else:
			percent = 0
		sys.stdout.write("\rWorking...%.2f%%" % percent)
		sleep(0.25)

def start(path,thread,**kwargs):


	queue = Queue()
	h5data_queue = Queue()
	h5files = hdf5_import.get_h5_files(path)

	t = Thread(target=worker,args=(queue,h5data_queue))
	t.daemon = True
	t.start()

	t = Thread(target=output_worker,args=(queue,len(h5files)))
	t.daemon = True
	t.start()

	params = {}
	for name, value in thread.items():
		params[name] = value

	if("kwargs" not in params):
		params["kwargs"] = {}		

	params["kwargs"]["h5data_queue"] = h5data_queue

	t = Thread(**params)
	t.daemon = True
	t.start()
	
	for h5file in h5files:
	    queue.put(h5file)

	queue.join()
	h5data_queue.join()