# Use pickle to get cookie from your web site and write cookie into your site

import pickle
import selenium.webdriver

driver = selenium.webdriver.Firefox()
driver.get("http://mall.beta.hiiir-inc.com/")

# Get cookie from your site
pickle.dump( driver.get_cookies() , open("cookies.pkl","wb"))

# Write cookdie into your site
cookies = pickle.load(open("cookies.pkl", "rb"))
for cookie in cookies:
    print cookie
    driver.add_cookie(cookie)

driver.close()

