import requests
from bs4 import BeautifulSoup

data = {
        'from':'/bbs/Gossiping/index.html',
        'yes':'yes'
    }

session = requests.session() # Create session
res = session.post('https://www.ptt.cc/ask/over18', verify=False, data=data )
soup =  BeautifulSoup(res.text)
for i in soup.select('.r-ent'):
    print i.select('.title')[0].text, i.select('.date')[0].text, i.select('.author')[0].text
