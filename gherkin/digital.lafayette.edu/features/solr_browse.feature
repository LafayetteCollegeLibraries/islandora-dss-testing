
Feature: Solr Browsing Interface
  In order to discover Islandora Objects by browsing
  As a user-agent
  I need to be able to refine subsets of Objects and sort these subjects by key fields

  @mink:zombie
  Scenario Outline: Filtering the Alumni Publications Collection by a Single Field
    Given I am on "collections/alumninewspubs/browse"
    When I wait for ".islandora-solr-search-result-list"
    Then I should see "<total-results> Items Found" in the "#page-header p.lead" element
    When I follow "<facet>"
    When I wait for ".islandora-solr-search-result-list"
    Then I should see "<filtered-results> Items Found" in the "#page-header p.lead" element
    When I follow "<facet>"
    When I wait for ".islandora-solr-search-result-list"
    Then I should see "<total-results> Items Found" in the "#page-header p.lead" element

    Examples:
    | total-results | facet                                   | filtered-results |
    |           780 | Alumni Association of Lafayette College |              596 |
    |           780 | Lafayette Alumni News [newspaper]       |              139 |
    |           780 |                                         |                2 |


  @mink:zombie
  Scenario Outline: Sorting the Alumni Publications Collection

    Given I am on "collections/browse?f[0]=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22&sort=<sort-field>%20asc"
    When I wait for ".islandora-solr-search-result-list"
    Then I should see a ".solr-value.first" element
    And I should see "<initial-value>" in the ".solr-value.first" element
    When I go to "collections/browse?f[0]=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22&sort=<sort-field>%20desc"
    And I wait for ".islandora-solr-search-result-list"
    And I should see a ".solr-value.first" element
    Then I should see "<terminal-value>" in the ".solr-value.first" element

    Examples:
    | collection-set                    | sort-field                               | sort-order | initial-value                     | terminal-value                    |
    | Alumni Publications               | MODS.mods.identifier.local_i             | Asc        | The Lafayette Alumnus             | Lafayette Magazine                |
    | Alumni Publications               | MODS.mods.originInfo.publisher_ss        | Desc       | Leopard Letter                    | Lafayette Alumni News [newspaper] |
    | collections/alumninewspubs/browse | MODS.mods.relatedItem.titleInfo.title_ss | Desc       | Lafayette Alumni News [newspaper] | Leopard Letter                    |

