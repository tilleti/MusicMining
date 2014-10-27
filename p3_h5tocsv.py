import os
import glob
import sys
import hdf5_getters
import numpy
import codecs
import time
import threading

def get_h5_files(basedir,ext='.h5') :
	if(not os.path.isdir(basedir)):
		raise Exception("Invalid directory: '"+basedir+"'")
	
	finalFiles = []
	for root, dirs, files in os.walk(basedir):
		files = glob.glob(os.path.join(root,'*'+ext))
		for file in files:
			finalFiles.append(file)

	return finalFiles
def get_all_fields():

	if hasattr(get_all_fields, "fields"):
		return get_all_fields.fields

	final = []
	exclude = ['get_num_songs']
	fields = list(filter(lambda x: x[:3] == 'get',sorted(hdf5_getters.__dict__.keys())))
	for field in fields:
		if(field not in exclude):
			final.append(field[4:])
	
	get_all_fields.fields = final

	return final

def get_onevalue_fields():
	if hasattr(get_onevalue_fields, "fields"):
		return get_onevalue_fields.fields
	final = []
	exclude = ['get_num_songs',
	'get_similar_artists',
	'get_artist_terms',
	'get_artist_terms_freq',
	'get_artist_terms_weight',
	'get_segments_start',
	'get_segments_confidence',
	'get_segments_pitches',
	'get_segments_timbre',
	'get_segments_loudness_max',
	'get_segments_loudness_max_time',
	'get_segments_loudness_start',
	'get_sections_start',
	'get_sections_confidence',
	'get_beats_start',
	'get_beats_confidence',
	'get_bars_start',
	'get_bars_confidence',
	'get_tatums_start',
	'get_tatums_confidence',
	'get_artist_mbtags',
	'get_artist_mbtags_count'
	]

	fields = list(filter(lambda x: x[:3] == 'get',sorted(hdf5_getters.__dict__.keys())))
	for field in fields:
		if(field not in exclude):
			final.append(field[4:])
	

	get_onevalue_fields.fields = final
	return final


# gets the field value as a string
def get_h5_field_value(h5,songidx,field):

	value = getattr(hdf5_getters, "get_"+field)(h5,songidx)
	t = type(value)
	if(t is numpy.bytes_):
		return str(value,'utf-8')
	return str(value)

def get_csv_h5_data(h5,songidx,fieldType='all'):
	data = []
	method = globals()['get_'+fieldType+'_fields']
	fields = method()
	for field in fields:
		value = get_h5_field_value(h5,songidx,field)
		data.append(str(value).replace("\"","\"\""))

	return data

def get_csv_rows(h5file,fieldType='all'):
	h5 = hdf5_getters.open_h5_file_read(h5file)

	output = []

	for i in range(hdf5_getters.get_num_songs(h5)):
		data = get_csv_h5_data(h5,i,fieldType)
		out = "\",\"".join(data)
		out = out.replace("\n","")
		out = out.replace("\r","")
		out = "\"" + out + "\""
		output.append(out)
		output.append("\n")
	h5.close()

	return ''.join(output)


def write_csv(dataPath,outPath='out.csv',fieldType='onevalue'):
	global percentage

	outfile = codecs.open(outPath,'w','utf-8')
	method = globals()['get_'+fieldType+'_fields']

	all_fields = method()
	
	h5files = get_h5_files(dataPath)
	outfile.write( ",".join(all_fields) )
	outfile.write("\n")
	c=0
	total = len(h5files)
	percentage = 0
	for h5file in h5files:
		rows = get_csv_rows(h5file,fieldType)
		outfile.write(rows)
		c = c+1
		percentage = (c/total)*100

	outfile.close()



percentage = 0

def main():

	if(len(sys.argv)<2):
		sys.stderr.write("ERROR: No data path specified.\n")
		return 

	args = sys.argv[1:]
	t = threading.Thread(target=write_csv,args=tuple(args))
	t.daemon = True
	t.start()
	
	while(t.is_alive()):
		sys.stdout.write("\rWorking... %.2f%%" % percentage)
		time.sleep(0.2)

	sys.stdout.write("\rWorking... %.2f%%\nDone!\n" % percentage)

	
main()