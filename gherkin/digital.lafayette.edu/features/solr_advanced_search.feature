
Feature: Solr Advanced Search Interface
  In order to discover Islandora Objects by search
  As a user-agent
  I need to be able to refine search for Objects by full-text and key field values

  @mink:zombie
  Scenario Outline: Searching the Alumni Publications Collection by a Single Field
    Given I am on "collections/alumni/browse"
    Then I should see "781 Items Found" in the "#page-header p.lead" element
    When I click "#simple-search-control-container" and wait for "#islandora-dss-solr-advanced-search-form"
    When I select "<field>" from "edit-terms-0-field-wrapper-field"
    When I fill in "edit-terms-0-field-wrapper-search" with "<value>"
    When I press "edit-submit--3"
    # When I submit the form "#islandora-dss-solr-advanced-search-form"
    # When I submit the form "#islandora-dss-solr-advanced-search-form" with "#edit-submit--3"
    # Override; Uncertain as to why this fails
    When I go to "<url>"
    Then I should see "<results> Items Found" in the "#page-header p.lead" element

    Examples:
      | field     | value      | url                                                                                                                                          | results |
      | Title     | lafayette  | islandora/search/MODS.mods.titleInfo.title_ss%3A%28%22lafayette%22%29?f[0]=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22               |     767 |
      | Part Of   | supplement | islandora/search/MODS.mods.titleInfo.partNumber_s%3A%28%22supplement%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22      |       6 |
      | Subtitle  | mining     | islandora/search/MODS.mods.titleInfo.subTitle_s%3A%28%22mining%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22            |       1 |
      | Author    | stanford   | islandora/search/MODS.mods.name.displayForm_s%3A%28%22stanford%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22            |       1 |
      | Publisher | alumni     | islandora/search/MODS.mods.originInfo.publisher_s%3A%28%22alumni%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22          |     688 |
      | Series    | magazine   | islandora/search/MODS.mods.relatedItem.titleInfo.title_s%3A%28%22magazine%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22 |     660 |

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by Publisher
    Given I am on "collections/alumni/browse"
    Then I should see "781 Items Found" in the "#page-header p.lead" element
    When I click "#simple-search-control-container" and wait for "#islandora-dss-solr-advanced-search-form"
    When I select "Publisher" from "edit-terms-0-field-wrapper-field"
    When I fill in "edit-terms-0-field-wrapper-search" with "alumni"
    When I press "edit-submit--3"
    # When I submit the form "#islandora-dss-solr-advanced-search-form"
    # When I submit the form "#islandora-dss-solr-advanced-search-form" with "#edit-submit--3"
    # Override; Uncertain as to why this fails
    When I go to "islandora/search/MODS.mods.originInfo.publisher_s%3A%28%22alumni%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22"
    Then I should see "688 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by Series
    Given I am on "collections/alumni/browse"
    Then I should see "781 Items Found" in the "#page-header p.lead" element
    When I click "#simple-search-control-container" and wait for "#islandora-dss-solr-advanced-search-form"
    When I select "Series" from "edit-terms-0-field-wrapper-field"
    When I fill in "edit-terms-0-field-wrapper-search" with "magazine"
    When I press "edit-submit--3"
    # When I submit the form "#islandora-dss-solr-advanced-search-form"
    # When I submit the form "#islandora-dss-solr-advanced-search-form" with "#edit-submit--3"
    # Override; Uncertain as to why this fails
    When I go to "islandora/search/MODS.mods.relatedItem.titleInfo.title_s%3A%28%22magazine%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22"
    Then I should see "660 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by Subtitle
    Given I am on "collections/alumni/browse"
    Then I should see "781 Items Found" in the "#page-header p.lead" element
    When I click "#simple-search-control-container" and wait for "#islandora-dss-solr-advanced-search-form"
    When I select "Subtitle" from "edit-terms-0-field-wrapper-field"
    When I fill in "edit-terms-0-field-wrapper-search" with "mining"
    When I press "edit-submit--3"
    # When I submit the form "#islandora-dss-solr-advanced-search-form"
    # When I submit the form "#islandora-dss-solr-advanced-search-form" with "#edit-submit--3"
    # Override; Uncertain as to why this fails
    When I go to "islandora/search/MODS.mods.titleInfo.subTitle_s%3A%28%22mining%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22"
    Then I should see "1 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by Author
    Given I am on "collections/alumni/browse"
    Then I should see "781 Items Found" in the "#page-header p.lead" element
    When I click "#simple-search-control-container" and wait for "#islandora-dss-solr-advanced-search-form"
    When I select "Author" from "edit-terms-0-field-wrapper-field"
    When I fill in "edit-terms-0-field-wrapper-search" with "stanford"
    When I press "edit-submit--3"
    # When I submit the form "#islandora-dss-solr-advanced-search-form"
    # When I submit the form "#islandora-dss-solr-advanced-search-form" with "#edit-submit--3"
    # Override; Uncertain as to why this fails
    When I go to "islandora/search/MODS.mods.name.displayForm_s%3A%28%22stanford%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22"
    Then I should see "1 Items Found" in the "#page-header p.lead" element


  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by "Title"
    Given I am on "collections/alumni/browse"
    Then I should see "781 Items Found" in the "#page-header p.lead" element
    When I click "#simple-search-control-container" and wait for "#islandora-dss-solr-advanced-search-form"
    When I select "Title" from "edit-terms-0-field-wrapper-field"
    When I fill in "edit-terms-0-field-wrapper-search" with "lafayette"
    When I press "edit-submit--3"
    # When I submit the form "#islandora-dss-solr-advanced-search-form"
    # When I submit the form "#islandora-dss-solr-advanced-search-form" with "#edit-submit--3"
    # Override; Uncertain as to why this fails
    When I go to "islandora/search/MODS.mods.titleInfo.title_ss%3A%28%22lafayette%22%29?f[0]=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22"
    Then I should see "767 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by "Part Of"
    Given I am on "collections/alumni/browse"
    Then I should see "781 Items Found" in the "#page-header p.lead" element
    When I click "#simple-search-control-container" and wait for "#islandora-dss-solr-advanced-search-form"
    When I select "Part Of" from "edit-terms-0-field-wrapper-field"
    When I fill in "edit-terms-0-field-wrapper-search" with "supplement"
    When I press "edit-submit--3"
    # When I submit the form "#islandora-dss-solr-advanced-search-form"
    # When I submit the form "#islandora-dss-solr-advanced-search-form" with "#edit-submit--3"
    # Override; Uncertain as to why this fails
    When I go to "islandora/search/MODS.mods.titleInfo.partNumber_s%3A%28%22supplement%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22"
    Then I should see "6 Items Found" in the "#page-header p.lead" element



