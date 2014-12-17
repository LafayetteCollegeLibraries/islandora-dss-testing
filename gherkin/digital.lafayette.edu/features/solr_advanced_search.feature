
Feature: Solr Advanced Search Interface
  In order to discover Islandora Objects by search
  As a user-agent
  I need to be able to refine search for Objects by full-text and key field values

  @mink:zombie
  Scenario Outline: Searching the Alumni Publications Collection by a Single Field
    Given I am on "collections/alumninewspubs/browse"
    Then I should see "780 Items Found" in the "#page-header p.lead" element
    When I click "#simple-search-control-container" and wait for "#islandora-dss-solr-advanced-search-form"
    And I select "<field>" from "edit-terms-0-field-wrapper-field"
    And I fill in "edit-terms-0-field-wrapper-search" with "<value>"
    And I press "edit-submit--3"
    # When I submit the form "#islandora-dss-solr-advanced-search-form"
    # When I submit the form "#islandora-dss-solr-advanced-search-form" with "#edit-submit--3"
    # Override; Uncertain as to why this fails
    When I go to "<url>"

    Then I should see "<results> Items Found" in the "#page-header p.lead" element

    Examples:
      | field    | value      | url                                                                                                                                                                                        | results |
      | Title    | lafayette  | islandora/search/MODS.mods.titleInfo.title_ss%3A%28%22lafayette%22%29?f[0]=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22                                                             |     766 |
      | Part Of  | supplement | islandora/search/MODS.mods.titleInfo.partNumber_s%3A%28%22supplement%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22                                                    |       6 |
      | Subtitle | mining     | islandora/search/MODS.mods.titleInfo.subTitle_s%3A%28%22mining%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22                                                          |       1 |
      | Author   | stanford   | islandora/search/MODS.mods.name.displayForm_s%3A%28%22stanford%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22                                                          |       1 |
      | Date     | 1969       | islandora/search/MODS.mods.relatedItem.date.w3cdtf_dts%3A%28%5B1969-01-01T00%3A00%3A00Z%20TO%201969-12-31T11%3A59%3A59Z%5D%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22 |       7 |
      | Date     | 1969-05    | islandora/search/MODS.mods.relatedItem.date.w3cdtf_dts%3A%28%5B1969-05-01T00%3A00%3A00Z%20TO%201969-05-31T11%3A59%3A59Z%5D%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22 |       1 |
      | Date     | 1969-05-05 | islandora/search/MODS.mods.relatedItem.date.w3cdtf_dts%3A%28%5B1969-05-05T00%3A00%3A00Z%20TO%201969-05-05T11%3A59%3A59Z%5D%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22 |       1 |
      | Publisher | alumni     | islandora/search/MODS.mods.originInfo.publisher_s%3A%28%22alumni%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22                                                        |     688 |
      | Series    | magazine   | islandora/search/MODS.mods.relatedItem.titleInfo.title_s%3A%28%22magazine%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22                                               |     659 |
      |           |            |                                                                                                                                                                                            |         |

  @mink:zombie
  Scenario Outline: Searching the Alumni Publications Collection by a Multiple Fields
    Given I am on "collections/alumninewspubs/browse"
    Then I should see "780 Items Found" in the "#page-header p.lead" element
    When I click "#simple-search-control-container" and wait for "#islandora-dss-solr-advanced-search-form"
    And I select "<field_0>" from "edit-terms-0-field-wrapper-field"
    And I fill in "edit-terms-0-field-wrapper-search" with "<value_0>"
    And I click "#edit-terms-1-add" and wait for "edit-terms-1-field-wrapper-search"
    And I select "<field_0>" from "edit-terms-1-field-wrapper-field"
    And I fill in "edit-terms-1-field-wrapper-search" with "<value_1>"
    And I press "edit-submit--3"
    When I go to "<url>"
    Then I should see "<results> Items Found" in the "#page-header p.lead" element

    Examples:
      | field_0 | value_0   | field_1   | value_1    | results | url                                                                                                                                                                                              |
      | Title   | lafayette | Publisher | office     |     171 | islandora/search/MODS.mods.titleInfo.title_ss%3A%28%22lafayette%22%29%20AND%20MODS.mods.originInfo.publisher_s%3A%28%22office%22%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22 |
      | Author  | lewis     | Date      | 1939-03-01 |       1 | islandora/search/MODS.mods.name.displayForm_s%3A%28%22lewis%22%29%20AND%20MODS.mods.relatedItem.date.w3cdtf_dts%3A%28%5B1939-03-01T00%3A00%3A00Z%20TO%201939-03-01T11%3A59%3A59Z%5D%29?f%5B0%5D=cdm.Relation.IsPartOf%3A%22Alumni%20Publications%22 |
      
