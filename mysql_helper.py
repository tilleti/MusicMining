from __future__ import print_function
from datetime import date, datetime, timedelta
import mysql.connector
import configparser


def _get_table_insert(table,fields):
	return "INSERT IGNORE INTO "+ table + "(" + ",".join(fields) + ") VALUES (%(" + ")s, %(".join(fields) +")s)"

def get_table_insert(table,mapping):
	columns = []
	values = []
	if hasattr(mapping, "keys") and callable(getattr(mapping, "keys")):
		for key in mapping.keys():
			columns.append(key);
			values.append(mapping[key])
	else:
		columns = mapping
		values = mapping

	return "INSERT IGNORE INTO "+ table + "(" + ",".join(columns) + ") VALUES (%(" + ")s, %(".join(values) +")s)"


def connect(**kwargs):
	return mysql.connector.connect(**kwargs)

def read_conf(conf_file):
	config = configparser.ConfigParser()
	config.read(conf_file)
	return connect(**dict(config['mysql']))

def insert(cnx,table,data):
	cursor = cnx.cursor()
	cursor.execute(get_table_insert(table,data.keys()), data)
	cnx.commit()
	cursor.close()


def insert_many(cnx,table,data,mapping):
	if(len(data)<=0):
		return

	cursor = cnx.cursor()
	cursor.executemany(get_table_insert(table,mapping), data)
	cnx.commit()
	cursor.close()

