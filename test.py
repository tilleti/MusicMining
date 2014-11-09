__author__ = 'Prashanth'

import push_to_db as db


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

data = {'artist': [(1, 'artist1', 2, 3, 'rochester', 'aa', 'as', 1, 2, 'ass'),
                   (2, 'artist2', 2, 3, 'rochester', 'aa', 'as', 1, 2, 'ass')]}


db.push(data)