require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "SolrBrowseMdlPrintsFacetSubjectLcsh" do

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

  describe 'searching by Solr facets for mdl_prints.subject.lcsh' do

  (1..5).each do |i|
  
  it "test_solr_browse_mdl_prints_facet_subject_lcsh" do
    @driver.get(@base_url + "/collections/lafayetteprints")
    @driver.find_element(:link, "title").click
    !60.times{ break if (element_present?(:css, "li.loaded") rescue false); sleep 1 }

      subject_lcsh_elem = @driver.find_element(:xpath, "//ul[@id='mdl-prints-subject-lcsh']/li[#{i}]/a")

      subject_lcsh_bucket_count = @driver.find_element(:xpath, "//ul[@id='mdl-prints-subject-lcsh']/li[#{i}]/span").text
    subject_lcsh_bucket_count = /\((\d+)\)/.match(subject_lcsh_bucket_count)[1]

    subject_lcsh_elem.click
    !60.times{ break if (element_present?(:css, "p.lead") rescue false); sleep 1 }

    (@driver.find_element(:css, "p.lead").text).should == "#{subject_lcsh_bucket_count} Items Found"
  end
  end
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
