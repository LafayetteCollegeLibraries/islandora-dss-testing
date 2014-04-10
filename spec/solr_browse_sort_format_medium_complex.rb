require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "SolrBrowseSortFormatMediumComplex" do

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

  describe "Refining browsed items sorted by fields" do
  [
   
   {"Subject.OCM" => "eastasia.Subject.OCM.sort"},
   {"Date.Artifact.Lower" => "eastasia.Date.Artifact.Lower"},
   {"Date.Artifact.Upper" => "eastasia.Date.Artifact.Upper"},
   {"Coverage.Location.Country" => "eastasia.Coverage.Location.Country.sort"},
   # {"Creator.Maker" => "eastasia.Creator.Maker.sort"},
   {"Format.Medium" => "eastasia.Format.Medium.sort"},
  ].each do |field|

      it "should be able to retain sorting by #{field.keys.shift} after refining by a facet" do

        @driver.get(@base_url)
        @driver.find_element(:link, "Collections").click
        @driver.find_element(:link, "East Asia Image Collection").click
        @driver.find_element(:link, field.keys.shift).click
        (@driver.find_element(:id, "field-sort-select").attribute("value")).should == field.values.shift

        !60.times{ break if (element_present?(:css, "p.lead") rescue false); sleep 1 }
        @driver.find_element(:link, "Imperial Postcard Collection").click
        !60.times{ break if (element_present?(:css, "p.lead") rescue false); sleep 1 }
        (@driver.find_element(:id, "field-sort-select").attribute("value")).should == field.values.shift
      end
      
      it "should be able to retain sorting by #{field.keys.shift} after refining by a date range" do

        @driver.get(@base_url)
        @driver.find_element(:link, "Collections").click
        @driver.find_element(:link, "East Asia Image Collection").click
        @driver.find_element(:link, field.keys.shift).click
        (@driver.find_element(:id, "field-sort-select").attribute("value")).should == field.values.shift
        @driver.find_element(:xpath, "//body[@onclick='if(stWidget.buttonClicked==false){stWidget.stopClosing=false;stWidget.openDuration=0;stWidget.stClose(100);}']").click

        # ERROR: Caught exception [ERROR: Unsupported command [dragAndDrop | //section[@id='block-islandora-solr-facet-pages-islandora-solr-facet-pages']/div[7]/a | +70,0]]
        # @driver.find_element(:xpath, "//section[@id='block-islandora-solr-facet-pages-islandora-solr-facet-pages']/div[7]/a").drag_and_drop_by(70, 0)
        @driver.action.drag_and_drop_by(@driver.find_element(:xpath, "//section[@id='block-islandora-solr-facet-pages-islandora-solr-facet-pages']/div[7]/a"), 70, 0).perform

        !60.times{ break if (element_present?(:css, "p.lead") rescue false); sleep 1 }
        (@driver.find_element(:id, "field-sort-select").attribute("value")).should == field.values.shift
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
