require 'rails_helper'

RSpec.feature "Adding a game to a collection", type: :feature do
  scenario "User adds a game to a collection" do
    # Create a user and sign in
    user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', role: 'user')
    user.confirm
    visit "http://localhost:3000/users/sign_in"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to have_content("Signed in successfully.")

    # Create collections for the user with associated IDs
    collection1 = Collection.create(name: 'Test Collection 1', user_id: user.id)
    collection2 = Collection.create(name: 'Test Collection 2', user_id: user.id)

    # For testing purposes, let's assume we have a valid game_id
    game_id = '018d937f-2b23-73a3-9b40-d93860065d00'

    # We visit the game page
    visit "http://localhost:3000/games/details/#{game_id}"

    select "Test Collection 1", from: "collection-dropdown"

    # Click on the button to add the game to the selected collection
    click_button "Add to Collection"

    # Ensure that the flash notice message indicates the game was added to the collection successfully
    expect(page).to have_content("Game added to collection successfully.")

  end
end
