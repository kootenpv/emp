# -*- mode: snippet -*-
# name: sel
# key: sel
# --
from selenium import webdriver

chrome_options = webdriver.ChromeOptions()
chrome_options.binary_location = "/usr/bin/google-chrome-beta"
driver = webdriver.Chrome(executable_path="/usr/bin/chromedriver", options=chrome_options)

url = $0

driver.get(url)
