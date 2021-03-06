# -*- coding: utf-8 -*-
require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "SiteMdlpComplexSearchControlsTest" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://digital.prod.lafayette.edu"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_site_mdlp_complex_search_controls" do
    @driver.get(@base_url + "/collections/lafayetteprints")
    @driver.find_element(:link, "creator").click
    @driver.find_element(:css, "div.islandora-solr-content.content").click
    @driver.find_element(:link, ">>").click
    !60.times{ break if (@driver.find_element(:link, "Marie, Paul, Josh. Yves-Gil Mottier Mquis De La Fayette").text == "Marie, Paul, Josh. Yves-Gil Mottier Mquis De La Fayette" rescue false); sleep 1 }
    (@driver.find_element(:link, "Marie, Paul, Josh. Yves-Gil Mottier Mquis De La Fayette").text).should == "Marie, Paul, Josh. Yves-Gil Mottier Mquis De La Fayette"
    @driver.find_element(:link, "Hide").click
    !60.times{ break if (element_present?(:css, "h2.block-title") rescue false); sleep 1 }
#    (@driver.find_element(:css, "h2.block-title").text).should_not == "Refine your search"
#    @driver.find_element(:id, "refine-search-icon").click
#    !60.times{ break if (element_present?(:css, "h2.block-title") rescue false); sleep 1 }
    (@driver.find_element(:css, "h2.block-title").text).should == "Refine your search"
    @driver.find_element(:link, "×Marquis de Lafayette Prints Collection").click
    !60.times{ break if (@driver.find_element(:css, "div.islandora-solr-facet").text == "Choose a Collection" rescue false); sleep 1 }
    (@driver.find_element(:css, "p.lead").text).should == "34421 Items Found"
    @driver.find_element(:link, "McKelvy House Photograph Collection").click
    !60.times{ break if (@driver.find_element(:link, "×McKelvy House Photograph Collection").text == "×McKelvy House Photograph Collection" rescue false); sleep 1 }
    (@driver.find_element(:css, "p.lead").text).should == "211 Items Found"
    @driver.find_element(:css, "span.close").click
    !60.times{ break if (@driver.find_element(:css, "div.islandora-solr-facet").text == "Choose a Collection" rescue false); sleep 1 }
    (@driver.find_element(:css, "p.lead").text).should == "34421 Items Found"
    @driver.find_element(:link, "McKelvy House Photograph Collection").click
    !60.times{ break if (@driver.find_element(:link, "×McKelvy House Photograph Collection").text == "×McKelvy House Photograph Collection" rescue false); sleep 1 }
    (@driver.find_element(:css, "p.lead").text).should == "211 Items Found"
    @driver.find_element(:id, "field-sort-desc").click
    !60.times{ break if (@driver.find_element(:xpath, "//dl[2]/dd").text == "[Oakhurst]..." rescue false); sleep 1 }
    (@driver.find_element(:css, "dd.solr-value.eastasia-format-medium").text).should == "9 x 14 cm. (image), 9.5 x 14.5 cm. (on sheet), photograph"
    @driver.find_element(:link, "Hide").click
    (@driver.find_element(:css, "h2.block-title").text).should == "Refine your search"
    @driver.find_element(:link, "Grid").click
    !60.times{ break if (@driver.find_element(:css, "div.islandora-basic-collection-grid.clearfix").text == "[Oakhurst]... Title [Oakhurst]... Format.Medium 9 x 14 cm. (image), 9.5 x 14.5 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy House, McKelvy family Date [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium photograph, 21.5 x 14 cm. (image), 25 x 20 cm. (on sheet) Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Roth, Mary Joel S., Lafayette College (Easton, Pa.). McKelvy House Date 1983-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium photograph, 16 x 24 cm. (image), 17.5 x 25 cm. (on sheet) Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House, Teller, Edward, 1908-2003 Date 1982-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium photograph, 16 x 24 cm. (image), 20 x 25 cm. (on sheet) Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Crawford, James P., 1935-2003, Lafayette College (Easton, Pa.). McKelvy House Date 1973-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium photograph, 16.5 x 24 cm. (image), 17.5 x 25 cm. (on sheet) Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium photograph, 16.5 x 24 cm. (image), 17.5 x 25 cm. (on sheet) Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium photograph, 16 x 24 cm. (image), 20 x 25 cm. (on sheet) Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date 1972-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium photograph, 16.5 x 24 cm. (image), 17.5 x 25 cm. (on sheet) Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium photograph, 16 x 22.5 cm. (image), 20 x 25 cm. (on sheet) Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Taylor, Billy, 1921-2010, Lafayette College (Easton, Pa.). McKelvy House Date [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium 21.5 x 14.5 cm. (image), 25 x 20 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date 1983-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium 14.5 x 21.5 cm. (image), 20 x 25 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date 1983-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium 11 x 16.5 cm. (image), 12 x 17.5 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House, Teller, Edward, 1908-2003 Date 1982-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium 11 cm. x 16.5 cm. (image), 12 x 17.5 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date 1978-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium 14.5 x 21.5 cm. (image), 20 x 25 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date 1983-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium 16 x 24 cm. (image), 20.5 x 25 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Crawford, James P., 1935-2003, Lafayette College (Easton, Pa.). McKelvy House Date 1973-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium 14.5 x 22 cm. (image), 20 x 25 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date 1983-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium 14.5 x 22 cm. (image), 20 x 25 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date 1983-01-01 [McKelvy Scholars Program]... Title [McKelvy Scholars Program]... Format.Medium 14.5 x 21.5 cm. (image), 20 x 25 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy Scholars Program, Lafayette College (Easton, Pa.). McKelvy House Date 1983-01-01 [McKelvy House: McKelvy Family Slides]... Title [McKelvy House: McKelvy Family Slides]... Format.Medium 2.5 x 3.5 cm. (image), 5 x 5 cm. (slide), slide Subject Lafayette College (Easton, Pa.). McKelvy House, McKelvy family Date [McKelvy House: McKelvy Family Slides]... Title [McKelvy House: McKelvy Family Slides]... Format.Medium 2.5 x 3.5 cm. (image), 5 x 5 cm. (slide), slide Subject Lafayette College (Easton, Pa.). McKelvy House, McKelvy family Date" rescue false); sleep 1 }
    (@driver.find_element(:xpath, "(//a[contains(text(),'[McKelvy Scholars Program]...')])[3]").text).should == "[McKelvy Scholars Program]..."
    @driver.find_element(:link, "Hide").click
    (@driver.find_element(:css, "h2.block-title").text).should == "Refine your search"
    @driver.find_element(:link, "photograph").click
    !60.times{ break if (@driver.find_element(:link, "×photograph").text == "×photograph" rescue false); sleep 1 }
    (@driver.find_element(:link, "×photograph").text).should == "×photograph"
    (@driver.find_element(:css, "p.lead").text).should == "161 Items Found"
    @driver.find_element(:id, "field-sort-asc").click
    !60.times{ break if (@driver.find_element(:xpath, "//dl[6]/dd").text == "Mr. Eyerman's Italian Garden..." rescue false); sleep 1 }
    (@driver.find_element(:xpath, "//dl[6]/dd").text).should == "Mr. Eyerman's Italian Garden..."
    @driver.find_element(:id, "field-sort-select").click
    # ERROR: Caught exception [ReferenceError: selectLocator is not defined]
    @driver.find_element(:css, "option[value=\"mckelvy.date.original.display\"]").click
    !60.times{ break if (@driver.find_element(:link, "The Italian Garden at Oakhurst, the Home of John Eyerman, College Hill...").text == "The Italian Garden at Oakhurst, the Home of John Eyerman, College Hill..." rescue false); sleep 1 }
    (@driver.find_element(:link, "The Italian Garden at Oakhurst, the Home of John Eyerman, College Hill...").text).should == "The Italian Garden at Oakhurst, the Home of John Eyerman, College Hill..."
    @driver.find_element(:link, "3").click
    !60.times{ break if (@driver.find_element(:xpath, "//dl[20]").text == "Mr. Eyerman's Italian Garden... Title Mr. Eyerman's Italian Garden... Format.Medium 5 x 7.5 cm. (image), 6 x 8.5 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy House, Barrett, Nathan Franklin, 1845-1919, Eyerman family Date" rescue false); sleep 1 }
    (@driver.find_element(:xpath, "//dl[20]").text).should == "Mr. Eyerman's Italian Garden... Title Mr. Eyerman's Italian Garden... Format.Medium 5 x 7.5 cm. (image), 6 x 8.5 cm. (on sheet), photograph Subject Lafayette College (Easton, Pa.). McKelvy House, Barrett, Nathan Franklin, 1845-1919, Eyerman family Date"
    @driver.find_element(:id, "view-list-icon").click
    !60.times{ break if (@driver.find_element(:xpath, "//li[20]/dl[2]/dd").text == "Mr. Eyerman's Italian Garden..." rescue false); sleep 1 }
    (@driver.find_element(:xpath, "//li[20]/dl[2]/dd").text).should == "Mr. Eyerman's Italian Garden..."
    @driver.find_element(:link, "1").click
    !60.times{ break if (@driver.find_element(:xpath, "//dl[2]/dd").text == "Oakhurst, the Home of John Eyerman, College Hill..." rescue false); sleep 1 }
    (@driver.find_element(:xpath, "//dl[2]/dd").text).should == "Oakhurst, the Home of John Eyerman, College Hill..."
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
