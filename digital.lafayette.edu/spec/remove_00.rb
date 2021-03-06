require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Remove00" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://digital.stage.lafayette.edu/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_remove00" do
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Collections").click
    @driver.find_element(:link, "East Asia Image Collection").click
    @driver.find_element(:link, "Title").click
    @driver.find_element(:css, "img[alt=\"search the site\"]").click
    @driver.find_element(:id, "edit-terms-0-field-wrapper-search").clear
    @driver.find_element(:id, "edit-terms-0-field-wrapper-search").send_keys "test"
    @driver.find_element(:id, "edit-submit--3").click
    (@driver.find_element(:css, "p.lead").text).should == "2 Items Found"
    @driver.find_element(:css, "h4.modal-title").click
    @driver.find_element(:id, "edit-terms-0-field-wrapper-field").click
    @driver.find_element(:css, "option[value=\"foxml.all.text\"]").click
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
