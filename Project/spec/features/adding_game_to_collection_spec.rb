require 'rails_helper'

RSpec.describe "Adding a game to a collection", type: :feature do
  let(:user) { User.create(username: "Tartosso", email: "valid@example.com", password: "password") }
  let(:game_id) { '018d937f-2b23-73a3-9b40-d93860065d00' } # For testing purposes we use an already existing and valid game_id

  it "adds a game to a collection" do

    # Ensure user is logged in
    user.confirm
    visit "http://localhost:3000/users/sign_in"
    fill_in "Email", with: "valid@example.com"
    fill_in "Password", with: "password"
    click_button "Login"
    expect(page).to have_content("Signed in successfully.")

    # Ensure that collections are created
    collection1 = Collection.create(name: 'Test Collection 1', user_id: user.id)
    collection2 = Collection.create(name: 'Test Collection 2', user_id: user.id)

    # Visit the game page
    visit "http://localhost:3000/games/details/#{game_id}"

    # Ensure that the game page is accessible
    expect(page).to have_http_status(:success)

    # Select a collection

    puts page.html
    select collection1.name, from: "collection-dropdown"
    click_button "Add to Collection"

    # Ensure that the game is added to the selected collection
    expect(page).to have_content("Game added to collection successfully.")
  end
end
