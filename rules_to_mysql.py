import csv
import sys
import re
import mysql_helper

def get_row_data(row):
	q = re.compile("\{|\}").split(row[0])
	return {
		"songA":q[1],
		"songC":q[3],
		"support":row[1],
		"confidence":row[2],
		"lift":row[3]
	}
	



csv_file = sys.argv[1]
cnx = mysql_helper.read_conf("conf.ini")
table = "song_association"

with open(csv_file, newline='') as csvfile:
	reader = csv.reader(csvfile, delimiter=',', quotechar='"')
	next(reader,None) #skip csv header
	for row in reader:
		data = get_row_data(row)
		mysql_helper.insert(cnx,table,data)

cnx.close()