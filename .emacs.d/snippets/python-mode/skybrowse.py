# -*- mode: snippet -*-
# name: browse
# key: browse
# --
import selenium
from selenium import webdriver
opts = webdriver.ChromeOptions()
opts.add_argument('--user-data-dir=/Users/pascal/Library/Application Support/Google/Chrome/Default')
driver = webdriver.Chrome(chrome_options = opts)
driver.set_window_size(1920, 1200)
driver.maximize_window()
