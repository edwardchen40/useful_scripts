import requests
from bs4 import BeautifulSoup
payload = {
    'StartStation':'977abb69-413a-4ccf-a109-0272c24fd490',
    'EndStation':'f2519629-5973-4d08-913b-479cce78a356',
    'SearchDate':'2015/09/29',
    'SearchTime':'19:30',
    'SearchWay':'DepartureInMandarin',
    'RestTime':'',
    'EarlyOrLater':''
}

res = requests.post("http://www.thsrc.com.tw/tw/TimeTable/SearchResult", data=payload)
soup = BeautifulSoup(res.text)
for times in soup.select('.result_table'):
    car = times.select('.touch_table')
    print len(car)
    for i in range(len(car)):
        print car[i].text
