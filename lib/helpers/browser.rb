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

  def self.mechanize_agent
    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Chrome'

    agent
  end

  def self.submit_form_headless(url, form_data: {})
    agent = mechanize_agent
    form = agent.get(url).form()

    form_data.each do |name, value|
      form[name.to_s] = value
    end

    agent.submit(form)
  end

  def self.fill_form_fields(page, form_data: {}, finder: :id)
    form_data.each do |name, value|
      elem = page.find_element(finder, name.to_s)
      elem.clear if elem.attribute('type').include?('text')
      elem.send_keys value
    end

    page
  end
end
