import requests
from bs4 import BeautifulSoup
import shutil

res = requests.get('http://www.gamebase.com.tw/forum/64172/topic/97142830/1')

soup = BeautifulSoup(res.text)
for img in soup.select('.img'):
    fname = img['src'].split('/')[-1] # file name
    print fname
    res2 = requests.get(img['src'], stream=True) # Thru res2 to download file with streaming.
    f = open(fname, 'wb')
    shutil.copyfileobj(res2.raw, f) #save files
    f.close() #close the file
    del res2 #delete the temp res2 files
