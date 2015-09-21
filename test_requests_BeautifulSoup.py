import requests
from bs4 import BeautifulSoup
res = requests.get('http://tw.taobao.com/category/1512/a.htm?cat=1512&_ksTS=1442831274785_101&spm=a213z.1224559.20150331F102.1.kkQLMg&_input_charset=utf-8&navigator=all&json=on&callback=__jsonp_cb&cna=mDyADulTuDcCAXsz3SwcqUz6&abtest=_AB-LR492-LR501-LR517-PR492-PR501-PV517_2002')
soup = BeautifulSoup(res.text)

for items in soup.select('.item'):
    print items.select('strong')[0].text,items.select('strong')[0].text.strip()
    
    

