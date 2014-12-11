
Feature: Solr Advanced Search Interface
  In order to discover Islandora Objects by search
  As a user-agent
  I need to be able to refine search for Objects by full-text and key field values

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by "Title"
    Given I am on "collections/alumni/browse"
    Then I should see "779 Items Found" in the "#page-header p.lead" element
    # When I follow "#simple-search-control-container.modal-control-container a"
    When I select "Title" from "#edit-terms-0-field-wrapper-field"
    When I fill in "#edit-terms-0-field-wrapper-search" with "lafayette"
    When I press "Search"
    Then I should see "764 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by "Part Of"
    Given I am on "collections/alumni/browse"
    Then I should see "779 Items Found" in the "#page-header p.lead" element
    When I select "Part Of" from "#edit-terms-0-field-wrapper-field"
    When I fill in "#edit-terms-0-field-wrapper-search" with "supplement"
    When I press "Search"
    Then I should see "6 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by Subtitle
    Given I am on "collections/alumni/browse"
    Then I should see "779 Items Found" in the "#page-header p.lead" element
    When I select "Subtitle" from "#edit-terms-0-field-wrapper-field"
    When I fill in "#edit-terms-0-field-wrapper-search" with "mining"
    When I press "Search"
    Then I should see "1 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by Author
    Given I am on "collections/alumni/browse"
    Then I should see "779 Items Found" in the "#page-header p.lead" element
    When I select "Author" from "#edit-terms-0-field-wrapper-field"
    When I fill in "#edit-terms-0-field-wrapper-search" with "stanford"
    When I press "Search"
    Then I should see "1 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Searching the Alumni Publications Collection by Publisher
    Given I am on "collections/alumni/browse"
    Then I should see "779 Items Found" in the "#page-header p.lead" element
    When I select "Author" from "#edit-terms-0-field-wrapper-field"
    When I fill in "#edit-terms-0-field-wrapper-search" with "stanford"
    When I press "Search"
    Then I should see "1 Items Found" in the "#page-header p.lead" element

