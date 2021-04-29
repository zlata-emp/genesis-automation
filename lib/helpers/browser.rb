# frozen_string_literal: true

# Manages browser instances.
#
# ##### Usage:
# reuse instance for all tests
#   **<code>let(:page) { Browser.reuse_page }</code>**
# reuse instance with timeout 3 seconds
#   **<code>let(:page) { Browser.reuse_page(timeout_sec: 3) }</code>**
# opens new instance for every test
#   **<code>let(:page) { Browser.open_new_page }</code>**
class Browser
  private_class_method :new

  def self.reuse_page(timeout_sec: 10)
    @reuse_page ||= open_new_page(timeout_sec: timeout_sec)
  end

  def self.open_new_page(timeout_sec: 10)
    page = new_web_driver
    page.manage.timeouts.implicit_wait = timeout_sec

    page
  end

  def self.new_web_driver(browser: :chrome)
    Selenium::WebDriver.for browser
  end
end