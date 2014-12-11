
Feature: Solr Browsing Interface
  In order to discover Islandora Objects by browsing
  As a user-agent
  I need to be able to refine subsets of Objects and sort these subjects by key fields

  @mink:zombie
  Scenario: Filtering the Alumni Publications Collection by Publisher
    Given I am on "collections/alumni/browse"
    Then I should see "779 Items Found" in the "#page-header p.lead" element
    When I follow "Alumni Association of Lafayette College"
    Then I should see "595 Items Found" in the "#page-header p.lead" element
    When I follow "Alumni Association of Lafayette College"
    Then I should see "779 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Filtering the Alumni Publications Collection by Series
    Given I am on "collections/alumni/browse"
    Then I should see "779 Items Found" in the "#page-header p.lead" element
    When I follow "Lafayette Alumnus Football News Letter"
    Then I should see "243 Items Found" in the "#page-header p.lead" element
    When I follow "Lafayette Alumnus Football News Letter"
    Then I should see "779 Items Found" in the "#page-header p.lead" element

  @mink:zombie
  Scenario: Filtering the Alumni Publications Collection by Volume
    Given I am on "collections/alumni/browse"
    Then I should see "779 Items Found" in the "#page-header p.lead" element
    When I follow "#MODS-mods-relatedItem-part-detail-volume-number-i.islandora-solr-facet-list li.first a.active"
    Then I should see "4 Items Found" in the "#page-header p.lead" element
    When I follow "#MODS-mods-relatedItem-part-detail-volume-number-i.islandora-solr-facet-list li.first a.active"
    Then I should see "779 Items Found" in the "#page-header p.lead" element
