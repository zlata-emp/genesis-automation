require 'rubygems'
require 'selenium-webdriver'

#Create object of firefox class
driver = Selenium::WebDriver.for :firefox
driver.manage.timeouts.implicit_wait = 10 # seconds

#Navigate to admin login page
driver.get 'https://staging.admin.emerchantpay.net/admin_users/sign_in'

puts 'Staging_Psp Admin login page is successfuly loaded in firefox browser.'

sleep 5