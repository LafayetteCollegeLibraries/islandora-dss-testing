
Feature: Solr Browsing Interface
  In order to discover Islandora Objects by browsing
  As a user-agent
  I need to be able to refine subsets of Objects and sort these subjects by key fields

  @mink:zombie
  Scenario: Browsing the Alumni Publications Collection
    Given I am in the "Alumni Publications" Collection
    When I select the token "Alumni Association of Lafayette College" for the field "Publisher"
    Then I should refine my results
