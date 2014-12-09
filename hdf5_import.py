import os
import glob
import sys
import hdf5_getters
import numpy
import codecs
import time
import threading
import itertools

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


# gets the field value as a string
def get_h5_field_value(h5,songidx,field):

	value = getattr(hdf5_getters, "get_"+field)(h5,songidx)
	t = type(value)
	if(t is numpy.bytes_):
		return str(value,'utf-8')
	return str(value)

def sanitize_value(value):
	t = type(value)
	if(t is numpy.bytes_):
		return str(value,'utf-8')
	return str(value)

def sanitize_list(list):
	newlist = []
	for v in list:
		newlist.append(sanitize_value(v))

	return newlist

def get_h5_data(h5,songidx):
	data = {}
	for field in get_all_fields():
		data[field] = getattr(hdf5_getters, "get_"+field)(h5,songidx)

	return data

lock = threading.Lock()

def h5file_data(h5file):
	with lock:
		h5 = hdf5_getters.open_h5_file_read(h5file)	
		num_songs = hdf5_getters.get_num_songs(h5)

		for i in range(num_songs):
			yield get_h5_data(h5,i)
	
		h5.close()


def is_array(N):
	return hasattr(N, '__len__') and (not isinstance(N, str)) and (not isinstance(N,numpy.bytes_))

def get_fields_data_product(h5data,fields):
	cols = []
	for field in fields:
		field_value = h5data[field]
		if not is_array(field_value):
			field_value = [field_value]

		sanitized_list = sanitize_list(field_value)

		if(len(sanitized_list)==0):
			sanitized_list = [()]

		cols.append(sanitized_list)

	result = []
	
	for i in itertools.product(*cols):
		data = {}
		for idx,field in enumerate(fields):
			data[field] = i[idx]
		result.append(data)

	
	return result
	#
def get_fields_data(h5data,fields):
	#print (h5data)
	data = {}
	for field in fields:
		field_value = h5data[field]
		if is_array(field_value):
			field_value = field_value[0] if len(field_value) > 0 else ""

		data[field] = sanitize_value(field_value)

	yield data



def h5_files_schema_iterator(path,schema):
	h5files = get_h5_files(path)
	for h5file in h5files:
		for h5data in h5file_data(h5file):
			for table in schema:
				yield {table:get_schema_table_cols(h5data,schema[table])}