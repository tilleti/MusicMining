__author__ = 'Prashanth'

import db_helper

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


def _construct_insert_query(table, cols):
    query = "INSERT INTO " + table + cols + " VALUES "
    return query


def _push_to_db_table(table, cols, data):
    query = _construct_insert_query(table, cols)
    query += str(data).strip("[]")
#    print(query)
    db_helper.execute_query(query)


def _push_to_db(metadata, data):
    for table, cols in metadata.items():
        if table in data:
            _push_to_db_table(table, str(cols), data[table])


def push(data):
    metadata = db_helper.get_schema_metadata()
    _push_to_db(metadata, data)