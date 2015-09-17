# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re, pickle

class StorePart2Family(unittest.TestCase):
    def setUp(self):
        #選擇瀏覽器
        self.driver = webdriver.Firefox()
        #self.driver = webdriver.Chorme()
        # 將瀏覽器放置最大頁面
        self.driver.maximize_window()

        self.driver.implicitly_wait(30)
        self.base_url = "http://mall.beta.hiiir-inc.com/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_account_login(self):
        driver = self.driver
        driver.get("http://mall.beta.hiiir-inc.com/")
        self.assertEqual(u"friDay購物 - 好買．好逛．好好玩", driver.title)
        driver.find_element_by_css_selector("a > div.nav-border").click()
        driver.find_element_by_id("account").clear()
        driver.find_element_by_id("account").send_keys("rocker_wei@hiiir.com")
        driver.find_element_by_id("password").clear()
        driver.find_element_by_id("password").send_keys("12345678")
        driver.find_element_by_xpath("//button[@type='submit']").click()

        # 把這個 test case 登入狀態的 cookie 存起來
        pickle.dump(driver.get_cookies() , open("cookies.pkl","wb"))
    
  #  def test_store_part2_family(self):
  #      driver = self.driver
        driver.get("http://mall.beta.hiiir-inc.com/")

        # 把 cookie 塞進去
        cookies = pickle.load(open("cookies.pkl", "rb"))
        for cookie in cookies:
            driver.add_cookie(cookie)
             # 再開一次網址，就會是上個 test case 的登入狀態
        driver.get("http://mall.beta.hiiir-inc.com/")

        a = driver.window_handles
        #driver.find_element_by_xpath(u"(//a[contains(text(),'結帳')])[2]").click()
        driver.get("http://mall.beta.hiiir-inc.com:443/cart/mycart?shippingMethodId=2")
        driver.find_element_by_link_text(u"下一步 開始結帳").click()
        driver.find_element_by_id("ui-id-8").click()
        driver.find_element_by_xpath("//i[@class='icon-new-shop-car']").click()
        driver.find_element_by_id("retailStoreTypeFamily").click()

        driver.window_handles
        time.sleep(3)
        driver.window_handles[1]
        driver.switch_to_window(driver.window_handles[1])

        Select(driver.find_element_by_name("City")).select_by_visible_text(u"台北市")
        Select(driver.find_element_by_name("ICity2")).select_by_visible_text(u"內湖區")
       # driver.switch_to.frame(driver.find_element_by_tag_name("iframe"))
        driver.switch_to.frame('street')
        Select(driver.find_element_by_name("gps")).select_by_visible_text(u"港墘路")
       # Leave the store iframe 
        driver.switch_to.default_content()
        
       # driver.switch_to.frame('store')
       # Jump to right iframe area
        driver.switch_to.frame('new_map')
        
        driver.find_element_by_id("submit_img").click()
        driver.find_element_by_name("shippingMobile").clear()
        driver.find_element_by_name("shippingMobile").send_keys("0987728580")
        driver.find_element_by_xpath("//button[@type='button']").click()
        driver.find_element_by_css_selector("a.icon-lightbox-close.close").click()
        try: self.assertEqual(u"訂購完成", driver.find_element_by_css_selector("h2").text)
        except AssertionError as e: self.verificationErrors.append(str(e))
    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException, e: return False
        return True
    
    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True
    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors) 

if __name__ == "__main__":
    unittest.main()
