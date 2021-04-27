# Manages browser instances.
# Usage: let(:page) { Browser.open }     # uses one instance for all tests
#        let(:page) { Browser.open_new } # opens new instance for every test
class Browser
  @page = Selenium::WebDriver.for :chrome

  def self.open(timeout_sec: 10)
    @page ||= Selenium::WebDriver.for :chrome
    @page.manage.timeouts.implicit_wait = timeout_sec

    @page
  end

  def self.open_new(timeout_sec: 10)
    new_browser_page = Selenium::WebDriver.for :chrome
    new_browser_page.manage.timeouts.implicit_wait = timeout_sec # seconds

    new_browser_page
  end
end
