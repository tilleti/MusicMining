import os
import glob
import sys
import hdf5_getters

#TODO: this hard coded path should be received as an argument
#changed for Python 3
#dataPath = "/home/carlos/dm-project/musicdataset/MillionSongSubset/data"
dataPath ='/Users/alyssacolyette/Downloads/MillionSongSubset/data'
def get_h5_files(basedir,ext='.h5') :
    finalFiles = []
    for root, dirs, files in os.walk(basedir):
        files = glob.glob(os.path.join(root,'*'+ext))
        for file in files:
        	finalFiles.append(file)
    return finalFiles



def get_all_fields():
	final = []
	exclude = ['get_num_songs']
	fields = list(filter(lambda x: x[:3] == 'get',hdf5_getters.__dict__.keys()))
	for field in fields:
		if(field not in exclude):
			final.append(field[4:])
			
	return final



def get_h5_data(h5,songidx):
	data = []
	fields = get_all_fields()
	for field in fields:
			data.append(str(getattr(hdf5_getters, "get_"+field)(h5,songidx)).replace("\"","\"\""))

	return data





def print_h5_file(h5file):
	h5 = hdf5_getters.open_h5_file_read(h5file)
	for i in range(hdf5_getters.get_num_songs(h5)):
		data = get_h5_data(h5,i)
		print( '"' + "\",\"".join(data).replace("\n","").replace("\r","") + "\"")
	h5.close()


def print_csv():
	all_fields = get_all_fields()
	print( ",".join(all_fields) )
	h5files = get_h5_files(dataPath)
	c=0
	for h5file in h5files:
		if(c % 100 == 0):
			sys.stderr.write(str(c))
			sys.stderr.write("\n")
		print_h5_file(h5file)
		c = c+1











print_csv()
