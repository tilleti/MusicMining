__author__ = 'Prashanth'

import pymysql as server
from pymysql import err
from collections import OrderedDict
#import pprint

config = {
    'user': 'root',
    'host': '127.0.0.1',
    'database': 'millionsong'
}

###############################################################################
# 'metadata' structure <= ordered dictionary
# {
#   'table1': ('col1', 'col2', ...),
#   'table2': ('col1', 'col2', ...),
#   ...
# }

# 'data' structure
# {
#   'table1': [(col1val, col2val, ...), (col1val, col2val, ...), ...],
#   'table2': [(col1val, col2val, ...), (col1val, col2val, ...), ...],
#   ...
# }
###############################################################################


def execute_query(query):
    try:
        conn = server.connect(**config)
        cur = conn.cursor()
        cur.execute(query)
        return cur
    except server.Error as e:
        if e.__cause__ == err.ER.ACCESS_DENIED_ERROR:
            print("Either username or password is wrong")
        elif e.__cause__ == err.ER.BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(e)
    finally:
        cur.close()
        conn.close()


def get_schema_metadata():
    tables = ['artist', 'song', 'term', 'tatum',
              'bar', 'beat', 'section', 'segment',
              'artist_song', 'artist_term', 'similar_artist']
    metadata = OrderedDict()
    for table in tables:
        query = "SELECT DISTINCT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS" +\
                " WHERE TABLE_SCHEMA = 'millionsong' AND TABLE_NAME = '" + table + "'"
        result = execute_query(query)
        cols = ()
        for column in result:
            cols += column
        metadata[table] = cols
    return metadata
#    pp = pprint.PrettyPrinter()
#    pp.pprint(metadata)


#get_schema_metadata()