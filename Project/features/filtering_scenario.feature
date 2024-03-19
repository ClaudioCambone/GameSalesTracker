
Feature: Filtering and Viewing Deal Details

Scenario: Filter deals and view details
  Given I am on the homepage
  When I apply the selected filter options and click on the first deal title
  And I log in with valid credentials
  Then I should be redirected to the deal details page
