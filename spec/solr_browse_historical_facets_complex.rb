require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "SolrBrowseMdlPrintsFacetSubjectLcsh" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://digital.stage.lafayette.edu"
    @accept_next_alert = true
    # @driver.manage.timeouts.implicit_wait = 30
    @driver.manage.timeouts.implicit_wait = 5
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end

  describe 'browsing search results by any facet within 2 Solr fields for the Historical Photograph Collection' do

    [
     'Subject',
    ].each do |field_label|

      describe 'browsing search results by the initial 5 Solr facets for the field #{field_label} within the Historical Photograph Collection' do

        (1..5).each do |facet_index|
  
          it "refines the search by the facet #{facet_index} for faceted field #{field_label}" do

            @driver.get(@base_url + "/collections/historicalphotos")
            @driver.find_element(:link, "Title").click

            !60.times{ break if (element_present?(:css, "li.loaded") rescue false); sleep 1 }

            subject_lcsh_elem = @driver.find_element(:xpath, "/html/body/div[2]/div/div/div/div/section/div[text()='#{field_label}']/following-sibling::ul[1]/li[#{facet_index}]/a")
            is_deeper = true
            faceted_terms = []

            # Recurse until the search results can no longer be refined
            while is_deeper

              subject_lcsh_bucket_count = @driver.find_element(:xpath, "/html/body/div[2]/div/div/div/div/section/div[text()='#{field_label}']/following-sibling::ul[1]/li[#{facet_index}]/span").text
              
              subject_lcsh_bucket_count = /\((\d+)\)/.match(subject_lcsh_bucket_count)[1]
              
              faceted_terms << { :token => subject_lcsh_elem.text, :count => @driver.find_element(:css, "p.lead").text }
              
              subject_lcsh_elem.click

              !60.times{ break if (element_present?(:css, "p.lead") rescue false); sleep 1 }
          
              (@driver.find_element(:css, "p.lead").text).should == "#{subject_lcsh_bucket_count} Items Found"
            
              begin
              
                subject_lcsh_elem = @driver.find_element(:xpath, "/html/body/div[2]/div/div/div/div/section/div[text()='#{field_label}']/following-sibling::ul[1]/li[#{facet_index}]/a")
              rescue
            
                is_deeper = false
              end
            end
          
            # Iterate through the list as a stack in order to remove the applied facets
            faceted_terms.reverse.each do |term|

              # Remove the facet
              @driver.find_element(:xpath, "/html/body/div[2]/div/div/div/div/section/ul/li/a[contains(@class, 'islandora-solr-facet-token') and text()='#{term[:token]}']").click

              !60.times{ break if (element_present?(:css, "p.lead") rescue false); sleep 1 }
              
              (@driver.find_element(:css, "p.lead").text).should == term[:count]            
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
