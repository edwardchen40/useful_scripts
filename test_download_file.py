from selenium import webdriver


FirefoxProfile firefoxProfile = new FirefoxProfile();

firefoxProfile.setPreference("browser.download.folderList",2);
firefoxProfile.setPreference("browser.download.manager.showWhenStarting",false);
firefoxProfile.setPreference("browser.download.dir","c:\\downloads");
firefoxProfile.setPreference("browser.helperApps.neverAsk.saveToDisk","text/csv");

WebDriver driver = new FirefoxDriver(firefoxProfile); 
# new RemoteWebDriver(new URL("http://localhost:4444/wd/hub"), capability);

driver.navigate().to("http://www.myfile.com/hey.csv");


#To identify the content type you want to download automatically, you can use curl:
#curl -I URL | grep "Content-Type"

#Another way to find content type is using the requests module, you can use it like this:

#import requests
#content_type = requests.head('http://www.python.org').headers['content-type']
#print(content_type)
~                                                                                                                                              
~                  
