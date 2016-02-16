# Install xlrd via pip pip install xlrd

import xlrd
wb = xlrd.open_workbook('myfile.xlsx')                                                                                                         

nsheets = wb.nsheets
print nsheets 
wbnames = wb.sheet_names()
print wbnames

sheet0 = wb.sheet_by_index(0)
column_0_values = sheet0.col_values(colx=1)
print sheet0.name
print column_0_values
print column_0_values[1]
print sheet0.cell(0,0).value

keys = [sheet0.cell(0, col_index).value for col_index in xrange(sheet0.ncols)]
print sheet0.ncols
print keys
print "keys"
print sheet0.nrows

dict_list = []
for row_index in xrange(1, sheet0.nrows):
    d = {keys[col_index]: sheet0.cell(row_index, col_index).value 
             for col_index in xrange(sheet0.ncols)}
    dict_list.append(d)

print dict_list
