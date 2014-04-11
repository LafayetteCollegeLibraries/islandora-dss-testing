require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "SolrAdvancedSearchCollections" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://digital.stage.lafayette.edu/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []

    # Resize the window
    # @driver.set_window_size(1280, 600)
    @driver.manage().window().resize_to(1280, 600)
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end

  {
    'East Asia Image Collection' => {'Full Text' => {:value => 'taiwan', :results => 2170},
    },
  }.each_pair do |collection_name, collection_fields|

    describe "Search by all fields within #{collection_name}" do

      collection_fields.each_pair do |field_name, field|

        field_value = field[:value]
        field_results = field[:results]

        describe "Search by all #{field_name} within #{collection_name}" do

          # Attempt the following transformations:
          # lower case
          # upper case
          # capitalizing the initial character
          # inverting the case
          [
           field_value,
           field_value.downcase,
           field_value.upcase,
           field_value.capitalize,
           field_value.swapcase,
          ].each do |field_value_i|
  
            it "finds #{field_results} for #{field_value_i}" do
              @driver.get(@base_url)
              @driver.find_element(:link, "Collections").click
              @driver.find_element(:link, "East Asia Image Collection").click
              @driver.find_element(:link, "Title.English").click
              @driver.find_element(:css, "img[alt=\"search the site\"]").click
              #     @driver.find_element(:css, "option[value=\"#{field_name}\"]").click
              @driver.find_element(:xpath, "//option[text()='#{field_name}']").click
              @driver.find_element(:id, "edit-terms-0-field-wrapper-search").send_keys field_value_i
              @driver.find_element(:id, "edit-submit--3").click
              (@driver.find_element(:css, "p.lead").text).should == "#{field_results} Items Found"
            end
          end
        end
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
