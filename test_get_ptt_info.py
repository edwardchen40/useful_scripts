import requests
from bs4 import BeautifulSoup
res = requests.get('https://www.ptt.cc/bbs/Food/index.html')
item = soup.select('.r-ent')
for i in soup.select('.r-ent'):
    print i.select('.title')[0].text,i.select('.date')[0].text,i.select('.author')[0].text
