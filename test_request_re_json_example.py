import requests
import re
import json

res = requests.get('http://www.oanda.com/currency/historical-rates/')

m  = re.search('("data":\[\[.*\]\])',res.text) # . means add (+)
data = json.loads('{'+ m.group() + '}')
print data
print data.values()[0][1]


