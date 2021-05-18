# frozen_string_literal: true

require 'pry'
require 'active_support/all'
require 'httpclient'
require 'gmail'
require 'selenium-webdriver'
require 'mechanize'
require 'xmlsimple'
require 'logger'

Dir['./lib/**/*.rb'].sort.each { |file| require file }

# require default env
require './config/local' unless ARGV.index('-r')
