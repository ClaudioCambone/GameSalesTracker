Feature: Adding a game to a collection
  As a user
  I want to be able to add a game to my collection
  So that I can keep track of my favorite games

  Scenario: User adds a game to a collection
    Given I am a logged-in user
    And I have collections named "Test Collection 1" and "Test Collection 2"
    When I visit the game details page for a specific game
    And I select "Test Collection 1" from the collection dropdown
    And I click the "Add to Collection" button
    Then I should see a success message indicating the game was added to the collection
