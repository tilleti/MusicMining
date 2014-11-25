from __future__ import print_function
from datetime import date, datetime, timedelta
import mysql.connector


def get_table_insert(table,fields):
	return "INSERT INTO "+ table + "(" + ",".join(fields) + ") VALUES (%(" + ")s, %(".join(fields) +")s)"


def connect(**kwargs):
	return mysql.connector.connect(**kwargs)


def insert(cnx,table,data):
	cursor = cnx.cursor()
	cursor.execute(get_table_insert(table,data.keys()), data)
	cnx.commit()
	cursor.close()


def insert_many(cnx,table,data):
	if(len(data)<=0):
		return

	cursor = cnx.cursor()
	cursor.executemany(get_table_insert(table,data[0].keys()), data)
	cnx.commit()
	cursor.close()

