
Feature: User Registration and Authentication

Scenario: User registers an account, confirms, and signs in
  Given I visit the sign up page
  When I fill in the registration form with valid information
  And I confirm my account via email
  And I sign in with my credentials
  Then I should be successfully logged in
  And I should be able to update my account information
