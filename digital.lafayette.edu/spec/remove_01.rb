require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Remove01" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://digital.stage.lafayette.edu/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_remove01" do
    @driver.get(@base_url + "/islandora/search/*:*?f[0]=cdm.Relation.IsPartOf:%22Marquis%20de%20Lafayette%20Prints%20Collection%22")
    @driver.find_element(:css, "span.bucket-size").click
    subject_lcsh_bucket_count = @driver.find_element(:css, "span.bucket-size").text
    (@driver.find_element(:css, "p.lead").text).should == "565 Items Found"
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
