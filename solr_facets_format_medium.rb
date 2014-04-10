require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "SolrFacetsFormatMedium" do

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
  
  it "test_solr_facets_format_medium" do
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Collections").click
    @driver.find_element(:link, "East Asia Image Collection").click
    @driver.find_element(:link, "Title.English").click
    @driver.find_element(:link, "Picture postcard").click
    @driver.find_element(:css, "p.lead").click
    (@driver.find_element(:css, "p.lead").text).should == "2614 Items Found"
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
